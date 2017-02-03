
import re

import requests

from ratelimit import rate_limited

URL_SPARQL = 'https://query.wikidata.org/bigdata/namespace/wdq/sparql'

RATE_LIMIT_WIKIDATA = 1 # seconds between requests

CONGRESS_BIO_ID = 'P1157'

PROPERTY_WDID = "Wikidata ID"

# SPARQL query to retrieve identifiers for entity
# Q18614948: Property for Authority Control
QUERY_IDENTIFIERS_TEMPLATE = """

  SELECT ?entity ?property ?propertyLabel ?value
  WHERE
  {{

    {prelude}

    ?entity ?propUrl ?value .
    ?property wikibase:directClaim ?propUrl .
    ?property a wikibase:Property .
    ?property wdt:P31 wd:Q18614948 .
    ?property rdfs:label ?propertyLabel

    FILTER (lang(?propertyLabel) = 'en' )

  }}

"""

# SPARQL query to retrieve family relations for entity
# {'valueLabel': 'Frederick Trump', 'value': 'Q21070387', 'qualifierLabel': 'paternal grandfather', 'propLabel': 'relative'}
QUERY_FAMILY_MEMBERS_TEMPLATE = """

  SELECT ?propLabel ?value ?valueLabel ?qualifierLabel
  WHERE
  {{

    {entity} ?statementPredicate ?statement .
    ?statement ?valuePredicate ?value .
    ?value rdfs:label ?valueLabel .

    ?propertyItem wikibase:claim ?statementPredicate .
    ?propertyItem wikibase:statementProperty ?valuePredicate .
    ?propertyItem wdt:P31 wd:Q22964231 .
    ?propertyItem rdfs:label ?propLabel .

    FILTER(lang(?propLabel) = 'en')
    FILTER(lang(?valueLabel) = 'en')

    OPTIONAL {{
      ?statement pq:P1039 ?qualifier .
      ?qualifier rdfs:label ?qualifierLabel
      FILTER(lang(?qualifierLabel) = 'en')
    }}

  }}

"""

# property: e.g. "P1157" (U.S. Congress bio ID)

# If property is specified, use it to look up entity;
# otherwise value is assumed to be a reference to the entitity,
# e.g. "wd:Q22686"
def fetch_identifiers(value, prop=None):
    query = _identifiers_query(value, prop)
    print(query)
    data = _fetch_results(query)
    print(repr(data))
    values = { datum['propertyLabel']['value']: datum['value']['value'] for datum in data }
    values[PROPERTY_WDID] = _unqualify_wdid(data[0]['entity']['value']) # ASSUME: entity is uniquely identified
    return values

def _identifiers_query(value, prop=None):
    if prop:
        prelude = '?entity wdt:{prop} "{value}" .'.format(prop=prop, value=value)
    else:
        prelude = 'BIND ("{value}" as ?entity)'.format(value=value)
    return QUERY_IDENTIFIERS_TEMPLATE.format(prelude=prelude)

@rate_limited(RATE_LIMIT_WIKIDATA)
def _fetch_results(query):
    response = requests.get(URL_SPARQL, params={ 'query': query, 'format': 'json' })
    print(repr(response))
    data = response.json()
    return data['results']['bindings']

# {'valueLabel': 'Frederick Trump', 'value': 'Q21070387', 'qualifierLabel': 'paternal grandfather', 'propLabel': 'relative'}
def fetch_family(wdid):
    query = QUERY_FAMILY_MEMBERS_TEMPLATE.format(entity=wdid)
    print(query)
    data = _fetch_results(query)
    return [ { k: _unqualify_wdid(v['value']) \
              for k, v in datum.items() } for datum in data ]

def _unqualify_wdid(wdid):
    return re.sub('^.*/entity/', '', wdid)

if __name__ == '__main__':

    # sample usage

    data = fetch_identifiers(prop=CONGRESS_BIO_ID, value='A000055')
    print(repr(data))

    data = fetch_identifiers('Q22686')
    print(repr(data))

    data = fetch_family('wd:Q22686')
    print(repr(data))


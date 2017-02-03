
import wiki

class Member(object):

    def __init__(self, data):
        self.__dict__.update(data)

    def fetch_identifiers(self):
        return wiki.fetch_identifiers(wiki.CONGRESS_BIO_ID, self.id)

class Senator(Member):

    def __repr__(self):
        return "<Senator {first_name} {last_name} ({party}-{state})>".format(self.__dict__)

    # ProPublica member data:
    #
    #  {
    #    'next_election':        '2020',
    #    'api_uri':              'https://api.propublica.org/congress/v1/members/A000360.json',
    #    'missed_votes_pct':     '3.03',
    #    'ideal_point':          '',
    #    'url':                  'https://www.alexander.senate.gov/public/index.cfm/home',
    #    'votes_with_party_pct': '96.88',
    #    'thomas_id':            '1695',
    #    'id':                   'A000360',
    #    'last_name':            'Alexander',
    #    'state':                'TN',
    #    'facebook_id':          '89927603836',
    #    'domain':               '',
    #    'seniority':            '15',
    #    'total_votes':          '33',
    #    'first_name':           'Lamar',
    #    'twitter_account':      'SenAlexander',
    #    'total_present':        '0',
    #    'facebook_account':     'senatorlamaralexander',
    #    'middle_name':          '',
    #    'missed_votes':         '1',
    #    'google_entity_id':     '/m/01rbs3',
    #    'party':                'R',
    #    'dw_nominate':          '',
    #    'rss_url':              'http://www.alexander.senate.gov/public/?a=RSS.Feed'
    #  }

class Representative(Member):

    def __repr__(self):
        return "<Representative {first_name} {last_name} ({party}-{state}-{district})>".format(self.__dict__)

    # ProPublica member data:
    #
    # {
    #    'twitter_account':      'Robert_Aderholt',
    #    'total_present':        '0',
    #    'thomas_id':            '1460',
    #    'last_name':            'Aderholt',
    #    'domain':               'aderholt.house.gov',
    #    'middle_name':          'B.',
    #    'seniority':            '22',
    #    'facebook_account':     'RobertAderholt',
    #    'next_election':        '2018',
    #    'missed_votes_pct':     '0.00',
    #    'first_name':           'Robert',
    #    'ideal_point':          '',
    #    'facebook_id':          '19787529402',
    #    'total_votes':          '65',
    #    'missed_votes':         '0',
    #    'dw_nominate':          '',
    #    'rss_url':              'https://aderholt.house.gov/rss.xml',
    #    'id':                   'A000055',
    #    'state':                'AL',
    #    'party':                'R',
    #    'api_uri':              'https://api.propublica.org/congress/v1/members/A000055.json',
    #    'google_entity_id':     '/m/024p03',
    #    'url':                  'https://aderholt.house.gov',
    #    'district':             '4',
    #    'votes_with_party_pct': '95.38'
    # }


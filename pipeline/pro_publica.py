
import requests

from ratelimit import rate_limited

from congress import Senator, Representative

class Client(object):

    URL_BASE = 'https://api.propublica.org'

    PATH_MEMBERS = '/congress/v1/{congress}/{chamber}/members.json'

    RATE_LIMIT_PROPUBLICA = 1 # requests per second

    HEADER_API_KEY = 'X-API-Key'

    CHAMBER_HOUSE  = 'house'
    CHAMBER_SENATE = 'senate'

    def __init__(self, api_key):
        self.api_key = api_key

    def _headers(self):
        return { self.HEADER_API_KEY: self.api_key }

    def _members_url(self, congress, chamber):
        return self.URL_BASE + self.PATH_MEMBERS.format(congress=congress,
                                                        chamber=chamber)

    def _congress_members(self, congress, chamber):
        members_data = self._fetch_members_data(congress, chamber)
        if chamber == self.CHAMBER_SENATE:
            return [ Senator(member) for member in members_data ]
        elif chamber == self.CHAMBER_HOUSE:
            return [ Representative(member) for member in members_data ]
        else:
            raise ValueError('Unknown chamber: "%s"' % (chamber,))

    @rate_limited(RATE_LIMIT_PROPUBLICA)
    def _fetch_members_data(self, congress, chamber):
        url = self._members_url(congress, chamber)
        response = requests.get(url, headers=self._headers())
        response_data = response.json()
        result = response_data['results'][0]
        return result['members']

    def senators(self, congress):
        return self._congress_members(congress=congress,
                                      chamber=self.CHAMBER_SENATE)

    def representatives(self, congress):
        return self._congress_members(congress=congress,
                                      chamber=self.CHAMBER_HOUSE)

if __name__ == '__main__':

      # sample usage

      secret = '__THIS_SPACE_LEFT_BLANK_INTENTIONALLY_'
      client = Client(secret)

      congress = 115

      senators = client.senators(congress)
      print(repr(senators))
      for i, sen in enumerate(senators):
          if i == 0:
            ids = sen.fetch_identifiers()
            print(repr(ids))


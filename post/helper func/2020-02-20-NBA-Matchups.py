#from nba_api.stats.endpoints import boxscorematchups
#import pandas
# Anthony Davis
#career = boxscorematchups.BoxScoreMatchups(game_id='0021900663')
#career.get_data_frames()[0]

#print(career.get_data_frames()[0])


import requests

headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36',}
url = 'http://stats.nba.com/stats/boxscoresummaryv2'

params = {'GameID': '0021900663'}
response = requests.request("GET", url, params=params, headers=headers,timeout=10)

print(response.json)
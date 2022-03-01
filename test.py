import requests
import json

data = requests.get("https://api.warframestat.us/pc").json()

print(json.dumps(data['cetusCycle']))
import urllib.request
import json

base_url = "https://api.clashroyale.com/v1/"
endpoint = ""

#Utiliza a API para obter o countryID do Brazil

def get_CountryID (key):
    endpoint = "locations"
    r = urllib.request.Request(
        base_url+endpoint, None,{ 
            "Authorization" : "Bearer %s" % key
            }
        )
    response = urllib.request.urlopen(r).read().decode("utf-8")
    data = json.loads(response)
    for item in data["items"]:
        if item ["name"] == "Brazil" :
            id = (item ["id"])
    return id

def get_clan_information(key):
    location_id = get_CountryID(key)
    endpoint = "clans?name=The%20resistance&locationId=" + str(location_id)
    r = urllib.request.Request(
        base_url+endpoint, None,{ 
            "Authorization" : "Bearer %s" % key
            }
        )
    response = urllib.request.urlopen(r).read().decode("utf-8")
    data = json.loads(response)
    for item in data["items"]:
        if item ["name"] == "The resistance" and item["tag"].startswith("#9V2Y") == True:
            return (item ["tag"])
            
        else:
            return "nao encontrado"


   
import urllib.request
import json
import csv

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

def get_clan_members(key):
    clan_tag = get_clan_information(key)
    endpoint = "clans/" + clan_tag.replace("#","%23") + "/members"
    r = urllib.request.Request(
        base_url+endpoint, None,{ 
            "Authorization" : "Bearer %s" % key
            }
        )
    response = urllib.request.urlopen(r).read().decode("utf-8")
    data = json.loads(response)
    return data

def generate_csv(key):
    clan_members = get_clan_members(key)

    with open('results/membros.csv', 'w', newline='', encoding="utf-8") as csvfile:

        fieldnames = ['nome', 'level', 'Troféus', 'papel']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        
        for item in clan_members["items"]:
            writer.writerow({
                'nome'    : item["name"],
                'level'   : item["expLevel"],
                'Troféus' : item["trophies"],
                'papel'   : item["role"]            
            })
    return "csv gerado com sucesso"

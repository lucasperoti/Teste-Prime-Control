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

    with open('membros.csv', 'w', newline='', encoding="utf-8") as csvfile:

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


if __name__ == "__main__" :
    generate_csv("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6ImUzYjRiOWFkLTllNzEtNDkwOC1iNzg5LTIxNmM5NGFlZGE2NyIsImlhdCI6MTYwNDc4NTg5OSwic3ViIjoiZGV2ZWxvcGVyLzAyYjdkOGUzLWM1MTItYzBiNS0zMWM1LWZjMmRiODVmOWY5OCIsInNjb3BlcyI6WyJyb3lhbGUiXSwibGltaXRzIjpbeyJ0aWVyIjoiZGV2ZWxvcGVyL3NpbHZlciIsInR5cGUiOiJ0aHJvdHRsaW5nIn0seyJjaWRycyI6WyIyMDEuMTMuMTAzLjIwMyJdLCJ0eXBlIjoiY2xpZW50In1dfQ.dJDAmG2W6yrrp-iSPVLy4UDzfnp6vH5ZxO_dE7J1vGGfCtZehqSZWq9AQRFHtUIaaiPHR3C9XPcO5Ar_SlJ4YA")
   
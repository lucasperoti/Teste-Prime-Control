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

#Metodo para obter o clan tag utilizando o nome e countryID obtido no metado de get_coutryID
def get_clan_information(key):
    location_id = get_CountryID(key)
    name = "The%20resistance&locationId"
    endpoint = "clans?name=" + name + "=" + str(location_id)
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

#Metodo para obter a lista de membros do clan buscado pelo meto get clan members
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

#Metodo para gerar o arquivo csv com base na lista obtida utilizando o metodo get_clan_members
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

#Metodo para obter o ip da maquina
def get_ip():
    r = urllib.request.Request("http://meuip.com/api/meuip.php")
    response = urllib.request.urlopen(r).read().decode("utf-8")
    return response


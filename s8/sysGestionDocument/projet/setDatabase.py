from pymongo import MongoClient
import sys
import json
from tkinter.filedialog import askopenfilename


#Connection à la base de donnée
client = MongoClient("mongo2.iem", port=27017, username=sys.argv[0], password=sys.argv[0], authSource=sys.argv[0], authMechanism="SCRAM-SHA-1")
db = client.sys.argv[0]

print("Destruction des donnees")

db.films.drop()
db.cinemas.drop()

listeCollection = db.list_collection_names()

if "films" in listeCollection:
    print("La collection films existe deja")
else:
    with open("./ressources/collections/films.json") as f:
        data = json.load(f)
    if isinstance(data, list):
        db.films.insert_many(data)
    else:
        db.films.insert_one(data)
    print("la collection films a bien ete cree\nDes donnees ont etes enregistres.")

if "cinemas" in listeCollection:
    print("La collection cinemas existe deja")
else:
    with open("./ressources/collections/cinemas.json") as f:
        data = json.load(f)
    if isinstance(data, list):
        db.cinemas.insert_many(data)
    else:
        db.cinemas.insert_one(data)
    print("la collection cinemas a bien ete cree\nDes donnees ont etes enregistres.")


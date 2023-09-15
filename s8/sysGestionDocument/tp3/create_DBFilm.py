from pymongo import MongoClient
from bson.objectid import ObjectId
from pprint import pprint

import os
from dotenv import load_dotenv

load_dotenv(".env")

#Connection à la base de donnée
c = MongoClient("mongo2.iem", port=27017, username=os.environ.get("USERNAME"), password=os.environ.get("PASSWORD"), authSource=os.environ.get("AUTHSOURCE"), authMechanism="SCRAM-SHA-1")
db = c.ym186975

#Créations des collections pour creer la base de donnée
collist = db.list_collection_names()
if "Film" in collist:
    print("La collection Film existe deja.")

else:
    print("Creation de la collection Film.")

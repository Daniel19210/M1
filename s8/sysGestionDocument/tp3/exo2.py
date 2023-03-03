from pymongo import MongoClient
from bson.objectid import ObjectId
from pprint import pprint

c = MongoClient("mongo2.iem", port=27017, username="ym186975", password="ym186975", authSource="ym186975", authMechanism="SCRAM-SHA-1")
db = c.ym186975

etudiants = db.etudiants

""" MOYENNE UTILISANT AGGREGATE
moyenneBoris = etudiants.aggregate([
   {"$match": {"nom": "Boris Karloff"}},
   {"$unwind": "$UE"},
   {"$group": {"_id": "UE", "total": {"$avg": "$UE.note"}}}
   ])
"""
""" MOYENNE SANS UTILISER AGGREGATE t'as vus c de la merde)
boris = etudiants.find({
    "nom": "Boris Karloff"
})[0]

l = len(boris["UE"])

s = 0
for i in range (0,l):
    s += boris["UE"][i]["note"]

m = s/l
"""

maxNote = etudiants.aggregate([
    {"$group": {"_id": "$nom"}},
    {"$unwind": "$UE"},
    {"$group": {"_id": "UE", "max": {"$max": "$UE.note"}}}
])

print(list(maxNote))

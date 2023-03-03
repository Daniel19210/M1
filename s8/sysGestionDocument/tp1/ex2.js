db.etudiants.drop()
db.etudiants.insertMany([
    {
        "_id": "6546",
        "nom": "Marcel Campion",
        "UE": [
            {"id": "infol", "titre": "java", "note": "06"},
            {"id": "info1b", "titre": "Web", "note": "15"},
            {"id": "info4c", "titre": "Fondements de l'informatique", "note": "04"}
        ]
    },
    {
        "_id": "3215" ,
        "nom": "Boris Karloff",
        "UE": [
            {"id": "info2a", "titre": "Programmation orientée objet", "note": "17"},
            {"id": "info2b", "titre": "Interfaces visuaelles", "note": "06"},
            {"id": "info1b", "titre": "Web", "note": "12"}
        ]
    }
])

db.etudiants.find({"_id": "6546"})

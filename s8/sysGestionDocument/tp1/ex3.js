db.etudiantPr.insertMany([
    {
        "_id": "6546",
        "nom": "Campion",
        "prenom": "Marcel",
        "adresse": {
            "numRue": 12,
            "rue": "pimpon les pompiers",
            "ville": "coucou",
            "codePostal": "69692"
        },
        "UE": [
            {
                "id": "infol",
				"titre": "java",
				"note": "06"
            },
            {
                "id": "info1b",
				"titre": "Web",
				"note": "15"
            },
            {
                "id": "info4c",
				"titre": "Fondements de l'informatique",
				"note": "04"
            }
        ]
    },
    {
        "_id": "6548",
        "nom": "Boris",
        "prenom": "Karloff",
        "adresse": {
            "numRue": 13,
            "rue": "pipi les pompiers",
            "ville": "cocu",
            "codePostal": "69695"
        },
        "UE": [
            {
                "id": "infol",
				"titre": "java",
				"note": "06"
            },
            {
                "id": "info1b",
				"titre": "Web",
				"note": "15"
            },
            {
                "id": "info4c",
				"titre": "Fondements de l'informatique",
				"note": "04"
            }
        ]
    },
])

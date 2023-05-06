from pymongo import MongoClient
from pprint import pprint

# Connection à la base de donnée
client = MongoClient('localhost', 27017)
db = client.sgdProject_database

# Retourne tous les noms de cinéma sous forme de tableau.


def getAllNameCinema():
    return db.cinemas.find({}, {"nom": 1, "_id": 0})

# Retourne le titre de tous les films sous forme de tableau.


def getAllNameFilm():
    return [res['Titre'] for res in db.films.find()]

# Retourne les films d'un cinéma.


def get_films_from_cinema(nom_cinoch):
    return 
    db.cinemas.aggregate(
        [
            {
                '$match': {
                    'nom': 'Olympia'
                }
            }, {
                '$project': {
                    'film_et_Entrees': 1
                }
            }, {
                '$lookup': {
                    'from': 'films',
                    'localField': 'film_et_Entrees.idFilm',
                    'foreignField': 'id',
                    'as': 'film_olympia'
                }
            }, {
                '$project': {
                    'film_olympia': 1
                }
            }, {
                '$unwind': {
                    'path': '$film_olympia'
                }
            }
        ]
    )
    # res = []
    # films_du_cinema = list(db.cinemas.find({"nom": nom_cinoch},
    # {"film_et_Entrees": 1, "_id": 0}
    # ))[0]["film_et_Entrees"]
    # for idFilm in films_du_cinema:
    # res.append(db.films.find({"id": idFilm["idFilm"]}))
    # return res


def get_commentaires_film(nom_film):
    return db.films.find({"Titre": nom_film},
                         {"_id": 0, "Note_et_Commentaires.commentaire": 1})


"""
var map = function(){emit(this.nom, this.film_et_Entrees);}
var reduce = function(nomCinema, filmEntrees){
    var somme = 0;
    for (let i = 0; i < filmEntrees[0].length; i++) {
        somme += filmEntrees[0][i].nbEntrees;
    }
    return somme;
}
db.cinemas.mapReduce(map, reduce, {out: {inline: 1}})

var map = function(){emit(this.nom, this.film_et_Entrees);}
var reduce = function(nomCinema, filmEntrees){
    var somme = 0;
    for (let i = 0; i < filmEntrees[0].length; i++) {
        somme += filmEntrees[0][i].nbEntrees;
    }
    return somme/filmEntrees[0].length;
}
db.cinemas.mapReduce(map, reduce, {out: {inline: 1}})

db.films.insertOne({
    "_id": 6,
    "titre": "Bambi",
    "duree": 149,
    "realisateur": "Mickey",
    "acteurs": [
        "Arnold Schwarzeneger",
        "Bambi"
    ],
    "categorie": [
        "Action",
        "Tragédie"
    ],
    "noteMoyenne": 5,
    "avis": [
        {
            "note": 5,
            "commentaire": "Bambi est l'un des meilleurs films que j'ai jamais vu"
        },
        {
            "note": 5,
            "commentaire": "Arnold était parfait dans son rôle <3"
        }
    ],
    "nbEntreeTotal": 9000000000,
    "salleDiffusion": [
        1,
        2,
        3,
        4
    ]
})

db.cinemas.updateOne({
    "nom": "Olympia"
},
{
    $set: {
        "heureOuverture": {
            "heure": 9,
            "minutes": 0
        },
        "heureFermeture": {
            "heure": 0,
            "minutes": 0
        }
    }
})
db.films.updateOne({
    "titre": "Le Loup de Wall Street",
},
{
    $set: {
        "nbEntreeTotal": 3000000
    }
})
"""

# print(f'{getAllNameFilm() =}')
# pprint(list(getAllNameCinema()))
pprint(list(get_films_from_cinema("Olympia")))
# pprint(list(get_commentaires_film("Le seigneur des anneaux")[0]))

# En Pymongo

# Fait
# Création d'un commentaire
# Nombre d'avis positifs / négatifs d'un films (avec les notes)
# Les cinémas qui sont ouverts à cette heure-ci 
# Les films qui sont diffusés dans au moins 2 cinémas (pour donner une idée de sa popularitée)
# Le nombre d'entrée total d'un cinéma pour chaque cinema avec un map reduce
# Tous les avis d'un film
# La note moyenne d'un cinéma pour chaque cinema
# Tout les films de moins de 2h
# Les films réalisés par X
# Les films de X catégorie
# Les X films les mieux notés

# Ajout d'un film
# Modifications des horaires d'ouverture du cinéma
# Modifier le nombre d'entrées


# Cinémas ouverts 7/7J avec toujours les mêmes horaires

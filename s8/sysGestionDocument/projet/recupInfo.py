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
    return db.cinemas.aggregate(
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
var map = function(){emit(this.nom, this.id);}
var reduce = function(nomCinema, nbEntrees){
    return Array.sum(nbEntrees);
}
db.cinemas.mapReduce(map, reduce, {out: {inline: 1}})
"""

# print(f'{getAllNameFilm() =}')
# pprint(list(getAllNameCinema()))
pprint(list(get_films_from_cinema("Olympia")))
# pprint(list(get_commentaires_film("Le seigneur des anneaux")[0]))

# En mongoDB
# tous les commentaires avec la note d'un film
# Le nombre d'entrée total d'un cinéma pour chaque cinema avec un map reduce
# La moyenne des entrées d'un cinéma pour chaque cinema avec un map reduce

# En Pymongo
# La note moyenne d'un film (demander quel film)

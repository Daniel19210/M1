from pymongo import MongoClient
from pprint import pprint

#Connection à la base de donnée
client = MongoClient('localhost', 27017)
db = client.sgdProject_database

#Retourne tous les noms de cinéma sous forme de tableau.
def getAllNameCinema():
    return db.cinemas.find({}, {"nom": 1, "_id": 0})

#Retourne le titre de tous les films sous forme de tableau.
def getAllNameFilm():
    return [res['Titre'] for res in db.films.find()]

#Retourne les films d'un cinéma.
def get_films_from_cinema(nom_cinoch):
    res = []
    films_du_cinema = list(db.cinemas.find({"nom": nom_cinoch}, {"film_et_Entrees": 1, "_id": 0}))[0]["film_et_Entrees"]
    for idFilm in films_du_cinema:
        res.append(db.films.find({"id": idFilm["idFilm"]}))
    return res

def get_commentaires_film(nom_film):
    return db.films.find({"Titre": nom_film}, {"_id": 0, "Note_et_Commentaires.commentaire": 1})


print(f'{getAllNameFilm() =}')
pprint(list(getAllNameCinema()))
pprint(list(get_films_from_cinema("Olympia")[0]))
pprint(list(get_commentaires_film("Le seigneur des anneaux")[0]))

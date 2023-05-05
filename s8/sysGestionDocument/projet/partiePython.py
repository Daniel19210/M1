from pymongo import MongoClient

#Connection à la base de donnée
client = MongoClient('localhost', 27017)

db = client.sgdProject_database

def note_moyenne_cinema(nom_cinema):
    les_films = []
    les_notes = []

    for film in list(db.cinemas.find({"nom": nom_cinema}, {"_id": 0, "film_et_Entrees": 1})):
        for f in film.get("film_et_Entrees"):
            les_films.append(f.get("idFilm"))


    for i in les_films:
        for note_et_commentaire in list(db.films.find({"_id": i}, {"_id": 0, "Note_et_Commentaires": 1})):
            for note in note_et_commentaire.get("Note_et_Commentaires"):
                les_notes.append(note.get("note"))
    
    print(sum(les_notes)/len(les_notes))



note_moyenne_cinema("Olympia")

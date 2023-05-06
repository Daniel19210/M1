from pymongo import MongoClient
import datetime

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

def cinemas_ouvert_actuellement():
    cinemas_ouvert = []

    heureActuel = datetime.datetime.now().time()

    for cinema in db.cinemas.find():
        heureOuvert = datetime.time(cinema.get('heureOuverture').get('heure'), cinema.get('heureOuverture').get('minutes'))
        heureFerme = datetime.time(cinema.get('heureFermeture').get('heure'), cinema.get('heureFermeture').get('minutes'))

        if (heureActuel > heureOuvert) and (heureActuel < heureFerme):
            cinemas_ouvert.append(cinema.get('nom'))

    print(cinemas_ouvert)

def nombre_avis_Pos_Neg_Neutre(nom_film):
    avisPos = []
    avisNeg = []
    avisNeutre = []

    nbAvisPos = 0
    nbAvisNeg = 0
    nbAvisNeutre = 0

    for film in db.films.find():
        for avis in film.get('avis'):
            if avis.get('note') > 2.5:
                avisPos.append(avis)
                nbAvisPos += 1
            elif avis.get('note') < 2.5:
                avisNeg.append(avis)
                nbAvisNeg += 1
            else:
                avisNeutre.append(avis)
                nbAvisNeutre += 1

    print(f'{nbAvisPos = }')
    print(f'{avisPos = }')
    print(f'{nbAvisNeg = }')
    print(f'{avisNeg = }')
    print(f'{nbAvisNeutre = }')
    print(f'{avisNeutre = }')

def creation_Commentaire():
    film = input('Pour quel film voulez-vous faire un commentaire ?\t')
    note = float(input('Note (entre 0 et 5 par tranche de 0.5) : '))
    commentaire = input('Commentaire : ')

    db.films.update_one({"titre": film}, {"$push": {"avis": {"note": note, "commentaire": commentaire}}})

cinemas_ouvert_actuellement()
nombre_avis_Pos_Neg_Neutre('Le Loup de Wall Street')
creation_Commentaire()

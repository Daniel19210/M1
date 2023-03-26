import numpy as np
import re

CONST_JOKER_NOIR = 53  # Valeur du joker noir
CONST_JOKER_ROUGE = 54  # Valeur du joker rouge
CONST_ALPHABET_NUM = 26  # Nombre de lettre dans l'alphabet
CONST_ASCII_MAJ = 65  # Code ASCII de la lettre A


# Première étape
def reculJokerNoir(p):
    # Récupération de la position du joker noir dans le paquet
    indiceJokerNoir = np.where(p == CONST_JOKER_NOIR)[0][0]
    # Cas où le joker est dans la dernière position du paquet
    if (indiceJokerNoir == 53):
        p = np.delete(p, indiceJokerNoir)
        p = np.insert(p, 1, CONST_JOKER_NOIR)
    else:  # Inversion du joker noir avec la carte qui suit
        p[[indiceJokerNoir, indiceJokerNoir+1]] = p[[indiceJokerNoir+1,
                                                     indiceJokerNoir]]
    return p


# Seconde étape
def reculJokerRouge(p):
    indJR = np.where(p == CONST_JOKER_ROUGE)[0][0]
    # Cas où le joker est dans les dernières positions du paquet
    if indJR == 53:
        p = np.delete(p, indJR)
        p = np.insert(p, 2, CONST_JOKER_ROUGE)
    elif indJR == 52:
        p = np.delete(p, indJR)
        p = np.insert(p, 1, CONST_JOKER_ROUGE)
    else:  # Réarrengement des carte 1, 2, 3 en 2, 3, 1
        p[[indJR, indJR+1, indJR+2]] = p[[indJR+1, indJR+2, indJR]]
    return p


# Troisième étape
def coupeDouble(p):
    p1, p2, p3 = [], [], []
    entreJoker = False
    for i in range(len(p)):
        if p[i] == CONST_JOKER_NOIR or p[i] == CONST_JOKER_ROUGE:
            if entreJoker:
                # Définiton des 2 autres parties du paquet lorsqu'on trouve
                # le second joker
                p2 = p[len(p1):i+1]
                p3 = p[i+1:]
                break
            else:
                # Définition de la première partie du paquet
                # lorsqu'on trouve le première joker
                p1 = p[:i]
                entreJoker = True
    return np.concatenate((p3, p2, p1))


# Quatrième étape
def coupeSimple(p):
    # On tire la 53-ème carte du paquet (la première face cachée) et
    # on converti le joker rouge en 53
    carte = p[53] if p[53] != CONST_JOKER_ROUGE else CONST_JOKER_NOIR
    isJokerRouge = False if p[53] != CONST_JOKER_ROUGE else True
    # On sépare le paquet en 2 par rapport à la valeur de la carte
    cartesABouger, reste = p[:carte], p[carte:53]
    # On le réassemple en inversant les 2 parties du paquet
    return np.concatenate((reste, cartesABouger,
                           [carte if not isJokerRouge else CONST_JOKER_ROUGE]))


# Utilisation de toutes les étapes pour faire un "mélange"
def melange(p):
    p = reculJokerNoir(p)
    p = reculJokerRouge(p)
    p = coupeDouble(p)
    p = coupeSimple(p)
    return p


# Cinquième étape
def lecturePseudoAleatoire(p):
    premiereCarte = p[0] if p[0] != CONST_JOKER_ROUGE else 53
    # On tire la premièreCarte-ième carte du paquet
    carteTiree = p[premiereCarte]
    if (carteTiree == CONST_JOKER_NOIR or carteTiree == CONST_JOKER_ROUGE):
        p = melange(p)
        return lecturePseudoAleatoire(p)
    elif (carteTiree > CONST_ALPHABET_NUM):
        carteTiree = carteTiree - CONST_ALPHABET_NUM
    return carteTiree


# Pour vérifier que les paquets donnés par l'utilisateur sont valides
def verificationPaquet(paquet):
    temoin = np.array([x for x in range(1, 55)])
    if (paquet.size != temoin.size):
        return ("Le paquet ne contient pas le bon nombre de carte"
                + " ou comporte autre chose que des cartes")
    if (np.unique(paquet).size != temoin.size):
        return "Le paquet comporte un doublon"
    return ""


# Lit un paquet qui est dans un fichier
def lectureFichier(file):
    # Lecture du fichier à encoder
    with open(file, "r") as txt_file:
        lines = txt_file.read()
        return np.fromstring(lines[1:len(lines)], dtype=int, sep="\n")


# Écrit le message donné dans un fichier
def ecritureMessage(file, message):
    with open(file, "w") as txt_file:
        txt_file.write(message)


# Pour supprimer les caractères spéciaux
def formattageMessage(message):
    message = "\n".join(message).rstrip()
    # Suppression des accents
    accents = {"à": "a", "â": "a", "é": "e", "è": "e", "ê": "e", "ë": "e",
               "î": "i", "ï": "i", "ô": "o", "ù": "u", "û": "u", "ü": "u",
               "ÿ": "y", "ç": "c", "æ": "ae", "œ": "oe"}
    for acc, correction in accents.items():
        message = message.replace(acc, correction)
    # On ne garde que les lettres dans le message
    return ''.join(re.findall("[a-zA-Z]", message))


# Genère la cle pour coder et décoder le message
def genererCleEncodage(p, message):
    cleEncodage = ""
    for (i, lettre) in enumerate(message):
        paquet = melange(p)
        carte = lecturePseudoAleatoire(paquet)
        cleEncodage += chr(carte + CONST_ASCII_MAJ - 1)
    return cleEncodage


# Permet de coder le message
def chiffrage(message, p):
    messageChiffre = ""
    cle = genererCleEncodage(p, message)
    for (i, lettre) in enumerate(message):
        messageChiffre += chr((ord(cle[i]) + ord(lettre.upper())) %
                              CONST_ALPHABET_NUM + CONST_ASCII_MAJ)
    return messageChiffre


# Permet de décoder le message
def dechiffrage(paquet, message):
    messageDechiffre = ""
    cle = genererCleEncodage(paquet, message)
    for (i, lettre) in enumerate(message):
        messageDechiffre += chr((ord(lettre) -
                                ord(cle[i])) % CONST_ALPHABET_NUM
                                + CONST_ASCII_MAJ)
    return messageDechiffre

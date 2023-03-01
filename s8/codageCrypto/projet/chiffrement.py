import numpy as np
import re
import sys

CONST_JOKER_NOIR = 53
CONST_JOKER_ROUGE = 54
CONST_ALPHABET_NUM = 26
CONST_ASCII_MAJ = 65


def reculJokerNoir(p):
    indiceJokerNoir = np.where(p == CONST_JOKER_NOIR)[0][0]
    # Cas où le joker est dans la dernière position du paquet
    if (indiceJokerNoir == 53):
        p[[indiceJokerNoir, 0]] = p[[0, indiceJokerNoir]]
    else:
        p[[indiceJokerNoir, indiceJokerNoir+1]] = p[[indiceJokerNoir+1,
                                                     indiceJokerNoir]]
    return p


def reculJokerRouge(p):
    # On récupère l'indice du joker rouge
    indJR = np.where(p == CONST_JOKER_ROUGE)[0][0]

    # Cas où le joker est dans les dernières positions du paquet
    if indJR == 53:
        p[[indJR, 0, 1]] = p[[0, 1, indJR]]
    elif indJR == 52:
        p[[indJR, 53, 0]] = p[[53, 0, indJR]]
    else:
        p[[indJR, indJR+1, indJR+2]] = p[[indJR+1, indJR+2, indJR]]
    return p


def coupeDouble(p):
    # indiceJokerNoir = np.where(p == CONST_JOKER_NOIR)[0][0]
    # indiceJokerRouge = np.where(p == CONST_JOKER_ROUGE)[0][0]
    # p1 = p[:min(indiceJokerNoir, indiceJokerRouge)]
    # p2 = p[min(indiceJokerNoir, indiceJokerRouge):max(indiceJokerNoir,
    # indiceJokerRouge)+1]
    # p3 = p[max(indiceJokerNoir, indiceJokerRouge)+1:]

    p1 = []
    p2 = []
    p3 = []
    entreJoker = False

    for i in range(len(p)):
        if p[i] == CONST_JOKER_NOIR or p[i] == CONST_JOKER_ROUGE:
            if entreJoker:
                p2 = p[len(p1):i+1]
                p3 = p[i+1:]
                break
            else:
                p1 = p[:i]
                entreJoker = True

    return np.concatenate((p3, p2, p1))


def coupeSimple(p):
    # On tire la 53-ème carte du paquet (la première face cachée)
    carte = p[53] if p[53] != CONST_JOKER_ROUGE else 53
    cartesABouger, reste = p[:carte], p[carte:53]
    return np.concatenate((reste, cartesABouger, [carte]))


def melange(p):
    p = reculJokerNoir(p)
    p = reculJokerRouge(p)
    p = coupeDouble(p)
    p = coupeSimple(p)
    return p


def lecturePseudoAleatoire(p):
    # Il faut convertir le joker rouge en 53
    premiereCarte = p[0] if p[0] != CONST_JOKER_ROUGE else 53
    # On tire la premièreCarte-ième carte du paquet
    carteTiree = p[premiereCarte]
    if (carteTiree == CONST_JOKER_NOIR or carteTiree == CONST_JOKER_ROUGE):
        p = melange(p)
        return lecturePseudoAleatoire(p)
    elif (carteTiree > CONST_ALPHABET_NUM):
        carteTiree = carteTiree - CONST_ALPHABET_NUM
    return carteTiree


def lectureFichier(file):
    # Lecture du fichier à encoder
    with open(file, "r") as txt_file:
        lines = txt_file.readlines()
        return formattageMessage(lines)


def ecritureMessage(file, message):
    with open(file, "w") as txt_file:
        txt_file.write(message)


def formattageMessage(message):
    message = "\n".join(message).rstrip()
    # Suppression des accents
    accents = {"é": "e", "è": "e", "à": "a", "ù": "u",
               "ô": "o", "û": "u", "â": "a", "ï": "i", "î": "i"}
    for acc, correction in accents.items():
        message = message.replace(acc, correction)
    # On ne garde que les lettres dans le message
    return ''.join(re.findall("[a-zA-Z]", message))


def chiffrage(message, cle):
    messageChiffre = ""
    for (i, lettre) in enumerate(message):
        messageChiffre += chr((ord(cle[i]) + ord(lettre.upper())) %
                              CONST_ALPHABET_NUM + CONST_ASCII_MAJ)
    return messageChiffre


def genererCleEncodage(p, message):
    cleEncodage = ""
    for (i, lettre) in enumerate(message):
        paquet = melange(p)
        carte = lecturePseudoAleatoire(paquet)
        cleEncodage += chr(carte + CONST_ASCII_MAJ - 1)
    ecritureMessage("cle.txt", cleEncodage)


def dechiffrage(cle, message):
    messageDechiffre = ""
    for (i, lettre) in enumerate(message):
        messageDechiffre += chr((ord(lettre) -
                                ord(cle[i])) % CONST_ALPHABET_NUM
                                + CONST_ASCII_MAJ)
    return messageDechiffre
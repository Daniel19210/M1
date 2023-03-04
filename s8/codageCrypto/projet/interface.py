from tkinter import Text, Tk, Label, Button
from tkinter.filedialog import END, askopenfilename
import numpy as np
import random as rdn
import chiffrement as m
import pyperclip as pp


# Créée le paquet utilisé pour chiffrer le message et l'écrit dans un fichier
def creationPaquet(champPaquet, annonce):
    # rdn.seed(1)  # Fixe le RNG
    # Création d'un paquet mélangé
    paquet = np.array(rdn.sample(range(1, 55), 54))
    m.ecritureMessage("paquet.txt", np.array2string(paquet))
    champPaquet.delete("1.0", END)
    annonce.config(text="Génération d'un nouveau paquet")
    champPaquet.insert(END, paquet)


#  Chiffrage du message dans le champ de texte
def chiffrageMessage(champMessBrut, champMessChiffre,
                     champMessDechiffre, champPaquet, annonce):
    champMessChiffre.delete("1.0", END)
    champMessDechiffre.delete("1.0", END)
    annonce.config(text="")

    messageBrut = m.formattageMessage(champMessBrut.get("1.0", 'end-1c'))
    if (messageBrut == ''):
        annonce.config(text="Aucun message à chiffrer")
        return

    if (champPaquet.get("1.0", 'end-1c') == ''):  # Pas de paquet défini
        creationPaquet(champPaquet, annonce)
    else:
        m.ecritureMessage("paquet.txt", champPaquet.get("1.0", "end-1c"))

    paquet = m.lectureFichier("paquet.txt")
    messageVerification = m.verificationPaquet(paquet)
    if (messageVerification != ""):
        annonce.config(text=messageVerification)
        return
    messageChiffre = m.chiffrage(messageBrut, paquet)
    champMessChiffre.insert(END, messageChiffre)


def dechiffrageMessage(champMessChiffre, champMessDechiffre,
                       champPaquet, annonce):
    champMessDechiffre.delete("1.0", END)
    annonce.config(text="")
    if (champPaquet.get("1.0", 'end-1c') != ''):  # Pas de paquet défini
        m.ecritureMessage("paquet.txt", champPaquet.get("1.0", "end-1c"))
        messageChiffre = champMessChiffre.get("1.0", 'end-1c')
        if (messageChiffre != ''):  # Pas de message à déchiffrer
            messageDechiffre = m.dechiffrage(
                m.lectureFichier("paquet.txt"), messageChiffre)
            champMessDechiffre.insert(END, messageDechiffre)
        else:
            annonce.config(text="Aucun message à déchiffrer")
    else:
        annonce.config(text="Veuillez insérer un paquet pour déchiffrer " +
                       "le message")


def ouvrirFichier(fichierInput):
    filename = askopenfilename(title="Ouvrir votre document", filetypes=[
                               ('txt files', '.txt'), ('all files', '.*')])
    with open(filename, "r") as fichier:
        fichierInput.delete("1.0", END)
        fichierInput.insert(END, fichier.read())


def ouvrirPaquet(afficheCle):
    filename = askopenfilename(title="Ouvrir votre document", filetypes=[
                               ('txt files', '.txt'), ('all files', '.*')])
    with open(filename, "r") as fichier:
        m.ecritureMessage("paquet.txt", fichier.read())
    with open("paquet.txt", "r") as fichier:
        afficheCle.delete("1.0", END)
        afficheCle.insert(END, fichier.read())


def copieCle():
    with open("paquet.txt", "r") as fichier:
        pp.copy(fichier.read())


def initializeFenetre():
    fenetre = Tk()

    fenetre.geometry("1000x400")
    fenetre.title("Codage & Cryptographie")

    label1 = Label(fenetre, text="Message à coder")
    label2 = Label(fenetre, text="Message Codé")
    label3 = Label(fenetre, text="Message décodé")
    label4 = Label(fenetre, text="Paquet")
    annonce = Label(fenetre, text="")

    champMessBrut = Text(fenetre, height=10, width=30)
    champMessChiffre = Text(fenetre, height=10, width=30)
    champMessDechifre = Text(fenetre, height=10, width=30)
    champPaquet = Text(fenetre, height=10, width=30)

    boutonChiffrement = Button(
        fenetre, text="Chiffrer le message",
        command=lambda: chiffrageMessage(champMessBrut, champMessChiffre,
                                         champMessDechifre, champPaquet,
                                         annonce))
    boutonDechiffrage = Button(
        fenetre, text="Déchiffrer le message",
        command=lambda: dechiffrageMessage(champMessChiffre, champMessDechifre,
                                           champPaquet, annonce))
    setCleDechiffButton = Button(
        fenetre, text="Insérer paquet initial",
        command=lambda: ouvrirPaquet(champPaquet))
    openFileACoderButton = Button(
        fenetre, text="Insérer message a chiffrer",
        command=lambda: ouvrirFichier(champMessBrut))
    openFileADecoderButton = Button(
        fenetre, text="Insérer message a déchiffrer",
        command=lambda: ouvrirFichier(champMessChiffre))
    copyPressePapierButton = Button(
        fenetre, text="Copier le paquet dans le presse-papier",
        command=lambda: copieCle())
    generationPaquet = Button(
        fenetre, text="Générer un nouveau paquet",
        command=lambda: creationPaquet(champPaquet, annonce)
    )

    champMessBrut.grid_propagate(False)
    champMessChiffre.grid_propagate(False)
    champMessDechifre.grid_propagate(False)
    champPaquet.grid_propagate(False)
    annonce.grid_propagate(False)

    label1.grid(row=0, column=0, padx=10, pady=10, sticky="ns")
    label2.grid(row=0, column=1, padx=10, pady=10, sticky="ns")
    label3.grid(row=0, column=2, padx=10, pady=10, sticky="ns")
    label4.grid(row=0, column=3, padx=10, pady=10, sticky="ns")

    champMessBrut.grid(row=1, column=0, padx=10, pady=10, sticky="ns")
    champMessChiffre.grid(row=1, column=1, padx=10, pady=10, sticky="ns")
    champMessDechifre.grid(row=1, column=2, padx=10, pady=10, sticky="ns")
    champPaquet.grid(row=1, column=3, padx=10, pady=10, sticky="ns")
    annonce.grid(row=5, column=0, padx=10, pady=10, sticky="ns",
                 columnspan=4)

    boutonChiffrement.grid(row=2, column=0, padx=10, pady=10, sticky="ns")
    boutonDechiffrage.grid(row=2, column=1, padx=10, pady=10, sticky="ns")
    setCleDechiffButton.grid(row=2, column=3, padx=10, pady=10, sticky="ns")
    openFileACoderButton.grid(row=3, column=0, padx=10, pady=10, sticky="ns")
    openFileADecoderButton.grid(row=3, column=1, padx=10, pady=10, sticky="ns")
    copyPressePapierButton.grid(row=4, column=3, padx=10, pady=10, sticky="ns")
    generationPaquet.grid(row=3, column=3, padx=10, pady=10, sticky="ns")

    fenetre.mainloop()


if __name__ == "__main__":
    initializeFenetre()
    pass

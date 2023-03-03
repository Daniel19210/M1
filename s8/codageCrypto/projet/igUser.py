from tkinter import Text, Tk, Label, Button
from tkinter.filedialog import END, askopenfilename
import numpy as np
import random as rdn
import chiffrement as m
import pyperclip as pp


# Créée le paquet utilisé pour chiffrer le message et l'écrit dans un fichier
def creationPaquet(messageBrut):
    # rdn.seed(1)  # Fixe le RNG
    # Création d'un paquet mélangé
    paquet = np.array(rdn.sample(range(1, 55), 54))
    m.ecritureMessage("paquet.txt", np.array2string(paquet))


#  Chiffrage du message dans le champ de texte
def chiffrageMessage(champMessBrut, champMessChiffre,
                     champMessDechiffre, champPaquet):
    messageBrut = m.formattageMessage(champMessBrut.get("1.0", 'end-1c'))
    creationPaquet(messageBrut)
    paquet = m.lectureFichier("paquet.txt")
    messageChiffre = m.chiffrage(messageBrut, paquet)
    champMessChiffre.delete("1.0", END)
    champMessChiffre.insert(END, messageChiffre)
    champPaquet.delete("1.0", END)
    champPaquet.insert(END, paquet)
    champMessDechiffre.insert(END, m.lectureFichier("paquet.txt"))
    champMessDechiffre.delete("1.0", END)


def dechiffrageMessage(champMessChiffre, champMessDechiffre):
    messageChiffre = champMessChiffre.get("1.0", 'end-1c')
    messageDechiffre = m.dechiffrage(
        m.lectureFichier("paquet.txt"), messageChiffre)
    champMessDechiffre.delete("1.0", END)
    champMessDechiffre.insert(END, messageDechiffre)


def ouvrirFichier(fichierInput):
    filename = askopenfilename(title="Ouvrir votre document", filetypes=[
                               ('txt files', '.txt'), ('all files', '.*')])
    fichier = open(filename, "r")
    fichierInput.delete("1.0", END)
    fichierInput.insert(END, fichier.read())
    fichier.close()


def copieCle():
    fichier = open("paquet.txt", "r")
    pp.copy(fichier.read())
    fichier.close()


def setPaquetInitial(afficheCle):
    filename = askopenfilename(title="Ouvrir votre document", filetypes=[
                               ('txt files', '.txt'), ('all files', '.*')])
    fichier = open(filename, "r")
    m.ecritureMessage("paquet.txt", fichier.read())
    fichier.close()

    fichier = open("paquet.txt", "r")
    afficheCle.delete("1.0", END)
    afficheCle.insert(END, fichier.read())
    fichier.close()


def initializeFenetre():
    fenetre = Tk()

    fenetre.geometry("1000x400")
    fenetre.title("Codage & Crypto")

    label1 = Label(fenetre, text="Message à coder")
    label2 = Label(fenetre, text="Message Codé")
    label3 = Label(fenetre, text="Message décodé")
    label4 = Label(fenetre, text="Paquet")

    champMessBrut = Text(fenetre, height=10, width=30)
    champMessChiffre = Text(fenetre, height=10, width=30)
    champMessDechifre = Text(fenetre, height=10, width=30)
    champPaquet = Text(fenetre, height=10, width=30)

    boutonChiffrement = Button(
        fenetre, text="Chiffrer Message",
        command=lambda: chiffrageMessage(
            champMessBrut, champMessChiffre, champMessDechifre, champPaquet))
    boutonDechiffrage = Button(
        fenetre, text="Déchiffrer Message",
        command=lambda: dechiffrageMessage(champMessChiffre,
                                           champMessDechifre))
    setCleDechiffButton = Button(
        fenetre, text="Insérer cle de Dechiffrage",
        command=lambda: setPaquetInitial(champPaquet))
    openFileACoderButton = Button(
        fenetre, text="Insérer message a Coder",
        command=lambda: ouvrirFichier(champMessBrut))
    openFileADecoderButton = Button(
        fenetre, text="Insérer message a Décoder",
        command=lambda: ouvrirFichier(champMessChiffre))

    copyPressePapierButton = Button(
        fenetre, text="Copier la clé dans le presse-papier",
        command=lambda: copieCle())

    champMessBrut.grid_propagate(False)
    champMessChiffre.grid_propagate(False)
    champMessDechifre.grid_propagate(False)

    label1.grid(row=0, column=0, padx=10, pady=10, sticky="ns")
    label2.grid(row=0, column=1, padx=10, pady=10, sticky="ns")
    label3.grid(row=0, column=2, padx=10, pady=10, sticky="ns")
    label4.grid(row=0, column=3, padx=10, pady=10, sticky="ns")

    champMessBrut.grid(row=1, column=0, padx=10, pady=10, sticky="ns")
    champMessChiffre.grid(row=1, column=1, padx=10, pady=10, sticky="ns")
    champMessDechifre.grid(row=1, column=2, padx=10, pady=10, sticky="ns")
    champPaquet.grid(row=1, column=3, padx=10, pady=10, sticky="ns")

    boutonChiffrement.grid(row=2, column=0, padx=10, pady=10, sticky="ns")
    boutonDechiffrage.grid(row=2, column=1, padx=10, pady=10, sticky="ns")
    openFileACoderButton.grid(row=3, column=0, padx=10, pady=10, sticky="ns")
    openFileADecoderButton.grid(row=3, column=1, padx=10, pady=10, sticky="ns")
    copyPressePapierButton.grid(row=3, column=3, padx=10, pady=10, sticky="ns")
    setCleDechiffButton.grid(row=2, column=3, padx=10, pady=10, sticky="ns")

    fenetre.mainloop()


if __name__ == "__main__":
    initializeFenetre()
    pass

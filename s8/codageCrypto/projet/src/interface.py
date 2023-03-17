from tkinter import Text, Tk, Label, Button
from tkinter.filedialog import END, askopenfilename
import numpy as np
import chiffrement as chif
import pyperclip as pp

paquetGlobal = np.zeros(55)


# Créée le paquet utilisé pour chiffrer le message et l'écrit dans un fichier
def creationPaquet(champPaquet, annonce):
    global paquetGlobal
    # Création d'un paquet mélangé
    paquet = np.array([x for x in range(1, 55)])
    np.random.shuffle(paquet)
    paquetGlobal = paquet
    champPaquet.delete("1.0", END)
    annonce.config(text="Génération d'un nouveau paquet")
    champPaquet.insert(END, paquet)


# Chiffrage du message dans le champ de texte
def chiffrageMessage(champMessBrut, champMessChiffre,
                     champMessDechiffre, champPaquet, annonce):
    global paquetGlobal
    champMessChiffre.delete("1.0", END)
    champMessDechiffre.delete("1.0", END)
    annonce.config(text="")

    messageBrut = chif.formattageMessage(champMessBrut.get("1.0", 'end-1c'))
    if (messageBrut == ''):
        annonce.config(text="Aucun message à chiffrer")
        return

    if (champPaquet.get("1.0", 'end-1c') == ''):  # Pas de paquet défini
        creationPaquet(champPaquet, annonce)
    else:
        paquetString = champPaquet.get("1.0", "end-1c")[1:len(
            champPaquet.get("1.0", "end-1c"))-1]
        paquetGlobal = np.fromstring(paquetString, dtype=int, sep=" ")

    paquet = paquetGlobal
    messageVerification = chif.verificationPaquet(paquet)
    if (messageVerification != ""):
        annonce.config(text=messageVerification)
        return

    messageChiffre = chif.chiffrage(messageBrut, paquet)
    champMessChiffre.insert(END, messageChiffre)


# Déchiffrage du message dans le champ de texte
def dechiffrageMessage(champMessChiffre, champMessDechiffre,
                       champPaquet, annonce):
    global paquetGlobal
    champMessDechiffre.delete("1.0", END)
    annonce.config(text="")

    if (champPaquet.get("1.0", 'end-1c') != ''):  # Pas de paquet défini
        paquetString = champPaquet.get("1.0", "end-1c")[1:len(
            champPaquet.get("1.0", "end-1c"))-1]
        paquetGlobal = np.fromstring(paquetString, dtype=int, sep=" ")
        messageChiffre = chif.formattageMessage(
            champMessChiffre.get("1.0", 'end-1c'))

        if (messageChiffre != ''):  # Pas de message à déchiffrer
            messageDechiffre = chif.dechiffrage(paquetGlobal, messageChiffre)
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
        fichierInput.insert(END, fichier.read().strip())


def ouvrirPaquet(champPaquet):
    global paquetGlobal
    filename = askopenfilename(title="Ouvrir votre document", filetypes=[
                               ('txt files', '.txt'), ('all files', '.*')])
    with open(filename, "r") as fichier:
        paquetGlobal = fichier.read()

    champPaquet.delete("1.0", END)
    champPaquet.insert(END, paquetGlobal)


def copieCle():
    with open("bufferPaquet.txt", "r") as fichier:
        pp.copy(fichier.read())


def initializeFenetre():
    fenetre = Tk()

    fenetre.geometry("1080x400")
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

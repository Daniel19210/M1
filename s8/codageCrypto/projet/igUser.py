from tkinter import *
from tkinter.filedialog import *
import numpy as np
import random as rdn
import main as m

import pyperclip as pp

def main(messageBrut):
    # rdn.seed(1)  # Fixe le RNG
    # Création d'un paquet mélangé
    paquet = np.array(rdn.sample(range(1, 55), 54))
    m.genererCleEncodage(paquet, messageBrut)


def chiffrageMessage(inputtxt, outputtxt, b, affichCle):
    messageBrut = m.formattageMessage(inputtxt.get("1.0", 'end-1c'))
    main(messageBrut)
    messageChiffre = m.chiffrage(messageBrut, m.lectureFichier("cle.txt"))
    outputtxt.delete("1.0", END)
    outputtxt.insert(END, messageChiffre)
    affichCle.delete("1.0", END)
    affichCle.insert(END, m.lectureFichier("cle.txt"))
    b.delete("1.0", END)

def dechiffrageMessage(inputtxt, outputtxt):
    messageDechiffre = m.dechiffrage(m.lectureFichier("cle.txt"), m.formattageMessage(inputtxt.get("1.0",'end-1c')))
    outputtxt.delete("1.0", END)
    outputtxt.insert(END, messageDechiffre)

def ouvrirFichierCode(inputtxt):
    filename = askopenfilename(title="Ouvrir votre document", filetypes=[('txt files', '.txt'), ('all files', '.*')])
    fichier = open(filename, "r")
    inputtxt.delete("1.0", END)
    inputtxt.insert(END, fichier.read())
    fichier.close()

def ouvrirFichierDecode(inputtxt):
    filename = askopenfilename(title="Ouvrir votre document", filetypes=[('txt files', '.txt'), ('all files', '.*')])
    fichier = open(filename, "r")
    inputtxt.delete("1.0", END)
    inputtxt.insert(END, fichier.read())
    fichier.close()

def copieCle():
    fichier = open("cle.txt", "r")
    pp.copy(fichier.read())
    fichier.close()

def setCleDechiff():
    filename = askopenfilename(title="Ouvrir votre document", filetypes=[('txt files', '.txt'), ('all files', '.*')])
    fichier = open(filename, "r")
    m.ecritureMessage("cle.txt", fichier.read())
    fichier.close()

def initializeFenetre():
    fenetre = Tk()

    fenetre.geometry("1000x400")
    fenetre.title("Codage & Crypto")

    label1 = Label(fenetre, text = "Message à coder")
    label2 = Label(fenetre, text = "Message Codé")
    label3 = Label(fenetre, text = "Message décodé")

    inputtxt = Text(fenetre, height = 10, width = 30)
    outputtxt = Text(fenetre, height = 10, width = 30)
    resultatMessage = Text(fenetre, height = 10, width = 30)
    affichCle = Text(fenetre, height = 10, width = 30)

    cryptButton = Button(fenetre, text = "Chiffrer Message", command = lambda:chiffrageMessage(inputtxt, outputtxt, resultatMessage, affichCle))
    decryptButton = Button(fenetre, text = "Déchiffrer Message", command = lambda:dechiffrageMessage(outputtxt, resultatMessage))
    setCleDechiffButton = Button(fenetre, text = "Inserer cle de Dechiffrage", command = lambda:setCleDechiff())
    openFileACoderButton = Button(fenetre, text = "Ouvrir message a Coder", command = lambda:ouvrirFichierCode(inputtxt))
    openFileADecoderButton = Button(fenetre, text = "Ouvrir message a Décoder", command = lambda:ouvrirFichierDecode(outputtxt))

    copyPressePapierButton = Button(fenetre, text = "Copier Cle", command = lambda:copieCle())

    inputtxt.grid_propagate(False)
    outputtxt.grid_propagate(False)
    resultatMessage.grid_propagate(False)

    label1.grid(row = 0, column = 0, padx = 10, pady = 10, sticky = "ns")
    label2.grid(row = 0, column = 1, padx = 10, pady = 10, sticky = "ns")
    label3.grid(row = 0, column = 2, padx = 10, pady = 10, sticky = "ns")

    inputtxt.grid(row = 1, column = 0, padx = 10, pady = 10, sticky = "ns")
    outputtxt.grid(row = 1, column = 1, padx = 10, pady = 10, sticky = "ns")
    resultatMessage.grid(row = 1, column = 2, padx = 10, pady = 10, sticky = "ns")
    affichCle.grid(row = 1, column = 3, padx = 10, pady = 10, sticky = "ns")

    cryptButton.grid(row = 2, column = 0, padx = 10, pady = 10, sticky = "ns")
    decryptButton.grid(row = 2, column = 1, padx = 10, pady = 10, sticky = "ns")
    openFileACoderButton.grid(row = 3, column = 0, padx = 10, pady = 10, sticky = "ns")
    openFileADecoderButton.grid(row = 3, column = 1, padx = 10, pady = 10, sticky = "ns")
    copyPressePapierButton.grid(row = 2, column = 2, padx = 10, pady = 10, sticky = "ns")
    setCleDechiffButton.grid(row = 4, column = 1, padx = 10, pady = 10, sticky = "ns")

    fenetre.mainloop()

if __name__ == "__main__":
    initializeFenetre()
    pass

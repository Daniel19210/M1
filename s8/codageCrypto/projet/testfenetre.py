from tkinter import *

def initializeFenetre():
    fenetre = Tk()

    fenetre.geometry("800x500")
    fenetre.title("Codage & Crypto")

    label1 = Label(fenetre, text = "Message à coder")
    label2 = Label(fenetre, text = "Message Codé")

    inputtxt = Text(fenetre, height = 10, width = 30)
    outputtxt = Text(fenetre, height = 10, width = 30)

    cryptButton = Button(fenetre, text="Cypter Message", command = lambda:recupMessage(inputtxt, outputtxt))

    inputtxt.grid_propagate(False)
    outputtxt.grid_propagate(False)

    label1.grid(row = 0, column = 0, padx = 10, pady = 10, sticky = "ns")
    label2.grid(row = 0, column = 1, padx = 10, pady = 10, sticky = "ns")
    inputtxt.grid(row = 1, column = 0, padx = 10, pady = 10, sticky = "ns")
    outputtxt.grid(row = 1, column = 1, padx = 10, pady = 10, sticky = "ns")
    cryptButton.grid(row = 2, column = 0, padx = 10, pady = 10, sticky = "ns")

    fenetre.mainloop()

def recupMessage(inputtxt, outputtxt):
    INPUT = inputtxt.get("1.0", END)
    outputtxt.delete("1.0", END)
    outputtxt.insert(END, INPUT)

initializeFenetre()

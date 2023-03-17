import numpy as np
import inspect
from chiffrement import reculJokerNoir, reculJokerRouge, coupeDouble, coupeSimple, lecturePseudoAleatoire, verificationPaquet, ecritureMessage, lectureFichier, chiffrage, formattageMessage, genererCleEncodage


def testReculJokerNoirPaquetNeuf():
    paquet = np.array([x for x in range(1, 55)])
    paquet = reculJokerNoir(paquet)
    temoin = np.array([x for x in range(1, 53)] + [54, 53])
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testJokerNoirDernierePosition():
    paquet = np.array([x for x in range(1, 53)] + [54, 53])
    paquet = reculJokerNoir(paquet)
    temoin = np.array([1, 53]+[x for x in range(2, 53)]+[54])
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testReculJokerRougeDernierePosition():
    paquet = np.array([x for x in range(1, 55)])
    paquet = reculJokerRouge(paquet)
    temoin = np.array([1, 2, 54]+[x for x in range(3, 54)])
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testReculJokerRougeAvantDernierePosition():
    paquet = np.array([x for x in range(1, 53)]+[54, 53])
    paquet = reculJokerRouge(paquet)
    temoin = np.array([1, 54]+[x for x in range(2, 54)])
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testReculJokerRougePositionNormale():
    paquet = np.array([x for x in range(1, 26)] +
                      [54]+[x for x in range(26, 54)])
    paquet = reculJokerRouge(paquet)
    temoin = np.array([x for x in range(1, 28)] +
                      [54]+[x for x in range(28, 54)])
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testCoupeDouble():
    paquet = np.array([x for x in range(1, 53)])
    paquet = np.insert(paquet, 7, 54)
    paquet = np.insert(paquet, 42, 53)
    paquet = coupeDouble(paquet)

    p1 = np.array([x for x in range(42, 53)])
    p2 = np.concatenate(([54], np.array([x for x in range(8, 42)]), [53]))
    p3 = np.array([x for x in range(1, 8)])
    temoin = np.concatenate((p1, p2, p3))
    print("Passed :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print(
        "Failed :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testCoupeDoubleNeuf():
    paquet = np.array([x for x in range(1, 55)])
    paquet = coupeDouble(paquet)
    temoin = np.array([53, 54]+[x for x in range(1, 53)])
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testCoupeDoubleNormal():
    paquet = np.array([x for x in range(1, 21)]+[53] +
                      [x for x in range(21, 40)]+[54]+[x for x in range(40, 53)])
    paquet = coupeDouble(paquet)
    temoin = np.array([x for x in range(40, 53)]+[53] +
                      [x for x in range(21, 40)]+[54]+[x for x in range(1, 21)])
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testCoupeDoubleNormalJokerInverse():
    paquet = np.array([x for x in range(1, 21)]+[54] +
                      [x for x in range(21, 40)]+[53]+[x for x in range(40, 53)])
    paquet = coupeDouble(paquet)
    temoin = np.array([x for x in range(40, 53)]+[54] +
                      [x for x in range(21, 40)]+[53]+[x for x in range(1, 21)])
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testCoupeSimpleNeuf():
    paquet = np.array([x for x in range(1, 55)])
    paquet = coupeSimple(paquet)
    temoin = np.array([x for x in range(1, 55)])
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testCoupeSimpleNormal():
    paquet = np.array([x for x in range(1, 12)] +
                      [x for x in range(13, 55)]+[12])
    paquet = coupeSimple(paquet)
    temoin = np.array([x for x in range(14, 55)] +
                      [x for x in range(1, 12)]+[13, 12])
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testLectureAleatoireNeuf():
    paquet = np.array([x for x in range(1, 55)])
    carteTiree = lecturePseudoAleatoire(paquet)
    carteTemoin = 2
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if carteTemoin == carteTiree else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{carteTiree=}\n\t{carteTemoin=}")


def testLectureAleatoireJokerPremier():
    paquet = np.array([54]+[x for x in range(1, 54)])
    carteTiree = lecturePseudoAleatoire(paquet)
    carteTemoin = 4
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if carteTemoin == carteTiree else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{carteTiree=}\n\t{carteTemoin=}")


def testVerificationPaquetNormal():
    paquet = np.array([x for x in range(1, 55)])
    message = verificationPaquet(paquet)
    messageTemoin = ""
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if message == messageTemoin else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{message=}\n\t{messageTemoin=}")


def testVerificationPaquetCarteTrop():
    paquet = np.array([x for x in range(1, 55)] + [25])
    message = verificationPaquet(paquet)
    messageTemoin = "Le paquet ne contient pas le bon nombre de carte ou comporte autre chose que des cartes"
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if message == messageTemoin else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{message=}\n\t{messageTemoin=}")


def testVerificationPaquetCarteDouble():
    paquet = np.array([x for x in range(1, 40)] +
                      [x for x in range(41, 55)] + [30])
    message = verificationPaquet(paquet)
    messageTemoin = "Le paquet comporte un doublon"
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if message == messageTemoin else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{message=}\n\t{messageTemoin=}")


def testVerificationPaquetCarteInvalide():
    paquet = lectureFichier("exemple/paquet/lettre.txt")
    message = verificationPaquet(paquet)
    messageTemoin = "Le paquet ne contient pas le bon nombre de carte ou comporte autre chose que des cartes"
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if message == messageTemoin else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{message=}\n\t{messageTemoin=}")


def testGenerationCleLettreUnique():
    paquet = np.array([x for x in range(1, 55)])
    message = "A"
    cle = genererCleEncodage(paquet, message)
    cleTemoin = "D"
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if cle == cleTemoin else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{cle=}\n\t{cleTemoin=}")


def testGenerationCleLettre():
    paquet = np.array([x for x in range(1, 55)])
    message = "Test"
    cle = genererCleEncodage(paquet, message)
    cleTemoin = "DFFF"
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if cle == cleTemoin else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{cle=}\n\t{cleTemoin=}")


def testFormattageMessageNormal():
    message = "Test"
    messageChiffre = formattageMessage(message)
    messageTemoin = "Test"
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if messageChiffre == messageTemoin else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{messageChiffre=}\n\t{messageTemoin=}")


def testFormattageMessageAccent():
    message = "éèàçïüùà"
    messageFormattee = formattageMessage(message)
    messageTemoin = "eeaciuua"
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if messageFormattee == messageTemoin else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{messageFormattee=}\n\t{messageTemoin=}")


def testFormattageMessageEspace():
    message = "Te st"
    messageFormattee = formattageMessage(message)
    messageTemoin = "Test"
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if messageFormattee == messageTemoin else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{messageFormattee=}\n\t{messageTemoin=}")


def testFormattageMessageEspaceAccent():
    message = "Te sté pour ça"
    messageFormattee = formattageMessage(message)
    messageTemoin = "Testepourca"
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if messageFormattee == messageTemoin else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{messageFormattee=}\n\t{messageTemoin=}")


def testChiffrageMessageValide():
    message = "Test"
    paquet = np.array([x for x in range(1, 55)])
    messageChiffre = chiffrage(message, paquet)
    messageTemoin = "WJXY"
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if messageChiffre == messageTemoin else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{messageChiffre=}\n\t{messageTemoin=}")


def testChiffrageMessageAccent():
    message = "Testé"
    paquet = np.array([x for x in range(1, 55)])
    messageChiffre = chiffrage(message, paquet)
    messageTemoin = "WJXYL"
    print("Valide :", inspect.getframeinfo(inspect.currentframe()).function) if messageChiffre == messageTemoin else print(
        "Echoue :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{messageChiffre=}\n\t{messageTemoin=}")


# def testFormattageMessageAccent():
    # paquet = lectureFichier("texteExample/accent.txt")
    # mess


def testSuite():
    print("==================================================Test recul du joker noir de une position==================================================")
    testReculJokerNoirPaquetNeuf()
    testJokerNoirDernierePosition()
    print("==================================================Test recul du joker rouge de deux position==================================================")
    testReculJokerRougeDernierePosition()
    testReculJokerRougeAvantDernierePosition()
    testReculJokerRougePositionNormale()
    print("==================================================Test coupe double par rapport aux joker==================================================")
    testCoupeDouble()
    testCoupeDoubleNeuf()
    testCoupeDoubleNormal()
    testCoupeDoubleNormalJokerInverse()
    print("==================================================Test coupe simple déterminée par la dernière carte==================================================")
    testCoupeSimpleNeuf()
    testCoupeSimpleNormal()
    print("==================================================Test lecture pseudo aléatoire==================================================")
    testLectureAleatoireNeuf()
    testLectureAleatoireJokerPremier()
    print("==================================================Test validitée paquet==================================================")
    testVerificationPaquetNormal()
    testVerificationPaquetCarteTrop()
    testVerificationPaquetCarteDouble()
    testVerificationPaquetCarteInvalide()
    print("==================================================Test generation cle==================================================")
    testGenerationCleLettreUnique()
    testGenerationCleLettre()
    print("==================================================Test formattage message==================================================")
    testFormattageMessageNormal()
    testFormattageMessageAccent()
    testFormattageMessageEspace()
    testFormattageMessageEspaceAccent()
    print("==================================================Test chiffrage message==================================================")
    testChiffrageMessageValide()
    testChiffrageMessageAccent()
    print("Testsuite terminée")


def testFonctionRandom(fonction, nb):
    for i in range(1, nb):
        paquet = np.array([x for x in range(1, 55)])
        np.random.shuffle(paquet)
        paquet = fonction(paquet)


# Permet juste de savoir si on a une erreur avec un paquet quelconque
def testSuiteRandom():
    np.random.seed(1)
    nbRandom = 10000
    testFonctionRandom(reculJokerNoir, nbRandom)
    testFonctionRandom(reculJokerRouge, nbRandom)
    testFonctionRandom(coupeDouble, nbRandom)
    testFonctionRandom(coupeSimple, nbRandom)
    testFonctionRandom(lecturePseudoAleatoire, nbRandom)
    print("Testsuite random terminée")


testSuite()
# testSuiteRandom()

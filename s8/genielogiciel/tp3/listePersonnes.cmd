!create Roger : Personne -- Création d’une instance de la classe Personne
!set Roger.nom := 'Roger'
!set Roger.age := 22
!set Roger.sexe := #Homme
!create Simone : Personne -- Création d’une instance de la classe Personne
!set Simone.nom := 'Simone'
!set Simone.age := 45
!set Simone.sexe := #Femme
!create Linda : Personne -- Création d’une instance de la classe Personne
!set Linda.nom := 'Linda'
!set Linda.age := 15
!set Linda.sexe := #Femme
!create CompteRoger : Compte -- Création d’une instance de la classe Compte
!set CompteRoger.solde := 1500
!create CompteSimone : Compte -- Création d’une instance de la classe Compte
!set CompteSimone.solde := 2600
!create Universite : Entreprise -- Création d’une instance de la classe Entreprise
!set Universite.nom := 'UnivBourgogne'
!set Universite.budget := 7000
!set Universite.salaireEmploye := 1500
!create Banque : Entreprise -- Création d’une instance de la classe Entreprise
!set Banque.nom := 'MaBanque'
!set Banque.budget := 12000
!set Banque.salaireEmploye := 2000
-- Création des associations entre les instances de classe
!insert (Roger, CompteRoger) into CompteBancaire
!insert (Simone, CompteSimone) into CompteBancaire
!insert (Roger,Banque) into Emploi
!insert (Simone,Banque) into Emploi
!insert (CompteRoger,Banque) into Paie
!insert (CompteSimone,Banque) into Paie
!insert (Linda,Universite) into Emploi

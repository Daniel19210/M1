!create Roger : Homme -- Création d’une instance de la classe Personne
!set Roger.pere := false
!set Roger.grandPere := false
!set Roger.nom := 'Roger'
!set Roger.age := 22
!set Roger.sexe := #Homme
!create Simone : Femme -- Création d’une instance de la classe Personne
!set Simone.mere := false
!set Simone.grandMere := false
!set Simone.mereFilles := false
!set Simone.nom := 'Simone'
!set Simone.age := 45
!set Simone.sexe := #Femme
!create Joseph : Homme -- Création d'une instance de la classe Homme
!set Joseph.pere := false
!set Joseph.grandPere := false
!set Joseph.nom := 'Joseph'
!set Joseph.age := 12
!set Joseph.sexe := #Homme
!create Linda : Femme -- création d'une instance de la classe Femme
!set Linda.mere := false
!set Linda.grandMere := false
!set Linda.mereFilles := false
!set Linda.nom := 'Linda'
!set Linda.age := 15
!set Linda.sexe = #Femme
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

!insert (Linda, Linda) into ParentsEnfants

!insert (Linda, Joseph) into Frere
!insert (Linda, Linda) into Soeur

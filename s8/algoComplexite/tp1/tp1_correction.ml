(*====================================================================================*)
(* Correction du TP1 d'Algorithmique et Complexite. *)
(*====================================================================================*)

(* Pour lancer une session interactive d'OCaml dans un terminal : rlwrap ocaml. *)

(* Pour exécuter du code OCaml situe dans un fichier .ml depuis la 
session interactive : #use "nom_du_fichier.ml" ;; 

PS: Bien sur il faut changer nom_du_fichier par le vrai nom de votre fichier ... :) *)

(* Pour quitter la session interactive : #quit ;; *)

(* NB: Pour pouvoir trier des grandes listes, pensez a executer "export OCAMLRUNPARAM='l=4M'" dans 
votre terminal avant de faire appel a rlwrap ocaml. *)



(* ----- Question 1. *)

let rec insere_dans_liste_triee element liste =
	match liste with 
	| [] -> [element]
	| elt1::reste -> 
		if element < elt1 then element::liste 
		else elt1::(insere_dans_liste_triee element reste) ;;

let rec tri_insertion liste =
	match liste with
	| [] -> []
	| elt1::reste -> insere_dans_liste_triee elt1 (tri_insertion reste) ;;

(* 
1: Signature de la fonction recursive qui insere l'element en parametre dans une liste deja triee, aussi en parametre.
2: On regarde la composition de la liste donnee.
3: Si elle est vide, on retourne simplement l'element donne dans une nouvelle liste.
4: Sinon on separe le premier element du reste de la liste.
5: Si l'element qu'on veut inserer est plus petit que le premier element de la liste, alors il faut l'ajouter au début.
6: Sinon on laisse le premier element au debut et on retente l'insertion dans le reste de la liste.

8: Signature de la fonction recursive qui trie une liste donnee en parametre par insertion.
9: On regarde la composition de la liste donnee.
10: Si elle est vide, la liste est deja triee.
11: Sinon on separe le premier element du reste de la liste, on trie le reste et on insere simplement le premier 
element a la bonne place dans le reste de la liste qui a ete trie.
*)

(* ----- Question 2. *)

let rec insere_dans_liste_triee element liste fct_comparaison =
	match liste with 
	| [] -> [element]
	| elt1::reste -> 
		if fct_comparaison element elt1 
		then element::liste 
		else elt1::(insere_dans_liste_triee element reste fct_comparaison) ;;

let rec tri_insertion liste fct_comparaison =
	match liste with
	| [] -> []
	| elt1::reste -> insere_dans_liste_triee elt1 (tri_insertion reste fct_comparaison) fct_comparaison ;;

let cmp_croissant a b = a <= b ;;
(* ou *)
let cmp_croissant = (<=) ;;

let cmp_decroissant a b = a >= b ;;
(* ou *)
let cmp_decroissant = (>=) ;;

let cmp_coo_croissant (x1,y1) (x2,y2) = x1 <= x2 ;;
(* ou *)
let cmp_coo_croissant (x1,y1) (x2,y2) = cmp_croissant x1 x2 ;;
(* ou *)
let cmp_coo_croissant (x1,y1) (x2,y2) fct_comparaison = fct_comparaison x1 x2 ;;

(* ----- Question 3. *)

let liste_a_trier = [9;0;5;9;6] ;;
let liste_coo_a_trier = [(9,1);(0,2);(5,3);(9,4);(6,5)] ;;

tri_insertion liste_a_trier cmp_croissant ;;
tri_insertion liste_a_trier cmp_decroissant ;;
tri_insertion liste_coo_a_trier cmp_coo_croissant ;;



(* ----- Question 4. *)

let rec coupe_en_2 liste = 
  match liste with 
    | [] -> [], []
    | [_] -> liste, []
    | elt1::elt2::reste -> 
        let partie1, partie2 = coupe_en_2 reste in 
            elt1::partie1, elt2::partie2 ;;

let rec fusionne liste1 liste2 fct_comparaison = 
  match liste1, liste2 with 
    | [], _ -> liste2
    | _, [] -> liste1
    | (tete1::queue1), (tete2::queue2) -> 
        if fct_comparaison tete1 tete2
        then tete1::(fusionne queue1 liste2 fct_comparaison) 
        else tete2::(fusionne liste1 queue2 fct_comparaison) ;;

(* ----- Question 5. *)

let rec tri_fusion liste fct_comparaison = 
  match liste with 
    | []  -> []
    | [x] -> [x]
    | _ -> 
        let (partie1, partie2) = coupe_en_2 liste in 
        fusionne (tri_fusion partie1 fct_comparaison) (tri_fusion partie2 fct_comparaison) fct_comparaison ;;

(* ----- Question 6. *)

tri_fusion liste_a_trier cmp_croissant ;;
tri_fusion liste_a_trier cmp_decroissant ;;
tri_fusion liste_coo_a_trier cmp_coo_croissant ;;



(* ----- Question 7. *)

let rec tri_rapide liste fct_comparaison =
    let rec partition liste pivot petits egaux grands =
        match liste with 
        | [] -> List.concat [tri_rapide petits fct_comparaison; egaux; tri_rapide grands fct_comparaison]
        | elt1::reste -> 
                if (fct_comparaison elt1 pivot) 
                then partition reste pivot (elt1::petits) egaux grands
                else if (fct_comparaison pivot elt1) 
                    then partition reste pivot petits egaux (elt1::grands)
                    else partition reste pivot petits (elt1::egaux) grands 
    in 
    match liste with 
    | [] 
    | [_] -> liste
    | pivot::reste -> partition liste pivot [] [] [] ;;

(* ----- Question 8. *)

tri_rapide liste_a_trier cmp_croissant ;;
tri_rapide liste_a_trier cmp_decroissant ;;
tri_rapide liste_coo_a_trier cmp_coo_croissant ;;



(* ----- Question 9. *)

type 't arbre = Vide | Noeud of 't arbre * 't * 't arbre ;;

let tri_arbre liste fct_comparaison = 
    let arbre_binaire = List.fold_left (inserer fct_comparaison) Vide liste in
    lire_prefixe arbre_binaire [] ;;

let rec inserer fct_comparaison arbre element = 
    match arbre with
    | Vide -> Noeud(Vide, element, Vide)
    | Noeud(fils_gauche, valeur, fils_droit) ->
        if fct_comparaison element valeur
        then Noeud(inserer fct_comparaison fils_gauche element, valeur, fils_droit)
        else Noeud(fils_gauche, valeur, inserer fct_comparaison fils_droit element) ;;

(* ----- Question 10. *)

let rec lire_prefixe arbre liste = 
    match arbre with
    | Vide -> liste
    | Noeud(fils_gauche, valeur, fils_droit) -> lire_prefixe fils_gauche (valeur::(lire_prefixe fils_droit liste));;

(* ----- Question 11. *)

tri_arbre liste_a_trier cmp_croissant ;;
tri_arbre liste_a_trier cmp_decroissant ;;
tri_arbre liste_coo_a_trier cmp_coo_croissant ;;



(* ----- Question 12. *)

let rec liste_aleatoire taille max = 
    if taille = 0 then [] 
    else (Random.int max)::(liste_aleatoire (taille - 1) max) ;;

(* ----- Question 13. *)

let rec est_triee liste fct_comparaison = 
  match liste with
  | [] | [_] -> true
  | tete1::((tete2::queue2) as reste) -> 
    fct_comparaison tete1 tete2 && est_triee reste fct_comparaison ;;

(* ----- Question 14. *)

est_triee (tri_insertion (liste_aleatoire 10000 10000) cmp_croissant) cmp_croissant ;;
est_triee (tri_fusion (liste_aleatoire 10000 10000) cmp_croissant) cmp_croissant ;;
est_triee (tri_rapide (liste_aleatoire 10000 10000) cmp_croissant) cmp_croissant ;;
est_triee (tri_arbre (liste_aleatoire 10000 10000) cmp_croissant) cmp_croissant ;;
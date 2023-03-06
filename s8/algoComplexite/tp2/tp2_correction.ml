(*====================================================================================*)
(* Correction du TP2 d'Algorithmique et Complexite. *)
(*====================================================================================*)

(* Pour lancer une session interactive d'OCaml dans un terminal : rlwrap ocaml. *)

(* Pour exécuter du code OCaml situe dans un fichier .ml depuis la 
session interactive : #use "nom_du_fichier.ml" ;; 

PS: Bien sur il faut changer nom_du_fichier par le vrai nom de votre fichier ... :) *)

(* Pour quitter la session interactive : #quit ;; *)



(* ----- Question 1. *)

(* 
val map : ('a -> 'b) -> 'a list -> 'b list
    map f [a1; ...; an]
Prend en entree : une fonction qui prend en entree un element de type a et qui retourne un element de type b,
    une liste d'elements de type a.
Retourne en sortie : une liste d'elements de type b.
Ce qu'elle fait : applique une fonction sur chaque element d'une liste et retourne la liste des resultats.

val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a
    fold_left f init [b1; ...; bn]
Prend en entree : une fonction qui prend en entree un element de type a et un element de type b et qui retourne un element de type a,
    un element de type a,
    une liste d'elements de type b.
Retourne en sortie : un element de type a.
Ce qu'elle fait : parcourt une liste de gauche a droite et appelle a chaque etape une fonction en lui passant en parametres 
    le resultat retourne par l'appel de la fonction sur l'element precedent ainsi que l'element courant.
    Au premier appel, la valeur du parametre init est passee comme resultat precedent.

val fold_right : ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b
    fold_right f [a1; ...; an] init
Prend en entree : une fonction qui prend en entree un element de type a et un element de type b et qui retourne un element de type b,
    une liste d'elements de type a,
    un element de type b.
Retourne en sortie : un element de type b.
Ce qu'elle fait : idem que fold_left mais avec parcours de droite a gauche. Attention l'ordre des parametres est modifie.

val filter : ('a -> bool) -> 'a list -> 'a list
    filter f l
Prend en entree : une fonction qui prend en entree un element de type a et qui retourne un booleen,
    une liste d'elements de type a.
Retourne en sortie : une liste d'elements de type a.
Ce qu'elle fait : retourne uniquement les elements de la liste passee en parametre pour lesquels la fonction retourne true.
*)

(* ----- Question 2. *)

let rec map fonction liste =
    match liste with
    | [] -> []
    | elt1::reste -> (fonction elt1)::(map fonction reste) ;;

map (function x -> x + 1) [1;2;3;4] ;;

let rec fold_left fonction init liste =
    match liste with
    | [] -> init
    | elt1::reste -> fold_left fonction (fonction init elt1) reste ;;

fold_left (+) 0 [1;2;3;4] ;;

let rec fold_right fonction liste init =
    match liste with
    | [] -> init
    | elt1::reste -> fonction elt1 (fold_right fonction reste init) ;;

fold_right (+) [1;2;3;4] 0 ;;

let rec filter fonction liste =
    match liste with
    | [] -> []
    | elt1::reste -> if fonction elt1 then elt1::(filter fonction reste) else filter fonction reste ;;

filter (function x -> x mod 2 == 0) [1;2;3;4] ;;

(* ----- Question 3. *)

let rec rev liste =
    match liste with
    | [] -> []
    | [_] -> liste
    | elt1::reste -> (rev reste) @ [elt1] ;;

rev [1;2;3;4] ;;

let rev liste =
    let rec rev_rt liste acc =
        match liste with
        | [] -> acc
        | elt1::reste -> rev_rt reste (elt1::acc)
    in rev_rt liste [] ;;

rev [1;2;3;4] ;;

(* Oui la fonction est en recursion terminale, l'appel a rev_rt est la derniere operation executee
    a chaque etape. *)

(* ----- Question 4. *)

let concat liste_de_listes =
    let rec concat_rt liste_de_listes acc =
        match liste_de_listes with
        | [] -> acc
        | liste1::reste -> concat_rt reste (acc @ liste1)
    in concat_rt liste_de_listes [] ;;

concat [[1;2;3;4];[5;6;7;8]] ;;



(* ----- Question 5. *)

(* Version naive. *)
let rec fibonacci n =
    if n < 2 then n 
    else fibonacci (n-2) + fibonacci (n-1) ;;

fibonacci 0 ;; (* = 0. *) 
fibonacci 1 ;; (* = 1. *) 
fibonacci 2 ;; (* = 1. *) 
fibonacci 3 ;; (* = 2. *) 
fibonacci 16 ;; (* = 987. *) 

(* ----- Question 6. *)

(* Version iterative lineaire. *)
let fibonacci n =
    if n < 2 then n 
    else 
        let f1 = ref 1 in let f2 = ref 0 in let fn = ref 1 in
        for i=0 to (n-2) do 
            fn := !f1 + !f2 ;
            f2 := !f1 ;  f1 := !fn 
        done ;
        !fn ;;

(* Version lineaire en recursion terminale. *)
let fibonacci n =
    let rec fibonacci_rt n acc_f2 acc_f1 =
        if n = 0 then acc_f2
        else if n = 1 then acc_f1
        else fibonacci_rt (n-1) acc_f1 (acc_f2 + acc_f1) in
    fibonacci_rt n 0 1 ;;

(* ----- Question 7. *)

(* Version programmation dynamique avec tableau. *)
let fibonacci n =
    let tab_dyn = Array.make (if n > 1 then (n+1) else 3) (-1) in
    tab_dyn.(0) <- 0 ; tab_dyn.(1) <- 1 ; tab_dyn.(2) <- 1 ;
    let rec fibonacci_aux n =
        if tab_dyn.(n) < 0 then tab_dyn.(n) <- fibonacci_aux (n-1) + fibonacci_aux (n-2) else () ;
        tab_dyn.(n)
    in fibonacci_aux n ;;

(* ----- Question 8. *)

(* Version programmation dynamique avec table de hashage (memoisation). *)
let fibonacci n =
    let ht_dyn = Hashtbl.create n (*1*) in
    let rec fibonacci_aux n =
        try Hashtbl.find ht_dyn n (*2*)
        with Not_found -> 
            let fn = match n with
            | 0 -> 0
            | 1 | 2 -> 1
            | _ -> fibonacci_aux (n-1) + fibonacci_aux (n-2) 
            in Hashtbl.add ht_dyn n fn (*3*) ; fn
    in fibonacci_aux n ;;

(* ----- Question 9. *)

(* Version matricielle. *)
(* hg = haut-gauche, hd = haut-droite, bg = bas-gauche, bd = bas-droite. *)
type matrice = { hg: int; hd: int; bg: int; bd: int } ;;

let mult_matrices { hg = hg1; hd = hd1; bg = bg1; bd = bd1 } { hg = hg2; hd = hd2; bg = bg2; bd = bd2 } =
    { 
        hg = hg1 * hg2 + hd1 * bg2 ;
        hd = hg1 * hd2 + hd1 * bd2 ;
        bg = bg1 * hg2 + bd1 * bg2 ;
        bd = bg1 * hd2 + bd1 * bd2    
    } ;;

let puissance_2 matrice = 
    mult_matrices matrice matrice ;;

let rec puissance_n matrice n =
    if 0 = n then { hg = 1; hd = 0; bg = 0; bd = 1 } (* Matrice identite. *)
    else if 0 = n mod 2 then puissance_2 (puissance_n matrice (n/2))
        else mult_matrices matrice (puissance_n matrice (n-1)) ;;

let fibonacci n =
    in (puissance_n { hg = 1; hd = 1; bg = 1; bd = 0 } (n-1)).hg ;;



(* ----- Question 10. *)

let rec factorielle n =
    if n < 0 then failwith "n doit etre positif."
    else if 0 = n then 1
    else n * factorielle (n-1) ;;

factorielle 0 ;;
factorielle 1 ;;
factorielle 2 ;;
factorielle 3 ;;
factorielle 20 ;;
factorielle 25 ;;

#load "nums.cma" ;;
open Num ;;

(* Pour grands entiers. *)
let factorielle n =
    let rec factorielle_aux n =
        if n < 0 then failwith "n doit etre positif."
        else if 0 = n then (Int 1)
        else (Int n) */ factorielle (n-1)
    in string_of_num (factorielle_aux n) ;;

(* 
Quelques remarques interessantes :
- failwith permet de lever une erreur pour les fonctions qui ne sont pas toujours definies (applicable aussi sur Fibonacci) ;
- un symbole infixe est un operateur qui se place au milieu des deux elements qu'il traite ;
- */ est le symbole de la multiplication entre deux grands entiers. De facon similaire *. correspond a la multiplication entre flottants.
*)

(* ----- Question 11. *)

(* Pour grands entiers avec recursion terminale. *)
let factorielle n =
    let rec factorielle_rt n acc_moins1 =
        if n < 0 then failwith "n doit etre positif."
        else if n < 2 then string_of_num acc_moins1
        else factorielle_rt (n-1) ((Int n) */ acc_moins1) 
    in factorielle_rt n (Int 1) ;;
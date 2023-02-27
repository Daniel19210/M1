(*====================================================================================*)
(* Code mis à disposition pour le TP2 d'Algorithmique et Complexite. *)
(*====================================================================================*)

(* Pour lancer une session interactive d'OCaml dans un terminal : rlwrap ocaml. *)

(* Pour exécuter du code OCaml situe dans un fichier .ml depuis la 
session interactive : #use "nom_du_fichier.ml" ;; 

PS: Bien sur il faut changer nom_du_fichier par le vrai nom de votre fichier ... :) *)

(* Pour quitter la session interactive : #quit ;; *)
open Printf;;

(* ----- Fonction map
 Fonction qui prend en paramèetre une fonction et une liste puis renvoie 
 la liste avec la fonction appliquée à chaque élément de la liste.  *)
let rec map func liste =
    match liste with
    | [] -> []
    | t::q -> ( func t )::( map func q ) ;;

let l1 = [1;9;5;3] ;;
print_string("l1 = [") ;; let () = List.iter (printf "%d ") l1 ;; print_string("]\n") ;;

let f2 x = x * x ;;
let l1carre = map f2 l1 ;;
(* ----- Fonction fold_left
 Prends en param une fonction à 2 paramètre de type a et b et qui renvoie un élément du type a
 Prends en paramètre aussi un élément du type a
 Prends en paramètre aussi une liste de type b
 Renvoie un élément de type a
 Fonction qui prend en paramètre un opérateur, puis un élément, puis une liste.
 Elle renvoie un élément qui représente les opérations chainée à gauche 
 de l'élément par ce qu'il y a dans la liste. 
 Example : fold_left (+) 0 [a, b, c] -> (((0+a)+b)+c) *)
let rec fold_left op elem liste =
    match liste with
    | [] -> elem
    | t::q -> fold_left op ( op elem t ) q ;;

let l1LeftFolded = fold_left (+) 1 l1 ;;
Printf.printf "l1LeftFolded : %d\n" l1LeftFolded

(* ----- Fonction fold_right
 Fonction qui prend en paramètre un opérateur, puis un élément, puis une liste.
 Elle renvoie un élément qui représente les opérations chainée à droite
 de l'élément par ce qu'il y a dans la liste. 
 Example : fold_left (+) 0 [a, b, c] -> a+(b+(c+0)) *)
let rec fold_right op elem liste =
    match liste with
    | [] -> elem
    | t::q -> op t (fold_right op elem q)  ;;

let l2 = [5;2;1] ;;
print_string("l2") ;; let () = List.iter (printf "%d ") l2 ;; print_string("\n") ;;
let soustraction x1 x2 = x1 - x2 ;;
let l2RightFolded = fold_right (-) 0 l2 ;;
Printf.printf "l2RightFolded : %d\n" l2RightFolded ;;
let res = List.fold_right (-) l2 0;;

(* ----- Fonction filter 
 Fonction qui prend en paramètre un prédicat et une liste
 renvoie tous les éléments de la liste satisfaisant ce prédicat*)
let rec filter predicat liste =
    match liste with
    | [] -> []
    | t::q -> if predicat t then
                t::(filter predicat q)
              else
                filter predicat q ;;

let l3 = [1;2;3;4;5;6] ;;
let testPair x = x mod 2 == 0 ;;
let testImpair x = x mod 2 == 1 ;;
let l3Pair = filter testPair l3 ;;
let l3Impair = filter testImpair l3 ;;
print_string("l3Pair = ") ;; let () = List.iter (printf "%d ") l3Pair ;; print_string("\n") ;;
print_string("l3Impair = ") ;; let () = List.iter (printf "%d ") l3Impair ;; print_string("\n") ;;

(* ----- Fonction qui inverse l'ordre d'une liste. *)

let rec rev liste =
    match liste with
    | [] -> []
    | [_] -> liste
    | elt1::reste -> (rev reste) @ [elt1] ;;

(* ----- Fonction recursive terminale qui inverse l'ordre d'une liste. *)

let rec rev_rt liste acc =
    match liste with
    | [] -> acc
    | elt1::reste -> rev_rt reste (elt1::acc) ;;


(* ----- Fonction concat qui applatit une liste *)
(*let rec concat list acc=*)
    (*match list with*)
    (*| [] -> acc*)
    (*| t::q -> concat q t::acc ;;*)

(*let l4 = [l3Pair, l3Impair] ;;*)
(*let l4plat = concat l4 [] ;;*)
(*print_string("l4plat = ") ;; let () = List.iter (printf "%d ") l4plat ;; print_string("\n") ;;*)


(*
(* ----- Fonction iterative qui calcule la valeur de Fibonacci au rang n. *)

let fibonacci n =
    if n < 2 then n 
    else 
        let f1 = ref 1 in let f2 = ref 0 in let fn = ref 1 in
        for i=0 to (n-2) do 
            fn := !f1 + !f2 ;
            f2 := !f1 ;  f1 := !fn 
        done ;
        !fn ;;

(* ----- Fonction qui calcule la valeur de Fibonacci au rang n par programmation dynamique. *)
(* A completer bien sur sinon ca marche beaucoup moins bien. *)

let fibonacci n =
    let tab_dyn = Array.make ___ (-1) in
    tab_dyn.(0) <- ___ ; tab_dyn.(1) <- ___ ; tab_dyn.(2) <- ___ ;
    let rec fibonacci_aux n =
        if tab_dyn.(n) < 0 then ___ else () ;
        tab_dyn.(n)
    in fibonacci_aux n ;;

(* ----- Fonction qui calcule la valeur de Fibonacci au rang n par memoisation. *)
(* A completer bien sur sinon ca marche beaucoup moins bien. *)

let fibonacci n =
    let ht_dyn = (*1*) in
    let rec fibonacci_aux n =
        try (*2*) 
        with Not_found -> 
            let fn = match n with
            | 0 -> 0
            | 1 | 2 -> 1
            | _ -> fibonacci_aux (n-1) + fibonacci_aux (n-2) 
            in (*3*) ; fn
    in fibonacci_aux n ;;

(* ----- Definition du type matrice et de fonctions de multiplication. *)

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



(* ----- Fonction qui calcule la factorielle d'un entier. *)

let rec factorielle n =
    if n < 0 then failwith "n doit etre positif."
    else if 0 = n then 1
    else n * factorielle (n-1) ;;

(* ----- Fonction qui calcule la factorielle d'un grand entier. *)

#load "nums.cma" ;;
open Num ;;

let factorielle n =
    let rec factorielle_aux n =
        if n < 0 then failwith "n doit etre positif."
        else if 0 = n then (Int 1)
        else (Int n) */ factorielle (n-1)
    in string_of_num (factorielle_aux n) ;;
*)

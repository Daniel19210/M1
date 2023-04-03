(*====================================================================================*)
(* Correction du TP4 d'Algorithmique et Complexite. *)
(*====================================================================================*)

(* Pour lancer une session interactive d'OCaml dans un terminal : rlwrap ocaml. *)

(* Pour exécuter du code OCaml situe dans un fichier .ml depuis la 
session interactive : #use "nom_du_fichier.ml" ;; 

PS: Bien sur il faut changer nom_du_fichier par le vrai nom de votre fichier ... :) *)

(* Pour quitter la session interactive : #quit ;; *)

(* ----- Question 1. *)

let tab_sous_sequence s1 s2 =
    let taille_s1 = Array.length s1 in
    let taille_s2 = Array.length s2 in
    let tab_dynamique = Array.init (taille_s1 + 1) (function i -> Array.make (taille_s2 + 1) 0) in

    let rec tab_sous_sequence_aux i j =
        if j <= taille_s2 
        then ( tab_dynamique.(i).(j) <- if s1.(i-1) = s2.(j-1)
                                        then tab_dynamique.(i-1).(j-1) + 1
                                        else max tab_dynamique.(i-1).(j) tab_dynamique.(i).(j-1) ;
            tab_sous_sequence_aux i (j+1) )
        else ( if i < taille_s1 then tab_sous_sequence_aux (i+1) 1  )
    in tab_sous_sequence_aux 1 1 ;
    
    tab_dynamique ;;

(* ----- Question 2. *)

let string_to_array chaine = Array.of_list (List.init (String.length chaine) (String.get chaine)) ;;

let sous_sequence sequence_1 sequence_2 =
    let taille_seq_1 = Array.length sequence_1 in
    let taille_seq_2 = Array.length sequence_2 in
    let tab_dynamique = tab_sous_sequence sequence_1 sequence_2 in
    let rec parcourir_tableau i j chaine_resultat =
        match i, j with
        | 0, 0 -> String.of_seq (List.to_seq chaine_resultat)
        | 0, _ -> parcourir_tableau i (j-1) chaine_resultat
        | _, 0 -> parcourir_tableau (i-1) j chaine_resultat
        | _, _ -> if sequence_1.(i-1) = sequence_2.(j-1)
                  then parcourir_tableau (i-1) (j-1) (sequence_1.(i-1)::chaine_resultat)
                  else if (tab_dynamique.(i).(j) = tab_dynamique.(i-1).(j) && tab_dynamique.(i).(j) > tab_dynamique.(i).(j-1))
                       then parcourir_tableau (i-1) j chaine_resultat
                       else parcourir_tableau i (j-1) chaine_resultat
    in (tab_dynamique.(taille_seq_1).(taille_seq_2),
        parcourir_tableau (taille_seq_1) (taille_seq_2) [],
        tab_dynamique) ;;

sous_sequence (string_to_array "algo") (string_to_array "facile") ;;



(* ----- Question 3. *)

let tab_sac_a_dos capacite_max tab_poids tab_utilites =
    let nb_objets = Array.length tab_poids in
    let umax = Array.init (nb_objets + 1) (function i -> Array.make (capacite_max + 1) 0) in

    let rec tab_sac_a_dos_aux i c =
        if c <= capacite_max 
        then ( umax.(i).(c) <- if tab_poids.(i-1) <= c
                              then max umax.(i-1).(c) (umax.(i-1).(c-tab_poids.(i-1)) + tab_utilites.(i-1))
                              else umax.(i-1).(c) ;
            tab_sac_a_dos_aux i (c+1) )
        else ( if i < nb_objets then tab_sac_a_dos_aux (i+1) 0 )
    in tab_sac_a_dos_aux 1 0 ;

    umax ;;

(* ----- Question 4. *)

let sac_a_dos umax tab_poids =
    let nb_objets = (Array.length umax) - 1 in
    let capacite = (Array.length umax.(0)) - 1 in
    let rec parcourir_tableau i c contenu_sac =
        match i, c with
        | 0, 0 -> contenu_sac
        | 0, _ -> parcourir_tableau i (c-1) contenu_sac
        | _, 0 -> parcourir_tableau (i-1) c contenu_sac
        | _, _ -> if umax.(i).(c) > umax.(i-1).(c)
                  then parcourir_tableau (i-1) (c - tab_poids.(i-1)) (i::contenu_sac)
                  else parcourir_tableau (i-1) c contenu_sac
    in (umax.(nb_objets).(capacite),
        parcourir_tableau nb_objets capacite []) ;;

let capacite = 7 ;;
let nb_objets = 5 ;;
let poids = [| 1 ; 3 ; 5 ; 3 ; 1 |] ;;
let utilites = [| 1 ; 5 ; 2 ; 1 ; 3 |] ;;

let umax = tab_sac_a_dos capacite poids utilites ;;
let utilite_max = umax.(nb_objets).(capacite) ;;
let objets_dans_sac = sac_a_dos umax poids ;;

(* ----- Question 4.Bonus. *)

let tab_sac_a_dos capacite_max tab_poids tab_utilites =
    let nb_objets = Array.length tab_poids in
    let umax = Hashtbl.create (nb_objets * capacite_max) in 

    let rec tab_sac_a_dos_aux paire_ic =
        try Hashtbl.find umax paire_ic
        with Not_found ->
            let val_calculee = match paire_ic with
            | (0, c) -> if tab_poids.(0) <= c then tab_utilites.(0) else 0
            | (i, c) -> if c >= tab_poids.(i)
                        then max (tab_sac_a_dos_aux (i-1, c)) ((tab_sac_a_dos_aux (i-1, c - tab_poids.(i))) + tab_utilites.(i))
                        else tab_sac_a_dos_aux (i-1, c)
            in Hashtbl.add umax paire_ic val_calculee ; val_calculee
    in let _ = tab_sac_a_dos_aux (nb_objets - 1, capacite_max) in umax ;;

let print_umax umax = Hashtbl.iter (fun (i,c) y -> Printf.printf "(%d, %d) -> %d\n" i c y) umax ;;

let capacite = 7 ;;
let nb_objets = 5 ;;
let poids = [| 1 ; 3 ; 5 ; 3 ; 1 |] ;;
let utilites = [| 1 ; 5 ; 2 ; 1 ; 3 |] ;;

let umax = tab_sac_a_dos capacite poids utilites ;;
print_umax umax ;;
let utilite_max = Hashtbl.find umax (nb_objets-1, capacite) ;;



(* ----- Question 5. *)

let memoiser fonction =
	let hashtable = Hashtbl.create 123 in
	let rec fonction_aux x param =
		try Hashtbl.find hashtable x 
		with Not_found -> 
            let resultat = fonction fonction_aux x param
            in Hashtbl.add hashtable x resultat ; 
            resultat
        in (fonction_aux, hashtable) ;;

(* Type = val memoiser : (('a -> 'b -> 'c) -> 'a -> 'b -> 'c) -> ('a -> 'b -> 'c) * ('a, 'c) 
La fonction en paramètre prend en entrée : 
    une fonction à deux paramètres (qu'on va appeleer ici x et y), 
    un paramètre du même type que x,
    un paramètre du même type que y.
Elle retourne une valeur du même type que la valeur de retour de sa fonction en paramètre.*)        

(* ----- Question 6. *)

let rec fibo fibo_aux x _ =
	if x < 2 then x 
	else (fibo_aux (x-1) ()) + (fibo_aux (x-2) ()) ;;

let fibo_memoizee, ht_fibo = memoiser fibo ;;
let fibonacci x = fibo_memoizee x () ;;
fibonacci 50 ;;



(* ----- Question 7. *)

let sommets = [| 'A'; 'B'; 'C'; 'D'; 'E'; 'F' |] ;;
let arcs = [| ('A', 'B', 100); ('A', 'C', 200); ('B', 'D', 50); ('B', 'E', 60); ('C', 'D', 70);
('C', 'E', 80); ('D', 'F', 10); ('E', 'F', 20) |] ;;
let source = 'A' ;;
let terminal = 'F' ;;

let rec plus_tot plus_tot_aux sommet (arcs, arcs_restants, sommet_source, duree_defaut, duree_max) =
    if sommet = sommet_source then 0
    else ( match arcs_restants with 
            | [] -> duree_max
            | (source, destination, duree)::reste ->
                if destination <> sommet
                then plus_tot plus_tot_aux sommet (arcs, reste, sommet_source, duree_defaut, duree_max) 
                else plus_tot plus_tot_aux sommet (arcs, reste, sommet_source, duree_defaut,
                    (max duree_max ((plus_tot_aux source (arcs, arcs, sommet_source, duree_defaut, duree_defaut)) + duree)))) ;;

let memo_plus_tot, ht_plus_tot = memoiser plus_tot ;;
let au_plus_tot arcs sommet_source sommet_terminal = 
    let liste_arcs = Array.to_list arcs in memo_plus_tot sommet_terminal (liste_arcs, liste_arcs, sommet_source, -999, -999) ;;

au_plus_tot arcs source terminal ;;

let print_ht_pert ht = Hashtbl.iter (fun x y -> Printf.printf "%c -> %d\n" x y) ht ;;
print_ht_pert ht_plus_tot ;;

let rec plus_tard plus_tard_aux sommet (arcs, arcs_restants, sommet_terminal, plus_tot_terminal, duree_defaut, duree_min) =
    if sommet = sommet_terminal then plus_tot_terminal
    else ( match arcs_restants with 
            | [] -> duree_min
            | (source, destination, duree)::reste ->
                if source <> sommet
                then plus_tard plus_tard_aux sommet (arcs, reste, sommet_terminal, plus_tot_terminal, duree_defaut, duree_min) 
                else plus_tard plus_tard_aux sommet (arcs, reste, sommet_terminal, plus_tot_terminal, duree_defaut,
                    (min duree_min ((plus_tard_aux destination (arcs, arcs, sommet_terminal, plus_tot_terminal, duree_defaut, duree_defaut)) - duree)))) ;;

let memo_plus_tard, ht_plus_tard = memoiser plus_tard ;;
let au_plus_tard arcs sommet_source sommet_terminal = 
    let liste_arcs = Array.to_list arcs in memo_plus_tard sommet_source (liste_arcs, liste_arcs, sommet_terminal, (au_plus_tot arcs sommet_source sommet_terminal), 999, 999) ;;

au_plus_tard arcs source terminal ;;
print_ht_pert ht_plus_tard ;;

(* ----- Question 8. *)

let print_critiques arcs ht_tot ht_tard =
    let rec print_critiques_aux arcs_restants =
        match arcs_restants with
        | [] -> ()
        | (source, destination, duree)::reste -> 
            if (Hashtbl.find ht_tot source) = (Hashtbl.find ht_tard source) 
            && (Hashtbl.find ht_tot destination) = (Hashtbl.find ht_tard destination)
            && duree = (Hashtbl.find ht_tot destination) - (Hashtbl.find ht_tot source)
            then Printf.printf "(%c, %c, %d) est critique\n" source destination duree ; 
            print_critiques_aux reste
    in print_critiques_aux (Array.to_list arcs) ;;

print_critiques arcs ht_plus_tot ht_plus_tard ;;
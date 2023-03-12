(*====================================================================================*)
(* Code mis à disposition pour le TP3 d'Algorithmique et Complexite. *)
(*====================================================================================*)

(* Pour lancer une session interactive d'OCaml dans un terminal : rlwrap ocaml. *)

(* Pour exécuter du code OCaml situe dans un fichier .ml depuis la 
session interactive : #use "nom_du_fichier.ml" ;; 

PS: Bien sur il faut changer nom_du_fichier par le vrai nom de votre fichier ... :) *)

(* Pour quitter la session interactive : #quit ;; *)

(* ----- Definition du type graphe. *)
open Printf;;

type 'a graphe = { 
    sommets: 'a array; 
    aretes: ((int * float) list) array (*Liste d'adjascence*)
} ;;

let grapheComplet = {
                        sommets = [|"A"; "B"; "C"; "D"; "E"; "F"; "G"; "H"; "I"; "J"|];
                        aretes = [|
                            [(1, 85.); (2, 217.); (4, 173.)];    (* 0, A *)
                            [(0, 85.); (5, 80.)];                (* 1, B *)
                            [(0, 217.); (6, 186.); (7, 103.)];   (* 2, C *)
                            [(7, 183.)];                         (* 3, D *)
                            [(0, 173.); (9, 502.)];              (* 4, E *)
                            [(1, 80.); (8, 250.)];               (* 5, F *)
                            [(2, 186.)];                         (* 6, G *)
                            [(2, 103.); (3, 183.); (9, 167.)];   (* 7, H *)
                            [(5, 250.); (9, 84.)];               (* 8, I *)
                            [(4, 502.); (7, 167.); (8, 84.)];    (* 9, J *)
                            |]
                    };;

let rec get_indice_min_array_rec array sommet_marque elemMin indiceMin nbRec =
    if Array.length array == 0 then
        indiceMin
    else
        if ( array.(0) >= elemMin || Array.exists (fun a -> a == nbRec) sommet_marque ) then
            get_indice_min_array_rec (Array.sub array 1 ((Array.length array)-1)) sommet_marque elemMin indiceMin (nbRec+1)
        else
            get_indice_min_array_rec (Array.sub array 1 ((Array.length array)-1)) sommet_marque array.(0) nbRec (nbRec+1);;

let rec get_indice_min_array_init array sommet_marque =
    get_indice_min_array_rec array sommet_marque infinity (-1) 0 ;;

let rec traitement_liste_voisin listeVoisin indice_sommet_min tab_d tab_p =
    match listeVoisin with
    | [] -> tab_d, tab_p
    | tuple_voisin::voisin_restant -> let dist_voisin =
            if (tab_d.(indice_sommet_min) == infinity) then
                snd tuple_voisin
            else
                tab_d.(indice_sommet_min) +. snd tuple_voisin
        in
        if dist_voisin < tab_d.(fst tuple_voisin) then (
            tab_d.(fst tuple_voisin) <- dist_voisin ;
            tab_p.(fst tuple_voisin) <- indice_sommet_min ;
        );
        traitement_liste_voisin voisin_restant indice_sommet_min tab_d tab_p ;;

let rec traitement_point graphe tab_d tab_p tab_m =
    if (Array.length tab_m == Array.length tab_d)  then
        (tab_d, tab_p)
    else (
        let indice_sommet_min = get_indice_min_array_init tab_d tab_m in
        let liste_voisin_min = graphe.aretes.(indice_sommet_min) in
        let tab_d, tab_p = traitement_liste_voisin liste_voisin_min indice_sommet_min tab_d tab_p in
        let tab_m = Array.append tab_m [| indice_sommet_min |] in
        traitement_point graphe tab_d tab_p tab_m;
    );;

let dijkstra graphe indice_depart =
    let n = Array.length graphe.sommets in
    let tab_d = Array.make n infinity in
    let tab_p = [| -1; -1; -1; -1; -1; -1; -1; -1; -1; -1 |] in
    let tab_m = [| |] in
    tab_d.(indice_depart) <- 0. ;
    tab_p.(indice_depart) <- indice_depart ;
    traitement_point graphe tab_d tab_p tab_m;;

let arrayD, arrayP = dijkstra grapheComplet 0 ;;
print_string("tableau des distance = [") ;; Array.iter (printf "%f ") arrayD;; print_string("]\n");;
print_string("tableau des prédécesseurs = [") ;; Array.iter (printf "%d ") arrayP;; print_string("]\n");;

(*
(* ----- Definition du type tas. *)

type 't tas = Vide | Noeud of 't tas * 't * 't tas ;;

let rec ajouter element tas = 
	match tas with
	| Vide -> Noeud (Vide, element, Vide)
	| Noeud (fils_gauche, valeur, fils_droit) -> 
		Noeud (fils_droit, min valeur element, ajouter (max valeur element) fils_gauche) ;;

let rec ajouter_plusieurs liste tas = 
	match liste with
	| [] -> tas
	| elt1::reste -> ajouter elt1 (ajouter_plusieurs reste tas) ;;

let rec supprimer_premier_noeud tas = 
	match tas with
	| Vide -> Vide
	| Noeud (Vide, _, fils_droit) -> fils_droit
	| Noeud (fils_gauche, _, Vide) -> fils_gauche
	| Noeud ((Noeud (fg_fg, fg_val, fg_fd) as fg), valeur, (Noeud (fd_fg, fd_val, fd_fd) as fd)) -> 
		if fg_val < fd_val
		then Noeud (supprimer_premier_noeud fg, fg_val, fd)
		else Noeud (fg, fd_val, supprimer_premier_noeud fd) ;;

let vider tas = 
    let rec vider_rt tas acc =
        match tas with
        | Vide -> acc
        | Noeud (_, valeur, _) as noeud -> vider_rt (supprimer_premier_noeud noeud) (acc @ [valeur])
    in vider_rt tas [] ;; 

let creer_tas liste_elements = ajouter_plusieurs liste_elements Vide ;;



(* ----- Chargement du module pour faire du graphique. *)

#load "graphics.cma";;
open Graphics ;;

(* ----- Genere un ensemble de sommets sur l'interface graphique en evitant les coordonnees situees dans les trous. *)

let genere_sommets nb_sommets trous =
    let rec genere_sommets_rt nb_sommets trous acc = 
        if 0 = nb_sommets 
        then acc
        else 
            let x, y = Random.int 800, Random.int 800 in
            match List.filter (function trou -> trou (x,y)) trous with
            | [] -> genere_sommets_rt (nb_sommets - 1) trous ((x,y)::acc) 
            | _ -> genere_sommets_rt nb_sommets trous acc 
    in Array.of_list (genere_sommets_rt nb_sommets trous []) ;;

(* ----- Affiche des sommets sur l'interface graphique. *)

let affichage_sommets sommets = 
    clear_graph () ;
    Array.iter (function (x,y) -> plot x y) sommets ;;



(* ----- Calcule la distance entre deux points de l'interface graphique. *)

let puissance_2 x = x * x ;;
let distance (x1, y1) (x2, y2) = sqrt (float_of_int ((puissance_2 (x1 - x2)) + (puissance_2 (y1 - y2)))) ;;

(* ----- Cree des aretes entre paires de sommets. *)

let genere_aretes sommets rayon =
    let nb_sommets = Array.length sommets in
    let aretes = Array.make nb_sommets [] in
    let rec genere_aretes_rt sommets_restants =
        match sommets_restants with 
        | [] -> aretes
        | sommet::reste ->
            let aretes_sommet = List.fold_left (fun acc autre_sommet -> 
                if (distance sommet autre_sommet) < rayon 
                then (sommet, autre_sommet)::acc
                else acc) [] sommets 
            in aretes.(sommet) <- aretes_sommet
    in genere_aretes_rt sommets ;;

(* ----- Affiche une deuxieme version de l'interface graphique uniquement avec les aretes. *)

let affichage_aretes sommets aretes = 
    clear_graph() ;
    Array.iteri (fun sommet_source aretes_source -> 
        let xs, ys = sommets.(sommet_source) in
        List.iter (function (sommet_destination, _) -> 
            (* NB: Si le sommet de destination est avant la source alors l'arete a deja ete dessinee. *)
            if sommet_destination > sommet_source then (let xd, yd = sommets.(sommet_destination) in moveto xs ys; lineto xd yd)
        ) aretes_source
    ) aretes ;;   



(* Dessine sur l'interface graphique le chemin le plus court entre un sommet de depart et une destination a partir des resultats de Dijkstra. *)

let rec dessine_chemin sommets predecesseurs sommet_depart sommet_destination =
	if sommet_destination <> sommet_depart && predecesseurs.(sommet_destination) <> -1
	then ( 
        let xd, yd = sommets.(sommet_destination) in
        let xp, yp = sommets.(predecesseurs.(sommet_destination)) in
		set_color magenta ; set_line_width 2 ; moveto xd yd ; lineto xp yp ;
		dessine_chemin sommets predecesseurs sommet_depart predecesseurs.(sommet_destination)
    )
	else (set_line_width 0 ; set_color black) ;;

(* Affiche une troisieme version de l'interface graphique uniquement avec les plus courts chemins a partir d'un sommet donne. *)

let affichage_chemins sommets aretes sommet_depart = 
    let distances, predecesseurs = dijkstra { sommets = sommets; aretes = aretes } sommet_depart in 
    clear_graph();

    Array.iteri (fun sommet predecesseur -> 
        if predecesseur <> -1
        then 
            let xs, ys = sommets.(sommet) in 
            let xp, yp = sommets.(predecesseur) in 
            (moveto xs ys ; lineto xpi ypi)
    ) predecesseurs ;

    set_color red ;
    let x, y = sommets.(sommet_depart) in  fill_circle x y 3 ; 
    dessine_chemin sommets predecesseurs sommet_depart 0 ;
    dessine_chemin sommets predecesseurs sommet_depart ((Array.length aretes) - 1) ;
    set_color black ;;
 *)

(*====================================================================================*)
(* Correction du TP3 d'Algorithmique et Complexite. *)
(*====================================================================================*)

(* Pour lancer une session interactive d'OCaml dans un terminal : rlwrap ocaml. *)

(* Pour exécuter du code OCaml situe dans un fichier .ml depuis la 
session interactive : #use "nom_du_fichier.ml" ;; 

PS: Bien sur il faut changer nom_du_fichier par le vrai nom de votre fichier ... :) *)

(* Pour quitter la session interactive : #quit ;; *)

(* ----- Question 1. *)

type 'a graphe = { 
    sommets: 'a array; (* Tableau d'elements dont le type est generique. *)
    aretes: ((int * float) list) array (* Liste d'adjacence avec prise en consideration du poids via paire. *)
} ;;

(* ----- Question 2. *)

(* Oui puisque les aretes sont representees sous forme de liste d'adjacence. *)

(* ----- Question 3. *)

let g = {
    sommets = [| "A"; "B"; "C"; "D"; "E"; "F"; "G"; "H"; "I"; "J" |] ;
    aretes = [|
        (* aretes dont A est la source. *) [(1, 85.); (2, 217.); (4, 173.)] ;
        (* aretes dont B est la source. *) [(0, 85.); (5, 80.)] ;
        (* aretes dont C est la source. *) [(0, 217.); (6, 186.); (7, 103.)] ;
        (* aretes dont D est la source. *) [(7, 183.)] ;
        (* aretes dont E est la source. *) [(0, 173.); (9, 502.)] ;
        (* aretes dont F est la source. *) [(1, 80.); (8, 250.)] ;
        (* aretes dont G est la source. *) [(2, 186.)] ;
        (* aretes dont H est la source. *) [(2, 103.); (3, 183.); (9, 167.)] ;
        (* aretes dont I est la source. *) [(5, 250.); (9, 84.)] ;
        (* aretes dont J est la source. *) [(8, 84.); (7, 167.); (4, 502.)] ;
    |]
} ;;



(* ----- Question 4. *)

let sequence from to_ =
    let rec sequence_rt from to_ acc =
        if from >= to_ then acc
        else sequence_rt (from + 1) to_ (acc @ [from])
    in sequence_rt from to_ [] ;;    

let dijkstra graphe sommet_depart = 
    let nb_sommets = Array.length graphe.sommets in
    let distances = Array.make nb_sommets infinity in 
    let predecesseurs = Array.make nb_sommets (-1) in 

    distances.(sommet_depart) <- 0. ; predecesseurs.(sommet_depart) <- sommet_depart ;

    let rec dijkstra_aux sommets_restants =
        match sommets_restants with
        | [] -> distances, predecesseurs
        | elt1::reste -> ( 
            let sommet_dist_min = List.fold_left (fun i j -> if distances.(i) < distances.(j) then i else j) elt1 reste in
            List.iter (function (destination, poids) -> 
                let nouvelle_dist = distances.(sommet_dist_min) +. poids in
                if nouvelle_dist < distances.(destination) 
                then (distances.(destination) <- nouvelle_dist; predecesseurs.(destination) <- sommet_dist_min)
            ) graphe.aretes.(sommet_dist_min) ;
            dijkstra_aux (List.filter (function sommet -> sommet <> sommet_dist_min) sommets_restants)
        ) 
    in dijkstra_aux (sequence 0 nb_sommets) ;;

(* ----- Question 5. *)

dijkstra g 0 ;;



(* ----- Question 6. *)

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

vider (creer_tas [9;0;5;9;6]) ;;



(* ----- Question 7. *)

let dijkstra graphe sommet_depart =
    let nb_sommets = Array.length graphe.sommets in
    let distances = Array.make nb_sommets infinity in 
    let predecesseurs = Array.make nb_sommets (-1) in 

    distances.(sommet_depart) <- 0. ; predecesseurs.(sommet_depart) <- sommet_depart ;

    let rec dijkstra_aux tas =
        match tas with
        | Vide -> distances, predecesseurs
        | Noeud(_, (sommet_dist_min, dist_depuis_depart), _) -> 
            let nouveau_tas = supprimer_premier_noeud tas in
            if dist_depuis_depart > distances.(sommet_dist_min)
            then dijkstra_aux nouveau_tas
            else dijkstra_aux (List.fold_left (fun noeud (sommet, dist_actuelle) -> 
                let nouvelle_dist = distances.(sommet_dist_min) +. dist_actuelle in
                if nouvelle_dist < distances.(sommet)
                then (distances.(sommet) <- nouvelle_dist ; predecesseurs.(sommet) <- sommet_dist_min ; ajouter (sommet, distances.(sommet)) noeud) 
                else noeud) nouveau_tas graphe.aretes.(sommet_dist_min)
            )
	in 
    
    dijkstra_aux (creer_tas [(sommet_depart, 0.)]) ;;

dijkstra g 0 ;;



(* ----- Question 8. *)

#load "graphics.cma";;
open Graphics ;;

(* Genere un ensemble de sommets sur l'interface graphique en evitant les coordonnees situees dans les trous. *)
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

(* Affiche des sommets sur l'interface graphique. *)
let affichage_sommets sommets = 
    clear_graph () ;
    Array.iter (function (x,y) -> plot x y) sommets ;;

(* ----- Question 9. *)

close_graph() ;;
open_graph " 800x800" ;;

let puissance_2 x = x * x ;;

let trous = [
    (function (x,y) -> 200 < x && x < 600 && 600 < y && y < 700) ;                          (* Rectangle de 400x100 decale en 400 650. *)
    (function (x,y) -> puissance_2 (x - 500) + puissance_2 (y - 300) < puissance_2 200)     (* Cercle de rayon egal a 200 decale en -500 -300. *)
] ;;

let nb_sommets_aff = 50000 ;;
let sommets_aff = genere_sommets nb_sommets_aff trous ;;

affichage_sommets sommets_aff ;;
let _ = read_line() ;;



(* ----- Question 10. *)

(* Calcule la distance entre deux points de l'interface graphique. *)
let distance (x1, y1) (x2, y2) = sqrt (float_of_int ((puissance_2 (x1 - x2)) + (puissance_2 (y1 - y2)))) ;;

(* Cree une arete entre chaque paire de sommets dont la distance est inferieure a un certain rayon. *)
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

(* Affiche une deuxieme version de l'interface graphique uniquement avec les aretes. *)
let affichage_aretes sommets aretes = 
    clear_graph() ;
    Array.iteri (fun sommet_source aretes_source -> 
        let xs, ys = sommets.(sommet_source) in
        List.iter (function (sommet_destination, _) -> 
            (* NB: Si le sommet de destination est avant la source alors l'arete a deja ete dessinee. *)
            if sommet_destination > sommet_source then (let xd, yd = sommets.(sommet_destination) in moveto xs ys; lineto xd yd)
        ) aretes_source
    ) aretes ;;   

(* ----- Question 11. *)

let rayon_liaison_aff = 10 ;;
let aretes_aff = genere_aretes sommets rayon_liaison_aff ;;

affichage_aretes sommets_aff aretes_aff ;;
let _ = read_line() ;;



(* ----- Question 12. *)

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

affichage_chemins sommets_aff aretes_aff (Random.int (Array.length sommets_aff)) ;;
let _ = read_line() ;;
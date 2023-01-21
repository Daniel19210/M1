
module G=Graphics;;


(*rouge,vert,bleu*)
let decompose_color rgb=
        let r=rgb/256/256 in
        let v=(rgb/256) mod 256 in
        let b=rgb mod 256 in
        (r,v,b)


let string_cat l = List.fold_left ( ^ ) "" l;;

let terminate_graph() = try G.close_graph() with _ -> () ;;

(* sauve l'image de la fenetre graphique dans un fichier *)
let save_img  nom =
	let tx= G.size_x() and ty=G.size_y() in
	let img= G.dump_image (G.get_image 0 0 tx ty) in
        let file = open_out nom in
        Printf.fprintf file "P6 %d %d 255\n" (Array.length img.(0)) (Array.length img);
        for lig= Array.length img - 1 downto 0 do
        for col=0 to Array.length img.(0) - 1 do
		let (red,green,blue)= decompose_color img.(lig).(col) in
                Printf.fprintf file "%c%c%c" 
                  (Char.chr red) (Char.chr green) (Char.chr blue)
        done done;
        close_out file ;;      

let id x = x;;

let read_img nom=
	let file = open_in_bin nom in
	let entete= input_line file in
	let codage,nbcol,nbligne,maxval=  Scanf.sscanf entete "%s %d %d %d" 
		(fun cod col li t  ->(cod,col, li, t)) in
	let img = Array.create_matrix nbligne nbcol 0 in
	if codage="P3" || codage="p3"
	then begin 
	     let pixels= input_line file in
	     for lig=nbligne-1 downto 0 do
		for col=0 to nbcol-1 do
			let r= Scanf.sscanf pixels "%d" id in
			let v= Scanf.sscanf pixels "%d" id in
			let b= Scanf.sscanf pixels "%d" id in
			img.(lig).(col) <- G.rgb r v b 
		done done
	     end
	else if codage="P6" || codage = "p6"
	then begin
		(*let k= ref 0 in *)
		for lig=nbligne-1 downto 0 do for col=0 to nbcol-1 do
			(*
			let r= Char.code pixels.[!k] in incr k;
			let v= Char.code pixels.[!k] in incr k;
			let b= Char.code pixels.[!k] in incr k;
			*)
			let r= Char.code (input_char file) in
			let v= Char.code (input_char file) in
			let b= Char.code (input_char file) in
			img.(lig).(col) <- G.rgb r v b
		done done
	     end
	else Printf.printf 
"format non reconnu. J'attend: P3 nblig nbcol maxval\n ou bien: P6 nblig nbcol maxval\n"; 
	close_in file;
	img;;


let diaporama liste =
	List.iter 
	 (function nom -> 
	          let img = read_img nom in
		  G.draw_image (G.make_image img) 0 0 ;
	) liste;
;;



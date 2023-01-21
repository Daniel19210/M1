(*
#use "ray_tracer.ml";;
#load "bernstein.cmo";;
#load	"lu_decompose.cmo";;
#load	"transfo.cmo";;
*)


(*

module L= List;;
module A= Array;; 
open Lu;;*)
module Lu=Lu_decompose;;
module B=Bernstein;;
module P=Printf;;
module T=Transfo;;


exception ESingularity ;; (* exception generee quand l'equation generee est le polynome nul. Ca n'arrive pas souvent! *)
type equation= (float*int*int*int)list;;  (*monome*)
type transfo = { mat : float array array ; inv: float array array };;
type couleur=int;;
type poly={coul:couleur;plans:float array list};;
type objet = Group of objet list | Implicit of (couleur*equation) | Trf of ( transfo*objet) | Polyedre of poly;;
type contact ={ ttt: float; color : couleur; pt: float array; plan_tangent: float array };;
type rayon={x0: float; y0: float;z0: float;a: float;b: float;c:float};;
(*description de type de vue*)
type view={eye: float array; regard :float array; vertical : float array; lateral : float array;
                xs: int; ys: int};;


let sigma i0 i1 f=
	let rec scan i s=
		if i>i1 then s
		else scan(i+1) (s+.(f i)) in
	scan i0 0.;;

let pscal u v=sigma 0 (Array.length u-1) (function i->u.(i)*.v.(i));;

let cube={plans=[[|-1.;0.;0.;0.|];
		  [|0.;-1.;0.;0.|];
		  [|0.;0.;-1.;0.|];
          [|1.;0.;0.;-1.|];
		  [|0.;1.;0.;-1.|];
		  [|0.;0.;1.;-1.|];
		 ];coul=0};;

let ray_inter_pol {x0=x0;y0=y0;z0=z0;a=a;b=b;c=c} {plans=plans;coul=coul}=
	let infini=1e6 in 
	let p0=[|x0;y0;z0;1.|] in 
	let div=[|a;b;c;0.|] in
	let point t=[|x0+.a*.t;y0+.b*.t;z0+.c*.t;1.|] in
	let puissance t plane=pscal p0 plane +. t *.(pscal plane div) in
	let t_intersection plane=
		let t=0.-. (pscal p0 plane) /. (pscal plane div) in 
		{ttt=t;color=coul;pt=point t;plan_tangent=plane} in
	let clip segment plane=match segment with
		|None -> None
		|Some(ct0,ct1) -> let s0=puissance ct0.ttt plane in
						let s1=puissance ct1.ttt plane in
						if s0<=0.
						then if s1<=0. then segment
							 else Some(ct0,t_intersection plane)
						else if s1>=0. then None
							 else Some(t_intersection plane,ct1) in
	let rec loop segment planes=match planes with
		|[]->segment
		|plane::qplanes->(match clip segment plane with
							|None->None
							|segment'->loop segment' qplanes
						 ) in
	let intersection=loop (Some({ttt=0.;color=coul;pt=point 0.;plan_tangent=[||]},{ttt=infini;color=coul;pt=point infini;plan_tangent=[||]})) plans in
		match intersection with
		|None -> None
		|Some(ct0,ct1)->Some ct0;;

ray_inter_pol{x0=0.;y0=0.;z0=0.;a=0.;b=1.;c=0.} cube;;


(* trivialites *)
let rgb = Graphics.rgb 
let foi = float_of_int;;
let iof = int_of_float;;
let rec puiss_float x n= 
	if n=0 then 1.  else if n=1 then x 
	else if  n mod 2 = 0 then puiss_float (x *. x) (n/2)
	else x *. (puiss_float (x *. x) (n/2))

(* les polynomes *)
let xdeg (_,d,_,_)=d;;
let ydeg (_,_,d,_)=d;;
let zdeg (_,_,_,d)=d;;
let coeff(c,_,_,_)=c;;
let rec first_non_zero l = match l with [] -> 0 | t :: q -> if t <> 0 then t else first_non_zero q

let sign_monome (_, degx, degy, degz) = first_non_zero [ degx + degy + degz; degx; degy; degz ];;

(*comparer les monomes*)
let cmp_monome (c,xd,yd,zd)(c',xd',yd',zd')= 0 - (sign_monome (c, xd - xd', yd - yd', zd - zd' ))
	
(*met ens les termes de m√™me degr√©s=addition*)
let rec clean_pol pol= match pol with
	| [] | [_] -> pol (*si vide ou un seul monome*)
	| m1 :: m2 :: q-> if cmp_monome m1 m2=0
			  then clean_pol ( ((coeff m1) +. (coeff m2), xdeg m1, ydeg m1, zdeg m1) :: q)
			  else m1::(clean_pol (List.tl pol));;

(*pour standardiser un polynome*)
let std_pol pol=
	let pol'=List.sort cmp_monome pol in 
	List.filter (function monome->coeff monome <> 0.) (clean_pol pol');;

(*on donne le coeff puis les degr√©s de x y et z*)
let p=
[3.,1,0,0;
2.,0,2,0;
7.,1,1,0;
10.,1,0,0;
2.,0,2,0;
-5.,1,1,0];;

std_pol [];;

std_pol p;;

let print_pol pol=
List.iter (function (c,i,j,k) -> 
			    if c < 0. then P.printf " - %f" (abs_float c)
			    else P.printf " + %f " c;
                            if i=1 then P.printf "x" ;
                            if i>1 then P.printf "x^%d" i;
                            if j=1 then P.printf "y" ;
                            if j>1 then P.printf "y^%d" j;
                            if k=1 then P.printf "z" ;
                            if k>1 then P.printf "z^%d" k;
        ) pol; P.printf "\n";;
(*#install_printer print_pol;; le mettre dan le shell*)

(* degre_pol suppose que le 1er monome est de degre total le plus grand ; c'est ce que fait std_pol et cmp_monome *)
let degre_pol pol= match pol with
	| []->0
	| monome::_->(xdeg monome)+(ydeg monome)+(zdeg monome);;

let plus_pol p q= std_pol(p@q);;

(*multiplication de monomes*)
let mult_mono_poly (c,xd,yd,zd) pol=
	if c=0. then []
	else List.map (function (co,xdeg,ydeg,zdeg)-> (c*.co, xd+xdeg, yd+ydeg, zd+zdeg)) pol;;

(*multiplication de polynomes*)
let rec mult_pol a b= match a with
|	[]->a
|	ao::qa->plus_pol (mult_mono_poly ao b) (mult_pol qa b);;

let cst k = [(k, 0,0,0) ]

let k_pol cst pol= mult_mono_poly(cst,0,0,0) pol;;

let moins_pol a b = plus_pol a (k_pol (-1.) b)

let rec puiss_pol pol n=
	if n=0 then [(1.,0,0,0)]
	else if n=1 then pol
	else if n mod 2=0 then puiss_pol (mult_pol pol pol) (n/2)
	     else mult_pol pol (puiss_pol pol (n-1));;

mult_pol [1.,1,0,0; 1.,0,1,0] [2.,0,0,0];;

puiss_pol (std_pol[1.,1,0,0; 1.,0,1,0]) 3;;

let ( +% ) = plus_pol;;
let ( -% ) = moins_pol;;
let ( *% ) = mult_pol;;

let equation_tore r = 
	let x=[1.,1,0,0] in
	let y=[1.,0,1,0] in
	let z=[1.,0,0,1] in
	let tmp = x *% x +% y *% y +% z *% z +%  (cst (1. -. r *. r))  in
	tmp *% tmp -% (cst 4.) *% ( x *% x +% y *% y) ;; 

let gradient_pol f (x,y,z)=
let (a,b,c)= List.fold_left 
    (fun (fx,fy,fz) (coeff,degx,degy,degz) 
        ->    (fx +. (if degx=0 then 0.
                        else coeff*.(foi degx) *.(puiss_float x (degx-1)) *.(puiss_float y degy) *.(puiss_float z degz)),
               fy +. (if degy=0 then 0.
                        else coeff*.(foi degy) *.(puiss_float x degx) *.(puiss_float y (degy-1)) *.(puiss_float z degz)),
               fz +. (if degz=0 then 0.
                        else coeff*.(foi degz) *.(puiss_float x degx) *.(puiss_float y degy) *.(puiss_float z (degz-1)) ) )
        ) 
        (0.,0.,0.) f in
let d = -. (a*.x+.b*.y+.c*.z) in (a,b,c,d);;


(*calcul des cnk*)
let rec choices i n=
	if i= 0 then 1
	else if i > n then 0
	else if i=1 then  n
	else ((choices (i-1) n)*(n-i+1))/i;;
(*reste a convertir en float *)
let choices_f i n  =float_of_int (choices i n);;

(* genere l'equation en t (t=abscisse le long du rayon) de l'intersection entre un rayon et une surface implicite *) 
let genere_equation f {x0=x0;y0=y0;z0=z0;a=a;b=b;c=c} =
	let n=degre_pol f in
	let equation=Array.create (n+1) 0. in
	List.iter (function(aijk,alpha,beta,gamma)-> 
		if alpha + beta + gamma > n then failwith "un monome d'un polynome a un degre > degre total du polynome";
		for i=0 to alpha do
			for j=0 to beta do
				for k=0 to gamma do
				let temp=  aijk *. (choices_f i alpha) *. (puiss_float x0 (alpha-i)) *. (puiss_float a i )      
						*. (choices_f j beta)  *. (puiss_float y0 (beta-j))  *. (puiss_float b j)
						*. (choices_f k gamma) *. (puiss_float z0 (gamma-k)) *. (puiss_float c k)
				in
				equation.(i+j+k) <- equation.(i+j+k) +. temp
       done done done;
      ) f;
	equation;;

genere_equation [1.,0,1,0] {x0=0.;y0= (-1.);z0=0.;a=0.;b=1.;c=0.};;

open Graphics;;

let plot_pixel i j r v b = set_color (rgb r v b); Graphics.plot i j ;;

let pt_sur_rayon ray t= (ray.x0 +. ray.a *. t,ray.y0 +. ray.b *. t,ray.z0 +. ray.c *. t);;

(*rouge,vert,bleu*)
let decompose_color rgb=
        let r=rgb/256/256 in
        let v=(rgb/256) mod 256 in
        let b=rgb mod 256 in
        (r,v,b)

let attenue_couleur rgb facteur =
        assert (facteur <= 1. );
        assert ( 0. <= facteur );
        let r,v,b = decompose_color rgb in
        let r', v', b' = foi r, foi v, foi b in
        (iof (facteur *. r'), iof (facteur *. v'),  iof (facteur *. b')) 

let translation tx ty tz =
        {mat= T.mat_trans tx ty tz;
         inv= T.mat_trans (-. tx) (-. ty) (-. tz) };;

let scale kx ky kz =
        { mat= T.mat_affin kx ky kz; inv = T.mat_affin (1. /. kx) ( 1. /. ky) ( 1. /. kz ) };;

let homot k = scale k k k;;

let rotation (a,b,c) theta = { mat= T.mat_rota a b c theta; inv= T.mat_rota a b c (-. theta) };;

let rotationq (a,b,c) theta (x,y,z) =
        { mat= T.mat_rotaq a b c x y z theta;
          inv= T.mat_rotaq a b c x y z (-. theta) };;

(* compose_transfos [A;B;C] est la transfo : p -> C (B (A ( p)))  
   comme les points sont des vecteurs lignes, cette transfo a pour 
   matrice directe le produit des matrices directes: A*B*C
   et a pour matrice inverse le produit:  inv(C) * inv(B) * inv(A) 
*)
let rec compose_transfos liste= 
	if liste=[] then homot 1.
	else {	mat = Lu.mult_mats (List.map (function transfo-> transfo.mat) liste);
	  	inv = Lu.mult_mats (List.map (function transfo-> transfo.inv) (List.rev liste)) };;

let is_null_vect v =
        let rec scan i = i=Array.length v || v.(i) = 0. && scan (i+1) in 
        scan 0;;

(*********** fonctions calculant les intersections *******************************)
let intersection_rayon_implicit rayon surface= match surface with 
| (couleur,surf)->
        let equation =genere_equation surf  rayon in
	if is_null_vect equation then raise ESingularity ; (* si si, ca arrive !! avec surface de Cayley et rayon = Oy  *)
	let roots=B.roots_pos_canonic 1e-6 equation in
	match roots with
	| []->None
	| t1::_-> let (x,y,z) = pt_sur_rayon rayon t1 in
		  let (a,b,c,d)= gradient_pol surf (x,y,z) in
			Some ({ttt=t1; color= couleur; pt=[|x;y;z;1.|]; plan_tangent=[|a;b;c;d|] });;

let rec intersection_rayon_objet ({a=a;b=b;c=c;x0=x0;y0=y0;z0=z0} as rayon) objet = match objet with
| Implicit surface-> intersection_rayon_implicit rayon surface
| Polyedre polyedre -> ray_inter_pol rayon polyedre
| Group lobjet -> 
(
       let hits=List.map (intersection_rayon_objet rayon) (*ici c 'est une fonction curification*) lobjet in
	let contacts=List.fold_left (fun liste hit -> match hit with
							| Some contact ->contact::liste
							| None->liste
				  ) [] hits in 
	match contacts with
	|[] -> None
	|_ -> let cont = List.fold_left (fun con1 con2 -> if (con1.ttt<=con2.ttt) then con1 else con2 )
					  (List.hd contacts) (List.tl contacts) in 
		Some cont
)
| Trf({mat=mat;inv=inv}, objet_transforme) -> 
(
        let abc=[|a;b;c;0.|] in
        let oeil=[|x0;y0;z0;1.|] in
        let abc'=Lu.vect_mat abc inv in
        let oeil'=Lu.vect_mat oeil inv in
        let rayon'={x0=oeil'.(0); y0=oeil'.(1); z0=oeil'.(2); a=abc'.(0); b=abc'.(1); c=abc'.(2)} in
        let hit'=intersection_rayon_objet rayon' objet_transforme in
        match hit' with | None -> None
        		| Some { ttt=t1; color=color; pt=pt; plan_tangent=abcd } -> 
                	  Some { ttt=t1; color=color; pt= Lu.vect_mat pt mat; plan_tangent = Lu.mat_vect inv abcd }
)
;;  

let facteur_attenuation c = (* c est un cosinus, il est entre -1 et 1 *)
 let co = if c > 1. then 1. else if c < -1. then -1. else c in
 let facteur =
	 if co <= 0. then co *. 0.2 +. 0.6
 	 else co *. 0.2 +. 0.8 in
 min 1. facteur;;
 
(* axonometrie: tous les rayons primaires ont pour verteur support: regard 
   l'origine du rayon est eye + 2(col-xs/2)/xs*lateral + 2(ligne-ys/2)/ys*vertical 
*)
let tracer_rayons {eye=eye;regard=regard;vertical=vertical;lateral=lateral;xs=xs;ys=ys}  scene =
	open_graph (Printf.sprintf " %dx%d" xs ys);
        clear_graph();
        for col=0 to xs-1 do 
	for lig=0 to ys-1 do
                (* M= oeil+ 2(col-xs/2)/xs*lateral + 2(ligne-ys/2)/ys*vertical *)
                let x0=eye.(0) +. 2. *. (foi(col-xs/2))/.(foi xs)*.lateral.(0) +. 2. *. (foi(lig-ys/2))/.(foi ys)*.vertical.(0) in
                let y0=eye.(1) +. 2. *. (foi(col-xs/2))/.(foi xs)*.lateral.(1) +. 2. *. (foi(lig-ys/2))/.(foi ys)*.vertical.(1) in
                let z0=eye.(2) +. 2. *. (foi(col-xs/2))/.(foi xs)*.lateral.(2) +. 2. *. (foi(lig-ys/2))/.(foi ys)*.vertical.(2) in
                let rayon={x0=x0;y0=y0;z0=z0;a=regard.(0);b=regard.(1);c=regard.(2)} in
                try match intersection_rayon_objet rayon scene with
                | None->plot_pixel col lig 0 0 0
                | Some {ttt=t; pt=pt; plan_tangent=abcd ; color=coul }-> 
                         let (a1,b1,c1,d1) = abcd.(0), abcd.(1), abcd.(2), abcd.(3) in
			 let cosinus = b1 /. (sqrt (a1*.a1+.b1*.b1+.c1*.c1)) in			 
                         let attenuation = facteur_attenuation cosinus in
                         let r,v,b = attenue_couleur coul attenuation in 
                         plot_pixel col lig r v b
		with ESingularity -> ( P.printf "Tiens, une exception?\n"; flush stdout; plot_pixel col lig 255 0 0 ) 
	done done;;

let trf transfo objet = Trf( transfo, objet)
let trfn transfos objet = trf (compose_transfos transfos) objet;;
let apply transfos objet = trfn (List.rev transfos) objet ;;
let implicit couleur equation = Implicit (couleur, equation );;
let group l = Group l;;

type data_view =  { oeil : float array;
                    vise : float array;
                    verti: float array;
                    tx : int; ty : int;
                };;
let prod_vect u v = assert (Array.length u=4 && Array.length v=4 && u.(3)=0. && v.(3)=0. );
        let (x,y,z)= u.(0), u.(1), u.(2) in
        let (x',y',z')= v.(0), v.(1), v.(2) in
        [| y *. z' -. y' *. z ;
           z *. x' -. z' *. x ;
           x *. y' -. x' *. y ;
           0. |];;
let norme u = sqrt (pscal u u);;
let normer u = Lu.nb_vect (1. /. (norme u)) u ;;

let  build_view { oeil=oeil; vise=vise; verti=verti; tx=tx; ty=ty }=
        assert ( Array.length oeil=4);
        assert ( Array.length vise=4);
        assert ( Array.length verti=4);
        let vect_regard = Lu.moins_vect vise oeil in
        let a_droite= normer (prod_vect vect_regard verti) in
        { eye = oeil;
          regard= normer vect_regard;
          lateral= a_droite;
          vertical = normer (prod_vect a_droite vect_regard);
          xs=tx; ys=ty };;

	(*
	let vue1= {eye=[|0.;-2.;0.;1.|]; regard=[|0.;1.;0.;0.|];vertical=[|0.;0.;1.5;0.|];lateral=[|1.5;0.;0.;0.|]; xs=200;ys=200};;
	let x_ = [1., 1,0,0]
	let y_ = [1., 0,1,0]
	let z_ = [1., 0,0,1]
	let ball = x_ *% x_ +% y_ *% y_ +% z_ *% z_  -% (cst 1.)  ;;

	tracer_rayons vue1 (group [implicit (rgb 255 0 0) ball ] );;
	let vue2= {eye=[|0.;-2.;0.;1.|]; regard=[|0.;1.;0.;0.|];vertical=[|0.;0.;2.5;0.|];lateral=[|2.5;0.;0.;0.|]; xs=200;ys=200};;
	let scene2= group[
				   apply [homot 0.5; translation (-0.3) 0. 0. ] (implicit (rgb 0 255 0) ball) ;
				   apply [homot 0.5; translation 0.6 0. 0. ] (implicit (rgb 255 255 0) ball) ;
				   apply [rotation (1.,0.,0.) 80.; homot 1.75 ] (implicit (rgb 200 200 200) (equation_tore 0.3));
				   apply [homot 1.; translation  0. 0. (-1.) ] (implicit (rgb 255 0 255) ball)
				  ];;
	tracer_rayons vue2 scene2;;

	*)

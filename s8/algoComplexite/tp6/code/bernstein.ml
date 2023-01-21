exception Singularity

let rec choices i n =
   if i=0 then 1
   else if i>n then 0
   else if i=1 then n
   else ((choices (i-1) n) * (n - i + 1)) / i ;;

type polynome = { coeffs: float array };;

let to_bernstein a_i =
   let n = Array.length a_i - 1 (* n est le degre *) in
   let b_i = Array.make (n+1) 0. in
   (* p(x)= sum a_i x^i *)
   (* x^k = sum_(i=0..n) C(k,i)/C(k,n) B(i,n)(x) *)
   for k=0 to n do
      for i=k to n do
         let c_k_i = float_of_int (choices k i) in
         let c_k_n = float_of_int (choices k n) in
         b_i.(i) <- b_i.(i) +. a_i.(k) *. c_k_i /. c_k_n
      done
   done;
   b_i;;

let milieu x0 x1 = (x0 +. x1)/. 2.;;

(* rend: (left,right) où left est le tableau des coefficients 
de la moitié gauche, et right est le tableau des coefficients 
de la moitié droite. Utilise la méthode de Casteljau 
En entrée, coeffs est le tableau des coeffs dans la base de 
Bernstein *)

let deCasteljau coeffs =
   let n = Array.length coeffs - 1 (* n est le degre *) in
   let left= Array.make (n+1) 0. and right= Array.make (n+1) 0. in
   let layers = Array.make (n+1) coeffs in
   for level=1 to n do
      layers.(level) <- Array.make (n+1-level) 0.;
      for k=0 to n-level do
        layers.(level).(k) <- 
         milieu layers.(level-1).(k) layers.(level-1).(k+1)
      done;
   done;
   for k=0 to n do left.(k) <- layers.(k).(0); 
       right.(k) <- layers.(n-k).(k)  
        done;
   left, right;;

let minmax tableau =
   let mini = ref tableau.(0) and maxi= ref tableau.(0) in
   for i=1 to Array.length tableau - 1 do 
      mini := min !mini tableau.(i);
      maxi := max !maxi tableau.(i)
   done;
   !mini, !maxi;;

(* b est le tableau des coeffs, dans la base de Bernstein *)
(* epsilon est la précision souhaitée *)
let roots_0_1_bernstein epsilon b = 
   let rec search x0 x1 coeffs known_roots =
      let xm = milieu x0 x1 in
      let (mi,ma)=minmax coeffs in
   (* Printf.printf "x0=%f x1=%f in [%f %f]\n" x0 x1 mi ma; *)
      if ma < 0. || mi > 0. then known_roots
      else if x1 -. x0 < epsilon then xm::known_roots
           else let left,right=deCasteljau coeffs in
           search x0 xm left (search xm x1 right known_roots)    
   in
   let x0= 0. and x1=1. in
   let roots= search x0 x1 b [] in  roots;;
                 
deCasteljau (to_bernstein [| 1.; 0.; 0. |] );;
let ai= [| 0.; 0.; 1. |];;
let bi= to_bernstein ai;;
to_bernstein [| 1.; 0.; 0. |];; 
to_bernstein [| 0.; 1.; 0. |];; 

(*
# let pol_ca = [| -0.5; 0.; 1. |];;
val pol_ca : float array = [|-0.5; 0.; 1.|]
# let pol_be = to_bernstein pol_ca;;
val pol_be : float array = [|-0.5; -0.5; 0.5|]
# roots_0_1_bernstein 0.00001 pol_be;;
- : float list = [0.707103729248046875]
*)

let roots_0_1_canonic epsilon a = 
   roots_0_1_bernstein epsilon (to_bernstein a);;
let roots_1_infini_canonic epsilon a = 
   let a' = Array.of_list (List.rev (Array.to_list a)) in
   let roots' = roots_0_1_canonic epsilon a' in 
   List.rev (List.map (function x-> 1. /. x) roots');;

let roots_pos_canonic epsilon pol =
   roots_0_1_canonic epsilon pol 
      @ roots_1_infini_canonic epsilon pol;;
let roots_neg_canonic epsilon pol =
   let pol'= Array.copy pol in
   for i=1 to Array.length pol - 1 do 
           if i mod 2 = 1 then pol'.(i) <- 0. -. pol'.(i) 
        done;
   let roots' = roots_pos_canonic epsilon pol' in
   List.map (function x-> 0. -. x ) roots' ;;

(* le polynome est dans la base canonique : 
   polynome.(i)=coeff de x^i *)
let solve epsilon polynome =  
   roots_neg_canonic epsilon polynome 
      @ roots_pos_canonic epsilon polynome;;

(*
let eval_pol polynome x =
   let n= Array.length polynome - 1 in
   let accu = ref polynome.(n) in
   for i=n-1 downto 0 do
      accu := !accu *. x +. polynome.(i)
   done;
   !accu;;
*)

let eval_pol polynome x =
   let n= Array.length polynome - 1 in
   let rec aux i accu =
      if i<0 then accu
      else aux (i-1) (accu *. x +. polynome.(i))
   in aux (n-1) polynome.(n);; 

let derivative polynome =
   let n=Array.length polynome - 1 in
   let der= Array.make n 0. in
   for i=0 to n-1 do der.(i) <- (float_of_int (i+1)) *. polynome.(i+1) 
   done;
   der;; 

(* un newton pour les polynomes : *)
(* newton 0.000001 [| -2.; 0. ; 1. |] 10. ;; 
   rend 1.41421356237309537 = sqrt(2.) *)
let newton epsilon pol x0 =
   let pol' = derivative pol in
   let f x = x -. (eval_pol pol x) /. (eval_pol pol' x) in
   let rec iter x =
      let x'=f x in
      if abs_float (x' -. x) < epsilon then x' else iter x'
   in iter x0;;   
   
(* un newton pour les fonctions : *)
(*
# newton_f epsilon (function x -> x *. x -. 2. ) 10.;;
- : float = 1.4142135623730967
*)
let newton_f epsilon f x0 =
   let f' x = (f (x +. epsilon) -. f x) /. epsilon in
   let f x = x -. (f x) /. f' x in
   let rec iter x =
                let x'=f x in
                if abs_float (x' -. x) < epsilon then x' else iter x'
        in iter x0;;   

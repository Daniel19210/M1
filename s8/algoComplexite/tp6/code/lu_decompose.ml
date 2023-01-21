(* FILE lu_decompose.ml *)
(* reference = Introduction a l'algorithmique, pg 728, de Cormen, Leiserson, Rivest, Stein *)

type lup_decomposition =
{	 
	mat : float array array;
	low : float array array;
	up  : float array array;
	per : int array
};;
exception Singular ;;

module A= Array;;
module L= List;;

let parity_permutation tab = (* i va en tab.(i) *)
	let n= A.length tab in let count = ref 0 in
	for i=0 to n-2 do for j=i+1 to n-1 do 
		if tab.(i) > tab.(j) then count := 1 - !count 
	done done;
	!count;;
(* oui, oui, il y a plus rapide, mais comme on a recours a des algos en n^3, pas la peine
   de s'embeter; le n^2 est plus concis  *)

let vecteur = A.init;;

let matrice nlines ncolumns fonc =
	A.init nlines (function line -> A.init ncolumns (function col -> fonc line col));;

let transpose m = matrice (A.length m.(0)) (A.length m) (fun l c -> m.(c).(l));;

let summation i_min i_max fonc_i =
	let rec scan accu i = if i> i_max then accu else scan (accu +. (fonc_i i))  (i+1) in 
	scan 0. i_min;; 

let pscal u v = summation 0 (A.length u - 1) (function i -> u.(i) *. v.(i) );;

let plus_vect a b = A.init (A.length a) (function i -> a.(i) +. b.(i));;

let moins_vect a b = A.init (A.length a) (function i -> a.(i) -. b.(i));;

let nb_vect k u = A.init (A.length  u) (function i -> k *. u.(i));;

let transpose mat = let nl=A.length mat in let nc=A.length mat.(0) in 
	matrice nc nl (fun i j -> mat.(j).(i));;

let copy_matrix m = A.init (A.length m) (function l -> A.copy m.(l));;

let vect_mat v m = 
    let n=A.length v in
    let nl=A.length m in
    let nc=A.length m.(0) in
    assert (n=nl);
    A.init nc (function c -> summation 0 (n-1) (fun lig -> v.(lig) *. m.(lig).(c)));;

let prod_vect_mat = vect_mat

let mat_mat a b =
    let la=A.length a and ca=A.length a.(0) and lb=A.length b 
	and cb=A.length b.(0) in assert (ca=lb);
    matrice la cb (fun line col -> 
			summation 0 (ca-1) 
			  (function k-> a.(line).(k) *. b.(k).(col)));; 

let mult_mat = mat_mat
let prod_mat = mat_mat
let mult_mats liste = L.fold_left mat_mat (L.hd liste) (L.tl liste);;
let prod_mats = mult_mats;;

let plus_mat a b = assert (A.length a=A.length b && A.length a.(0)=A.length b.(0));
	matrice (A.length a)(A.length a.(0)) 
		(fun lig col -> a.(lig).(col) +. b.(lig).(col));;

let moins_mat a b = assert (A.length a=A.length b && A.length a.(0)=A.length b.(0));
	matrice (A.length a)(A.length a.(0)) 
                (fun lig col -> a.(lig).(col) -. b.(lig).(col));;

let mat_diagonal vect = 
	let n =A.length vect in
	matrice n n (fun l c -> if l=c then vect.(l) else 0. );;

let mat_id n = matrice n n  (fun l c -> if l=c then 1. else 0.);;

let mat_vect a v = (* v est considere comme un vecteur colonne *)
	let la = A.length a and ca = A.length a.(0) and n=A.length v in 
	assert (ca = n);
	A.init la (function k -> pscal a.(k) v);;  

let prod_mat_vect = mat_vect ;;

let nb_mat nb mat = matrice (A.length mat)(A.length mat.(0)) 
	(fun l c -> nb *. mat.(l).(c));;

let prod_nb_mat = nb_mat

let lup_decomp m =
let n= A.length m in
assert (A.length m.(0) = n);
let a= A.init n (function lig -> A.copy m.(lig)) in
let per = A.init n (function i-> i ) in
for k=0 to n-1 do
	let k'= ref k in
	for i=k+1 to n-1 do 
		if abs_float a.(i).(k) > abs_float a.(!k').(k) then   k' := i 
	done;
	let k' = !k' in
	if a.( k').(k) = 0. then raise Singular;
	let tmp= per.(k) in per.(k) <- per.( k'); per.(k') <- tmp ;	
	for i=0 to n-1 do let tmp= a.(k).(i) in 
		a.(k).(i) <- a.(k').(i); a.(k').(i) <- tmp done;
	for i=k+1 to n-1 do
		a.(i).(k) <- a.(i).(k) /. a.(k).(k);
		for j=k+1 to n-1 do 
			a.(i).(j) <- a.(i).(j) -. a.(i).(k) *. a.(k).(j) 
		done;
	done;
done;
{ up= matrice n n (fun l c -> if l<=c then a.(l).(c) else 0.); 
  low= matrice n n (fun l c -> if l>c then a.(l).(c) else if l=c then 1. else 0.); 
  per = per;
  mat = copy_matrix m;
};;

(* returns X such that AX=B *)
(* la LUP est celle de A, bien sur *)
let lup_solve { low=l; up=u; per=p } b = 
	let n= A.length p in
	assert (A.length b = n);
	let x= A.make n 0. in let y= A.make n 0. in 
	for i=0 to n-1 do 
	y.(i) <- b.( p.(i)) -. (summation 0 (i-1) (function j-> l.(i).(j) *. y.(j)))
	done;
	for i=n-1 downto 0 do
	x.(i) <- ( y.(i) -. (summation (i+1) (n-1) 
			(function j-> u.(i).(j) *. x.(j)))  ) /. u.(i).(i)
	done;
	x ;;

let lup_det  { low=l; up=u; per=p } =
	let n = A.length p in
	let determinant = ref 1. in
	for i=0 to n-1 do determinant := !determinant *. u.(i).(i) done;
	match parity_permutation p   with
	| 0 -> !determinant
	| 1 -> 0. -. !determinant
	| _ -> failwith "bug in parity_permutation";;

let lup_inverse  ({ low=l; up=u; per=p } as lup) =
	let n= A.length p in
	let mat=A.init n (function k ->
			let b= A.init n (function l -> if l=k then 1. else 0.) in
				lup_solve lup b
			) in
	transpose mat;;

(* oui, oui, c'est pas bien, je sais. Mais c'est tellement commode *)
let inverse_mat mat = lup_inverse (lup_decomp mat);; 

let newton_improve_inverse a x = (* x est ne approximation de l'inverse de a *)
(* considerer l'equation: 1/x - a = 0.
   le Newton associe est: N(x) = x(2 - ax)
   on l'applique sur des matrices au lieu de nombres *)
        let ax= mat_mat a x in
        let x'= mat_mat x (matrice (A.length x)(A.length x) (fun l c ->
                        if l<>c then (0. -. ax.(l).(c)) 
                                else (2. -. ax.(l).(c)))) in
        x';;

let sqr x = x *. x;;
let norme_frobenius mat =
	summation 0 (A.length mat - 1)
	(function lig -> summation 0 (A.length mat.(lig)-1)
					(function col ->  (sqr mat.(lig).(col))));;

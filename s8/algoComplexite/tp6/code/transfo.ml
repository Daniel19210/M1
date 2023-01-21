(*module A= Array;; 
module L= List;;
module Lu=Lu_decompose;;*)

let mat_trans tx ty tz = 
             [| [|1.;0.;0.;0.|];
                [|0.;1.;0.;0.|];
                [|0.;0.;1.;0.|];
                [|tx;ty;tz;1.|] |]

let mat_affin (kx:float) (ky:float) (kz:float)=
                         [|  [| kx; 0.; 0.; 0. |];
                             [| 0.; ky; 0.; 0. |];
                             [| 0.; 0.; kz; 0. |];
                             [| 0.; 0.; 0.; 1. |] |];; 

(* rend la matrice de rotation % axe (a,b,c) passant par l'origine
   et d'angle theta en degres *)
let pi= acos (-1.) 

let norme3 a b c = sqrt ( a *. a +. b *. b +. c *. c)

let mat_rota (n1:float) (n2:float) (n3:float) (theta:float)=
let n=norme3 n1 n2 n3 in
if (n = 0.) then failwith "matrice: mauvais axe pour rotation"
else let n1=n1 /. n and n2=n2 /. n and n3=n3 /. n
     and kos=cos( theta *. pi/.  180.)
     and zin=sin( theta *. pi /. 180.)
     in [|
        [| n1 *. n1 +. (1.-.n1 *. n1) *. kos ; n1 *. n2 *. (1.-.kos) +. n3 *. zin;
            n1 *. n3 *. (1.-.kos)-.n2 *. zin; 0. |];
        [| n1 *. n2 *. (1.-.kos)-.n3 *. zin; n2 *. n2 +. (1.-.n2 *. n2) *. kos;
            n2 *. n3 *. (1.-.kos) +. n1 *. zin; 0. |];
        [| n1 *. n3 *. (1.-.kos) +. n2 *. zin; n2 *. n3 *. (1.-.kos)-.n1 *. zin;
            n3 *. n3 +. (1.-.n3 *. n3) *. kos; 0. |];
        [| 0. ; 0.; 0.; 1. |] |] ;;

(* rend la matrice d'une rotation qcq: l'axe passe par x0 y0 z0
  et a pour  vecteur directeur a,b,c. L'angle est theta, en degres *)
let mat_rotaq (a:float) (b:float) (c:float)
              (x0:float) (y0:float) (z0:float) (theta:float)=
let n=a*.a +. b*.b +. c*.c in
if (n= 0.) then failwith "matrice: bad arg in rotatq"
else let t= -. (a*.x0+.b*.y0+.c*.z0) /. n in
        let xi=x0+.a*.t and yi=y0+.b*.t and zi=z0+.c*.t
            (* i est l'intersection entre axe et le plan normal a (a b c)
               passant par l'origine *)
        in Lu_decompose.mult_mat (mat_trans (-. xi) (-. yi) (-. zi))
                       (Lu_decompose.mult_mat (mat_rota a b c theta)
                                    (mat_trans xi yi zi))
;;

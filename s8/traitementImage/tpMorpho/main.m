I = [0 0 0 0 0 0 0 0 0 0 0 0 ; 
     0 0 0 0 0 0 0 0 0 0 0 0 ; 
     0 0 0 0 0 0 1 0 0 0 0 0 ; 
     0 0 0 1 1 1 1 0 0 0 0 0 ;
     0 0 0 1 1 1 1 0 0 0 0 0 ;
     0 0 0 1 1 0 0 0 0 0 0 0 ;
     0 0 0 1 1 1 1 1 1 0 0 0 ;
     0 0 0 0 0 0 0 0 0 0 0 0 ; 
     0 0 0 0 0 0 0 0 0 0 0 0 ; 
     0 0 0 0 0 0 0 0 0 0 0 0 ];

filtre = [0 0 1;
          0 1 1;
          0 0 0];

subplot(2,3,1);
imshow(erosion(I, filtre));
subplot(2,3,2);
imshow(dilatation(I, filtre));
subplot(2,3,3);
imshow(ouverture(I, filtre));
subplot(2,3,4);
imshow(fermeture(I, filtre));
%subplot(2,3,5);
%imshow(lantuejoul(imread('../TP/NG/centaur1.png')));
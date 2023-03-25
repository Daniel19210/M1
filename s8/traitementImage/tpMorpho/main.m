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


subplot(3,3,2);
imshow(I);
title("Image originale");
subplot(3,3,3);
imshow(filtre);
title("Image filtre utilisé");
subplot(3,3,4);
imshow(erosion(I, filtre));
title("Image erodée");
subplot(3,3,5);
imshow(dilatation(I, filtre));
title("Image dilatée");
subplot(3,3,6);
imshow(ouverture(I, filtre));
title("Image ouverte");
subplot(3,3,7);
imshow(fermeture(I, filtre));
title("Image fermée");
%subplot(3,3,8);
%imshow(lantuejoul(imread('../TP/NG/centaur1.png')));
waitfor(gcf);

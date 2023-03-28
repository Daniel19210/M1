I = [0 0 0 0 0 0 0 0 0 0 0 0 ; 
     0 0 0 0 0 0 0 0 0 0 0 0 ; 
     0 0 0 1 1 1 1 1 1 0 0 0 ; 
     0 0 0 1 1 1 1 1 1 0 0 0 ;
     0 0 0 1 1 1 1 1 1 0 0 0 ;
     0 0 0 1 1 1 1 1 1 0 0 0 ;
     0 0 0 1 1 1 1 1 1 0 0 0 ;
     0 0 0 0 0 0 0 0 0 0 0 0 ; 
     0 0 0 0 0 0 0 0 0 0 0 0 ; 
     0 0 0 0 0 0 0 0 0 0 0 0 ];

filtre = [0 0 1;
          0 1 1;
          0 0 0];

I2 = [0 0 0 0 0 0 0 0 0 0 0 0 ; 
     0 0 0 0 0 0 0 0 0 0 0 0 ; 
     0 0 0 0 0 0 0 0 0 0 0 0 ; 
     0 0 0 0 1 1 1 1 0 0 0 0 ;
     0 0 0 0 1 1 1 1 0 0 0 0 ;
     0 0 0 0 1 1 1 1 0 0 0 0 ;
     0 0 0 0 0 0 0 0 0 0 0 0 ;
     0 0 0 0 0 0 0 0 0 0 0 0 ; 
     0 0 0 0 0 0 0 0 0 0 0 0 ; 
     0 0 0 0 0 0 0 0 0 0 0 0 ];

IOuvert = ouverture(I, filtre);
IFerme = fermeture(I, filtre);
IDilate = dilatation(I, filtre);
IErode = erosion(I, filtre);
figure(1);
    subplot(3,3,2);
    imshow(I);
    title("Image originale");
    subplot(3,3,3);
    imshow(filtre);
    title("Image filtre utilisé");
    subplot(3,3,4);
    imshow(IErode);
    title("Image erodée");
    subplot(3,3,5);
    imshow(IDilate);
    title("Image dilatée");
    subplot(3,3,6);
    imshow(IOuvert);
    title("Image ouverte");
    subplot(3,3,7);
    imshow(IFerme);
    title("Image fermée");


img = ~imread("../TP/NG/cir1.png");
subplot(3,3,8);
imshow(img*255);
title("image cercle")
subplot(3,3,9);
imshow(lantuejoul(img)*255);
title("Squelette du cercle")

verifIdempotenceOuverture = min(min(IOuvert == ouverture(IOuvert, filtre) ))
verifAntiExtensiviteOuverture = min(min(I - IOuvert)) ~= -1
verifIntegration = min(min(I - I2)) ~= -1
verifCroissanceOuverture = min(min(IOuvert - ouverture(I2, filtre)))~= -1
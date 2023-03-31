Icarre = [0 0 0 0 0 0 0 0 0 0 0 0 ;
     0 0 0 0 0 0 0 0 0 0 0 0 ;
     0 0 0 1 1 1 1 1 1 0 0 0 ;
     0 0 0 1 1 1 1 1 1 0 0 0 ;
     0 0 0 1 1 1 1 1 1 0 0 0 ;
     0 0 0 1 1 1 1 1 1 0 0 0 ;
     0 0 0 1 1 1 1 1 1 0 0 0 ;
     0 0 0 0 0 0 0 0 0 0 0 0 ;
     0 0 0 0 0 0 0 0 0 0 0 0 ;
     0 0 0 0 0 0 0 0 0 0 0 0 ];

Iinclue = [0 0 0 0 0 0 0 0 0 0 0 0 ;
     0 0 0 0 0 0 0 0 0 0 0 0 ;
     0 0 0 0 0 0 0 0 0 0 0 0 ;
     0 0 0 0 1 1 1 1 0 0 0 0 ;
     0 0 0 0 1 1 1 1 0 0 0 0 ;
     0 0 0 0 1 1 1 1 0 0 0 0 ;
     0 0 0 0 0 0 0 0 0 0 0 0 ;
     0 0 0 0 0 0 0 0 0 0 0 0 ;
     0 0 0 0 0 0 0 0 0 0 0 0 ;
     0 0 0 0 0 0 0 0 0 0 0 0 ];

filtre = [0 0 0 1 0 0 0;
          0 0 0 1 0 0 0;
          0 0 0 1 0 0 0;
          1 1 1 1 1 1 1;
          0 0 0 1 0 0 0;
          0 0 0 1 0 0 0;
          0 0 0 1 0 0 0];

function a = execOp(I, filtre, nb)
    IOuvert = ouverture(I, filtre);
    IFerme = fermeture(I, filtre);
    IDilate = dilatation(I, filtre);
    IErode = erosion(I, filtre);

    printf("Opération terminées pour l'image n°%d\n", nb);
    fig = figure(nb);
    %set(fig, "Visible", "off");
        subplot(3,2,1);
            imshow(I, [min(min(I)), max(max(I))]);
            title("Image originale");
        subplot(3,2,2);
            imshow(filtre, [0, 1]);
            title("Image filtre utilisé");
        subplot(3,2,3);
            imshow(IErode, [min(min(IErode)), max(max(IErode))]);
            title("Image erodée");
        subplot(3,2,4);
            imshow(IDilate, [min(min(IDilate)), max(max(IDilate))]);
            title("Image dilatée");
        subplot(3,2,5);
            imshow(IOuvert, [min(min(IOuvert)), max(max(IOuvert))]);
            title("Image ouverte");
        subplot(3,2,6);
            imshow(IFerme, [min(min(IFerme)), max(max(IFerme))]);
            title("Image fermée");
    %set(fig, "Visible", "on");
end

I1 = imread("../TP/NG/clc3.png");
I2 = imread("../TP/NG/cln1fil1.png");
execOp(I1, filtre, 1);
execOp(I2, filtre, 2);


IOuvert = ouverture(Icarre, filtre);
IOuvert2 = ouverture(IOuvert, filtre);
IFerme = fermeture(Icarre, filtre);
IFerme2 = fermuter(IFerme, filtre);
IDilate = dilatation(Icarre, filtre);
IErode = erosion(Icarre, filtre);
verifAntiExtensiviteOuverture = min(min(Icarre - IOuvert)) ~= -1
verifIdempotenceOuverture = min(min(IOuvert == ouverture(IOuvert, filtre) ))
verifIntegration = min(min(Icarre - Iinclue)) ~= -1
verifCroissanceOuverture = min(min(IOuvert - ouverture(Iinclue, filtre)))~= -1

figure(3);
    subplot(3,2,1);
        imshow(Icarre*255)
        title("Image Carre centree")
    subplot(3,2,2)
        imshow(Iinclue*255)
        title("Image Carre centrée inclue")
    subplot(3,2,3)
        imshow(Iinclue*255)
        title("Image Carre centrée inclue")
%img = ~imread("../TP/NG/cir1.png");
%subplot(3,3,8);
%imshow(img*255);
%title("image cercle")
%subplot(3,3,9);
%imshow(lantuejoul(img)*255);
%title("Squelette du cercle")
waitfor(gcf);


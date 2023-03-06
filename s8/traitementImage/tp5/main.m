afficheRendu = "";
if (nargin != 0)
    afficheRendu = argv(){1};
end
I = imread("peppers.png");

[normeISimple, Gx, Gy] = normeGradient(I);
Sb = 36;
Sh = 100;
IBinaireContour = seuillage_hysteresis(normeISimple, Sb, Sh, 4);
figureHysteresis = figure(1, "Name", "Peppers");
    set(figureHysteresis, "Visible", "off");
    subplot(2,2,1);
        minNorme = min(min(normeISimple));
        maxNorme = max(max(normeISimple));
        imshow(normeISimple, [minNorme, maxNorme]);
        title(strcat("Norme de l'image min=", num2str(minNorme), ", max=", num2str(maxNorme)));
        printf("Rendu normeimage originale fait\n");
    subplot(2,2,2);
        imshow(IBinaireContour, [0,1])
        title(strcat("valeur du seuil Sh=", num2str(Sh)));
        printf("Rendu image binaire de contour fait\n");
    subplot(2,2,3);
        ISH = normeISimple > Sb;
        imshow(ISH, [0,1]);
        title(strcat("Seuillage simple, seuil : ", num2str(Sb)));
        printf("Rendu Seuillage simple bas fait\n")
    subplot(2,2,4);
        ISH = normeISimple > Sh;
        imshow(ISH, [0,1]);
        title(strcat("Seuillage simple, seuil : ", num2str(Sh)));
        printf("Rendu Seuillage simple haut fait\n")

[maxima, orientation] = maxima_locaux(Gx, Gy);
figureMaxima = figure(2, "Name", "Maxima_locaux");
    set(figureMaxima, "Visible", "off");
    subplot(1,3,1);
        imshow(I);
        title("Image originale");
        printf("Rendu image originale fait\n");
    subplot(1,3,2);
        imshow(normeISimple, [min(min(normeISimple)), max(max(normeISimple))]);
        title("normeISimple simple");
        printf("Rendu normeISimple fait\n");
    subplot(1,3,3);
        imshow(maxima, [1, max(max(maxima))]);
        title("Maxima locaux");
        printf("Rendu maxima fait\n");
    set(figureHysteresis, "Visible", "on");
    set(figureMaxima, "Visible", "on");
waitfor(gcf);

%abs(normeI - imgradient(I))
%imshow(laplacien(I, 4))

I = imread('../TP/faible_contraste/lena_fc.png');Iref = imread('../TP/NG/lena256.png');
I2 = etirement(I);
I3 = egalisation(I);
I4 = specification(I, Iref);

subplot(4,4,1);
imshow(I);
title("Image originale");

subplot(4,4,2);
bar(histogramme(I));
title("Histogramme image originale");

%subplot(4,4,3);
%bar(hcn(I));
%title("Histogramme cumulé normé de l'image originale");

subplot(4,4,5);
imshow(I2);
title("Image étirée");

subplot(4,4,6);
bar(histogramme(I2));
title("Histogramme image étirée");

%subplot(4,4,7);
%bar(hcn(I2));
%title("Histogramme cumulé normé image étirée");

subplot(4,4,7);
traceLUT(I);
title("LUT etirement");

subplot(4,4,9);
imshow(I3);
title("Image égalisée");

subplot(4,4,10);
histI3 = histogramme(I3);
bar(histI3);
title("Histogramme image égalisée");

subplot(4,4,11);
bar(hcn(I3))
title("Histogramme cumulé normé de l'image égalisée");

subplot(4,4,13);
imshow(I4);
title("Image spécifiée");

subplot(4,4,14);
bar( histogramme(I4) );
title("Histogramme image spécifiée")

subplot(4,4,15);
bar(hcn(I4));
title("Histogramme cumulé normé de l'image spécifiée")

subplot(4,4,16);
imshow(Iref);
title("Image de référence pour la spécification");

waitfor(gcf) % Pour que les graphiques ne se ferment pas automatiquement sur octave

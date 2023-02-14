I = imread('../TP/faible_contraste/lena_fc.png');Iref = imread('../TP/NG/lena256.png');
I2 = etirement(I);
I3 = egalisation(I);
I4 = specification(I, Iref);

subplot(4,4,1);
imshow(I);
title(strcat("Image originale\n min = ", num2str(double(min(min(I)))), ", max = ", num2str(double(max(max(I))))));

subplot(4,4,2);
imshow(I2);
title(strcat("Image étirée\n min = ", num2str(double(min(min(I2)))), ", max = ", num2str(double(max(max(I2))))));

subplot(4,4,3);
imshow(I3);
title(strcat("Image égalisée\n min = ", num2str(double(min(min(I3)))), ", max = ", num2str(double(max(max(I3))))));

subplot(4,4,4);
imshow(Iref);
title(strcat("Image de référence pour la spécification\n min = ", num2str(double(min(min(I3)))), ", max = ", num2str(double(max(max(I3))))));

subplot(4,4,5);
bar(histogramme(I));
title("Histogramme image originale");
xlabel("NG");
ylabel("Nombre d'occurence");
axis([0,256]);

subplot(4,4,6);
bar(histogramme(I2));
title("Histogramme image étirée");
xlabel("NG");
ylabel("Nombre d'occurence");
axis([0,256]);

subplot(4,4,7);
histI3 = histogramme(I3);
bar(histI3);
title("Histogramme image égalisée");
xlabel("NG");
ylabel("Nombre d'occurence");
axis([0,256]);

subplot(4,4,8);
bar( histogramme(I4) );
title("Histogramme image spécifiée")
xlabel("NG");
ylabel("Nombre d'occurence");
axis([0,256]);

subplot(4,4,9);
bar(hcn(I));
title("Histogramme cumulé normé de l'image originale");
xlabel("NG");
ylabel("Probabilité d'apparition");
axis([0,256]);

subplot(4,4,10);
bar(hcn(I2));
title("Histogramme cumulé normé image étirée");
xlabel("NG");
ylabel("Probabilité d'apparition");
axis([0,256]);

subplot(4,4,11);
bar(hcn(I3))
title("Histogramme cumulé normé de l'image égalisée");
xlabel("NG");
ylabel("Probabilité d'apparition");
axis([0,256]);

subplot(4,4,12);
bar(hcn(I4));
title("Histogramme cumulé normé de l'image spécifiée")
xlabel("NG");
ylabel("Probabilité d'apparition");
axis([0,256]);

subplot(4,4,14);
[a, b] = traceLUT(I);
title("" + a);
title(strcat("LUT etirement\ny = ", num2str(b), "x + ", num2str(a)));
xlabel("NG entrée");
ylabel("NG sortie");
axis([0,256, -5,260]);

waitfor(gcf);

function res = renduEgalisation(I, nom, nbFenetre)
    IE = egalisation(I);
    figure(nbFenetre, "Name", nom);
        subplot(3,2,1);
            imshow(I);
            title(strcat("Image originale\n min=", num2str(double(min(I(:)))), ", max=", num2str(double(max((I(:)))))));

        subplot(3,2,2);
            imshow(IE);
            title(strcat("Image égalisée\n min=", num2str(double(min(IE(:)))), ", max=", num2str(double(max(IE(:))))));

        subplot(3,2,3);
            bar(histogramme(I));
            title("Histogramme image originale");
            xlabel("NG");
            ylabel("Nombre d'occurence");
            axis([0,256]);

        subplot(3,2,4);
            bar(histogramme(IE));
            title("Histogramme image égalisée");
            xlabel("NG");
            ylabel("Nombre d'occurence");
            axis([0,256]);

        subplot(3,2,5);
            bar(hcn(I));
            title("Histogramme cumulé normalisé image originale");
            xlabel("NG");
            ylabel("Probabilité d'apparition");
            axis([0,256]);

        subplot(3,2,6);
            plot(hcn(IE)); % Il est demandé d'afficher une courbe plûtot qu'un histogramme
            title("Histogramme cumulé normalisé de l'image égalisée");
            xlabel("NG");
            ylabel("Probabilité d'apparition");
            axis([0,256]);
end

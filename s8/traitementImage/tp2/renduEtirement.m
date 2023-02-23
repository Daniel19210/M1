function res = renduEtirement(I, nom, nbFenetre)
    IE = etirement(I);

    figure(nbFenetre, "Name", nom);
        subplot(3,2,1);
            imshow(I);
            title(strcat("Image originale\n min=", num2str(double(min(I(:)))), ", max=", num2str(double(max(I(:))))));

        subplot(3,2,2);
            imshow(IE);
            title(strcat("Image étirée\n min=", num2str(double(min(IE(:)))), ", max=", num2str(double(max(IE(:))))));

        subplot(3,2,3);
            bar(histogramme(I));
            title("Histogramme image originale");
            xlabel("NG");
            ylabel("Nombre d'occurence"):w          axis([0,256]);

        subplot(3,2,4);
            bar(histogramme(IE));
            title("Histogramme image étirée");
            xlabel("NG");
            ylabel("Nombre d'occurence");
            axis([0,256]);

        subplot(3,2,5);
            [coefDir, Ord] = traceLUT(I);
            title(strcat("LUT etirement\n coefficiant directeur =\t", num2str(coefDir), " ordonnée à l'origine =\t", num2str(Ord)));
            xlabel("NG entrée");
            ylabel("NG sortie");
            axis([0,256, -5,260]);
end

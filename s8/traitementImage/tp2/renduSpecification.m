function a = renduSpecification(Ix, Iz, nom, nbFenetre)
    IS = specification(Ix, Iz);

    figure(nbFenetre, "Name", nom);
        subplot(4,2,1);
            imshow(Ix);
            title(strcat("Image originale\n min=", num2str(double(min(Ix(:)))), ", max=", num2str(double(max((Ix(:)))))));

        subplot(4,2,2);
            imshow(Iz);
            title(strcat("Image de référence\n min=", num2str(double(min(Iz(:)))), ", max=", num2str(double(max(Iz(:))))));

        subplot(4,2,3);
            bar(histogramme(Ix));
            title("Histogramme image originale");
            xlabel("NG");
            ylabel("Nombre d'occurence");
            axis([0,256]);

        subplot(4,2,4);
            bar(histogramme(Iz));
            title("Histogramme image de référence");
            xlabel("NG");
            ylabel("Nombre d'occurence");
            axis([0,256]);

        subplot(4,2,5);
            bar(cumsum(histogramme(Ix)));
            title("Histogramme cumulé image originale");
            xlabel("NG");
            ylabel("Probabilité d'apparition");
            axis([0,256]);

        subplot(4,2,6);
            bar(cumsum(histogramme(Iz)));
            title("Histogramme cumulé de l'image de référence");
            xlabel("NG");
            ylabel("Probabilité d'apparition");
            axis([0,256]);

        subplot(4,2,7)
            imshow(IS);
            title(strcat("Image spécifiée\n min=", num2str(double(min(IS(:)))), ", max=", num2str(double(max((IS(:)))))));

        subplot(4,2,8);
            bar(histogramme(IS));
            title("Histogramme image spécifiée");
            xlabel("NG");
            ylabel("Nombre d'occurence");
            axis([0,256]);
end

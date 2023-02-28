I = imread("../TP/image_test_bruit.tif");
afficheRendu = "";
if (nargin != 0)
    afficheRendu = argv(){1};
end
if (strcmp( afficheRendu, "bruit" ))
    figureBruit = figure(1)
        set(figureBruit, 'Visible', 'off');
    % tracé histoire
        subplot(2,7,1);
            imshow(I);
            title("Original");
        subplot(2,7,2);
            gaussian = imnoise(I, 'gaussian');
            imshow(gaussian);
            gaussianPSNR = psnr(gaussian, I);
            title(strcat( "Gaussian \nPSNR = ", num2str( gaussianPSNR ) ));
        subplon(2,7,3);
            uniform = bruitUniforme(I);
            imshow(uniform);
            uniformPSNR = psnr(uniform, I);
            title(strcat( "uniform \nPSNR = ", num2str( uniformPSNR ) ));
        subplot(2,7,4);
            poisson = imnoise(I, 'poisson');
            imshow(poisson);
            poissonPSNR = psnr(poisson, I);
            title(strcat( "poisson \nPSNR = ", num2str( poissonPSNR ) ));
        subplot(2,7,5);
            santPepper = imnoise(I, 'salt & pepper');
            imshow(saltPepper);
            saltPepperPSNR = psnr(saltPepper, I);
            title(strcat( "saltPepper \nPSNR = ", num2str( saltPepperPSNR ) ));
        subplot(2,7,6);
            speckle = imnoise(I, 'speckle');
            imshow(speckle);
            specklePSNR = psnr(speckle, I);
            title(strcat( "speckle \nPSNR = ", num2str( specklePSNR ) ));
        %subplot(2,7,7); % Problème avec le packet statistics
            %exponentiel = bruitExponentiel(I);
            %imshow(exponentiel);
            %exponentielPSNR = psnr(speckle, I);
            %title(strcat( "exponentiel \nPSNR = ", num2str( specklePSNR ) ));
    % Tracé histogramme
        subplot(2,7,8);
            bar(histogramme(I));
            axis([-5,261]);
        subplot(2,7,9);
            bar(histogramme(gaussian));
            axis([-5,261]);
        subplot(2,7,10);
            bar(histogramme(uniform));
            axis([-5,261]);
        subplot(2,7,11);
            bar(histogramme(poisson));
            axis([-5,261]);
        subplot(2,7,12);
            bar(histogramme(saltPepper));
            axis([-5,261]);
        subplot(2,7,13);
            bar(histogramme(speckle));
            axis([-5,261]);
        %subplot(2,7,14);
            %bar(histogramme(exponentiel));
            %axis([-5,261]);

        set(figureBruit, "Visible", "on");

elseif (strcmp(afficheRendu, "filtrage"))
    figureFiltrage = figure(1);
        %figureFiltrage.WindowState = 'minimized';
        set(figureFiltrage, "Visible", "off");
        subplot(2,6,1);
            imshow(I);
            title("Image originale");
        subplot(2,6,2);
            gaussian = imnoise(I, "salt & pepper");
            imshow(gaussian);
            title("Image Bruit gaussien");
        subplot(2,6,3);
            IF3 = filtrageMedian(gaussian, 3);
            imshow(IF3, []);
            title("Image Filtrée avec un filtre en 3x3");
        subplot(2,6,4);
            IF5 = filtrageMedian(gaussian, 5);
            imshow(IF5, []);
            title("Image Filtrée avec un filtre en 5x5");
        subplot(2,6,5);
            IF3bis = filtrageMedian(filtrageMedian(IF3, 3), 3);
            imshow(IF3, []);
            title("Image Filtrée 3 fois avec un filtre en 3x3");
        subplot(2,6,6);
            IFM = medfilt2(I);
            imshow(IFM);
            title("Image Filtrée par Matlab");
        subplot(2,6,7);
            bar(histogramme(I));
            axis([-5, 261]);
        subplot(2,6,8);
            bar(histogramme(gaussian));
            axis([-5, 261]);
        subplot(2,6,9);
            bar(histogramme(IF3));
            axis([-5, 261]);
        subplot(2,6,10);
            bar(histogramme(IF5));
            axis([-5, 261]);
        %subplot(2,6,11);
            %bar(histogramme(IF3bis));
            %axis([-5, 261]);
        subplot(2,6,12);
            bar(histogramme(IFM));
            axis([-5, 261]);
        set(figureFiltrage, "Visible", "on");
end

printf("Rendu terminé\n");
waitfor(gcf);

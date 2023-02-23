I = imread("../TP/image_test_bruit.tif");
afficheRendu = "";
if (nargin != 0)
    afficheRendu = argv(){1};
end
if (strcmp( afficheRendu, "bruit" ))
    figure(1)
    % tracé histoire
        subplot(2,7,1);
            imshow(I);
            title("Original");
        subplot(2,7,2);
            gaussian = imnoise(I, 'gaussian');
            imshow(gaussian);
            gaussianPSNR = psnr(gaussian, I);
            title(strcat( "Gaussian \nPSNR = ", num2str( gaussianPSNR ) ));
        subplot(2,7,3);
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
            saltPepper = imnoise(I, 'salt & pepper');
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
elseif (strcmp(afficheRendu, "filtrage"))
    figure(1)
        subplot(2,4,1);
            imshow(I);
            title("Image originale");
        subplot(2,4,2);
            gaussian = imnoise(I, "salt & pepper");
            imshow(gaussian);
            title("Image Bruit gaussien");
        subplot(2,4,3);
            IF = filtrageMedian(gaussian, 3);
            imshow(IF, []);
            title("Image Filtrée");
        subplot(2,4,4);
            IFM = medfilt2(I);
            imshow(IFM);
            title("Image Filtrée par Matlab");
        subplot(2,4,5);
            bar(histogramme(I));
            axis([-5, 261]);
        subplot(2,4,6);
            bar(histogramme(gaussian));
            axis([-5, 261]);
        subplot(2,4,7);
            bar(histogramme(IF));
            axis([-5, 261]);
        subplot(2,4,8);
            bar(histogramme(IFM));
            axis([-5, 261]);
end

printf("Rendu terminé\n");
waitfor(gcf);

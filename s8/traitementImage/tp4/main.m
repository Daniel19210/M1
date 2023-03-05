afficheRendu = "";
if (nargin != 0)
    afficheRendu = argv(){1};
end
%I = imread("../TP/NG/lena256.png");
I = imread("../TP/NG/grenouille.png");
if (strcmp(afficheRendu, "Gradient"))
    %test = reshape([2,2,2,2,0,12,1,51,0, 60, 0, 50], 4, 3)
    [normeISimple, Gx, Gy] = normeGradient(I);
    nbSeuils = 5;
    gradientFunc = zeros(1, nbSeuils);
    for i = 1:nbSeuils
        seuil = i/nbSeuils;
        printf("Seuil=%d\n", seuil)
        gradientFunc(i) = figure(i, "Name", strcat("Seuil=", num2str(seuil)));
            set(gradientFunc, "Visible", "off");
            subplot(2,3,1);
                imshow(I, [min(min(I)), max(max(I))]);
                title("Image originale");
                printf("Rendu image originale fait\n");
            subplot(2,3,2);
                imshow(uint8(normeISimple), [min(min(normeISimple)), max(max(normeISimple))]);
                title("Simple");
                printf("Rendu simple fait\n");
            subplot(2,3,3);
                IRoberts = edge(I, 'Roberts', seuil);
                imshow(IRoberts);
                title(strcat("Roberts seuil=", num2str(seuil)));
                printf("Rendu roberts fait\n");
            subplot(2,3,4);
                ISobel = edge(I, 'sobel', seuil);
                imshow(ISobel);
                title(strcat("Sobel seuil=", num2str(seuil)));
                printf("Rendu sobel fait\n");
            subplot(2,3,5);
                IPrewitt = edge(I, 'prewitt', seuil);
                imshow(IPrewitt);
                title(strcat("Prewitt seuil=", num2str(seuil)));
                printf("Rendu prewitt fait\n");
            subplot(2,3,6);
                ICanny = edge(I, 'Canny', seuil);
                imshow(ICanny);
                title(strcat("Canny seuil=", num2str(seuil)));
                printf("Rendu canny fait\n");
        printf("\n")
    end
    for i = 1:nbSeuils
        set(gradientFunc(i), "Visible", "on");
    end
    waitfor(gcf);
elseif (strcmp(afficheRendu, "Laplacien"))
    filtre4 = reshape([0, 1, 0, 1, -4, 1, 0, 1, 0], 3, 3);
    filtre8 = reshape([1, 1, 1, 1, -8, 1, 1, 1, 1], 3, 3);
    seuil = 0.01;
    figureLaplacien = figure(1, "Name", "Laplacien");
        set(figureLaplacien, "Visible", "off");
        subplot(2,3,1);
            imshow(I, [min(min(I)), max(max(I))]);
            title("Image originale");
            printf("Rendu image originale fait\n");
        subplot(2,3,2);
            ILaplacien4 = laplacien(I, 4);
            imshow(ILaplacien4, [min(min(ILaplacien4)), max(max(ILaplacien4))]);
            title("Laplacien 4-cx");
            printf("Rendu laplacien 4-cx fait\n");
        subplot(2,3,3);
            ILaplacien8 = laplacien(I, 8);
            imshow(ILaplacien8, [min(min(ILaplacien8)), max(max(ILaplacien8))]);
            title("Laplacien 8-cx");
            printf("Rendu laplacien 8-cx fait\n");
        subplot(2,3,4);
            ILaplacien4Func = edge(I, 'zerocross', seuil, filtre4);
            imshow(ILaplacien4Func);
            title("Laplacien 4-cx matlab");
            printf("Rendu laplacien 4-cx de matlab fait\n");
        subplot(2,3,5);
            ILaplacien8Func = edge(I, 'zerocross', seuil, filtre8);
            imshow(ILaplacien8Func);
            title("Laplacien 8-cx matlab");
            printf("Rendu laplacien 8-cx de matlab fait\n");
        subplot(2,3,6);
            ILaplacienGaussienne = edge(I, 'log', seuil);
            imshow(ILaplacienGaussienne);
            title("Laplacien Gaussien");
            printf("Rendu laplacien gaussien fait\n");

    IBruite = imnoise(I, 'gaussian');
    figureLaplacienBruite = figure(2, "Name", "Laplacien");
        set(figureLaplacienBruite, "Visible", "off");
        subplot(2,3,1);
            imshow(IBruite, [min(min(IBruite)), max(max(IBruite))]);
            title("Image originale");
            printf("Rendu image originale fait\n");
        subplot(2,3,2);
            ILaplacien4 = laplacien(IBruite, 4);
            imshow(ILaplacien4, [min(min(ILaplacien4)), max(max(ILaplacien4))]);
            title("Laplacien 4-cx");
            printf("Rendu laplacien 4-cx fait\n");
        subplot(2,3,3);
            ILaplacien8 = laplacien(IBruite, 8);
            imshow(ILaplacien8, [min(min(ILaplacien8)), max(max(ILaplacien8))]);
            title("Laplacien 8-cx");
            printf("Rendu laplacien 8-cx fait\n");
        subplot(2,3,4);
            ILaplacien4Func = edge(IBruite, 'zerocross', seuil, filtre4);
            imshow(ILaplacien4Func);
            title("Laplacien 4-cx matlab");
            printf("Rendu laplacien 4-cx de matlab fait\n");
        subplot(2,3,5);
            ILaplacien8Func = edge(IBruite, 'zerocross', seuil, filtre8);
            imshow(ILaplacien8Func);
            title("Laplacien 8-cx matlab");
            printf("Rendu laplacien 8-cx de matlab fait\n");
        subplot(2,3,6);
            ILaplacienGaussienne = edge(IBruite, 'log', seuil);
            imshow(ILaplacienGaussienne);
            title("Laplacien Gaussien");
            printf("Rendu laplacien gaussien fait\n");
        set(figureLaplacienBruite, "Visible", "on");
    waitfor(gcf);
elseif(strcmp(afficheRendu, "Maxima"))
    [norme, Gx, Gy] = normeGradient(I);
    [maxima, orientation] = maxima_locaux(Gx, Gy);
    figureMaxima = figure(1, "Name", "Maxima_locaux");
        set(figureMaxima, "Visible", "off");
        subplot(2,3,1);
            imshow(I);
            title("Image originale");
            printf("Rendu image originale fait\n");
        subplot(2,3,2);
            imshow(orientation, [min(min(orientation)), max(max(orientation))]);
            title("Orientation");
            printf("Rendu orientation fait\n");
        subplot(2,3,3);
            imshow(maxima, [1, max(max(maxima))]);
            title("Maxima locaux");
            printf("Rendu maxima fait\n");
        subplot(2,3,4);
            hist(I);
            title("Histogramme image originale");
            printf("Rendu histogramme image originale fait\n");
        subplot(2,3,5);
            hist(orientation);
            title("Histogramme orientation");
            printf("Rendu histagramme orientation fait\n");
        subplot(2,3,6);
            hist(maxima);
            title("Histogramme maxima");
            printf("Rendu histogramme maxima fait\n");
        set(figureMaxima, "Visible", "on");
    waitfor(gcf);
end

%abs(normeI - imgradient(I))
%imshow(laplacien(I, 4))

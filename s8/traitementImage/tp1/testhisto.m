img = imread('../TP/NG/cameraman.jpg');
figure(1)
    subplot(2,1,1)
        imshow(img);
        title("Image originale")
    subplot(2,1,2)
        bar(histogramme(img));
        title("Histogramme image originale");
        xlabel("NG");
        ylabel("Nombre d'occurence");
        axis([0,256]);

figure(2)
    subplot(2,1,1);
        imshow(img);
        title("Image originale");
    subplot(2,1,2);
        IBin = binarisation_man(img);
        imshow(IBin * 255);
        title("Image binarisée\nSeuil=128");

%binarisation_auto(img);
waitfor(gcf);

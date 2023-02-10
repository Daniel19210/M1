%I = imread('../TP/NG/lena256.png');
I = imread('../TP/faible_contraste/lena_fc.png');
[n, m, can] = size(I);
I2 = etirement(I);
%I3 = egalisation(I);

subplot(3,3,1);
imshow(I);
title("Image originale");

subplot(3,3,2);
bar(histogramme(I));
title("Histogramme Image originale");

subplot(3,3,3);
traceLUT(I);
title("LUT Etirement");

subplot(3,3,4);
imshow(I2);
title("Image étirée");

subplot(3,3,5);
ist = histogramme(I2);
bar(ist)
title("Histogramme Image étirée");


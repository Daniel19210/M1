subplot(2,3,1);
imshow(erosion(I));
subplot(2,3,2);
imshow(dilatation(I));
subplot(2,3,3);
imshow(ouverture(I));
subplot(2,3,4);
imshow(fermeture(I));
subplot(2,3,5);
imshow(lantuejoul(imread('../TP/NG/centaur1.png')));
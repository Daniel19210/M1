I = imread("../TP/NG/lena256.png");
%test = reshape([2,2,2,2,0,12,1,51,0, 60, 0, 50], 4, 3)
normeISimple = normeGradient(I, 'Simple');
%normeI = normeGradient(I, 'Roberts');
subplot(1,3,1)
imshow(I);
subplot(1,3,2)
imshow(uint8(normeISimple));
subplot(1,3,3)
imshow(imgradient(I)/255)
waitfor(gcf);
%abs(normeI - imgradient(I))
%imshow(laplacien(I, 4))

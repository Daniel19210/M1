I = imread("../TP/NG/lena256.png");
test = reshape([2,2,2,2,0,12,1,51,0, 60, 0, 50], 4, 3);
normeI = normeGradient(I)
imshow(uint8(normeI));
%imshow(imgradient(I)/255)
waitfor(gcf);
%abs(normeI - imgradient(I))
%imshow(laplacien(I, 4))

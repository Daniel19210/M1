function imOutput = binarisation_auto(image)
%BINARISATION_MAN Summary of this function goes here
%   Detailed explanation goes here
[m, n, can] = size(image);

if(can>1)
    imageNG = rgb2gray(image);
else
    imageNG = image;
end

T = graythresh(imageNG);

imageB = imbinarize(imageNG, T);

colormap(gray(256));
imagesc(imageB);
%imshow(imageNG*255);
imOutput = imageNG;

end
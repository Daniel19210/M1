function histoImg = histogramme(image)
%HISTOGRAMME Summary of this function goes here
%   Detailed explanation goes here
[m, n, can] = size(image);
H = zeros(1,256);

if(can > 1)
    imageNG = rgb2gray(image);
else
    imageNG = image;
end

for i = 1:m
    for j = 1:n
        H(1,imageNG(i, j)+1) = H(1,imageNG(i, j)+1) + 1;
    end
end

histoImg = H;
end


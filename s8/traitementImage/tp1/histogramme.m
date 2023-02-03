function histoImg = histogramme(image)
%HISTOGRAMME Summary of this function goes here
%   Detailed explanation goes here
[m, n, can] = size(image);
H = zeros(1,255);

if(can > 1)
    imageNG = rgb2gray(image);
else
    imageNG = image;
end

for i = 1:m
    for j = 1:n
        H(1,imageNG(i, j)) = H(1,imageNG(i, j)) + 1;
    end
end
bar(H);
histoImg = H;
end


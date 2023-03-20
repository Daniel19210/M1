function squelette = lantejoule(Image)
%LANTEJOULE Summary of this function goes here
%   Detailed explanation goes here)
[n,m] = size(Image);
squelette = zeros(n,m);
imErode = erosion(Image);
while max(max(imErode)) == 0
    imErode2 = erosion(imErode);
    pixelErode = Image - imErode2;
    for i = 2:n-1
        for j = 2:m-1
            squelette(i,j) = min(reshape(pixelErode(i-1:i+1, j-1:j+1), [1,9]));
        end
    end
    imErode = imErode2;
end
end
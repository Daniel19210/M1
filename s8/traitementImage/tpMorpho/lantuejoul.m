function squelette = lantuejoul(Image)
%LANTEJOULE Summary of this function goes here
%   Detailed explanation goes here)
i = 1;
filtre = ones(3, 3);
squelette = zeros(size(Image));
A = Image;

while max(max(A)) ~= 0

    iH = ones(2*i+1,2*i+1);
    A = erosion(Image, iH);
    B = ouverture(A, filtre);
    R = A-B;
    squelette = squelette + R;
    i = i+1;

end
end

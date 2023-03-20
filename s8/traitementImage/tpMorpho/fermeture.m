function resImage = fermeture(Image)
%FERMETURE Summary of this function goes here
%   Detailed explanation goes here
resImage = erosion(dilatation(Image));
end


function resImage = fermeture(Image, filtre)
%FERMETURE Summary of this function goes here
%   Detailed explanation goes here
resImage = erosion(dilatation(Image, filtre), filtre);
end


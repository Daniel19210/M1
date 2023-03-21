function resImage = ouverture(Image, filtre)
%OUVERTURE Summary of this function goes here
%   Detailed explanation goes here
resImage = dilatation(erosion(Image, filtre), filtre);
end




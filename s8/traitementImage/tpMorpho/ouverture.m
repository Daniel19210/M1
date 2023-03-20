function resImage = ouverture(Image)
%OUVERTURE Summary of this function goes here
%   Detailed explanation goes here
resImage = dilatation(erosion(Image));
end




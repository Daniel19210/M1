function Imagenew = etirement(Image)
%ETIREMENT Summary of this function goes here
%   Detailed explanation goes here
[n, m, can] = size(Image);
if can>1
    Image = rgb2gray(Image);
end
Image = double(Image);
aMin = min(Image(:));
aMax = max(Image(:));
Imagenew = 255*(Image - aMin) / (aMax - aMin);
Imagenew = uint8(Imagenew);
end
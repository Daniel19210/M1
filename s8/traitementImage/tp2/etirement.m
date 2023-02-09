function Imagenew = etirement(Image)
%ETIREMENT Summary of this function goes here
%   Detailed explanation goes here
[n, m, can] = size(Image)
if can>1
    Image = rgb2gray(Image)
end
aMin = min(Image(:))
aMax = max(Image(:))
Imagenew = uint8(round(255*(double(Image - aMin)/double(aMax - aMin))))

end
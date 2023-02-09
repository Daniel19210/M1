function traceLUT(Image)
%TRACELUT Summary of this function goes here
%   Detailed explanation goes here
aMin = double(min(min(Image)))
aMax = double(max(max(Image)))
x1 = 0:1:29
x2 = 29:1:255
y1 = zeros(30)
y2 = double(255)/(aMax - aMin)* double(x2 - (double(255)*aMin)/(aMax - aMin))
y2 = uint8(y2)
plot(x1,y1, x2,y2)
end


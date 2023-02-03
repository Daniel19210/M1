function imgOutput = LUT()
%LUT Summary of this function goes here
%   Detailed explanation goes here
I = imread('../NG/rectangles.png');
I2 = uint8(I);

r = zeros(255, 1);
g = zeros(255, 1);
b = zeros(255, 1);
r(30) = 1;
r(92) = 1;
r(256) = 1;
g(92) = 1;
g(227) = 1;
g(256) = 1;
b(151) = 1;
b(256) = 1;

map4C = [r g b];

image(I2);
colormap(map4C);
%imagesc(I);
imgOutput = I2;
end


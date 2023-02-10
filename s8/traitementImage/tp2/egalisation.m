function egalise = egalisation(I)
%EGALISATION Summary of this function goes here
%   Detailed explanation goes here
[n, m, can] = size(I);

if can>1
    I = rgb2gray(I);
end
I=double(I);
aMin = double(min(min(I)));
aMax = double(max(max(I)));
H = histogramme(I);
HC = cumsum(H);
HCN = HC / (m*n);
res = I;
for i = 1:n
    for j = i:m
        gris = double(I(i,j));
        res(i,j) = HCN(gris) * (aMax - aMin) + aMin;
    end
end

egalise = uint8(res);

%{
HC = zeros(1, 255)
HC(1) = H(1)
for i = 2:255
    HC(1, i) = HC(1, i-1) + H(1, i)
end
HCN = uint8(HC/255)
%bar(HC/255)

HF = zeros(1, 255)

for i = 1:255
    a = HCN(i, 1)
    disp(a)
    HF(1, a) = H(1, i)%+HF(1, HCN(1, i))
end
bar(HF)
%}
end
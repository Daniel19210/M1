function imageEgalise = egalisation(I)
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
    for j = 1:m
        res(i,j) = HCN(double(I(i,j))) * 256;
    end
end

imageEgalise = uint8(res);

end

function imageEgalise = egalisation(I)
    %EGALISATION Summary of this function goes here
    %   Detailed explanation goes here
    [n, m, can] = size(I);

    if can>1
        I = rgb2gray(I);
    end
    I=double(I);
    aMin = double(min(I(:)));
    aMax = double(max(I(:)));
    H = histogramme(I);
    HC = cumsum(H);
    HCN = HC / (m*n);
    imageEgalise = uint8(HCN(double(I+1))*256);
end

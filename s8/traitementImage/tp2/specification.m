function imageSpecifie = specification(Ix, Iz)
    ng = 256;
    [m, n, can] = size(image);
    imageSpecifie = Ix;
    hres = zeros(1, 256);
    hcx = cumsum(histogramme(Ix));
    hcz = cumsum(histogramme(Iz));
    for i = 1:ng
        fX = hcx(1, i);
        [minDist, gInvX] = min(abs(hcz-fX));
        imageSpecifie(Ix==i) = gInvX;
    end
end

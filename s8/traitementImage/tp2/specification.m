function imageSpecifie = specification(Ix, Iz)
    ng = 256;
    [m, n, can] = size(image);
    imageSpecifie = Ix;
    hres = zeros(1, 256);
    hcx = cumsum(histogramme(Ix));
    hcz = cumsum(histogramme(Iz));
    for x = 1:ng
        fX = hcx(1, x);
        [minDist, gInvX] = min(abs(hcz-fX));
        imageSpecifie(Ix==x) = gInvX;
    end
end

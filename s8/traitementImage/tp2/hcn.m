function histCumuleNorme = hcn(image)

[ m,n,can ] = size(image);
HC = cumsum(histogramme(image));
histCumuleNorme = HC / (m*n);

end

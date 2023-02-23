function INoised = bruitUniforme(I)
    [M, N] = size(I);
    a = 0;
    b = 28;
    Noise = a+(b-a)*rand([M,N]);
    INoised = imadd(I, uint8(Noise));
end

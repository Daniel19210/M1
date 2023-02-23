function INoised = bruitExponentiel(I)
    [M, N] = size(I);
    Noise = exprnd(5, [M,N]);
    INoised = imadd(I, uint8(Noise));
end

function Ires = laplacien(I, connexite)
    filtre = zeros(3, 3);
    if(connexite == 4)
        filtre=reshape([0, 1, 0, 1, -4, 1, 0, 1, 0], 3, 3);
    elseif(connexite == 8)
        filtre = reshape([1, 1, 1, 1, -8, 1, 1, 1, 1], 3, 3);
    end
    [n, m, can] = size(I);
    if(can > 1)
        I = rgb2gray(I);
    end
    Ires = zeros(n, m);
    for ligne = 2:n-1
        for colonne = 2:m-1
            Ires(ligne,colonne) = sum(reshape(double(I(ligne-1:ligne+1, colonne-1:colonne+1)).*filtre(1:3, 1:3), 1, 9));
        end
    end
end

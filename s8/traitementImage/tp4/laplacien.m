function Ires = laplacien(Image, type)
    if(type == 4)
        filtre=reshape([0, 1, 0, 1, -4, 1, 0, 1, 0], 3, 3);
    else if(type == 8)
        filtre = reshape([1, 1, 1, 1, -8, 1, 1, 1, 1], 3, 3);
    end
    [n, m, can] = size(Image);

    if(can > 1)
        Image = rgb2gray(Image);
    end

    Ires = zeros(n, m);

    for ligne = 2:n-1
        for colonne = 2:m-1
            Fen(1:3, 1:3) = I(ligne-1:ligne+1, colonne-1:colonne+1);
            array = reshape(Fen,1,9);
            %IFiltre(ligne-1,colonne-1)
            %Fen(size(Fen)(2))
            Ires(ligne,colonne) = sum(array);
        end
    end
end

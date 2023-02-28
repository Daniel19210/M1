function IFiltre = filtrageMedian(I, sizeFiltre)
    [ n,m,can ] = size(I);
    %if (can > 1)
        %I = rgb2gray(I);
    %end
    if(mod(sizeFiltre, 2) == 0)
        printf("Taille du filtre = %d\n", sizeFiltre+1);
        sizeFiltre = sizeFiltre + 1;
    end
    decalage = floor(sizeFiltre/2);
    IFiltre = zeros(n-2,m-2);
    for ligne = decalage+1:n-decalage
        for colonne = decalage+1:m-decalage
            Fen(1:sizeFiltre, 1:sizeFiltre) = I(ligne-decalage:ligne+decalage, colonne-decalage:colonne+decalage);
            array = sort(reshape(Fen,1,sizeFiltre * sizeFiltre));
            %IFiltre(ligne-decalage,colonne-decalage)
            %Fen(size(Fen)(2))
            IFiltre(ligne-decalage,colonne-decalage) = floor(Fen(size(array)(2))+1);
    end
end

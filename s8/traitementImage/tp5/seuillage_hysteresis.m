function M = seuillage_hysteresis(Norme, Sb, Sh, type)
    [n, m] = size(Norme);
    M = Norme > Sh;
    M = zeros(n,m);
    pile = zeros(0,2);
    for i = 1:n
        for j = 1:m
            if (Norme(i,j) > Sh)
                M(i,j) = 1;
                pile(end+1, 1) = i;
                pile(end, 2) = j;
            else
                M(i,j) = 0;
            end
        end
    end
    hauteur = size(pile)(1);
    while hauteur != 0
        i = pile(hauteur, 1);
        j = pile(hauteur, 2);
        hauteur= hauteur - 1; % Dépiler
        %if (i == 1)
            %voisin = [Norme(i, j-1), Norme(i, j+1), Norme(i+1, j-1), Norme(i+1, j), Norme(i+1, j+1)]
        %else if (i == n)
            %voisin = [Norme(i-1, j-1), Norme(i-1, j+1), Norme(i-1, j+1), Norme(i, j-1), Norme(i, j+1)]
        %end
        Fen = zeros(3,3);
        minI = -1;
        maxI = 1;
        minJ = -1;
        maxJ = 1;
        %if (i == 1)
            %if (j == 1)
                %Fen(1:2, 1:2) = Norme(i:i+1, j:j+1);
                %minI = 0;
                %maxI = 1;
                %minJ = 0;
                %maxJ = 1;
            %elseif (j == m)
                %Fen(1:2, 1:2) = Norme(i:i+1, j-1:j);
                %minI = 0;
                %maxI = 1;
                %minJ = -1;
                %maxJ = 0;
            %end
        %elseif (i == n)
            %if (j == 1)
                %Fen(1:2, 1:2) = Norme(i-1:i, j:j+1);
                %minI = -1;
                %maxI = 0;
                %minJ = 0;
                %maxJ = 1;
            %elseif (j == m)
                %Fen(1:2, 1:2) = Norme(i-1:i, j-1:j);
                %minI = -1;
                %maxI = 0;
                %minJ = 0;
                %maxJ = 1;
            %end
        %end

        if (i != 1 && i != n && j != 1 && j != m)
            Fen(1:3, 1:3) = Norme(i-1:i+1, j-1:j+1);
            for ligne = -1:1
                for colonne = -1:1
                    if (M(i+ligne,j+colonne) == 0 && Fen(ligne+2,colonne+2) > Sb)
                        M(i+ligne, j+colonne) = 1;
                        pile(hauteur+1, 1) = i+ligne;
                        pile(hauteur+1, 2) = j+colonne;
                        hauteur = hauteur + 1;
                    end
                end
            end
        end
    end
end

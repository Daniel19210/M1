function norme = normeGradient(Image, type)
    [n,m,can]=size(Image);
    Gx = zeros(n,m);
    Gy = zeros(n,m);
    if (strcmp(type, 'Simple'))
        fx = [-1, 1];
        fy = reshape([-1, 1], 2, 1);
        for ligne = 1:n
            for colonne = 1:m
                if (colonne < m)
                    Gx(ligne, colonne) = Image(ligne, colonne) * fx(1) + Image(ligne, colonne+1) * fx(2);
                else
                    Gx(ligne, colonne) = Image(ligne, colonne) * fx(1);
                end
                if (ligne < n)
                    Gy(ligne, colonne) = Image(ligne, colonne) * fy(1, 1) + Image(ligne+1, colonne) * fy(2, 1);
                else
                    Gy(ligne, colonne) = Image(ligne, colonne) * fy(1, 1);
                end
            end
        end
        norme = abs(Gx) + abs(Gy);
    else if (strcmp(type, 'Roberts'))
        fx = reshape([1, 0, 0, -1], 2, 2)
        fy = reshape([0, -1, 1, 0], 2, 2)
    end
end

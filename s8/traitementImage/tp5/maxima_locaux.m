function [maxima, orientation] = maxima_locaux(Gx, Gy)
    [n, m] = size(Gx);
    norme = abs(Gx) + abs(Gy);
    maxima = zeros(n,m);
    orientation = zeros(n,m);
    for ligne = 2:n-1
        for colonne = 2:m-1
            theta = atan(sqrt(power(Gx(ligne, colonne),2) + power(Gy(ligne, colonne), 2)));
            orientation(ligne, colonne) = theta;
            n1 = 0;
            n2 = 0;
            if(theta >= -(3 * pi)/8 && theta < -pi/8)
                n1 = norme(ligne-1, colonne-1);
                n2 = norme(ligne+1, colonne+1);
            elseif (theta >= -pi/8 && theta < pi/8)
                n1 = norme(ligne, colonne+1);
                n2 = norme(ligne, colonne-1);
            elseif (theta >= pi/8 && theta < (3*pi)/8)
                n1 = norme(ligne-1, colonne+1);
                n2 = norme(ligne+1, colonne-1);
            elseif ((theta >= (3*pi)/8 && theta <= pi/2) || (theta >= -pi/2 && theta <= (-3*pi)*8))
                n1 = norme(ligne-1, colonne);
                n2 = norme(ligne+1, colonne);
            end
            if (norme(ligne, colonne) > n1 && norme(ligne, colonne) > n2)
                maxima(ligne, colonne) = norme(ligne, colonne);
            else
                maxima(ligne, colonne) = 1;
            end
        end
    end
end

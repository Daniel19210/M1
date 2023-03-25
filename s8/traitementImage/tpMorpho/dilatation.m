function resImage = dilatation(Image, filtre)
%DILATATION Summary of this function goes here
%   Detailed explanation goes here[n, m] = size(Image);
[longImage, largImage] = size(Image);
[longFiltre, largFiltre] = size(filtre);
resImage = zeros(longImage, largImage);
for ligne = 1:longImage
	for colonne = 1:largImage
    	maxVal = Image(ligne, colonne);
    	if maxVal == 0
        	for i = 1:longFiltre
            	for j = 1:largFiltre
                	lig = ligne - (i-1) + floor(longFiltre / 2);
                	col = colonne - (j-1) + floor(largFiltre / 2);
                	if((lig >= 1) && (lig < longImage) && (col >= 1) && (col < largImage))
                    	if((filtre(i, j) == 1) && (maxVal < Image(lig, col)))
                        	maxVal = Image(lig, col);
                    	end
                	end
            	end
        	end
    	end
    	resImage(ligne, colonne) = maxVal;
	end
end
end

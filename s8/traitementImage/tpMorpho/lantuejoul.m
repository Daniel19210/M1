function squelette = lantuejoul(Image)
%LANTEJOULE Summary of this function goes here
%   Detailed explanation goes here)
i = 20;
filtre = ones(3, 3);
squelette = zeros(size(Image));
A = Image;

while max(max(A)) ~= 0

    printf(strcat("nb iteration : ", num2str(i), "\n"));
    iH = ones(2*i+1,2*i+1);
    printf("Erosion en cours\n");
    A = erosion(Image, iH)
    printf("Ouverture en cours\n");
    B = ouverture(A, filtre);
    R = A-B;
    squelette = bitor(squelette, R);
    i = i+1;

end
end

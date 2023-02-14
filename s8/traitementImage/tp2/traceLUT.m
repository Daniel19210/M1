function [coefDir,Ord] = traceLUT(Image)
    %TRACELUT Summary of this function goes here
    %   Detailed explanation goes here

    aMin = double(min(Image(:)));
    aMax = double(max(Image(:)));

    x1 = 1:1:aMin(1); % les '(1)' sont juste là pour éviter des warnings
    x2 = aMin(1):1:aMax(1);
    x3 = aMax(1):1:255;
    y1 = zeros(1, aMin);

    y2 = 255 * (x2 - aMin) / (aMax - aMin);
    y3 = ones(1, 256-aMax)*255;

    plot(x1,y1, x2,y2, x3,y3)

    coefDir = 255 / (aMax - aMin); % Coefficient directeur
    Ord = - 255 * aMin / (aMax - aMin); % Ordonnée à l'origine
end

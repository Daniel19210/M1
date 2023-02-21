function imOutput = binarisation_man(image)
    %BINARISATION_MAN Summary of this function goes here
    %   Detailed explanation goes here
    [m, n, can] = size(image);

    if(can>1)
        imageNG = rgb2gray(image);
    else
        imageNG = image;
    end

    %s = input("Veuillez choisir un seuil : ");
    s = 128;

    for i=1:m
        for j=1:n
            if imageNG(i, j) <= s
                imageNG(i,j) = 0;
            else
                imageNG(i, j) = 1;
            end
        end
    end
    imOutput = imageNG;
end


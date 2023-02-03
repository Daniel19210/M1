function imageOutput = transformationNG()
%TRANSFORMATIONNG Summary of this function goes here
%   Detailed explanation goes here
I = imread('../NG/lena256.png');

[m, n, can] = size(I);

for i = 1:m
    for j = 1:n
        if I(i, j) <= 50
            I(i, j) = I(i, j) * 150/50;
        else if I(i, j)>50 && I(i, j)<=150
                I(i,j) = 255;
        else if I(i, j) > 150
                I(i, j) = I(i, j) *105/155 + (255/155) * 150;
        end
        end
        end
    end
end

plot = imshow(I);
waitfor(plot)

end

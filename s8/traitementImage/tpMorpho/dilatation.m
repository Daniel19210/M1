function resImage = dilatation(Image)
%DILATATION Summary of this function goes here
%   Detailed explanation goes here[n, m] = size(Image);
[n, m] = size(Image);
resImage = zeros(n, m);

for i = 2:n-1
    for j=2:m-1
        temp = [Image(i-1,j+1),Image(i,j),Image(i,j+1)];
        if Image(i,j) == 1
            resImage(i-1, j+1) = 1;
            resImage(i, j) = 1;
            resImage(i, j+1) = 1;
        end
    end
end
end



function resImage = dilatation(Image, filtre)
%DILATATION Summary of this function goes here
%   Detailed explanation goes here[n, m] = size(Image);
[n, m] = size(Image);
resImage = zeros(n, m);

tuple = zeros(sum(filtre(:)==1), 2);
k = 1;

for i = -1:1
    for j = -1:1
        if filtre(i+2,j+2) == 1
            tuple(k, 1) = i;
            tuple(k, 2) = j;
            k = k+1;
        end
    end
end
[s, p] = size(tuple);

for i = 2:n-1
    for j = 2:m-1
        if Image(i,j) == 1
            for k = 1:s
                resImage(i+tuple(k, 1),j+tuple(k, 2)) = 1;
            end
        end
    end
end
end



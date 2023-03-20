function descripteur = descripteurCouleur( Image,nombre_couleurs )
   ab = double(Image(:,:,:));
    [nrows ncols dim] = size(ab) ;
    ab = reshape(ab,nrows*ncols,dim);

 %   [cluster_idx, cluster_center] = kmeans(ab,nombre_couleurs,'distance','sqEuclidean', ...
%                                      'Replicates',3);
     [cluster_idx, cluster_center] = Kmeans(ab',nombre_couleurs);

    descripteur = zeros(1,3*nombre_couleurs) ;
    ind=1 ;
    for cl=1:nombre_couleurs
        for d=1:dim
            descripteur(1,ind)=cluster_center(d,cl) ;
            ind=ind+1;
        end
    end

    descripteur ;
end


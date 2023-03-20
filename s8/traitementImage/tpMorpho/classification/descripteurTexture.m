function descripteur = descripteurTexture(Image)
    % taille du descripteur (à remplir)
    tailleDescripteur=4 ;

    descripteur = zeros(1,tailleDescripteur) ;
    ImageRGB = rgb2gray(Image);
    
    % calcul de la matrice de coocurrence spatiale
    % le paramètre Offset définit l'angle et la distance D :
    %             angle   |    0°     45°     90°     135°
    %             offset  |  [0 D]  [-D D]  [-D 0]  [-D -D]]  
    glcm = graycomatrix(ImageRGB,'Offset',[5 0]);
    
    % Calcul des paramètres statistiques
    stats = graycoprops(glcm);
    contraste = stats.Contrast ;
    correlation = stats.Correlation;
    energie = stats.Energy;
    homogeneite = stats.Homogeneity ;
    
    % choix des variables du descripteur (à remplir)
    descripteur(1,1) = contraste ;
    descripteur(1,2) = correlation ;
     descripteur(1,3) = energie ;
     descripteur(1,4) = homogeneite ;
end
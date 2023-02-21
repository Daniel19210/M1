afficheRendu = "";
if (nargin != 0)
    afficheRendu = argv(){1};
end
if (strcmp(afficheRendu, "Etirement"))
    renduEtirement(imread('../TP/faible_contraste/soi1.png'), "Etirement soil", 1); % Image sombre
    renduEtirement(imread('../TP/faible_contraste/meca.png'), "Etirement meca", 2); % Ng centré
    renduEtirement(imread('../TP/faible_contraste/lune.png'), "Etirement lune", 3); % Ng distribué
    renduEtirement(imread('../TP/faible_contraste/sap1.png'), "Etirement sap1", 4); % image avec un niveau de gris trop resseré
elseif (strcmp(afficheRendu, "Egalisation")) % Répartiton d'intensitée
    renduEgalisation(imread('../TP/faible_contraste/ville.png'), "Egalisation ville", 1); % Très bonne égalisation
    renduEgalisation(imread('../TP/faible_contraste/soi1.png'), "Egalisation soil", 2); % Bonne égalisation (étalage des pics qui sont assez homogène)
    renduEgalisation(imread('../TP/faible_contraste/lune.png'), "Egalisation lune", 3); % Mauvaise égalisation car trop de pixel noir (perte de détail)
elseif (strcmp(afficheRendu, "Specification"))
    renduSpecification(imread('../TP/faible_contraste/lena_fc.png'), imread('../TP/NG/lena256.png'), "Specifiaction Lena, Lena", 1) % Bonne spécification
    renduSpecification(imread('../TP/faible_contraste/lena_fc.png'), imread('../TP/NG/photographe256.png'), "Specifiaction Lena, Photographe", 1) % Bonne spécification
    renduSpecification(imread('../TP/faible_contraste/lena_fc.png'), imread('../TP/NG/colonne512.png'), "Specifiaction Lena, Colonne", 1) % Mauvaise spécification car l'histogramme est loin de la référence
end

if (strcmp(afficheRendu, "") == 0)
    printf("Rendu terminé\n");
    waitfor(gcf); % Pour que les graphiques ne se ferment pas automatiquement sur octave
else
    printf("Aucun affichage sélectionné.\n");
end

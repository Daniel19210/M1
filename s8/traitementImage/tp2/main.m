afficheRendu = "";

%afficheRendu = "Etirement"; % Commenter ou décommenter cette ligne pour afficher les figures concernant l'étirement
if (afficheRendu == "Etirement")
    renduEtirement(imread('../TP/faible_contraste/fce5.png'), 1, "Image sombre");
    %renduEtirement(imread('../TP/faible_contraste/soi1.png'), 1, "Image sombre");
    renduEtirement(imread('../TP/faible_contraste/meca.png'), 2, "NG centré");
    renduEtirement(imread('../TP/faible_contraste/lune.png'), 3, "NG distribué");
    renduEtirement(imread('../TP/faible_contraste/sap1.png'), 4, "Image trop resserée");
    renduEtirement(imread('../TP/faible_contraste/lena_fc.png'), 5, "Image claire");
end

waitfor(gcf) % Pour que les graphiques ne se ferment pas automatiquement sur octave

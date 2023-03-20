% charger l'ensemble es images du dossier img
rep = 'img';
list1 = dir(fullfile('classe1','*.jpg'));
list2 = dir(fullfile('classe2','*.jpg'));
listTest = dir(fullfile('test','*.jpg'));
    
% apprentissage de la classe 1
for n = 1:numel(list1)
    name=fullfile(rep, list1(n).name);
    Image = imread(name);  % chargement de chaque image de la première classe l'une après l'autre
    
     % déclaratioin des matrices contenant les données d'apprentissage et de test 
     if n==1
         [d dim] = size(descripteurTexture(Image)) ;
          donneesApprentissage = zeros(numel(list1)+numel(list2),dim);
          donneesTest = zeros(numel(listTest),dim);
          assignationApprentissage = zeros(numel(list1)+numel(list2),1);
     end
         
     donneesApprentissage(n,:) = descripteurTexture(Image) ;
     assignationApprentissage(n)=1; % label = 1
end
    
% apprentissage de la classe 2
for n = 1:numel(list2)
    name=fullfile(rep, list2(n).name) ;
    Image = imread(name) ; % chargement de chaque image de la seconde classe l'une après l'autre
        
    donneesApprentissage(n+numel(list1),:) = descripteurTexture(Image) ;
    assignationApprentissage(n+numel(list1))=2 ; % label = 2
end
    
% données de test
for n = 1:numel(listTest)
    name=fullfile(rep, listTest(n).name);
    Image = imread(name);  
       
    donneesTest(n,:) = descripteurTexture(Image) ;
end
    
classif =  Knn(donneesApprentissage',donneesTest',assignationApprentissage',3) ;

for n = 1:numel(listTest)
    disp(['    ' sprintf('%18s',listTest(n).name) '     ->    classe '  num2str(classif(n))])
end

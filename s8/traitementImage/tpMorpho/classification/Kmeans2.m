function [assignation noyaux] = Kmeans(donnees,nbRegions)
	[dim nbSample]=size(donnees);
	assignation=zeros(1,nbSample);
	noyaux=zeros(dim,nbRegions);
	noyauxP=zeros(dim,nbRegions);
	distance=zeros(1,nbRegions);

	for i=1:nbRegions
		%k=round(((nbSample-1)*i+nbRegions-nbSample)/(nbRegions-1));
		%noyaux(:,i)=donnees(:,k);
		k=round((i-1)*255/(nbRegions-1)) ;
		noyaux(:,i)=[k k k];
	end


	iteration=0;
	while iteration<10 %&& noyaux!=noyauxP 
		for i=1:nbSample
			for j=1:nbRegions
				dif=noyaux(:,j)-donnees(:,i);
				distance(j)=sum(dif.*dif) ;
			end
			[valMin assignation(i)]=min(distance);
		end
	
		noyauxP=noyaux;
		for j=1:nbRegions
			noyaux(:,j)=mean(	donnees(:,find(assignation==j)),2);
			
			if(isnan(noyaux(1,j)))
				noyaux(:,j)=[0 0 0];
		end
		iteration=iteration+1;
	end
end

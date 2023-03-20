function [assignation noyaux] = Kmeans(donnees,nbRegions)
	[dim nbSample]=size(donnees);
	assignation=zeros(1,nbSample);
	noyaux=zeros(dim,nbRegions);
	noyauxP=zeros(dim,nbRegions);
	distance=zeros(1,nbRegions);

	for i=1:nbRegions
		k=round(((nbSample-1)*i+nbRegions-nbSample)/(nbRegions-1));
		noyaux(:,i)=donnees(:,k);
	end

	iteration=0;
	while iteration<20 %&& noyaux!=noyauxP 
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
		end
		iteration=iteration+1;
	end
end

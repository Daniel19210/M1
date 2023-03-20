function classTest = Knn(learning,test,classLearning,K)
	[dim sizeLearning] = size(learning);
	[dim sizeTest] = size(test);
	classTest=zeros(1,sizeTest);
	d=zeros(1,sizeLearning);

	for i=1:sizeTest
		for j=1:sizeLearning
			di=test(:,i)-learning(:,j);
			d(j)=di'*di ;
		end
		[Y tri]=sort(d);
		claKNN=classLearning(tri(1:K));
		[count index] = hist(claKNN,unique(claKNN));
		[valMax indMax]=max(count) ;
		classTest(i)=index(indMax) ;
	end

end

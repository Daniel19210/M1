for i in 'cat cluster.txt'
do
	ssh $i slot=10
done

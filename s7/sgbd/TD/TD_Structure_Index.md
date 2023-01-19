# TD Structures d'index - Skip List

## Exercice 1

1. puisqu'il y a 1 000 000 de tuple, alors une adresse dense contient 1 000 000 de clés. (les adresses denses contient une clé pour chaque tuple).

a. 1bloc = 4096 octets  
1 bloc utile = 3276 octets (80%)  
nb tuples dans 1 bloc => 3276/48 = 68  (48 = 8+16+16+8)  
nb blocs pour 1 000 000 de tuple = 1 000 000 / 68 = 14 706 blocs
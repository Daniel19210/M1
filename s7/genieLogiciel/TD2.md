# Exercice 1

## Partie 1

|Entrées|classe valide|Pas d'ajout|Exception|
|:-:|:-:|:-:|:-:|
|Valeurs de o|o!=null|o=null||
||Panier Vide|Panier a 1 élément||


        public void ajout(Fruit o){
            if(o === null){
                return;
            }
            if(!estPleine()){
                fruits.add(o);
            }else{
                throw new PanierPleinException();
            }
        }

||Cas Normeaux|Cas Anormaux|Cas Anormaux|
|:-:|:-:|:-:|:-:|
|Donnees d'entrées|Classe Valide|Pas d'Ajout|Exception|
|Valeur o|o!=Null|o==Null||
|valeur de this|PanierVide \| Panier1ELT \| Panier Presque Pleine ||Panier Plein doit renvoyer lexception Panier Pleine Exception|
||Attention aux valeurs (\< o, ==o ou \>o) de contenance MAX|||

Nous venons ici de classer les données d'entrées en grandes classes d'équivalence (on en paquets) regroupent les données qui entrainent un comportement équivalent de la méthode ajout  
Il convient maintenant de réaliser toutes les combinaison possible de ces classes identifiées  
Pour les deux variables d'entrées (o et this) pour en déduire tous les scenarii possibles à tester et pour choisir un représentant parmi ces scénarii : ce qui donnera les DT (8 scénarii possibles) :
1. Panier vide (contenanceMax=3) et o est une orange a 0.5€ et provenant d'Espagne (non null) -> résultat le panier contient 1 ELT
2. Panier vide (contenanceMax=3) et o est une orange a 0.5€ et provenant d'Espagne (non null) -> résultat le panier contient 2 ELT
3. Panier vide (contenanceMax=3) et o est une orange a 0.5€ et provenant d'Espagne (non null) -> résultat le panier contient 3 ELT
4. Panier Plein (contenanceMax=3) o est toujours la meme orange (non null) -> résultat envoi de l'Exception 
5. o=null ->résultat : panier toujours vide (idem pour 6,7,8)


## Partie 2

        public class PanierTest{
            Panier P0, P2, P2Pleine, P3, P4;
            Fruit o1, o2, o3;
            Fruit mock1, mock2;
            
            public PanierTest(){}

            @Before
            public void SetUp() throws PanierPleinException{
                P0 = new Panier(0);
                P2 = new Panier(2);
                P2Pleine = new Panier(2);
                P3 = new Panier(3);
                P4 = new Panier(4);

                o1 = new Orange(0.5, "Espagne");
                o2 = new Orange(0.7, "France");
                o3 = new Orange(0.5, "USA");

                P2Pleine.ajout(o1);
                P2Pleine.ajout(o1);

                mock1 = mock(Fruit.class);
                mock2 = mock(Fruit.class);
                when(mock1.getPrix())thisReturn(1);
                when(mock2.getPrix())thisReturn(0.5);
            }
        }

Test de getPrix

        @Test
        public void testGetPrixMock(){
            System.out.println("GetPrixMock");
            Panier panier = new Panier(3);
            panier.ajout(mock1);
            panier.ajout(mock2);
            double res = Panier.getPrix();
            //Test d'interaction
            verify(mock1.time(1)).getPrix();
            verify(mock2.time(1)).getPrix();
            assertTime(res==1.5);
            panier.retrait();
            verify(mock1.time(2)).getPrix();
            verify(mock2.time(1)).getPrix();
            res = panier.getPrix();
            assertTime(res==1);
        }
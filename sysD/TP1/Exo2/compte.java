public class Compte {
    public class Operation {
        string operation;
        float montant;

        public Operation(string op, float mt){
            this.operation = op;
            this.montant = mt;
        }
    }

    float solde = 100;
    ArrayList<Operation> historique;

    public Compte(float solde){
        this.solde = solde;
        historique = new ArrayList<Operation>();
    }

    public void depot(float montant) throws Exception {
        if (montant > 0){
            this.solde += montant;
            this.historique.add(new Operation("dépot", montant));
        }
        else
            throw new Exception("Impossible de faire un dépot négatif");
    }

    public void retrait(float montant) throws Exception {
        if (montant > 0){
            if (this.solde - montant > 0){
                this.solde -= montant
                this.historique.add(new Operation("retrait", montant));
            }
            else
                throw Excpetion("Impossible de retirer ce montant");
        }
        else
            throw new Exception("Impossible de faire un retrait positif");
    }

    public void afficherSolde(){
        System.out.println("Solde:" + solde);
    }
}

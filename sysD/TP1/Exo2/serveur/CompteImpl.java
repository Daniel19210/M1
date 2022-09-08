public class CompteImpl {

    float solde = 100;
    ArrayList<Pair<String, float>> historique; // List d'opération avec String = "dépot" ou "retrait" et float le montant

    public CompteImpl(float solde){
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

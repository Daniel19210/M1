package fruit;
import fruit.model.Panier;
import fruit.controller.Controlleur;
import fruit.view.VueConsole;
import fruit.view.VueGraphiqueSimple;

public class TestMVC {
    private Panier p;
    private Controlleur c;
    private VueGraphiqueSimple vueGraph;
    private VueConsole vueC;

    public TestMVC(){
        this.p = new Panier(0);
        this.c = new Controlleur();
        this.vueGraph = new VueGraphiqueSimple();
        this.vueC = new VueConsole();

        c.setPanier(p);
        p.addObserver(vueC);
        p.addObserver(vueGraph);
        vueGraph.ajoutControlleur(c);
    }

    public VueGraphiqueSimple getVueGraph() {
        return this.vueGraph;
    }

    public void setVueGraph(VueGraphiqueSimple vueGraph) {
        this.vueGraph = vueGraph;
    }

    public static void main(String[] args) {
        TestMVC test = new TestMVC();
    }

}

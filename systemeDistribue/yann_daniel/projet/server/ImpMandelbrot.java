import java.util.ArrayList;


public class ImpMandelbrot implements Mandelbrot{

    public ArrayList<Point> pointsATraiter = new ArrayList<Point>();
    public Fenetre fenetre;
    public Complexe widthComplexe, heightComplexe;
    public float width, height;
    public int nbtache;

    public ImpMandelbrot(Fenetre fen, float w, float h){
        
        this.fenetre = fen;

        this.nbtache=0;

        this.width = w;
        this.height = h;
        this.widthComplexe = new Complexe(-2,1);
        this.heightComplexe = new Complexe(1,-1);
        for(int i=0; i<=w; i++){
            for(int j=0; j<=h; j++){
                pointsATraiter.add(new Point(i,j));
            }
        }
    }

    public synchronized int getNbTache(){
        nbtache++;
        return nbtache-1;
    }

    //Vérification qu'un point donnée appartient à l'ensemble de Mandelbrot
    public boolean traitementPoint(int tache){
        
        if(tache >= pointsATraiter.size()){return false;}

        System.out.println("calcul en cours : " + ((float)nbtache/(float)pointsATraiter.size()*100) + "%");
        Complexe z = new Complexe(0, 0);
        Complexe c = convert(pointsATraiter.get(tache));
        
        for(int i=0; i<50 ; i++){
            if(z.module() > 2){
                return true;
            }
            z = z.multiply(z);
            z = z.add(c);
        }
        fenetre.getPanelDessin().listePointMandelbrot.add(pointsATraiter.get(tache));

        return true;
    }

    public Complexe convert(Point p){

        float intervalleFenetreWidth = (Math.max(widthComplexe.getA(), heightComplexe.getA()) - Math.min(widthComplexe.getA(), heightComplexe.getA()));
        float intervalleFenetreHeight = (Math.max(widthComplexe.getB(), heightComplexe.getB()) - Math.min(widthComplexe.getB(), heightComplexe.getB()));

        float decalImageX = Math.min(widthComplexe.getA(), heightComplexe.getA());
        float decalImageY = Math.min(widthComplexe.getB(), heightComplexe.getB());

        return new Complexe((float)(p.getX()*(intervalleFenetreWidth/width) + decalImageX), (float)(p.getY()*(intervalleFenetreHeight/height) + decalImageY)); 
    }

    public void paint(){
        fenetre.getPanelDessin().repaint();
    }
}
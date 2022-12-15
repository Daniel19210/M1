import java.util.ArrayList;


public class ImpMandelbrot implements Mandelbrot{

    public ArrayList<Point> pointsATraiter = new ArrayList<Point>();
    public Fenetre fenetre;
    public Complexe widthComplexe, heightComplexe;
    public float width, height;

    public ImpMandelbrot(Fenetre fen, float w, float h){
        
        this.fenetre = fen;

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

    //Vérification qu'un point donnée appartient à l'ensemble de Mandelbrot
    public boolean traitementPoint(){
        
        if(pointsATraiter.isEmpty()){return false;}

        Complexe z = new Complexe(0, 0);
        Complexe c = convert(pointsATraiter.get(0));
        
        for(int i=0; i<100 ; i++){
            if(z.module() > 2){
                pointsATraiter.remove(0);
                return true;
            }
            z = z.multiply(z);
            z = z.add(c);
        }
        fenetre.getPanelDessin().listePointMandelbrot.add(pointsATraiter.get(0));
        pointsATraiter.remove(0);

        fenetre.getPanelDessin().repaint();
        return true;
    }

    public Complexe convert(Point p){

        float intervalleFenetreWidth = (Math.max(widthComplexe.getA(), heightComplexe.getA()) - Math.min(widthComplexe.getA(), heightComplexe.getA()));
        float intervalleFenetreHeight = (Math.max(widthComplexe.getB(), heightComplexe.getB()) - Math.min(widthComplexe.getB(), heightComplexe.getB()));

        float decalImageX = Math.min(widthComplexe.getA(), heightComplexe.getA());
        float decalImageY = Math.min(widthComplexe.getB(), heightComplexe.getB());

        return new Complexe((float)(p.getX()*(intervalleFenetreWidth/width) + decalImageX), (float)(p.getY()*(intervalleFenetreHeight/height) + decalImageY)); 
    }
}
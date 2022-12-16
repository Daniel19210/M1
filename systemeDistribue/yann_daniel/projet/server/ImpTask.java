import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class ImpTask extends UnicastRemoteObject implements Task{

    public Point point_a_traiter;
    public boolean appartient_mandelbrot;

    public ImpTask(Point p) throws RemoteException{

        point_a_traiter = p;
        appartient_mandelbrot = false;
    }

    public void run() throws RemoteException{

        Complexe z = new Complexe(0, 0);
        Complexe c = convert(point_a_traiter);
        System.out.println("Point en traitement : " + point_a_traiter);
        
        for(int i=0; i<50 ; i++){
            if(z.module() > 2){
                System.out.println("Point traite");
                return;
            }
            z = z.multiply(z);
            z = z.add(c);
        }
        appartient_mandelbrot = true;
        System.out.println("Point traite");
    }

    public Complexe convert(Point p){

        float intervalleFenetreWidth = (Math.max(Constantes.widthComplexe.getA(), Constantes.heightComplexe.getA()) - Math.min(Constantes.widthComplexe.getA(), Constantes.heightComplexe.getA()));
        float intervalleFenetreHeight = (Math.max(Constantes.widthComplexe.getB(), Constantes.heightComplexe.getB()) - Math.min(Constantes.widthComplexe.getB(), Constantes.heightComplexe.getB()));

        float decalImageX = Math.min(Constantes.widthComplexe.getA(), Constantes.heightComplexe.getA());
        float decalImageY = Math.min(Constantes.widthComplexe.getB(), Constantes.heightComplexe.getB());

        return new Complexe((float)(p.getX()*((float)intervalleFenetreWidth/(float)Constantes.width) + decalImageX), (float)(p.getY()*((float)intervalleFenetreHeight/(float)Constantes.height) + decalImageY)); 
    }
}
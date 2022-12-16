import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.awt.Color;

public class ImpTask extends UnicastRemoteObject implements Task{

    public Point point_a_traiter;
    public boolean appartient_mandelbrot;
    public int divergence;

    public ImpTask(Point p) throws RemoteException{
        super();

        point_a_traiter = p;
        appartient_mandelbrot = false;
        divergence = 0;
    }

    public void run() throws RemoteException{
        

        Complexe z = new Complexe(0, 0);
        Complexe c = convert(point_a_traiter);
        //System.out.println("Point en traitement : " + point_a_traiter);
        
        for(int i=0; i<Constantes.limite ; i++){
            if(z.module() > 2){
                divergence = i;
                //System.out.println("Point traite");
                break;
            }
            z = z.multiply(z);
            z = z.add(c);
        }
        appartient_mandelbrot = true;
        if(divergence == 0)
            point_a_traiter.setColor(Color.black);
        else if(divergence > 0 && divergence <= (int) Constantes.limite/5)
            point_a_traiter.setColor(new Color(102, 102, 255));
        else if(divergence > (int) Constantes.limite/5 && divergence <= (int) Constantes.limite/4)
            point_a_traiter.setColor(new Color(0, 0, 255));
        else if(divergence > (int) Constantes.limite/4 && divergence <= (int) Constantes.limite/3)
            point_a_traiter.setColor(new Color(255, 255, 102));
        else if(divergence > (int) Constantes.limite/3 && divergence <= (int) Constantes.limite/2)
            point_a_traiter.setColor(new Color(255, 153, 51));
        else if(divergence > (int) Constantes.limite/2 && divergence <= (int) Constantes.limite/1)
            point_a_traiter.setColor(new Color(255, 0, 0));
        //System.out.println("Point traite");
    }

    public Complexe convert(Point p){

        double intervalleFenetreWidth = (Math.max(Constantes.widthComplexe.getA(), Constantes.heightComplexe.getA()) - Math.min(Constantes.widthComplexe.getA(), Constantes.heightComplexe.getA()));
        double intervalleFenetreHeight = (Math.max(Constantes.widthComplexe.getB(), Constantes.heightComplexe.getB()) - Math.min(Constantes.widthComplexe.getB(), Constantes.heightComplexe.getB()));

        double decalImageX = Math.min(Constantes.widthComplexe.getA(), Constantes.heightComplexe.getA());
        double decalImageY = Math.min(Constantes.widthComplexe.getB(), Constantes.heightComplexe.getB());

        return new Complexe((double)(p.getX()*((double)intervalleFenetreWidth/(double)Constantes.width) + decalImageX), (double)(p.getY()*((double)intervalleFenetreHeight/(double)Constantes.height) + decalImageY)); 
    }

    public boolean getAppartient_mandelbrot() throws RemoteException{
        return this.appartient_mandelbrot;
    }

    public Point getPoint_a_traiter() throws RemoteException{
        return this.point_a_traiter;
    }
}
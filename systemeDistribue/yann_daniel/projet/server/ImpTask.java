import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.awt.Color;

public class ImpTask extends UnicastRemoteObject implements Task{

    public Point point_a_traiter;
    public int divergence;

    public ImpTask(Point p) throws RemoteException{
        super();

        point_a_traiter = p;
        divergence = 0;
    }

    public void run() throws RemoteException{
        
        Complexe z = new Complexe(0, 0);
        Complexe c = convert(point_a_traiter);

        //verification d'appartenance au disque de centre (-1,0)
        double verif1 = Math.pow(c.getA()+1., 2) + Math.pow(c.getB(), 2);
        //Verification d'appartenance à la cardioïde.
        double p = Math.sqrt(Math.pow(c.getA()-(1./4.),2) + Math.pow(c.getB(), 2));
        double verif2 = p - (2 * Math.pow(p, 2)) + (1./4.);

        if(verif1 >= (1./16.) || c.getA() >= verif2){
            for(int n=0; n<Constantes.limite ; n++){
                
                if(z.module() > 2){
                    /*
                     * Le cas où z0 a un module supérieur à 2 fait que le point c a une divergence de 0,
                     * comme les points appartenant à Mandelbrot
                     * Cependant, comme z0 vaut 0+0i le module ne peut pas être supérieur à 2
                     */
                    divergence = n;
                    break; // inutile de calculer la suite des termes, on sait que la suite n'est pas bornée
                }
                z = z.multiply(z);
                z = z.add(c);
            }
        }
        // On attribue une couleur en fonction de la divergence.
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
    }

    public int getDivergence() throws RemoteException{
        return this.divergence;
    }

    public Point getPoint_a_traiter() throws RemoteException{
        return this.point_a_traiter;
    }

    //on converti un point en son équivalent complexe dans l'intervalle donnée
    public Complexe convert(Point p){

        return new Complexe((double)(p.getX()*((double)Constantes.intervalleFenetreWidth/(double)Constantes.width) + Constantes.decalImageX),
            (double)(p.getY()*((double)Constantes.intervalleFenetreHeight/(double)Constantes.height) + Constantes.decalImageY));
    }
}
import java.lang.Math;

public class Complexe{

    private double a, b;

    public Complexe(){

        this.a = 0;
        this.b = 0;
    }

    public Complexe(double newA, double newB){

        this.a = newA;
        this.b = newB;
    }

    public Complexe(Complexe c){
        this.a = c.getA();
        this.b = c.getB();
    }

    public double getA(){return this.a;}
    public double getB(){return this.b;}

    public void setA(double newA){this.a = newA;}
    public void setB(double newB){this.b = newB;}

    public Complexe multiply(Complexe c){
        double newA = this.getA() * c.getA() - this.getB() * c.getB();
        double newB = this.getA() * c.getB() + this.getB() * c.getA();

        return new Complexe(newA, newB);
    }
    
    public Complexe add(Complexe c){
        double newA = this.getA() + c.getA();
        double newB = this.getB() + c.getB();

        return new Complexe(newA, newB);
    }

    public double module(){
        return (double)(Math.sqrt(Math.pow(this.getA(), 2) + Math.pow(this.getB(), 2)));
    }

    @Override
    public String toString(){
        return this.a+"+i"+this.b;
    }
}
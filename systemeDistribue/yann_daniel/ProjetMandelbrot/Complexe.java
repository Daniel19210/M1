import java.lang.Math;

public class Complexe{

    private float a, b;

    public Complexe(){

        this.a = 0;
        this.b = 0;
    }

    public Complexe(float newA, float newB){

        this.a = newA;
        this.b = newB;
    }

    public float getA(){return this.a;}
    public float getB(){return this.b;}

    public void setA(float newA){this.a = newA;}
    public void setB(float newB){this.b = newB;}

    public Complexe multiply(Complexe c){
        float newA = this.getA() * c.getA() - this.getB() * c.getB();
        float newB = this.getA() * c.getB() + this.getB() * c.getA();

        return new Complexe(newA, newB);
    }
    /*public Complexe multiply(float a){
        float newA = this.getA() * a;
        float newB = this.getB() * b;

        return new Complexe(newA, newB);
    }*/
    public Complexe add(Complexe c){
        float newA = this.getA() + c.getA();
        float newB = this.getB() + c.getB();

        return new Complexe(newA, newB);
    }

    public float module(){
        return (float)(Math.sqrt(Math.pow(this.getA(), 2) + Math.pow(this.getB(), 2)));
    }
}
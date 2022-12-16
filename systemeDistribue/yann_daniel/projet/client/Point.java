import java.io.Serializable;;

public class Point implements Serializable{

    private int x,y;

    public Point(){
        this.x = 0;
        this.y = 0;
    }
    public Point(int newX, int newY){
        this.x = newX;
        this.y = newY;
    }

    public int getX(){return this.x;}
    public int getY(){return this.y;}

    public void setX(int newX){this.x = newX;}
    public void setY(int newY){this.y = newY;}

    @Override
    public String toString(){
        return "("+this.x+";"+this.y+")";
    }
}
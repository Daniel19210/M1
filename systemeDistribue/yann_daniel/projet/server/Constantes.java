public class Constantes{
    //Taille de la fenetre où on affiche l'image
    public static final int width = 600;
    public static final int height = 400;

    //intervalle complexe dans lequel on affiche la fractale
    public static Complexe widthComplexe = new Complexe(-2, 1);
    public static Complexe heightComplexe = new Complexe(1, -1);

    //Limite de calcul du module de mandelbrot
    public static final int limite = 100;

    //taille intervalle complexe en x et en y
    public static double intervalleFenetreWidth = (Math.max(widthComplexe.getA(), heightComplexe.getA()) - Math.min(widthComplexe.getA(), heightComplexe.getA()));
    public static double intervalleFenetreHeight = (Math.max(widthComplexe.getB(), heightComplexe.getB()) - Math.min(widthComplexe.getB(), heightComplexe.getB()));

    //decalage de l'image a gauche et en bas
    public static double decalImageX = Math.min(widthComplexe.getA(), heightComplexe.getA());
    public static double decalImageY = Math.min(widthComplexe.getB(), heightComplexe.getB());

    public static void calculCoordPlan(){
        intervalleFenetreWidth = (Math.max(widthComplexe.getA(), heightComplexe.getA()) - Math.min(widthComplexe.getA(), heightComplexe.getA()));
        intervalleFenetreHeight = (Math.max(widthComplexe.getB(), heightComplexe.getB()) - Math.min(widthComplexe.getB(), heightComplexe.getB()));

        decalImageX = Math.min(widthComplexe.getA(), heightComplexe.getA());
        decalImageY = Math.min(widthComplexe.getB(), heightComplexe.getB());
    }
}
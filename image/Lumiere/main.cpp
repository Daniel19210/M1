#include "sphere.hpp"
#include <iostream>

int main(){
    Rayon r = Rayon(Point(0, 0, 10), Vect(0, 0, -1));
    Sphere s = Sphere(Point(0, 0, 0), 2);
    Point p = s.intersect(r);
    
    std::cout << "x: " << p.getX() << "\ty: " << p.getY() << "\tz: " << p.getZ() << std::endl;

    return 0;
}
#include "sphere.hpp"
#include <cmath>

Sphere::Sphere(Point c, float r){
    this->centre = c;
    this->rayon = r > 0 ? r : 0;
}
Sphere::~Sphere(){}

Point Sphere::getCentre(){
    return this->centre;
}

void Sphere::setCentre(Point c){
    this->centre = c;
}

float Sphere::getRayon(){
    return this->rayon;
}

void Sphere::setRayon(float r){
    this->rayon = r;
}

bool Sphere::appartient(Point c){
    return rayon > sqrt(pow(this->getCentre().getX() - c.getX(), 2) + pow(this->getCentre().getY() - c.getY(), 2) + pow(this->getCentre().getZ() - c.getZ(), 2));
}

Point Sphere::intersect(Rayon r){
    float a = pow(r.getDirecteur().getX(), 2) + pow(r.getDirecteur().getY(), 2) + pow(r.getDirecteur().getZ(), 2);
    float b = r.getOrigine().getX() * r.getDirecteur().getX() + r.getOrigine().getY() * r.getDirecteur().getY() + r.getOrigine().getZ() * r.getDirecteur().getZ();
    float c = pow(r.getOrigine().getX(), 2) + pow(r.getOrigine().getY(), 2) + pow(r.getOrigine().getZ(), 2) - pow(this->getRayon(), 2);
    float delta = pow(b, 2) - (4 * a * c);
    if (delta >= 0){ // Plusieurs solution
        float racine1 = ( -b - sqrt(delta)) / (2 * a);
        float racine2 = ( -b - sqrt(delta)) / (2 * a);
        return r.pointVect( racine1 < racine2 ? racine1 : racine2 );
    }
    return Point(INFINITY, INFINITY, INFINITY);
}
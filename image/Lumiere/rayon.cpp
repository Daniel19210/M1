
#include "rayon.hpp"

Rayon::Rayon(Point o, Vec v){
    this->origine = o;
    this->directeur = v;
}

Point Rayon::pointVec(float t){
    return Point(this->origine.x + t * directeur[0], this->origine.y + t * directeur[1], this->origine.z + t * directeur[2]);
}

Rayon::~Rayon(){}
#include "rayon.hpp"

Rayon::Rayon(Point o, Vect v){
    this->origine = o;
    this->directeur = v;
}

Point Rayon::getOrigine(){
	return this->origine;
}

Vect Rayon::getDirecteur(){
	return this->directeur;
}

void Rayon::setOrigine(Point o){
	this->origine = o;
}

void Rayon::setDirecteur(Vect v){
	this->directeur = v;
}

Point Rayon::pointVect(float t){
    return this->getOrigine() + (this->getDirecteur() * t);
}

Rayon::~Rayon(){}
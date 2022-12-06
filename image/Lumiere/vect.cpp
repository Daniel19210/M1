#include "vect.hpp"

Vect::Vect(){
    this->x = 0;
    this->y = 0;
    this->z = 0;
}

Vect::Vect(float a, float b, float c){
    this->x = a;
    this->y = b;
    this->z = c;
}

void Vect::set(float a, float b, float c){
    this->x = a;
    this->y = b;
    this->z = c;
}

float Vect::getX(){
    return this->x;
}
float Vect::getY(){
	return this->y;
}

float Vect::getZ(){
	return this->z;
}

Vect::~Vect(){}

Vect Vect::operator*(const float t){
    return Vect(t*this->getX(), t*this->getY(), t*this->getZ());
}
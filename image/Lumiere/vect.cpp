#include "vect.hpp"
#include <cmath>

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

float Vect::norm(){
    return sqrt(pow(this->getX(), 2) + pow(this->getY(), 2) + pow(this->getZ(), 2));
}

Vect Vect::normalisation(){
    float norm = this->norm();
    return Vect(this->getX()/norm, this->getY()/norm, this->getZ()/norm);
}

Vect Vect::produitVectoriel(Vect v){
    float X = this->getY()*v.getZ() - this->getZ()*v.getY();
    float Y = this->getZ()*v.getX() - this->getX()*v.getZ();
    float Z = this->getX()*v.getY() - this->getY()*v.getX();

    return Vect(X, Y, Z);
}

float Vect::produitScalaire(Vect v){
    return this->getX() * v.getX() + this->getY() * v.getY() + this->getZ() * v.getZ();
}

Vect::~Vect(){}

Vect Vect::operator*(const float t){
    return Vect(t*this->getX(), t*this->getY(), t*this->getZ());
}

Vect Vect::operator+(Vect v){
    return Vect(this->getX()+v.getX(), this->getY()+v.getY(), this->getZ()+v.getZ());
}

Vect Vect::operator-(Vect v){
    return Vect(this->getX()-v.getX(), this->getY()-v.getY(), this->getZ()-v.getZ());
}
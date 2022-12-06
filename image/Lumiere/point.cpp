#include "point.hpp"

Point::Point(){
    this->x = 0;
    this->y = 0;
    this->z = 0;
}

Point::Point(float a, float b, float c){
    this->x = a;
    this->y = b;
    this->z = c;
}

void Point::set(float a, float b, float c){
    this->x = a;
    this->y = b;
    this->z = c;
}

float Point::getX(){
    return this->x;
}
float Point::getY(){
	return this->y;
}

float Point::getZ(){
	return this->z;
}

Point::~Point(){}

Point Point::operator+(Vect v){
    return Point(this->getX() + v.getX(), this->getY() + v.getY(), this->getZ() + v.getZ());
}
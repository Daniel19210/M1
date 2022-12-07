#include "point.hpp"

Point::Point(){
    this->x = 0;
    this->y = 0;
    this->z = 0;
}

Point::~Point(){}

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

bool Point::operator==(Point p){   
    return p.getX() == this->getX() && p.getY() == this->getY() && p.getZ() == this->getZ();
}

Point Point::operator+(Vect v){
    return Point(this->getX() + v.getX(), this->getY() + v.getY(), this->getZ() + v.getZ());
}

std::ostream& operator<<(std::ostream& os, Point p){
    return os << "x: " << p.getX() << "\ty: " << p.getY() << "\tz: " << p.getZ();
}
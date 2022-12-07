#ifndef POINT_HPP
#define POINT_HPP

#include "vect.hpp"
#include <iostream>

class Point{
    private:
        float x,  y,  z;

    public:
        Point();
        Point(float, float, float);
        ~Point();
        void set(float, float, float);
        float getX();
        float getY();
        float getZ();

        Point operator+(Vect);
        bool operator==(Point);
        friend std::ostream& operator <<(std::ostream&, Point);
};

#endif
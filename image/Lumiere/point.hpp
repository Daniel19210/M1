#ifndef POINT_HPP
#define POINT_HPP

#include "vect.hpp"

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
};

#endif
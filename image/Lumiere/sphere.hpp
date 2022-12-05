#ifndef SPHERE_HPP
#define SPHERE_HPP

#include "point.hpp"

class Sphere{
    private:
        Point centre;
        float rayon = 0;

    public:
        Sphere(Point c, float r);
        ~Sphere();
        Point getCentre();
        void setCentre(Point);
        float getRayon();
        void setRayon(float);
        bool appartient(Point);
};

#endif
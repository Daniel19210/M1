#ifndef SPHERE_HPP
#define SPHERE_HPP

#include "point.hpp"
#include "vect.hpp"
#include "rayon.hpp"

class Sphere{
    private:
        Point centre;
        float rayon;

    public:
        Sphere(Point, float);
        ~Sphere();
        Point getCentre();
        void setCentre(Point);
        float getRayon();
        void setRayon(float);
        bool appartient(Point);
        Point intersect(Rayon);
};

#endif
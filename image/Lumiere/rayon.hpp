#ifndef RAYON_HPP
#define RAYON_HPP

#include "point.hpp"
#include "vect.hpp"

class Rayon{
    private:
        Point origine;
        Vect directeur;
    public:
        Rayon(Point, Vect);
        ~Rayon();
        Point getOrigine();
        void setOrigine(Point);
        Vect getDirecteur();
        void setDirecteur(Vect);
        Point pointVect(float);
};
#endif
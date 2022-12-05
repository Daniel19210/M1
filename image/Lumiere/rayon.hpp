#ifndef RAYON_HPP
#define RAYON_HPP
#include "point.hpp"

class Rayon{
    private:
        Point origine;
        Vec directeur;
    public:
        Rayon(Point, Vec);
        ~Rayon();
        Point getOrigine();
        void setOrigine(Point);
        Vec getDirecteur();
        void setDirecteur(Vec);
        Point pointVec(float);
};
#endif
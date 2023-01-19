#ifndef VECT_HPP
#define VECT_HPP

class Vect{

    private:
        float x, y, z;

    public:
        Vect();
        Vect(float, float, float);
        ~Vect();

        void set(float, float, float);
        float getX();
        float getY();
        float getZ();

        float norm();
        Vect normalisation();
        Vect produitVectoriel(Vect);
        float produitScalaire(Vect);

        Vect operator*(const float);
        Vect operator+(Vect);
        Vect operator-(Vect);
};

#endif
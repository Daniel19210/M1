#ifndef POINT_HPP
#define POINT_HPP
struct Vec{
    float x, y, z;
};

// test

struct Point{
    float x,  y,  z,  r,  g,  b;
    Point(float a=0, float b=0, float c=0, float d=0, float e=0, float f=0){set(a, b, c, d, e, f);}
	void set(float a, float b, float c, float d, float e, float f) {x=a;y=b;z=c;r=d;g=e;b=f;}
};

#endif
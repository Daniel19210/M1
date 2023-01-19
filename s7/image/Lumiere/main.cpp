#include "sphere.hpp"
#include <iostream>
#include <cmath>
#include <vector>
#include <GL/glut.h>

#define _USE_MATH_DEFINES

float cameraAngleX, cameraAngleY;
float cameraDistance =0;

std::vector<Point> lancerRayon(Sphere s, Sphere sObj)
{
    float theta, phi, pasTheta, pasPhi, x, y, z, r;
    pasTheta = M_PI / 16;
    pasPhi = M_PI / 16;
    r = s.getRayon();
    std::vector<Point> res = {};

    for (theta = 0; theta <= M_PI; theta += pasTheta)
    {
        for (phi = -M_PI / 2; phi <= M_PI / 2; phi += pasPhi)
        {
            x = r * sin(theta) * cos(phi);
            y = r * sin(theta) * sin(phi);
            z = r * cos(theta);
            Point p = sObj.intersect(Rayon(s.getCentre(), Vect(x - s.getCentre().getX(), y - s.getCentre().getY(), z - s.getCentre().getZ()))); 
            if (!(p == Point(INFINITY, INFINITY, INFINITY))){
                res.push_back(p);
            }
        }
    }
    return res;
    // return Point(x, y, z);
}

void affichPoints(std::vector<Point> v){
    for (auto it : v){
        glBegin(GL_POINTS);
            glColor3f(1., 0., 0.);
            glVertex3f(it.getX(), it.getY(), it.getZ());
        glEnd();
    }
}

void initOpenGL(int argc, char** argv){
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGB);
    glutInitWindowPosition(0, 0);
    glutInitWindowSize(600, 600);
    glutCreateWindow("lancerRayon");

    glClearColor(0., 0., 0., 0.);
    glColor3f(1., 1., 1.);
    glPointSize(7.0);

    glEnable(GL_COLOR_MATERIAL);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(45.0f,(GLfloat)200/(GLfloat)200, 0.1f, 100.0f);
        glMatrixMode(GL_MODELVIEW);
    gluLookAt(0., 0., 10., 0., 0., 0., 0., 1., 0.);
}

void affichageGL(){
    glMatrixMode(GL_MODELVIEW);
    glClear(GL_COLOR_BUFFER_BIT);
    glPushMatrix();
    glTranslatef(0., 0., cameraDistance);
    glRotatef(cameraAngleX, 1., 0., 0.);
    glRotatef(cameraAngleY, 0., 1., 0.);
    glPopMatrix();
    glFlush();
}

int main(int argc, char **argv)
{
    initOpenGL(argc, argv);

    affichageGL();

    Rayon rPrincipal = Rayon(Point(0, 0, 10), Vect(0, 0, -1));
    Sphere s1 = Sphere(Point(0, 0, 0), 2);
    Point s1rPrincipal = s1.intersect(rPrincipal);

    Sphere sLumière = Sphere(Point(0, 0, 10), 1);

    std::vector<Point> rayons1 = lancerRayon(sLumière, s1);
    affichPoints(rayons1);

    glutMainLoop();
    return 0;
}
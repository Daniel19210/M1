#include "halfEdge.h"
#include <GL/glut.h>
#include <iostream>
// #include "../armadillo/include/armadillo"


//using namespace arma;
using namespace std;

//=========================================
HalfEdge::HalfEdge(void)
{


}
HalfEdge::HalfEdge(Vertex* InitVertex, string initName)
{
    this->vertex = InitVertex ;
    this->name = initName ;
}
//------------------------------------------
HalfEdge::~HalfEdge(void)
{
}

string HalfEdge::toString(){
    return string("Vertex :") + to_string(vertex->x) + ", " + to_string(vertex->y) + ", " + to_string(vertex->z) + "\tnom: " + name;
}


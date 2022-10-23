#ifndef __HALFEGDE
#define __HALFEGDE

#include "vertex.h"
#include "face.h"
#include <string>
//#include "./armadillo/include/armadillo"

//#include <GL/glut.h>

using namespace std ;
class Vertex ; 
class Face ; 
class Vertex ; 

class HalfEdge 
{
public:
Vertex* vertex ;
HalfEdge* heNext ;
HalfEdge* hePrev ;
HalfEdge* heTwin ;
Face* face ;
string name ;
HalfEdge(void);
HalfEdge(Vertex* InitVertex, string initName);
string toString();
~HalfEdge(void);

};


#endif

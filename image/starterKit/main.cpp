
#include <iostream>
#include <stdlib.h>
#include <GL/glut.h>
#include "halfEdge.h"
#include "vertex.h"
#include "face.h"
#include "mesh.h"
#include <vector>
#include <sstream>
#include"objfile.h"
#include<string>

using namespace std ;
void affichage(void);

void clavier(unsigned char touche,int x,int y);
void affiche_repere(void);

void mouse(int, int, int, int);
void mouseMotion(int, int);
//void reshape(int,int);


// variables globales pour OpenGL
bool mouseLeftDown;
bool mouseRightDown;
bool mouseMiddleDown;
float mouseX, mouseY;
float cameraAngleX;
float cameraAngleY;
float cameraDistance=0.;


#define NBFACES 6
#define NBVERTICES 7
#define NBHALFEDGES 24
Mesh* ExMesh ;




//----------------------------------------------------------------------------------
void initMesh()
//----------------------------------------------------------------------------------
{
    int tabHe[NBHALFEDGES][5]={  // sommet, he, face, next, prev pour chaque demi-arete
        { 1,18, 0, 1, 2},
        { 3,11, 0, 2, 0},
        { 4,3 , 0, 0, 1},
        { 1, 2, 1, 4, 5},
        { 4, 6, 1, 5, 3},
        { 2,19, 1, 3, 4},
        { 2, 4, 2, 7, 8},
        { 4,17, 2, 8, 6},
        { 5,20, 2, 6, 7},
        { 3,21, 3,10,11},
        { 6,12, 3,11, 9},
        { 4, 1, 3, 9,10},
        { 4,10, 4,13,14},
        { 6,22, 4,14,12},
        { 7,15, 4,12,13},
        { 4,14, 5,16,17},
        { 7,23, 5,17,15},
        { 5, 7, 5,15,16},
        { 3, 0,-1,19,21},
        { 1, 5,-1,20,18},
        { 2, 8,-1,23,19},
        { 6, 9,-1,18,22},
        { 7,13,-1,21,23},
        { 5,16,-1,22,20}   };
    int tabFace[NBFACES] ={0,3,6,9,12,15}; // he pour chaque face
    int tabVertex[NBVERTICES][4] ={          // x,y,z, he pour chaque sommet
                            {1,4,0,0},
                            {3,4,0,5},
                            {0,2,0,1},
                            {2,2,0,2},
                            {4,2,0,8},
                            {1,0,0,10},
                            {3,0,0,14}};

   ExMesh = new Mesh() ;
    //***********************************************
    // AFAIRE
    // ici construire le maillage haldEdge "ExMesh" à partir des tableaux d'incides tabHe, tabFace, tabVertex
    vector<Vertex> vertex = {};
    vector<HalfEdge> he = {};
    vector<Face> faces = {};
    string nomVertex = "v";
    for (int i = 0; i < NBVERTICES; i++){
      nomVertex.append(std::to_string(i+1));
      vertex.push_back(Vertex(tabVertex[i][0], tabVertex[i][1], tabVertex[i][2], nomVertex));
    }
    for (int i = 0; i < NBHALFEDGES; i++){
      HalfEdge tmp = HalfEdge(&vertex[tabHe[i][0]], std::to_string(i));
      tmp.heTwin = tabHe[i][1];
      tmp.face = tabHe[i][2];
      tmp.heNext = tabHe[i][3];
      tmp.hePrev = tabHe[i][4];
      he.push_back = tmp;
    }
    for (int i = 0; i < NBHALFEDGES; i++){
      faces.push_back(Face(&he[tabFace[i]], std::to_string(i)));
    }
    ExMesh->faces = faces;
    ExMesh->hedges = he;
    ExMesh->vertices = vertex;
    //***********************************************
}



//----------------------------------------------------------------------------------
void initOpenGl()
//----------------------------------------------------------------------------------
{
initMesh();

//lumiere 

	glClearColor( .5, .5, 0.5, 0.0 );
 
	glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    GLfloat l_pos[] = { 3.,3.5,3.0,1.0 };
    glLightfv(GL_LIGHT0,GL_POSITION,l_pos);

     glLightfv(GL_LIGHT0,GL_DIFFUSE,l_pos);
     glLightfv(GL_LIGHT0,GL_SPECULAR,l_pos);
 
     // glDepthFunc(GL_LESS);
     // glEnable(GL_DEPTH_TEST);
     glEnable(GL_COLOR_MATERIAL);

     glMatrixMode(GL_PROJECTION);
     glLoadIdentity();
     gluPerspective(45.0f,(GLfloat)200/(GLfloat)200,0.1f,100.0f);
	glMatrixMode(GL_MODELVIEW);
	//glLoadIdentity();	
//	glScalef(.7,.7,.7);
    gluLookAt(0.,0.,4., 0.,0.,0., 0.,1.,0.);
  //  glTranslatef(0.0,0.0,-5.0);
}

//------------------------------------------------------
void displayHalfEdge(void)
//----------------------------------------------------------------------------------
{
    //**********************************************************************
    // AFAIRE
    // Écrire la visualisation du maillage "ExMesh
    for (Faces face : ExMesh->faces){
      glBegin(GL_LINES);
        glColor3ub(255, 255, 0);
        glVertex3d(face.oneHe.hePrev.vertex->x, face.oneHe.hePrev.vertex->y, face.oneHe.hePrev.vertex->z);
        glVertex3d(face.oneHe.vertex->x, face.oneHe.vertex->y, face.oneHe.vertex->z);
        glVertex3d(face.oneHe.vertex->x, face.oneHe.vertex->y, face.oneHe.vertex->z);
        glVertex3d(face.oneHe.heNext.vertex->x, face.oneHe.heNext.vertex->y, face.oneHe.heNext.vertex->z);
        glVertex3d(face.oneHe.heNext.vertex->x, face.oneHe.heNext.vertex->y, face.oneHe.heNext.vertex->z);
        glVertex3d(face.oneHe.hePrev.vertex->x, face.oneHe.hePrev.vertex->y, face.oneHe.hePrev.vertex->z);
      glEnd();
    }
    //**********************************************************************

}
int main(int argc,char **argv)
{
  /* initialisation de glut et creation
     de la fenetre */
  glutInit(&argc,argv);
  glutInitDisplayMode(GLUT_RGB);
  glutInitWindowPosition(200,200);
  glutInitWindowSize(600,600);
  glutCreateWindow("ifs");

  /* Initialisation d'OpenGL */
  glClearColor(0.0,0.0,0.0,0.0);
  glColor3f(1.0,1.0,1.0);
  glPointSize(1.0);
	
  /* enregistrement des fonctions de rappel */
  glutDisplayFunc(affichage);
  glutKeyboardFunc(clavier);
  glutMouseFunc(mouse);
  glutMotionFunc(mouseMotion);

initOpenGl() ;

/* Entree dans la boucle principale glut */
  glutMainLoop();
  return 0;
}
//------------------------------------------------------
void affiche_repere(void)
{
  glBegin(GL_LINES);
  glColor3f(1.0,0.0,0.0);
  glVertex2f(0.,0.);
  glVertex2f(1.,0.);
  glEnd(); 

	 glBegin(GL_LINES);
  glColor3f(0.0,1.0,0.0);
  glVertex2f(0.,0.);
  glVertex2f(0.,1.);
  glEnd(); 
   glBegin(GL_LINES);
  glColor3f(0.0,0.0,1.0);
  glVertex3f(0.,0.,0.);
  glVertex3f(0.,0.,1.);
  glEnd(); 
}

//-----------------------------------------------------



//------------------------------------------------------
void affichage(void)
{
	glMatrixMode(GL_MODELVIEW);
  /* effacement de l'image avec la couleur de fond */
	glClear(GL_COLOR_BUFFER_BIT);
	glPushMatrix();
	glTranslatef(0,0,cameraDistance);
    glRotatef(cameraAngleX,1.,0.,0.)	;
    glRotatef(cameraAngleY,0.,1.,0.);
    //--------------------------------
    affiche_repere();
    //--------------------------------
    displayHalfEdge();
    //--------------------------------

    glPopMatrix();
  /* on force l'affichage du resultat */
  glFlush();
}

//------------------------------------------------------


//------------------------------------------------------
void clavier(unsigned char touche,int x,int y)
{

  switch (touche)
    {
    case '+':
      glutPostRedisplay();
      break;
    case '-':
      glutPostRedisplay();
      break;
    case 'f': //* affichage en mode fil de fer 
      glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);
      glutPostRedisplay();
      break;
      case 'p': //* affichage du carre plein 
      glPolygonMode(GL_FRONT_AND_BACK,GL_FILL);
      glutPostRedisplay();
      break;
  case 's' : //* Affichage en mode sommets seuls 
      glPolygonMode(GL_FRONT_AND_BACK,GL_POINT);
      glutPostRedisplay();
      break;
    case 'q' : //*la touche 'q' permet de quitter le programme 
      exit(0);
    }
    
}
void mouse(int button, int state, int x, int y)
{
    mouseX = x;
    mouseY = y;

    if(button == GLUT_LEFT_BUTTON)
    {
        if(state == GLUT_DOWN)
        {
            mouseLeftDown = true;
        }
        else if(state == GLUT_UP)
            mouseLeftDown = false;
    }

    else if(button == GLUT_RIGHT_BUTTON)
    {
        if(state == GLUT_DOWN)
        {
            mouseRightDown = true;
        }
        else if(state == GLUT_UP)
            mouseRightDown = false;
    }

    else if(button == GLUT_MIDDLE_BUTTON)
    {
        if(state == GLUT_DOWN)
        {
            mouseMiddleDown = true;
        }
        else if(state == GLUT_UP)
            mouseMiddleDown = false;
    }
}


void mouseMotion(int x, int y)
{
    if(mouseLeftDown)
    {
        cameraAngleY += (x - mouseX);
        cameraAngleX += (y - mouseY);
        mouseX = x;
        mouseY = y;
    }
    if(mouseRightDown)
    {
        cameraDistance += (y - mouseY) * 0.2f;
        mouseY = y;
    }

    glutPostRedisplay();
}

    
    


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
        { 1,18, 0, 1, 2},//e0
        { 3,11, 0, 2, 0},//e1
        { 4,3 , 0, 0, 1},//e2
        { 1, 2, 1, 4, 5},//e3
        { 4, 6, 1, 5, 3},//e4
        { 2,19, 1, 3, 4},//e5
        { 2, 4, 2, 7, 8},//e6
        { 4,17, 2, 8, 6},//e7
        { 5,20, 2, 6, 7},//e8
        { 3,21, 3,10,11},//e9
        { 6,12, 3,11, 9},//e10
        { 4, 1, 3, 9,10},//e11
        { 4,10, 4,13,14},//e12
        { 6,22, 4,14,12},//e13
        { 7,15, 4,12,13},//e14
        { 4,14, 5,16,17},//e15
        { 7,23, 5,17,15},//e16
        { 5, 7, 5,15,16},//e17
        { 3, 0,-1,19,21},//e18
        { 1, 5,-1,20,18},//e19
        { 2, 8,-1,23,19},//e20
        { 6, 9,-1,18,22},//e21
        { 7,13,-1,21,23},//e22
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
    for(int i=0; i<NBVERTICES; i++){

      ExMesh->vertices.push_back(Vertex(tabVertex[i][0],tabVertex[i][1],tabVertex[i][2], "v"+to_string(i+1)));
    }

    for(int i=0; i<NBHALFEDGES; i++){

      ExMesh->hedges.push_back(HalfEdge(&(ExMesh->vertices[tabHe[i][0]-1]), "e"+to_string(i)));
    }

    for(int i=0; i<NBFACES; i++){

      ExMesh->faces.push_back(Face(&(ExMesh->hedges[tabFace[i]]), "f"+to_string(i)));
    }
    
    for(int i=0; i<NBHALFEDGES; i++){

      ExMesh->hedges[i].face = &(ExMesh->faces[tabHe[i][2]]);
      ExMesh->hedges[i].heNext = &(ExMesh->hedges[tabHe[i][3]]);
      ExMesh->hedges[i].hePrev = &(ExMesh->hedges[tabHe[i][4]]);
      ExMesh->hedges[i].heTwin = &(ExMesh->hedges[tabHe[i][1]]);
    }

    for(int i=0; i<NBVERTICES; i++){

      ExMesh->vertices[i].oneHe = &(ExMesh->hedges[tabVertex[i][3]]);
    }

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
    glTranslatef(-2.0,-2.0,-5.0);
}

//------------------------------------------------------
void displayHalfEdge(void)
//----------------------------------------------------------------------------------
{
    //**********************************************************************
    // AFAIRE
    // Écrire la visualisation du maillage "ExMesh
    for(int i=0; i<NBFACES; i++){

      glBegin(GL_LINE_LOOP);

        glVertex3d(ExMesh->hedges[i*3].vertex->x, ExMesh->hedges[i*3].vertex->y, ExMesh->hedges[i*3].vertex->z);
        glVertex3d(ExMesh->hedges[i*3 + 1].vertex->x, ExMesh->hedges[i*3 + 1].vertex->y, ExMesh->hedges[i*3 + 1].vertex->z);
        glVertex3d(ExMesh->hedges[i*3 + 2].vertex->x, ExMesh->hedges[i*3 + 2].vertex->y, ExMesh->hedges[i*3 + 2].vertex->z);
      glEnd();
    }

    for(int i=0; i<NBFACES; i++){

      glBegin(GL_LINES);
        glColor3f(1.0,0.,0.);
        glVertex3d(ExMesh->hedges[NBHALFEDGES-1-i].vertex->x, ExMesh->hedges[NBHALFEDGES-1-i].vertex->y, ExMesh->hedges[NBHALFEDGES-1-i].vertex->z);
        glVertex3d(ExMesh->hedges[NBHALFEDGES-1-i].heNext->vertex->x, ExMesh->hedges[NBHALFEDGES-1-i].heNext->vertex->y, ExMesh->hedges[NBHALFEDGES-1-i].heNext->vertex->z);
      glEnd();
    }
    //**********************************************************************

}

/***********VALENCE**************/
void calculValence(){

  for(int i=0; i<NBVERTICES; i++){
    Vertex v = ExMesh->vertices[i];
    HalfEdge* init = v.oneHe;
    HalfEdge* next = init->heTwin->heNext;
    int valence = 1;

    do{

      valence++;
      next = next->heTwin->heNext;

    }while(next != init);

    cout << "valence de " << v.name << ": " << valence << endl;
  }
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
  calculValence();
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

    
    

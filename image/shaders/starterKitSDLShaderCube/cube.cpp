#include <GL/glew.h>
#ifdef __cplusplus
    #include <cstdlib>
#else
    #include <stdlib.h>
#endif
#include <iostream>
#include <SDL/SDL.h>

#include <vector>
#include "shader.hpp"

//************************************************

typedef struct {
        //coordonnées x, y et z du sommet
        GLfloat x;
        GLfloat y;
        GLfloat z;
} Sommet ;
//vector pour stocker les sommets du cube et leur couleur
std::vector<Sommet> Cube ={
//AFAIRE 2 définir un cube entre (-.5,-.5,-.5) et (.5, .5 ,.5)
    {-0.5, -0.5, 0.5},
    {0.5, -0.5, 0.5},
    {0.5, 0.5, 0.5},
    {-0.5, 0.5, 0.5},
    {0.5, -0.5, -0.5},
    {0.5, 0.5, -0.5},
    {-0.5, 0.5, -0.5},
    {-0.5, -0.5, -0.5},
};

//Tableau pour stocker les indices des sommets par face pour le cube
std::vector<GLuint> indexFaceCube={
    //AFAIRE 3 définir les 6 faces quadrangulaires
    0, 1, 2,
    0, 2, 3,
    1, 4, 5,
    1, 5, 2,
    4, 6, 5,
    4, 7, 6,
    0, 3, 7,
    3, 6, 7,
    0, 4, 1,
    0, 7, 4,
    2, 5, 3,
    3, 5, 6,
};

// initialise à 0 = pas d’indice
GLuint vbo=0 ;
GLuint ibo = 0;
GLuint vao = 0;
GLuint IdProgram = 0;
GLuint VShader = 0;
GLuint FShader = 0;

void genererVBOVAO(void)
{
    //AFAIRE 4
    // VBO
    glGenBuffers(1, &vbo);
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    glBufferData(GL_ARRAY_BUFFER, Cube.size()*3*sizeof(GLuint), &Cube[0], GL_STATIC_DRAW);
    glBindBuffer(GL_ARRAY_BUFFER, 0);

    // IBO
    glGenBuffers(1, &ibo);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ibo);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indexFaceCube), indexFaceCube, GL_STATIC_DRAW);
    glBindBuffer(GL_ARRAY_BUFFER, 0);

    // VAO
    glGenVertexArrays(1, &vao);
    glBindVertexArray(vao);
        glBindBuffer(GL_ARRAY_BUFFER, vbo);
        glEnableVertexAttribArray(0);
        glVertexAttribPointer(0, 3, GL_INT, GL_FALSE, 0, nullptr);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ibo);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);
}

void prepareProgammeShader(void)
{
// vous avez de la chance ce n'est pas AFAIRE 6
     IdProgram = LoadShaders( "shader.vert", "shader.frag");
}

void dessinerCube(void)
{
    glUseProgram(IdProgram);
    glBindVertexArray(vao);
    glDrawElements(GL_TRIANGLES, sizeof(indexFaceCube), GL_UNSIGNED_INT, 0);
    glBindVertexArray(0);
}

char presse;
int anglex,angley,x,y,xold,yold;

/* Prototype des fonctions */
void affichage();
void clavier(unsigned char touche,int x,int y);
void reshape(int x,int y);
void idle();
void mouse(int bouton,int etat,int x,int y);
void mousemotion(int x,int y);
//********************************************

 SDL_Surface* screen ;
//********************************************
int main ( int argc, char** argv )
{
    // initialize SDL video
    if ( SDL_Init( SDL_INIT_VIDEO ) < 0 )
    {
        printf( "Unable to init SDL: %s\n", SDL_GetError() );
        return 1;
    }

    // make sure SDL cleans up before exit
    atexit(SDL_Quit);

    // create a new window
    screen = SDL_SetVideoMode(500, 500, 16,SDL_OPENGL |SDL_DOUBLEBUF);
    if ( !screen )
    {
        printf("Unable to set 640x480 video: %s\n", SDL_GetError());
        return 1;
    }

    
    glEnable(GL_DEPTH_TEST);



     // ATTENTION ne pas oublier l'initialisation de GLEW
     GLenum err = glewInit() ;

     //info version oenGL / GLSL :
     // AFAIRE 1 : récupérer les infos sur la cater version d'openGL/GLSL


     prepareProgammeShader();
     genererVBOVAO();

    // program main loop
    bool done = false;
    while (!done)
    {
        // message processing loop
        SDL_Event event;
        while (SDL_PollEvent(&event))
        {
            // check for messages
            switch (event.type)
            {
                // exit if the window is closed
            case SDL_QUIT:
                done = true;
                break;

                // check for keypresses
            case SDL_KEYDOWN:

                    // exit if ESCAPE is pressed
                    if (event.key.keysym.sym == SDLK_ESCAPE)
                        done = true;
                    break;
                // check for keypresses
            case SDL_MOUSEBUTTONDOWN:
                        mouse(event.button.button,SDL_MOUSEBUTTONDOWN, event.button.x,event.button.y) ;
                    break;
            case SDL_MOUSEBUTTONUP:
                        mouse(event.button.button,SDL_MOUSEBUTTONUP, event.button.x,event.button.y) ;
                    break;
            case SDL_MOUSEMOTION:
                         mousemotion(event.button.x,event.button.y) ;
                    break;

            } // end switch
        } // end of message processing

        // DRAWING STARTS HERE
         affichage();
    } // end main loop


    // all is well ;)
    printf("Exited cleanly\n");
    std::cout << "Version OpenGL : " << glGetString(GL_VERSION) << std::endl;
    return 0;
}


void affichage()
{
  int i,j;
  /* effacement de l'image avec la couleur de fond */
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

   // Dessin du cube
    dessinerCube() ;

    //Repère (fait à l'ancienne
    //axe x en rouge
    glBegin(GL_LINES);
        glColor3f(1.0,0.0,0.0);
        glVertex3f(0, 0,0.0);
        glVertex3f(1, 0,0.0);
    glEnd();
    //axe des y en vert
    glBegin(GL_LINES);
        glColor3f(0.0,1.0,0.0);
        glVertex3f(0, 0,0.0);
        glVertex3f(0, 1,0.0);
    glEnd();
    //axe des z en bleu
    glBegin(GL_LINES);
        glColor3f(0.0,0.0,1.0);
        glVertex3f(0, 0,0.0);
        glVertex3f(0, 0,1.0);
    glEnd();


  //On echange les buffers
    SDL_GL_SwapBuffers( );
}

void clavier(unsigned char touche,int x,int y)
{
  switch (touche)
    {
    case 'd':
      glEnable(GL_DEPTH_TEST);
      break;
    case 'D':
      glDisable(GL_DEPTH_TEST);
      break;
    case 'q' : /*la touche 'q' permet de quitter le programme */
      exit(0);
    }
}

void reshape(int x,int y)
{
  if (x<y)
    glViewport(0,(y-x)/2,x,x);
  else
    glViewport((x-y)/2,0,y,y);
}

void mouse(int button, int state,int x,int y)
{


    /* si on appuie sur le bouton gauche */
    if (button == SDL_BUTTON_LEFT && state == SDL_MOUSEBUTTONDOWN)
  {
    presse = 1; /* le booleen presse passe a 1 (vrai) */
    xold = x; /* on sauvegarde la position de la souris */
    yold=y;
  }
  /* si on relache le bouton gauche */
  if (button == SDL_BUTTON_LEFT  && state == SDL_MOUSEBUTTONUP)
 {   presse=0; /* le booleen presse passe a 0 (faux) */
}
}

void mousemotion(int x,int y)
  {
    if (presse) /* si le bouton gauche est presse */
    {
      /* on modifie les angles de rotation de l'objet
         en fonction de la position actuelle de la souris et de la derniere
         position sauvegardee */
      anglex=anglex+(x-xold);
      angley=angley+(y-yold);
//      glutPostRedisplay(); /* on demande un rafraichissement de l'affichage */
    }

    xold=x; /* sauvegarde des valeurs courante de le position de la souris */
    yold=y;
  }

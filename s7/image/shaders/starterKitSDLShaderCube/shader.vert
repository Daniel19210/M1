#version 430


layout(location = 0) in vec3 position; // le location permet de dire de quel flux/canal on récupère la données
layout(location = 1) in vec3 color;
out vec3 pos;
out vec3 col;
uniform mat4 MVP;

void main(){
        pos = position;
        col = color;
        gl_Position = MVP * vec4(pos,1);
}



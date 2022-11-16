#version 430


layout(location = 0) in vec3 position; // le location permet de dire de quel flux/canal on récupère la données
layout(location = 1) in vec3 color;
out vec3 pos;
out vec3 col;

void main(){
        gl_Position = vec4(position, 1.0);
        pos = position;
        col = color;
}



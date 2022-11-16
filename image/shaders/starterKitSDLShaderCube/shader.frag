#version 430


out vec4 finalColor;
in vec3 pos;
in vec3 col;

void main() {
   finalColor = vec4(pos, 1.);
}

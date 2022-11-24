#version 430

in vec3 col;
out vec4 finalColor;
uniform vec3 colors;

void main() {
   finalColor = vec4(colors, 1.);
   
}

#version 120

varying vec4 glcolor;
varying vec3 viewDir;

void main() {
    vec4 viewPos = gl_ModelViewMatrix * gl_Vertex;
    gl_Position  = gl_ProjectionMatrix * viewPos;
    glcolor      = gl_Color;
    viewDir      = normalize(viewPos.xyz);
}

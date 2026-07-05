#version 120

varying vec2  texcoord;
varying vec4  glcolor;
varying float viewDist;

void main() {
    vec4 viewPos = gl_ModelViewMatrix * gl_Vertex;
    gl_Position  = gl_ProjectionMatrix * viewPos;
    texcoord     = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    glcolor      = gl_Color;
    viewDist     = length(viewPos.xyz);
}

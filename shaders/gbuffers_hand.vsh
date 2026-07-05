#version 120

#include "/include/settings.glsl"

varying vec2  texcoord;
varying vec2  lmcoord;
varying vec4  glcolor;
varying vec3  normal;
varying float viewDist;

void main() {
    vec4 viewPos = gl_ModelViewMatrix * gl_Vertex;
    gl_Position  = gl_ProjectionMatrix * viewPos;
    texcoord     = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    lmcoord      = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    glcolor      = gl_Color;
    normal       = normalize(gl_NormalMatrix * gl_Normal);
    viewDist     = length(viewPos.xyz);
}

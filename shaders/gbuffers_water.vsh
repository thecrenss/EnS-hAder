#version 120

#include "/include/settings.glsl"

uniform mat4  gbufferModelViewInverse;
uniform mat4  shadowProjection;
uniform mat4  shadowModelView;
uniform float frameTimeCounter;

varying vec2  texcoord;
varying vec2  lmcoord;
varying vec4  glcolor;
varying vec3  normal;
varying vec4  shadowPos;
varying float viewDist;
varying vec3  worldPos;

void main() {
    vec4 viewPos = gl_ModelViewMatrix * gl_Vertex;
    vec4 wPos    = gbufferModelViewInverse * viewPos;
    worldPos     = wPos.xyz;

    float wave   = sin(worldPos.x * 0.8 + frameTimeCounter * 1.4)
                 + sin(worldPos.z * 0.9 + frameTimeCounter * 1.1);
    viewPos.y   += wave * 0.04;

    gl_Position  = gl_ProjectionMatrix * viewPos;
    texcoord     = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    lmcoord      = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    glcolor      = gl_Color;
    normal       = normalize(gl_NormalMatrix * gl_Normal);
    viewDist     = length(viewPos.xyz);
    vec4 sView   = shadowModelView * wPos;
    shadowPos    = shadowProjection * sView * 0.5 + 0.5;
}

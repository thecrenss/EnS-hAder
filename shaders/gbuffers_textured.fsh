#version 120

#include "/include/settings.glsl"
#include "/include/daynight.glsl"
#include "/include/fog.glsl"
#include "/include/pastel.glsl"

uniform sampler2D texture;
uniform float     rainStrength;

varying vec2  texcoord;
varying vec4  glcolor;
varying float viewDist;

void main() {
    vec4 albedo = texture2D(texture, texcoord) * glcolor;
    if (albedo.a < 0.05) discard;

    vec3 col = applyPastel(albedo.rgb);

    float day    = getDayFactor();
    vec3  fogCol = getFogColor(rainStrength);
    col          = applyHorizonFog(col, fogCol, calcFog(viewDist));

    /* DRAWBUFFERS:0 */
    gl_FragData[0] = vec4(col, albedo.a);
}

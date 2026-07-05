#version 120

#include "/include/settings.glsl"
#include "/include/daynight.glsl"
#include "/include/fog.glsl"
#include "/include/pastel.glsl"

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform float     rainStrength;

varying vec2  texcoord;
varying vec2  lmcoord;
varying vec4  glcolor;
varying float viewDist;

void main() {
    vec4 albedo = texture2D(texture, texcoord);
    if (albedo.a < 0.1) discard;

    vec3 col = albedo.rgb * glcolor.rgb;
    col     *= texture2D(lightmap, lmcoord).rgb;
    col     *= 0.85;

    col = applyPastel(col);
    col = applySaturation(col);
    col = applyBrightness(col);

    float day     = getDayFactor();
    vec3  fogCol  = getFogColor(rainStrength);
    col           = applyHorizonFog(col, fogCol, calcFog(viewDist));

    float lum = dot(col, vec3(0.299, 0.587, 0.114));
    /* DRAWBUFFERS:01 */
    gl_FragData[0] = vec4(col, albedo.a);
    gl_FragData[1] = vec4(col * max(lum - 0.75, 0.0) * 3.0, 1.0);
}

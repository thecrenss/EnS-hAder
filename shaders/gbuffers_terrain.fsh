#version 120

#include "/include/settings.glsl"
#include "/include/daynight.glsl"
#include "/include/fog.glsl"
#include "/include/pastel.glsl"
#include "/include/shadow_sample.glsl"

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform vec3      sunPosition;
uniform float     rainStrength;

varying vec2  texcoord;
varying vec2  lmcoord;
varying vec4  glcolor;
varying vec3  normal;
varying vec4  shadowPos;
varying float viewDist;

void main() {
    vec4 albedo = texture2D(texture, texcoord);
    if (albedo.a < 0.1) discard;

    vec3 col     = albedo.rgb * glcolor.rgb;
    vec3 lm      = texture2D(lightmap, lmcoord).rgb;
    col         *= lm;

    float day    = getDayFactor();
    vec3  lDir   = normalize(sunPosition);
    float shadow = getShadow(shadowPos, normal, lDir);
    float amb    = 0.38 + rainStrength * 0.25;
    col         *= (amb + shadow * (1.0 - amb) * day);
    col          = max(col, albedo.rgb * glcolor.rgb * 0.04);

    col = applyPastel(col);
    col = applySaturation(col);
    col = applyBrightness(col);

    vec3  fogCol  = getFogColor(rainStrength);
    float fogFact = calcFog(viewDist);
    col           = applyHorizonFog(col, fogCol, fogFact);

    float lum      = dot(col, vec3(0.299, 0.587, 0.114));
    vec3  bloomSrc = col * max(lum - 0.75, 0.0) * 3.0;

    /* DRAWBUFFERS:01 */
    gl_FragData[0] = vec4(col, albedo.a);
    gl_FragData[1] = vec4(bloomSrc, 1.0);
}

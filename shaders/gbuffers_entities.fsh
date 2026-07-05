#version 120

#include "/include/settings.glsl"
#include "/include/daynight.glsl"
#include "/include/fog.glsl"
#include "/include/pastel.glsl"
#include "/include/shadow_sample.glsl"

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform vec4      entityColor;
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
    if (albedo.a < 0.05) discard;

    vec3 col  = albedo.rgb * glcolor.rgb;
    col       = mix(col, entityColor.rgb, entityColor.a);
    col      *= texture2D(lightmap, lmcoord).rgb;

    float day    = getDayFactor();
    float shadow = getShadow(shadowPos, normal, normalize(sunPosition));
    float amb    = 0.40 + rainStrength * 0.2;
    col         *= (amb + shadow * (1.0 - amb) * day);
    col          = max(col, albedo.rgb * 0.05);

    col = applyPastel(col);
    col = applySaturation(col);
    col = applyBrightness(col);

    vec3  fogCol  = getFogColor(rainStrength);
    col           = applyHorizonFog(col, fogCol, calcFog(viewDist));

    float lum = dot(col, vec3(0.299, 0.587, 0.114));
    /* DRAWBUFFERS:01 */
    gl_FragData[0] = vec4(col, albedo.a);
    gl_FragData[1] = vec4(col * max(lum - 0.75, 0.0) * 3.0, 1.0);
}

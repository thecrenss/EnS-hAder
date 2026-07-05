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
    vec3 lm     = texture2D(lightmap, lmcoord).rgb;

    vec3 waterTint = vec3(0.68, 0.88, 0.98);
    vec3 col       = mix(albedo.rgb, waterTint, 0.45) * glcolor.rgb * lm;

    float day    = getDayFactor();
    vec3  lDir   = normalize(sunPosition);
    float shadow = getShadow(shadowPos, normal, lDir);
    float amb    = 0.55;
    col         *= (amb + shadow * (1.0 - amb) * day);

    vec3  vDir   = vec3(0.0, 0.0, 1.0);
    vec3  hDir   = normalize(lDir + vDir);
    float spec   = pow(max(dot(normal, hDir), 0.0), 32.0) * 0.4 * day;
    col         += vec3(spec);

    col = applyPastel(col);
    col = applySaturation(col);

    vec3  fogCol  = getFogColor(rainStrength);
    float fogFact = calcFog(viewDist);
    col           = applyHorizonFog(col, fogCol, fogFact);

    float alpha    = clamp(albedo.a * glcolor.a * 0.75, 0.3, 0.92);
    float lum      = dot(col, vec3(0.299, 0.587, 0.114));
    vec3  bloomSrc = col * max(lum - 0.70, 0.0) * 2.5;

    /* DRAWBUFFERS:01 */
    gl_FragData[0] = vec4(col, alpha);
    gl_FragData[1] = vec4(bloomSrc, 1.0);
}

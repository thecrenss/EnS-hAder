#version 120

#include "/include/settings.glsl"
#include "/include/daynight.glsl"
#include "/include/fog.glsl"

uniform vec3  sunPosition;
uniform float rainStrength;

varying vec4 glcolor;
varying vec3 viewDir;

void main() {
    float day   = getDayFactor();
    float upDot = clamp(viewDir.y, 0.0, 1.0);

    vec3 horizon = getTimeFogColor();
    vec3 zenithDay   = vec3(0.35, 0.65, 0.98);
    vec3 zenithNight = vec3(0.16, 0.10, 0.38);
    vec3 zenith      = mix(zenithNight, zenithDay, day);

    vec3 sky = mix(horizon, zenith, pow(upDot, 0.5));
    sky      = mix(sky, vec3(0.65, 0.68, 0.75), rainStrength * 0.5);

    /* DRAWBUFFERS:01 */
    gl_FragData[0] = vec4(sky, 1.0);
    gl_FragData[1] = vec4(0.0);
}

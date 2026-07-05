#version 120

#include "/include/settings.glsl"
#include "/include/pastel.glsl"

uniform sampler2D colortex0;
uniform sampler2D colortex2;
uniform float     viewHeight;

varying vec2 texcoord;

vec3 vblur(sampler2D tex, vec2 uv) {
    float t = 1.0 / viewHeight;
    vec3 r  = vec3(0.0);
    r += texture2D(tex, uv + vec2(0.0, -2.0 * t)).rgb * 0.0625;
    r += texture2D(tex, uv + vec2(0.0, -1.0 * t)).rgb * 0.25;
    r += texture2D(tex, uv).rgb * 0.375;
    r += texture2D(tex, uv + vec2(0.0,  1.0 * t)).rgb * 0.25;
    r += texture2D(tex, uv + vec2(0.0,  2.0 * t)).rgb * 0.0625;
    return r;
}

void main() {
    vec3 scene = texture2D(colortex0, texcoord).rgb;

    #ifdef BLOOM
        vec3 bloomV = vblur(colortex2, texcoord);
        float bStr;
        if      (BLOOM_STRENGTH == 1) bStr = 0.15;
        else if (BLOOM_STRENGTH == 2) bStr = 0.30;
        else                            bStr = 0.50;
        scene += bloomV * bStr;
    #endif

    scene = applySaturation(scene);
    scene = applyBrightness(scene);

    /* DRAWBUFFERS:0 */
    gl_FragData[0] = vec4(scene, 1.0);
}

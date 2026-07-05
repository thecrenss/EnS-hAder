#version 120

#include "/include/settings.glsl"

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform float     viewWidth;

varying vec2 texcoord;

vec3 hblur(sampler2D tex, vec2 uv) {
    float t = 1.0 / viewWidth;
    vec3 r  = vec3(0.0);
    r += texture2D(tex, uv + vec2(-2.0 * t, 0.0)).rgb * 0.0625;
    r += texture2D(tex, uv + vec2(-1.0 * t, 0.0)).rgb * 0.25;
    r += texture2D(tex, uv).rgb * 0.375;
    r += texture2D(tex, uv + vec2( 1.0 * t, 0.0)).rgb * 0.25;
    r += texture2D(tex, uv + vec2( 2.0 * t, 0.0)).rgb * 0.0625;
    return r;
}

void main() {
    vec3 scene = texture2D(colortex0, texcoord).rgb;

    #ifdef BLOOM
        vec3 bloomH = hblur(colortex1, texcoord);
        /* DRAWBUFFERS:02 */
        gl_FragData[0] = vec4(scene, 1.0);
        gl_FragData[1] = vec4(bloomH, 1.0);
    #else
        /* DRAWBUFFERS:0 */
        gl_FragData[0] = vec4(scene, 1.0);
    #endif
}

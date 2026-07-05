#version 120

uniform sampler2D texture;
varying vec2 texcoord;
varying vec4 glcolor;

void main() {
    vec4 col = texture2D(texture, texcoord) * glcolor;
    if (col.a < 0.05) discard;
    /* DRAWBUFFERS:01 */
    gl_FragData[0] = col;
    gl_FragData[1] = vec4(col.rgb * 0.6, 1.0);
}

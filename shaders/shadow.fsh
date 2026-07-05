#version 120

uniform sampler2D texture;
varying vec2 texcoord;
varying vec4 vertColor;

void main() {
    vec4 col = texture2D(texture, texcoord) * vertColor;
    if (col.a < 0.1) discard;
    /* DRAWBUFFERS:01 */
    gl_FragData[0] = col;
    gl_FragData[1] = vec4(0.0, 0.0, 0.0, 1.0);
}

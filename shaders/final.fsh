#version 120

uniform sampler2D colortex0;
varying vec2 texcoord;

vec3 reinhard(vec3 col) {
    return col / (col + vec3(1.0));
}

float vignette(vec2 uv) {
    uv = uv * 2.0 - 1.0;
    return clamp(1.0 - dot(uv, uv) * 0.35, 0.0, 1.0);
}

void main() {
    vec3 col = texture2D(colortex0, texcoord).rgb;
    col      = reinhard(col);
    col      = pow(max(col, vec3(0.0)), vec3(1.0 / 2.2));
    col     *= vignette(texcoord);
    gl_FragColor = vec4(col, 1.0);
}

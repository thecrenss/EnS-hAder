// =======================================================
//  En-hader - Golge Ornekleme (PCF)
// =======================================================

uniform sampler2DShadow shadowtex0;

vec3 fixShadowBias(vec3 coord, vec3 n, vec3 lDir) {
    float cosA = clamp(dot(n, lDir), 0.0, 1.0);
    float sinA = sqrt(1.0 - cosA * cosA);
    float bias = SHADOW_BIAS * sinA / max(cosA, 0.0001);
    bias = clamp(bias, 0.0, SHADOW_BIAS * 3.0);
    coord.z -= bias;
    return coord;
}

float sampleShadowHard(vec4 sPos, vec3 n, vec3 lDir) {
    vec3 c = sPos.xyz;
    if (c.x < 0.0 || c.x > 1.0 || c.y < 0.0 || c.y > 1.0) return 1.0;
    c = fixShadowBias(c, n, lDir);
    return shadow2D(shadowtex0, c).r;
}

float sampleShadowSoft(vec4 sPos, vec3 n, vec3 lDir) {
    vec3 c = sPos.xyz;
    if (c.x < 0.0 || c.x > 1.0 || c.y < 0.0 || c.y > 1.0) return 1.0;
    c = fixShadowBias(c, n, lDir);
    float t = 1.0 / float(shadowMapResolution);
    float r = 0.0;
    r += shadow2D(shadowtex0, c + vec3(-t, -t, 0.0)).r;
    r += shadow2D(shadowtex0, c + vec3( 0.0, -t, 0.0)).r;
    r += shadow2D(shadowtex0, c + vec3( t, -t, 0.0)).r;
    r += shadow2D(shadowtex0, c + vec3(-t,  0.0, 0.0)).r;
    r += shadow2D(shadowtex0, c).r;
    r += shadow2D(shadowtex0, c + vec3( t,  0.0, 0.0)).r;
    r += shadow2D(shadowtex0, c + vec3(-t,  t, 0.0)).r;
    r += shadow2D(shadowtex0, c + vec3( 0.0,  t, 0.0)).r;
    r += shadow2D(shadowtex0, c + vec3( t,  t, 0.0)).r;
    return r / 9.0;
}

float getShadow(vec4 sPos, vec3 n, vec3 lDir) {
    #ifdef SOFT_SHADOWS
        return sampleShadowSoft(sPos, n, lDir);
    #else
        return sampleShadowHard(sPos, n, lDir);
    #endif
}

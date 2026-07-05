// =======================================================
//  En-hader - Pastel Renk Fonksiyonlari
// =======================================================

vec3 applyPastel(vec3 col) {
    float str;
    if      (PASTEL_STRENGTH == 0) str = 0.00;
    else if (PASTEL_STRENGTH == 1) str = 0.18;
    else if (PASTEL_STRENGTH == 2) str = 0.36;
    else                            str = 0.54;
    if (str < 0.001) return col;
    float lum = dot(col, vec3(0.299, 0.587, 0.114));
    col = mix(col, vec3(lum), str * 0.25);
    col = mix(col, vec3(1.0), str * 0.45);
    col.r *= (1.0 + str * 0.04);
    col.b *= (1.0 - str * 0.03);
    return clamp(col, 0.0, 1.0);
}

vec3 applySaturation(vec3 col) {
    float sat;
    if      (SATURATION == 0) sat = 0.5;
    else if (SATURATION == 1) sat = 1.0;
    else if (SATURATION == 2) sat = 1.25;
    else                       sat = 1.5;
    float lum = dot(col, vec3(0.299, 0.587, 0.114));
    return clamp(mix(vec3(lum), col, sat), 0.0, 1.0);
}

vec3 applyBrightness(vec3 col) {
    float br;
    if      (BRIGHTNESS == 0) br = 0.80;
    else if (BRIGHTNESS == 1) br = 1.00;
    else if (BRIGHTNESS == 2) br = 1.15;
    else                       br = 1.30;
    return clamp(col * br, 0.0, 1.0);
}

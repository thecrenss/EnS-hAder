// =======================================================
//  EnS-hAder3 - Sis Fonksiyonlari (Neon Pastel Gun Dongusu)
// =======================================================

float calcFog(float viewDist) {
    float t = clamp((viewDist - FOG_START_DIST) / max(FOG_END_DIST - FOG_START_DIST, 1.0), 0.0, 1.0);
    return t * t * (3.0 - 2.0 * t);
}

// Gun boyunca 4 nokta arasinda yumusak gecis: dawn -> noon -> dusk -> night -> dawn
vec3 getTimeFogColor() {
    float t = mod(float(worldTime), 24000.0);

    vec3 dawn  = vec3(1.00, 0.74, 0.40); // neon sari-turuncu (gun dogumu)
    vec3 noon  = vec3(0.48, 0.86, 0.92); // neon acik mavi-yesil (oglen)
    vec3 dusk  = vec3(1.00, 0.48, 0.70); // neon pembe-turuncu (gun batimi)
    vec3 night = vec3(0.60, 0.42, 0.95); // neon mor-mavi (gece)

    if (t < 6000.0) {
        return mix(dawn, noon, t / 6000.0);
    } else if (t < 12000.0) {
        return mix(noon, dusk, (t - 6000.0) / 6000.0);
    } else if (t < 18000.0) {
        return mix(dusk, night, (t - 12000.0) / 6000.0);
    } else {
        return mix(night, dawn, (t - 18000.0) / 6000.0);
    }
}

vec3 getFogColor(float rain) {
    vec3 rainFog = vec3(0.60, 0.65, 0.78);
    vec3 timeCol = getTimeFogColor();
    return mix(timeCol, rainFog, rain * 0.55);
}

vec3 applyHorizonFog(vec3 color, vec3 fogCol, float fogFactor) {
    return mix(color, fogCol, fogFactor);
}

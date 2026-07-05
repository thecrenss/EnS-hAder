// =======================================================
//  EnS-hAder2 - Gun/Gece Faktoru (tum shaderlarda ortak)
// =======================================================

uniform int worldTime;

float getDayFactor() {
    float t = mod(float(worldTime), 24000.0);
    // 6000 = ogle (tam gun), 18000 = gece yarisi (tam karanlik)
    float distFromNoon = abs(mod(t - 6000.0 + 12000.0, 24000.0) - 12000.0);
    float day = 1.0 - clamp(distFromNoon / 9000.0, 0.0, 1.0);
    return clamp(day, 0.0, 1.0);
}

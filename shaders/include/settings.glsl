// =======================================================
//  EnS-hAder - Ayarlar & Sabitler
// =======================================================

// Sabit kalite ayarlari (profil sistemi kaldirildi, direkt gomulu)
#define BLOOM
#define SOFT_SHADOWS
#define SHADOW_HIGH

const int   FOG_DISTANCE     = 8;      // [4 6 8 10 12 16] Fog Distance (Chunks)
const int   PASTEL_STRENGTH  = 1;      // [0 1 2 3] Pastel Strength
const int   FOG_COLOR_PRESET = 0;      // [0 1 2 3] Fog Color
const int   BLOOM_STRENGTH   = 2;      // [1 2 3] Bloom Intensity
const int   SATURATION       = 1;      // [0 1 2 3] Saturation
const int   BRIGHTNESS       = 1;      // [0 1 2 3] Brightness
const float SHADOW_BIAS      = 0.0018; // [0.0008 0.0013 0.0018 0.0025] Shadow Bias

#ifdef SHADOW_ULTRA
  const int shadowMapResolution = 4096;
  const float shadowDistance    = 160.0;
#elif defined(SHADOW_HIGH)
  const int shadowMapResolution = 2048;
  const float shadowDistance    = 128.0;
#elif defined(SHADOW_MED)
  const int shadowMapResolution = 1024;
  const float shadowDistance    = 96.0;
#else
  const int shadowMapResolution = 512;
  const float shadowDistance    = 64.0;
#endif

#define FOG_END_DIST   (float(FOG_DISTANCE) * 16.0)
#define FOG_START_DIST (FOG_END_DIST * 0.30)

#if   FOG_COLOR_PRESET == 1
  #define FOG_RGB vec3(0.82, 0.76, 0.97)
#elif FOG_COLOR_PRESET == 2
  #define FOG_RGB vec3(1.00, 0.88, 0.76)
#elif FOG_COLOR_PRESET == 3
  #define FOG_RGB vec3(0.76, 0.95, 0.86)
#else
  #define FOG_RGB vec3(1.00, 0.85, 0.90)
#endif

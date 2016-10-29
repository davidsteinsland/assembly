#ifndef SIMD_H
#define SIMD_H

#include <xmmintrin.h> // SSE
#include <pmmintrin.h> // SSE3
#include <immintrin.h> // AVX2

#include "inttypes.h"

void transpose_8x8_int16(uint16_t src[8 * 8], uint16_t out[8 * 8]);
void transpose_8x8_int32(uint32_t src[8 * 8], uint32_t out[8 * 8]);

#endif

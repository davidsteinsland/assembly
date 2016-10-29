#include <inttypes.h>
#include <emmintrin.h>

void transpose_8x8(uint32_t a[8 * 8], uint32_t b[8 * 8]) {
  uint8_t i, j;

  for (i = 0; i < 8; ++i) {
    for (j = 0; j < 8; ++j) {
      b[i * 8 + j] = a[j * 8 + i];
    }
  }
}

void transpose_8x8_one_more(uint32_t* a, uint32_t* b) {
  uint8_t i;

  for (i = 0; i < 8; ++i) {
    b[8*i + 0] = a[i + 0];
    b[8*i + 1] = a[i + 8];
    b[8*i + 2] = a[i + 16];
    b[8*i + 3] = a[i + 24];
    b[8*i + 4] = a[i + 32];
    b[8*i + 5] = a[i + 40];
    b[8*i + 6] = a[i + 48];
    b[8*i + 7] = a[i + 56];
  }
}

/* assuming that a and b is aligned to 16 bytes (!!!!) */
void transpose_8x8_simd(uint16_t in[8 * 8], uint16_t out[8 * 8]) {
  __m128i* in128 = (__m128i*)in;

  __m128i row0, row1, row2, row3, row4, row5, row6, row7;

  row0 = in128[0];
  row1 = in128[1];
  row2 = in128[2];
  row3 = in128[3];
  row4 = in128[4];
  row5 = in128[5];
  row6 = in128[6];
  row7 = in128[7];

  __m128i a, b, c, d, p, q;

  a = _mm_unpacklo_epi16(row0, row2);
  b = _mm_unpacklo_epi16(row1, row3);
  p = _mm_unpacklo_epi16(a, b);

  c = _mm_unpacklo_epi16(row4, row6);
  d = _mm_unpacklo_epi16(row5, row7);
  q = _mm_unpacklo_epi16(c, d);

  row0 = _mm_unpacklo_epi64(p, q);
  row1 = _mm_unpackhi_epi64(p, q);

  p = _mm_unpackhi_epi16(a, b);
  q = _mm_unpackhi_epi16(c, d);

  row2 = _mm_unpacklo_epi64(p, q);
  row3 = _mm_unpackhi_epi64(p, q);

  a = _mm_unpackhi_epi16(row0, row2);
  b = _mm_unpackhi_epi16(row1, row3);
  p = _mm_unpacklo_epi16(a, b);

  c = _mm_unpackhi_epi16(row4, row6);
  d = _mm_unpackhi_epi16(row5, row7);
  q = _mm_unpacklo_epi16(c, d);

  row4 = _mm_unpacklo_epi64(p, q);
  row5 = _mm_unpackhi_epi64(p, q);

  p = _mm_unpackhi_epi16(a, b);
  q = _mm_unpackhi_epi16(c, d);

  row6 = _mm_unpacklo_epi64(p, q);
  row7 = _mm_unpackhi_epi64(p, q);

  _mm_store_si128((__m128i *)&out[0], row0);
  _mm_store_si128((__m128i *)&out[8], row1);
  _mm_store_si128((__m128i *)&out[16], row2);
  _mm_store_si128((__m128i *)&out[24], row3);
  _mm_store_si128((__m128i *)&out[32], row4);
  _mm_store_si128((__m128i *)&out[40], row5);
  _mm_store_si128((__m128i *)&out[48], row6);
  _mm_store_si128((__m128i *)&out[56], row7);
/*
  out[0] = (uint16_t)row0;
  out[8] = (uint16_t)row1;
  out[16] = (uint16_t)row2;
  out[24] = (uint16_t)row3;
  out[32] = (uint16_t)row4;
  out[40] = (uint16_t)row5;
  out[48] = (uint16_t)row6;
  out[56] = (uint16_t)row7;*/
}

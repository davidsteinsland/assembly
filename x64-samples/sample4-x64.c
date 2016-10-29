signed int* binary_search(unsigned int size, signed int* list, signed int search)
{
  unsigned int p, q, m;
  p = 0;
  q = size - 1;

  while (p <= q) {
    m = (q + p) >> 1;

    if (list[m] > search) {
      q = m - 1;
    } else if (list[m] < search) {
      p = m + 1;
    } else {
      return list + m;
    }
  }

  return 0;
}

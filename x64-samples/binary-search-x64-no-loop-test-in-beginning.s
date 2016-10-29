# If we find value at first try,
# we run through 15 instructions
#
# 23 instructions if:
# - first match is > search
# - second match == search
_binary_search:
  pushq %rbp
  movq %rsp, %rbp

  # set return value to -1
  movq $-1, %rax

  # if size <= 0, return
  testl %edi, %edi
  jle binary_search_end

  # p = 0
  movq $0, %rcx
  # q = size - 1
  subq $1, %rdi

while_p_is_less_than_or_equal_to_q:
  # m = p + (q - p)/2 === (q + p)/2
  leaq (%rdi, %rcx), %rbx
  sarq %rbx

  # compare search and list[m]
  cmpl %edx, (%rsi, %rbx, 4)
  # if list[m] <= search
  jle possible_match_less_than

  # list[m] > search

  # q = m - 1
  leaq -1(%rdi), %rdi
  jmp test_if_p_is_less_than_or_equal_to_q

possible_match_less_than:
  # if list[m] >= search
  jge found_match

  # list[m] < search
  leaq 1(%rcx), %rcx

test_if_p_is_less_than_or_equal_to_q:
  # if p <= q, go to loop
  cmpq %rcx, %rdi
  jge while_p_is_less_than_or_equal_to_q
  # if p > q, return
  jmp binary_search_end

found_match:
  movq %rbx, %rax

binary_search_end:
  leave
  ret

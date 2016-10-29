# If we find value at first try,
# we run through 18 instructions
#
# 28 instructions if:
# - first match is > search
# - second match == search
_binary_search:
  pushq %rbp
  movq %rsp, %rbp

  # p = 0
  movq $0, %rcx
  # q = size - 1
  subq $1, %rdi

  # set return value to -1
  movq $-1, %rax

while_p_is_less_than_or_equal_to_q:
  # XXX: Optimise this cmpq away
  cmpq %rdi, %rcx
  # if p > q, go away
  jg binary_search_end

  # m = p + (q - p)/2
  movq %rdi, %rbx
  subq %rcx, %rbx
  sarq $1, %rbx
  addq %rcx, %rbx

  # compare search and list[m]
  cmpl %edx, (%rsi, %rbx, 4)
  # if list[m] <= search
  jle possible_match_less_than

  # list[m] > search

  # q = m - 1
  subq $1, %rdi
  jmp while_p_is_less_than_or_equal_to_q

possible_match_less_than:
  # if list[m] >= search
  jge found_match

  # list[m] < search
go_up:
  addq $1, %rcx
  jmp while_p_is_less_than_or_equal_to_q

found_match:
  movq %rbx, %rax

binary_search_end:
  movq %rbp, %rsp
  popq %rbp

  ret

# If we find value at first try,
# we run through 20 instructions
#
# 30 instructions if:
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
  # if list[m] > search
  jg go_down

  # XXX: Optimise this second cmpl away
  cmpl %edx, (%rsi, %rbx, 4)
  # if list[m] < search
  jl go_up

  # found match
  movq %rbx, %rax
  jmp binary_search_end

go_down:
  # q = m - 1
  subq $1, %rdi
  jmp while_p_is_less_than_or_equal_to_q
go_up:
  addq $1, %rcx
  jmp while_p_is_less_than_or_equal_to_q

binary_search_end:
  movq %rbp, %rsp
  popq %rbp

  ret

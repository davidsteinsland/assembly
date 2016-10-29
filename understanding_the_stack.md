x86/IA-32 Assembly
==================

# C calling convention - cdecl

* Caller prepares stack, pushes arguments in reverse order
* Caller cleans up stack after call
* Callee must preserve `%ebp` and `%esp`

```
void callee(int arg1, int arg2)
{
}

void caller()
{
    callee(10, 5);
}
```

is equivalent to:

```

callee:
    pushl %ebp
    movl %esp, %ebp
    
    # (%ebp) points to the old %ebp we pushed above
    # 4(%ebp) contains the return address
    
    # move first argument to %eax
    movl 8(%ebp), %eax
    # move second argument to %ecx
    movl 12(%ebp), %ecx
    
    # if we wanted to put the arguments onto stack, in local variables, we could do:
    subl $8, %esp
    # put first argument at top of stack
    movl 8(%ebp), -4(%esp)
    # put second argument at bottom of local stack
    movl 12(%ebp), -8(%esp)
    
    # clean up our local stack
    addl $8, %esp
    
    movl %ebp, %esp
    popl %ebp
    ret

caller:
    pushl %ebp
    movl %esp, %ebp
    
    pushl $5
    pushl $10
    call callee
    
    # we dont need to perform "addl $8, %esp",
    # because we are setting %esp to %ebp
    movl %ebp, %esp
    popl %ebp
    ret
```


# Memory addressing

In AT&T, a memory reference takes the following form:

```
section:disp(base, index, scale)
```
where 

* base and index are the optional 32-bit base and index registers,
* disp is the optional displacement,
* and scale, taking the values 1, 2, 4, and 8.

In Intel syntax, the equivalent is:

```
section:[base + index*scale + disp]
```

---


What is the assembly equivalent of:

```
int a[] = {1, 2, 3};
int b = a[2];
```
Assume `a` is in `edx`, `2` is in `ecx` and `b` is in `eax`.

```
movl (%edx, %ecx, 4), %eax
```

Since `%edx` is the equivalent of `&a[0]`, the above expression is equivalent to:

```
b = a + (4 * i)
```

We use `4` as the scale, as each `int` is 4 bytes long.

---

What is the assembly equivalent of:

```
int a[] = {1, 2, 3};
a[2] = 5 + 2 * a[2];
```

Here we can make use of the full memory reference syntax:

```
# move "a + 4*i" to %edx
movl (%eax, %edi, 4), %edx

# %edx = %edx * 2 + 5
# this means that we multiply the
# array element with 2 and adds 5
leal 5(, %edx, 2), %edx 
# move %edx back into array
movl %edx, (%eax, %edi, 4)
```

Assume that `a` is int `%eax` and the index `2` is in `%edi`.

# Understanding the Stack

The stack is a simple data structure stored in memory (RAM) and acts as a LIFO queue, where the
bottom of the stack is placed higher in memory than the top.

If we assume a stack of 16 bytes, that starts at `0xFFFF`, it would look like this:

```
Address  Stack index
0xF     0
0xE     1
.............
0x1     14
0x0     15
```

Consider the function:
```
void MyFunction()
{
  int a, b, c;
  a = 10;
  b = 5;
  c = 2;
}
```

This would produce assembly equal to:

```
_MyFunction:
  pushl %ebp         # save the value of ebp by pushing it onto stack
  movl %esp, %ebp    # %ebp now points to the top of the stack, when entering _MyFunction
                     # 0(%ebp) = the "old" %ebp we pushed above
                     # 4(%ebp) = the return address, pushed onto stack before entering _MyFunction
                     # 8(%ebp) = first argument, if MyFunction would accept one
                     # 12(%ebp) = second argument, if Myfunction would accept one
  subl $12, %esp     # allocate 12 bytes on stack
  movl $10, -4(%ebp) # a = 10
  movl $5, -8(%ebp)  # b = 5
  movl $2, -12(%ebp) # c = 2
```

At `movl %esp, %ebp` the stack would look like:

```
0xFF ...
0xF1 ...
0xF0 %ebp
```

Assume that upon entering `MyFunction`, the current value of `%esp` is `0xF1`.
When we are pushing `%ebp` onto the stack, the stack is increased by `4 bytes`.
When we are moving `%esp` into `%ebp`, the `%ebp` register would now point to `%esp`.

Next, after `movl $2, -12(%ebp)`, the stack would look like:

```
0xFF ...
0xF1 ...
0xF0 %ebp
0xEF 10
0xEE 5
0xED 2
```

We could also have used `%esp`, but since the `%esp` points to the top of the stack, we would then do:

```
  movl $10, 12(%esp) # a = 10
  movl $5,  4 (%esp) # b = 5
  movl $2,    (%esp) # c = 2
```

We could also have used `pushl`, but only if we did not do `subl $12, %esp`

```
   pushl $10
   pushl $5
   pushl $2
```

To clean up the stack, we must do:

```
    addl $12, %esp
```

Or use `popl` with `%eax` as intermediary:

```
popl $eax
popl %eax
popl %eax
```

Note that we do not preserve the value of `%eax`.

Or, we could restore `%esp` to the value of `%ebp`:

```
movl %ebp, %esp
```

Once stack is back where it was when we pushed `%ebp`, we restore that:

```
popl %ebp
```

---

Summary:

- Stack begins at higher RAM addresses
- Stack ends at lower addresses
- Stack top => lowest address
- Stack bottom => highest address
- `x(%esp)` => `x` bytes from the top of stack, towards bottom of stack
- `-x(%ebp)` => `x` bytes from the bottom of the stack, towards the top

---

Consider:

```
int a = 1000;
int b[] = {3000, 2000, 8000};
```

Assume the value `b` is put into `%eax` and `a` is put into `%ecx`.

Registers:
```
+------------------------+------------------------+
|         %eax           |          %ecx          |
+------------------------+------------------------+
|        0xFF00          |          1000          |
+------------------------+------------------------+
```

Memory:
```
+---------+--------+
| Address |  Value |
+---------+--------+
| 0xFFFC  |  1000  |
| 0xFF00  |  3000  |
| 0xFF04  |  2000  |
| 0xFF08  |  8000  |
+---------+--------+
```

Memory references are calculated using:

```
  base + index * scale + disp
```

AT&T syntax defines the following:

```
  section:disp(base, index, scale)
```

---

How do we address index 0, 1 and 2 of the pointer `b`?

```
  # Assume the pointer b is placed in %eax

  # index 0
  movl (%eax), %ecx
  # index 1
  movl 4(%eax), %ecx
  # index 2
  movl 8(%eax), %ecx
```

In the above examples we are only using `disp` and `base`, but we can also use `index` and `scale` instead. Assume we are iterating over `b` and the index is placed in register `%ecx`:

```
  # move the value <b + 4 * i> to %edx
  movl (%eax, %ecx, 4), %edx
```

In the last example, assume we are iterating every 2nd integer over `b`, something like:

```
  for (i = 0; i < size; i += 2) {
    p = b[i];
    q = b[i + 1];
  }
```

We could then use the full memory reference syntax:

```
  movl (%eax, %ecx, 4), %edx
  movl 4(%eax, %ecx, 4), %ecx
```

---

As a last example, what if we wanted to multiply the array value by 2 and add 5?

First, we move the value into a register. We're assuming that the `int` pointer is stored in `%eax` and the array index is stored in `%ecx`.

```
  movl (%eax, %ecx, 4), %edx
```

Next, we multiply by 2 and add 5:

```
  leal 5(, %edx, 2), %edx
```

See what we did there? We omitted the `base`.

---

```
+------------+-----------------------------+
|   Address  |         Description         |
+------------+-----------------------------+
| 0xbffff968 | third argument of function  |
+------------+-----------------------------+
| 0xbffff964 | second argument of function |
+------------+-----------------------------+
| 0xbffff960 | first argument of function  |
+------------+-----------------------------+
| 0xbffff95c | return address of function  | %esp upon entering function
+------------+-----------------------------+
| 0xbffff958 | %esp after <pushl %ebp>     | old %ebp is stored here
+------------+-----------------------------+
| 0xbffff954 | first local var             | 
+------------+-----------------------------+
| 0xbffff950 | second local var            | 
+------------+-----------------------------+
```

```
foo:
  pushl %ebp
  movl %esp, %ebp

  subl $8, %esp

# 8(%ebp)  = 0xbffff958 + 8 = 0xbffff960 = first argument
# 4(%ebp)  = 0xbffff958 + 4 = 0xbffff95c = return address
# (%ebp)   = 0xbffff958 = %ebp
# -4(%ebp) = 0xbffff958 - 4 = 0xbffff954 = 4(%esp) = first local var
# -8(%ebp) = 0xbffff958 - 8 = 0xbffff950 =  (%esp) = second local var

  movl %ebp, %esp
  popl %ebp
  ret
```

---

# Differences between `leal` and `movl`

```
leal (%eax,%ecx,4), %edx  ←  moves %eax+%ecx*4 into %edx
movl (%eax,%ecx,4), %edx  ←  moves whatever is at address %eax+%ecx*4 into %edx
```

So `leal (%eax,%ecx,4), %edx` would be equal to:

```
int p, q, r;
p = 5;
q = 10;

r = p + q * 4;
```

`movl (%eax,%ecx,4), %edx` would be equal to:

```
int p[] = {1, 2, 3};
int q, r;
q = 2;

r = *(p + 4 * q); // => r = p[q]
```

---

Consider the following struct:

```
struct Point
{
     int xcoord;
     int ycoord;
};
```

Now imagine a statement like:

```
int y = points[i].ycoord;
```

where `points[]` is an array of `Point`. 

Now, assume that:

* the base of the array is already in `EBX`,
* and variable `i` is in `EAX`, 
* and `xcoord` and `ycoord` are each 32 bits (so `ycoord` is at offset 4 bytes in the struct)

The statement can be compiled to:

```
movl 4(%ebx, %eax, 8), %edx
```

which will land `y` in `EDX`. The scale factor of `8` is because each `Point` is 8 bytes in size. 

Now consider the same expression used with the "address of" operator `&`:

```
int* p = &points[i].ycoord;
```

In this case, you don't want the value of `ycoord`, but its address. 
That's where `LEA` (load effective address) comes in. Instead of a `MOV`, the compiler can generate

```
leal 4(%ebx, %eax, 8), %esi
```

which will load the address in `ESI`.

---


LEA, the only instruction that performs memory addressing calculations but doesn't actually address memory. LEA accepts a standard memory addressing operand, but does nothing more than store the calculated memory offset in the specified register, which may be any general purpose register.

What does that give us? Two things that ADD doesn't provide:

* the ability to perform addition with either two or three operands, and
* the ability to store the result in any register; not just one of the source operands.

A simple example:

- Consider you want to add register `%r10d` and `%r8d`, and store the result in `%r9d`:

With `addl` and `movl`:

```
movl %r10d, %r9d
addl %r8d, %r9d
```

With `leal`:

```
leal (%r10d, %r8d), %r9d
```

Anoter nice feature of `LEA`, is that it does not modify the flags:

Other usecase is handy in loops: the difference between `leal 1(%eax), %eax` and `incl %eax` is that the latter changes `EFLAGS` but the former does not; **this preserves `CMP` state**

---

# Flags, comparisons

*  The **S**ign **F**lag (`SF`) is used to indicate whether a mathematical operation resulted on the most significant bit being set. In a two's complement representation, the most significant bit is `1` if the number if negative.
*  The **Z**ero **F**lag is set to `1` if the result of an arithmetic operation is zero.
*  The **P**arity **F**lag indicates if the number of set bits is odd or even in the binary representation of the result of the last operation.

---


```
cmpl %ebx, %eax
```

Performs a comparison operation between `%eax` and `%ebx`. The comparison is performed by a (signed) subtraction of `%eax` from `%ebx`. If `%ebx` is an immediate value it will be sign extended to the length of `%eax`. The `EFLAGS` register is set in the same manner as a sub instruction.

Note that the syntax can be rather confusing, as for example:

```
cmp $0, %rax
jl branch
```

will branch if `%rax < 0` (and not the opposite as might be expected from the order of the operands).

```
test %eax, %ebx
```

Performs a bit-wise logical AND on `%eax` and `%ebx` and sets the `ZF`, `SF` and `PF` flags.

| Instruction |         Description          | signed-ness |       Flags        |
|-------------|------------------------------|-------------|--------------------|
| JO          | Jump if overflow             |             | OF = 1             |
| JNO         | Jump if not overflow         |             | OF = 0             |
| JS          | Jump if sign                 |             | SF = 1             |
| JNS         | Jump if not sign             |             | SF = 0             |
| JE          | Jump if equal                |             | ZF = 1             |
| JZ          | Jump if zero                 |             | ZF = 1             |
| JNE         | Jump if not equal            |             | ZF = 0             |
| JNZ         | Jump if not zero             |             | ZF = 0             |
| JB          | Jump if below                | unsigned    | CF = 1             |
| JNAE        | Jump if not above or equal   | unsigned    | CF = 1             |
| JC          | Jump if carry                | unsigned    | CF = 1             |
| JNB         | Jump if not below            | unsigned    | CF = 0             |
| JAE         | Jump if above or equal       | unsigned    | CF = 0             |
| JNC         | Jump if not carry            | unsigned    | CF = 0             |
| JBE         | Jump if below or equal       | unsigned    | CF = 1 or ZF = 1   |
| JNA         | Jump if not above            | unsigned    | CF = 1 or ZF = 1   |
| JA          | Jump if above                | unsigned    | CF = 0 and ZF = 0  |
| JNBE        | Jump if not below or equal   | unsigned    | CF = 0 and ZF = 0  |
| JL          | Jump if less                 | signed      | SF <> OF           |
| JNGE        | Jump if not greater or equal | signed      | SF <> OF           |
| JGE         | Jump if greater or equal     | signed      | SF = 0             |
| JNL         | Jump if not less             | signed      | SF = OF            |
| JLE         | Jump if less or equal        | signed      | ZF = 1 or SF <> OF |
| JNG         | Jump if not greater          | signed      | ZF = 1 or SF <> OF |
| JG          | Jump if greater              | signed      | ZF = 0 and SF = OF |
| JNLE        | Jump if not less or equal    | signed      | ZF = 0 and SF = OF |
| JP          | Jump if parity               |             | PF = 1             |
| JPE         | Jump if parity even          |             | PF = 1             |
| JNP         | Jump if not parity           |             | PF = 0             |
| JPO         | Jump if parity odd           |             | PF = 0             |
| JCXZ        | Jump if %CX register is 0    |             | %CX = 0            |
| JECXZ       | Jump if %ECX register is 0   |             | %ECX = 0           |



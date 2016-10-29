
AS = as
CC = gcc
LD = ld

# -m32   32-bit mode
# -Wall  show all warnings
# -g     Produce debug symbols
# -c     Compile only, no linking
CCOPTS = -Wall -g -c
CCOPTS_32 = $(CCOPTS) -m32

# -lc    Link with libc
# -arch  Specify 32-bit arch
# -macosx_version_min Set the target version
LDOPTS = -lc -macosx_version_min 10.11
LDOPTS_32 = $(LDOPTS) -arch i386

# snip from:
# https://github.com/InterNations/kata-c
TEST_NAME = testsuite
TEST_SRC = $(wildcard tests/check*.c)
TEST_OBJ = $(TEST_SRC:%.c=%.o)
TEST_LDFLAGS = $(LDOPTS) `pkg-config --libs check`

.PHONY: clean all test

all: main main-x64
	./main
	./main-x64

main: x86/helpers-x86.o x86/main-x86.o
	$(LD) $(LDOPTS_32) -o $@ $^

main-x64: x64/helpers-x64.o x64/main-x64.o
	$(LD) $(LDOPTS) -arch x86_64 -o $@ $^

fib: x64/fib-x64.o
	$(LD) $(LDOPTS) $^ -o $@

cpuid: cpuid-main.o cpuid.o
	$(LD) $(LDOPTS_32) -o $@ $^

$(TEST_NAME): x64/helpers-x64.o x64/transpose_8x8-x64.o $(TEST_OBJ)
	$(LD) $(TEST_LDFLAGS) -arch x86_64 -o $@ $^

test: $(TEST_NAME)
	@./$(TEST_NAME)

# Decompilation
# ===================================

# how to decompile 64-bit C to ASM
%-x64.s: %-x64.c
	$(CC) -O3 -Wall -S -o $@ $<

# how to decompile C to ASM
%.s: %.c
	$(CC) -m32 -O0 -Wall -S -o $@ $<

## Compilation
# ===================================
#
# GCC:
# file.s: Assembler code.
# file.S: Assembler code that must be preprocessed.
#
# GCC automatically sets the language based on the file name,
# but if we need to preprocess a .s file, we should add:
# "-x assembler-with-cpp" to CCOPTS

# how to compile 64-bit C
%-x64.o: %-x64.c
	$(CC) $(CCOPTS) -o $@ $<

# how to compile 64-bit ASM
%-x64.o: %-x64.s
	$(AS) $(CCOPTS) -o $@ $<

%.o: %.c
	$(CC) $(CCOPTS_32) -o $@ $<

# how to compile ASM
%.o: %.s
	$(AS) $(CCOPTS_32) -o $@ $<

clean:
	-$(RM) *.o
	-$(RM) x86/*.o
	-$(RM) x64/*.o

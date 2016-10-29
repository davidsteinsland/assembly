AS = clang
#CC = clang
#LD = ld
CC=/usr/local/opt/gcc48/bin/gcc-4.8

# Nice blog post:
# https://blogs.oracle.com/ksplice/entry/hello_from_a_libc_free

# -m32   32-bit mode
# -Wall  show all warnings
# -g     Produce debug symbols
# -c     Compile only, no linking
CCOPTS = -std=c99 -Wall -m32 -g -O3 -nostdlib -fno-builtin -mavx2
ASOPTS = -Wall -m32 -g -c -O3 -nostdlib

# -arch  Specify 32-bit arch
# -macosx_version_min Set the target version
#LDOPTS = -macosx_version_min 10.11 -arch i386
#LDOPTS = -arch i386 -Xlinker "-macosx_version_min 10.11"
LDOPTS = -arch i386
#  * <-nostdlib> seems to be invalid for OSX
#  * Added <-lSystem> because of:
#    ld: dynamic main executables must link with libSystem.dylib for architecture i386

.PHONY: clean all depend

all: hello
	./hello Hello World!

hello: entry.o syscalls.o string.o hello.o util.o #simd.o tests.o
	$(CC) $(CCOPTS) $(LDOPTS) -o $@ $^

# Figure out dependencies, and store them in the hidden file .depend
depend: .depend
.depend: *.[cSh]
	$(CC) $(CCOPTS) -MM -MG *.[cS] > $@

# Decompilation
# ===================================

# how to decompile C to ASM
%.s: %.c
	$(CC) -m32 -O0 -S -o $@ $<

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

%.o: %.c
	$(CC) $(CCOPTS) -c -o $@ $<

# how to compile ASM
%.o: %.s
	$(AS) $(ASOPTS) -c -o $@ $<

# how to compile ASM (preprocessed)
%.o: %.S
	$(CC) $(CCOPTS) -c -x assembler-with-cpp -o $@ $<

clean:
	-$(RM) *.o

# Include dependencies
# (the leading dash prevents warnings if the file doesn't exist)
-include .depend

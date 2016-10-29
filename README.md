Assembly Playground
===================

This repository contains both x86 (IA-32) and x64 (IA-64) assembly, written on a Mac. Don't expect my
programs to compile on other machines.

Some programs are written as C then "compiled" into ASM as an exercise to see what the compiler does at the different optimisation steps.

## Motivation

* Learn x86 and x64 assembly
* Is it hard to write assembly that outperforms the compiler?

The `x86-isolated` contains an application written without the `stdlib`. It also have it's own entrypoint, instead of the GCC's. 

## Resources

The web is a nice place, but books are still better:

* Andrew Tanenbaum: Modern Operating Systems, 3rd Edition, 2007. Prentice-Hall. ISBN: 0-13-600663-9
* The Undocumented PC, Frank van Gilluwe, Addison Wesley
* Protected Mode Software Architecture, by Tom Shanley, MindShare, Inc. 1996.

* [Understanding the Stack](understanding_the_stack.md)


### On the web

* [https://www.cs.virginia.edu/~evans/cs216/guides/x86.html](https://www.cs.virginia.edu/~evans/cs216/guides/x86.html)
* [http://www.eecg.toronto.edu/~amza/www.mindsec.com/files/x86regs.html](http://www.eecg.toronto.edu/~amza/www.mindsec.com/files/x86regs.html)
* [https://en.wikibooks.org/wiki/X86_Assembly](https://en.wikibooks.org/wiki/X86_Assembly)
  * [https://en.wikibooks.org/wiki/X86_Disassembly/Calling_Convention_Examples](https://en.wikibooks.org/wiki/X86_Disassembly/Calling_Convention_Examples)
* [http://www.tenouk.com/Bufferoverflowc/Bufferoverflow2a.html](http://www.tenouk.com/Bufferoverflowc/Bufferoverflow2a.html)
* [http://unixwiz.net/techtips/index.html](http://unixwiz.net/techtips/index.html)
  * [http://unixwiz.net/techtips/x86-jumps.html](http://unixwiz.net/techtips/x86-jumps.html)
  * [http://unixwiz.net/techtips/win32-callconv-asm.html](http://unixwiz.net/techtips/win32-callconv-asm.html)
* [https://en.wikipedia.org/wiki/Branch_%28computer_science%29](https://en.wikipedia.org/wiki/Branch_%28computer_science%29)
* [http://www.delorie.com/djgpp/doc/ug/asm/calling.html](http://www.delorie.com/djgpp/doc/ug/asm/calling.html)
* [http://peter.michaux.ca/articles/assembly-hello-world-for-os-x](http://peter.michaux.ca/articles/assembly-hello-world-for-os-x)
* [http://www.guideforschool.com/625348-memory-address-calculation-in-an-array/](http://www.guideforschool.com/625348-memory-address-calculation-in-an-array/)
  * Row Major, Column major
* [http://staff.ustc.edu.cn/~xlanchen/cailiao/x86%20Assembly%20Programming.htm](http://staff.ustc.edu.cn/~xlanchen/cailiao/x86%20Assembly%20Programming.htm)
* [https://www.ibiblio.org/gferg/ldp/GCC-Inline-Assembly-HOWTO.html](https://www.ibiblio.org/gferg/ldp/GCC-Inline-Assembly-HOWTO.html)

![IA-64 registers](registers.png)
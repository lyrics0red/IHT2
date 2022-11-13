	.file	"main.c"
	.intel_syntax noprefix
	.text
	.comm	data,20000,32
	.comm	input,8,8
	.comm	output,8,8
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
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	DWORD PTR -36[rbp], edi
	mov	QWORD PTR -48[rbp], rsi
	cmp	DWORD PTR -36[rbp], 3
	jne	.L2
	mov	rax, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
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
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1
	jmp	.L4
.L8:
	lea	rdi, .LC2[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1
	jmp	.L4
.L5:
	mov	rdi, QWORD PTR -16[rbp]
	lea	rsi, .LC1[rip]
	call	fopen@PLT
	mov	QWORD PTR input[rip], rax
	mov	rdi, QWORD PTR -24[rbp]
	lea	rsi, .LC3[rip]
	call	fopen@PLT
	mov	QWORD PTR output[rip], rax
	mov	DWORD PTR -4[rbp], 0
	jmp	.L6
.L7:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, data[rip]
	add	rdx, rax
	mov	rdi, QWORD PTR input[rip]
	lea	rsi, .LC4[rip]
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	add	DWORD PTR -4[rbp], 1
.L6:
	mov	rdi, QWORD PTR input[rip]
	call	feof@PLT
	test	eax, eax
	je	.L7
	lea	rdi, data[rip]
	mov	eax, 0
	call	modify@PLT
	mov	rsi, QWORD PTR output[rip]
	lea	rdi, data[rip]
	call	fputs@PLT
	mov	rdi, QWORD PTR input[rip]
	call	fclose@PLT
	mov	rdi, QWORD PTR output[rip]
	call	fclose@PLT
	mov	eax, 0
.L4:
	leave
	ret

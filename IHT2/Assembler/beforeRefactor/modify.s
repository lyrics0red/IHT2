	.file	"modify.c"
	.intel_syntax noprefix
	.text
	.globl	mask
	.data
	.type	mask, @object
	.size	mask, 6
mask:
	.ascii	"aeiouy"
	.text
	.globl	modify
	.type	modify, @function
modify:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 24
	mov	DWORD PTR -20[rbp], 0
	jmp	.L2
.L7:
	mov	DWORD PTR -24[rbp], 0
	jmp	.L3
.L6:
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	lea	rdx, data[rip]
	movzx	edx, BYTE PTR [rax+rdx]
	mov	eax, DWORD PTR -24[rbp]
	cdqe
	lea	rcx, mask[rip]
	movzx	eax, BYTE PTR [rax+rcx]
	cmp	dl, al
	jne	.L4
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	lea	rdx, data[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	sub	eax, 32
	mov	ecx, eax
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	lea	rdx, data[rip]
	mov	BYTE PTR [rax+rdx], cl
	jmp	.L5
.L4:
	add	DWORD PTR -24[rbp], 1
.L3:
	cmp	DWORD PTR -24[rbp], 5
	jle	.L6
.L5:
	add	DWORD PTR -20[rbp], 1
.L2:
	mov	eax, DWORD PTR -20[rbp]
	movsx	rbx, eax
	lea	rdi, data[rip]
	call	strlen@PLT
	cmp	rbx, rax
	jb	.L7
	nop
	nop
	add	rsp, 24
	pop	rbx
	pop	rbp
	ret
	.size	modify, .-modify
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:

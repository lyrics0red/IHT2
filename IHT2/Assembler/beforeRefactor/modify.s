	.intel_syntax noprefix
	.text
	.globl	mask
	.data
mask:
	.ascii	"aeiouy"
	.text
	.globl	modify
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
	add	rsp, 24
	pop	rbx
	pop	rbp
	ret

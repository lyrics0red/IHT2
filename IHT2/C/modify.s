# -20[rbp] = r14d
# -24[rbp] = r15d
	.intel_syntax noprefix
	.text
	.globl	mask
	.data
mask:
	.ascii	"aeiouy"				# char mask[6] = "aeiouy"
	
	.text						# Секция с кодом
	.globl	modify					# Функция modify
	
modify:
	push	rbp					# Сохраняем rbp на стек
	mov	rbp, rsp				# rbp := rsp
	push	rbx					# Сохраняем rbx на стек
	sub	rsp, 24				# rsp -= 24 (выделение памяти на стеке)
	mov	r14d, 0				# i = 0;
	jmp	.L2					# Переходим в .L2
	
.L7:
	mov	r15b, 0				# j = 0
	jmp	.L3					# Переходим в .L3
	
.L6:
	mov	eax, r14d				# eax := i
	cdqe
	lea	rdx, data[rip]				# rdx := &data
	movzx	edx, BYTE PTR [rax+rdx]		# edx := data[i]
	mov	eax, r15d				# eax := j
	cdqe
	lea	rcx, mask[rip]				# rcx := &mask
	movzx	eax, BYTE PTR [rax+rcx]		# eax := mask[j]
	cmp	dl, al					# Сравниваем data[i] и mask[j]
	jne	.L4					# Если data[i] != mask[j], то переходим в .L4
	mov	eax, r14d				# eax := i
	cdqe
	lea	rdx, data[rip]				# rdx := &data
	movzx	eax, BYTE PTR [rax+rdx]		# eax := data[i]
	sub	eax, 32				# ecx := ecx - 32
	mov	ecx, eax				# ecx := data[i]
	mov	eax, r14d				# eax := i		
	cdqe
	lea	rdx, data[rip]				# rdx := &data
	mov	BYTE PTR [rax+rdx], cl			# data[i] := ecx
	jmp	.L5					# Переходим в .L5 
	
.L4:
	add	r15d, 1				# ++j;
	
.L3:
	cmp	r15d, 5				# Сравниваем j с 5
	jle	.L6					# Если i <= 5, то переходим в .L6 
	
.L5:
	add	r14d, 1				# ++i;
	
.L2:
	mov	eax, r14d				# eax := i
	movsx	rbx, eax				# rbx := eax (с расширением разрядности)
	lea	rdi, data[rip]				# rdi := &data - 1-й аргумент
	call	strlen@PLT				# strlen(data)
	cmp	rbx, rax				# Сравниваем i с strlen(data)
	jb	.L7					# Если i < strlen(data), то переходим в .L7 
	add	rsp, 24				# rsp := rsp + 24
	pop	rbx
	pop	rbp
	ret						# Выход из функции

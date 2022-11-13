# -52[rbp] := r12d
# -4[rbp] := r13d

	.intel_syntax noprefix
	.text
	.comm	data,20000,32					# Строка, которую мы вводим (массив символов)
	.section	.rodata				# rodata
	.align 8
	
.LC0:
	.string	"Incorect number of parameters."	# .LC0: "Incorrect number of parameters." (Сообщение об ошибке)
	
.LC1:
	.string	"r"					# .LC1: "r" (Файл на чтение)
	
.LC2:
	.string	"Incorrect name of input file."	# .LC2: "Incorrect name of input file." (Сообщение об ошибке)
	
.LC3:
	.string	"w"					# .LC3: "w" (Файл на запись)
	
.LC4:
	.string	"%c"					# .LC4: "%c" (Символьный формат)

	
	.text							# Секция с кодом
	.globl	main						# Функция main
	
main:
	push	rbp						# Сохраняем rbp на стек
	mov	rbp, rsp					# rbp := rsp
	sub	rsp, 64					# rsp -= 64 (выделение памяти на стеке)
	mov	r12d, edi					# edi - 1-й аргумент - argc
	mov	QWORD PTR -64[rbp], rsi			# rsi - 2-й аргумент - argv
	cmp	r12d, 3					# Сравниваем argc с 3
	jne	.L2						# Если argc != 3, то переходим в .L2
	mov	rax, QWORD PTR -64[rbp]			# rax := argv
	mov	rax, QWORD PTR 8[rax]				# rax := argv[1]
	mov	QWORD PTR -16[rbp], rax			# instr := argv[1]
	mov	rax, QWORD PTR -64[rbp]			# rax := argv
	mov	rax, QWORD PTR 16[rax]				# rax := argv[2]
	mov	QWORD PTR -24[rbp], rax			# outstr := argv[2]
	mov	rdi, QWORD PTR -16[rbp]			# rdi := instr - 1-й аргумент
	lea	rsi, .LC1[rip]					# rsi := &(строчка "r") - 2-й аргумент
	call	fopen@PLT					# fopen(instr, "r");
	test	rax, rax					# Проверка rax на значение NULL
	jne	.L5						# Если rax != NULL, то переходим в .L5 
	jmp	.L8						# Переходим в .L8
	
.L2:
	lea	rdi, .LC0[rip]					# rdi := &(строчка "Incorrect number of parameters.") - 1-й аргумент
	call	printf@PLT					# printf("Incorrect number of parameters.");
	mov	eax, 1						# eax := 1
	jmp	.L4						# Переходим в .L4
	
.L8:
	lea	rdi, .LC2[rip]					# rdi := &(строчка "Incorrect name of input file.") - 1-й аргумент
	call	printf@PLT					# printf("Incorrect name of input file.");
	mov	eax, 1						# eax := 1
	jmp	.L4 						# Переходим в .L4
	
.L5:
	mov	rdi, QWORD PTR -16[rbp]			# rdi := instr - 1-й аргумент
	lea	rsi, .LC1[rip]					# rsi := &(строчка "r") - 2-й аргумент
	call	fopen@PLT					# fopen(instr, "r");
	mov	QWORD PTR -32[rbp], rax			# rbp[-32](input) := результат работы fopen(instr, "r")
	mov	rdi, QWORD PTR -24[rbp]			# rdi := outstr - 1-й аргумент 
	lea	rsi, .LC3[rip]					# rsi := &(строчка "w") - 2-й аргумент
	call	fopen@PLT					# fopen(outstr, "w");
	mov	QWORD PTR -40[rbp], rax			# rbp[-40](output) := результат работы fopen(outstr, "w")
	mov	r13d, 0					# int i = 0;
	jmp	.L6						# Переходим в .L6
	
.L7:
	mov	eax, r13d					# eax := i
	cdqe
	lea	rdx, data[rip]					# rdx := &data - 3-й аргумент
	add	rdx, rax					# rdx := rdx + rax
	mov	rdi, QWORD PTR -32[rbp]			# rdi := input - 1-й аргумент
	lea	rsi, .LC4[rip]					# rsi := &(строчка "%c") - 2-й аргумент
	mov	eax, 0						# eax := 0
	call	__isoc99_fscanf@PLT				# fscanf(input, "%c", &data[i]);
	add	r13d, 1					# ++i;
	
.L6:
	mov	rdi, QWORD PTR -32[rbp]			# rdi := input
	call	feof@PLT					# feof(input)
	test	eax, eax					# Проверка eax на значение 0
	je	.L7						# Если eax == 0, то переходим в .L7 
	call	modify@PLT					# modify();
	mov	rsi, QWORD PTR -40[rbp]			# rsi := input - 2-й аргумент
	lea	rdi, data[rip]					# rdi := rbp[-144](data) - 1-й аргумент
	call	fputs@PLT					# fprintf(output, "%s", data); (под капотом вызвалось fputs(data, output);)
	mov	rdi, QWORD PTR -32[rbp]			# rdi := input - 1-й аргумент
	call	fclose@PLT					# fclose(input);
	mov	rdi, QWORD PTR -40[rbp]			# rdi := output - 1-й аргумент
	call	fclose@PLT					# fclose(output);
	mov	eax, 0						# eax := 0
	
.L4:
	leave							# / Выход из функции
	ret							# \

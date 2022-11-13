# IHT2

## 1) Краснослободцев Кирилл Дмитриевич

## 2) БПИ218

## 3) 5 Вариант
Условие: Разработать программу, заменяющую все строчные гласные буквы в заданной ASCII-строке заглавными.

## 4) Тесты
Текстовыые файлы с тестами расположены в папке <b>IHT2/IHT2/Tests</b>. В папке in расположены файлы с тестовыми входными данными. В папке out расположены файлы, которые соответствуют корректным выходным данным (<b>in1.txt</b> -> <b>out1.txt</b>; <b>in2.txt</b> -> <b>out2.txt</b>; <b>in3.txt</b> -> <b>out3.txt</b>). 

## 5) Тестовые прогоны
<p>В папке <b>IHT2/IHT2/Tests/results</b> расположены результаты тестовых прогонов исполняемых файлов, полученных компиляцией C файлов (<b>fromC.exe</b>) и компиляцией отредактированных файлов ассемблера (<b>fromAssem.exe</b>).</p>
<p>Соответствие тестов:</p>
<p><b>fromC.exe</b>: <b>in1.txt</b> -> <b>result1.txt</b>; <b>in2.txt</b> -> <b>result2.txt</b>; <b>in3.txt</b> -> <b>result3.txt</b></p>
<p><b>fromAssem.exe</b>: <b>in1.txt</b> -> <b>result11.txt</b>; <b>in2.txt</b> -> <b>result12.txt</b>; <b>in3.txt</b> -> <b>result13.txt</b></p>
<p>Демонстрация запуска исполняемых файлов на разных входных данных и их соответствие нужному результату могут быть найдены в папке <b>IHT2/IHT2/Screenshots</b>. <b>testC.jpg</b> демонстрирует тестовый прогон исполняемого файла, полученного компиляцией программы на C. <b>testAssem.jpg</b> демонстрирует тестовый прогон исполняемого файла, полученного компиляцией программы на отредактированном ассемблере.</p>

![image](https://user-images.githubusercontent.com/90769620/201541487-1da50b13-7dbf-42d2-bb5a-ff1b1e1f5eaa.png)
![image](https://user-images.githubusercontent.com/90769620/201541492-e19d091f-d067-4690-bf84-a10af041866d.png)

## 6) Исходные тексты программы на C
<p>В папке <b>IHT2/IHT2/C</b> расположены файлы программы на C: <b>main.c</b> и <b>modify.c</b></p>

<b>main.c</b>:

    #include <stdio.h>

     char data[20000];

    extern void modify();

    int main(int argc, char** argv) {
      	FILE* input; 
      	FILE* output;
	    char* instr;
	    char* outstr;

	    if (argc == 3) {
		    instr = argv[1];
		    outstr = argv[2];
	    } else {
		    printf("Incorect number of parameters.");
		    return 1;
	    }

	    if (fopen(instr, "r") == NULL) {
		    printf("Incorrect name of input file.");
		    return 1;
	    }

	    input = fopen(instr, "r");
	    output = fopen(outstr, "w");

        int i = 0;
	    while (!feof(input)) {
		    fscanf(input, "%c", &data[i]);
		    ++i;
	    }

	    modify();

	    fprintf(output, "%s", data);

	    fclose(input);
	    fclose(output);

	    return 0;
    }
    
<b>modify.c</b>:

    #include <string.h>

    char mask[6] = "aeiouy";

    extern char data[20000];

    void modify() {
	    for (int i = 0; i < strlen(data); ++i) {
		    for (int j = 0; j < 6; ++j) {
			    if (data[i] == mask[j]) {
				    data[i] = data[i] - 32;
				    break;
			    }
		    }
	    }
    }

## 7) Тексты программы на языке ассемблера, расширенные комментариями
<p>В папке <b>IHT2/IHT2/Assembler</b> расположены файлы программы на языке ассемблера. В папке <b>beforeRefactor</b> лежат файлы ассемблера до рефакторинга программы за счет оптимизации регистров процессора. В папке <b>afterRefactor</b> лежат файлы ассемблера после рефакторинга программы за счет оптимизации регистров процессора. Комментарии прописаны только для окончательных файлов ассемблера, то есть лежащих в папке <b>afterRefactor</b>.</p>

<b>main.s</b>:

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
			
<b>modify.s</b>:

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
			sub	eax, 32				# eax := eax - 32
			mov	ecx, eax				# ecx := eax
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

## 8) Тексты программы на языке ассемблера
<b>main.s</b>:

      .file "main.c"
      .intel_syntax noprefix
      .text
      .comm data,20000,32
      .section .rodata
      .align 8
    .LC0:
      .string "Incorect number of parameters."
    .LC1:
      .string "r"
    .LC2:
      .string "Incorrect name of input file."
    .LC3:
      .string "w"
    .LC4:
      .string "%c"
      .text
      .globl main
      .type main, @function
    main:
      endbr64
      push rbp
      mov rbp, rsp
      sub rsp, 64
      mov DWORD PTR -52[rbp], edi
      mov QWORD PTR -64[rbp], rsi
      cmp DWORD PTR -52[rbp], 3
      jne .L2
      mov rax, QWORD PTR -64[rbp]
      mov rax, QWORD PTR 8[rax]
      mov QWORD PTR -16[rbp], rax
      mov rax, QWORD PTR -64[rbp]
      mov rax, QWORD PTR 16[rax]
      mov QWORD PTR -24[rbp], rax
      mov rax, QWORD PTR -16[rbp]
      lea rsi, .LC1[rip]
      mov rdi, rax
      call fopen@PLT
      test rax, rax
      jne .L5
      jmp .L8
    .L2:
      lea rdi, .LC0[rip]
      mov eax, 0
      call printf@PLT
      mov eax, 1
      jmp .L4
    .L8:
      lea rdi, .LC2[rip]
      mov eax, 0
      call printf@PLT
      mov eax, 1
      jmp .L4
    .L5:
      mov rax, QWORD PTR -16[rbp]
      lea rsi, .LC1[rip]
      mov rdi, rax
      call fopen@PLT
      mov QWORD PTR -32[rbp], rax
      mov rax, QWORD PTR -24[rbp]
      lea rsi, .LC3[rip]
      mov rdi, rax
      call fopen@PLT
      mov QWORD PTR -40[rbp], rax
      mov DWORD PTR -4[rbp], 0
      jmp .L6
    .L7:
      mov eax, DWORD PTR -4[rbp]
      cdqe
      lea rdx, data[rip]
      add rdx, rax
      mov rax, QWORD PTR -32[rbp]
      lea rsi, .LC4[rip]
      mov rdi, rax
      mov eax, 0
      call __isoc99_fscanf@PLT
      add DWORD PTR -4[rbp], 1
    .L6:
      mov rax, QWORD PTR -32[rbp]
      mov rdi, rax
      call feof@PLT
      test eax, eax
      je .L7
      mov eax, 0
      call modify@PLT
      mov rax, QWORD PTR -40[rbp]
      mov rsi, rax
      lea rdi, data[rip]
      call fputs@PLT
      mov rax, QWORD PTR -32[rbp]
      mov rdi, rax
      call fclose@PLT
      mov rax, QWORD PTR -40[rbp]
      mov rdi, rax
      call fclose@PLT
      mov eax, 0
    .L4:
      leave
      ret
      .size main, .-main
      .ident "GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
      .section .note.GNU-stack,"",@progbits
      .section .note.gnu.property,"a"
      .align 8
      .long 1f - 0f
      .long 4f - 1f
      .long 5
    0:
      .string "GNU"
    1:
      .align 8
      .long 0xc0000002
      .long 3f - 2f
    2:
      .long 0x3
    3:
      .align 8
    4:
    
<b>modify.s</b>:

      .file "modify.c"
      .intel_syntax noprefix
      .text
      .globl mask
      .data
      .type mask, @object
      .size mask, 6
    mask:
      .ascii "aeiouy"
      .text
      .globl modify
      .type modify, @function
    modify:
      endbr64
      push rbp
      mov rbp, rsp
      push rbx
      sub rsp, 24
      mov DWORD PTR -20[rbp], 0
      jmp .L2
    .L7:
      mov DWORD PTR -24[rbp], 0
      jmp .L3
    .L6:
      mov eax, DWORD PTR -20[rbp]
      cdqe
      lea rdx, data[rip]
      movzx edx, BYTE PTR [rax+rdx]
      mov eax, DWORD PTR -24[rbp]
      cdqe
      lea rcx, mask[rip]
      movzx eax, BYTE PTR [rax+rcx]
      cmp dl, al
      jne .L4
      mov eax, DWORD PTR -20[rbp]
      cdqe
      lea rdx, data[rip]
      movzx eax, BYTE PTR [rax+rdx]
      sub eax, 32
      mov ecx, eax
      mov eax, DWORD PTR -20[rbp]
      cdqe
      lea rdx, data[rip]
      mov BYTE PTR [rax+rdx], cl
      jmp .L5
    .L4:
      add DWORD PTR -24[rbp], 1
    .L3:
      cmp DWORD PTR -24[rbp], 5
      jle .L6
    .L5:
      add DWORD PTR -20[rbp], 1
    .L2:
      mov eax, DWORD PTR -20[rbp]
      movsx rbx, eax
      lea rdi, data[rip]
      call strlen@PLT
      cmp rbx, rax
      jb .L7
      nop
      nop
      add rsp, 24
      pop rbx
      pop rbp
      ret
      .size modify, .-modify
      .ident "GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
      .section .note.GNU-stack,"",@progbits
      .section .note.gnu.property,"a"
      .align 8
      .long 1f - 0f
      .long 4f - 1f
      .long 5
    0:
      .string "GNU"
    1:
      .align 8
      .long 0xc0000002
      .long 3f - 2f
    2:
      .long 0x3
    3:
      .align 8
    4:
    
## 9) Дополнительная информация
Для получения ассемблерного кода, была применена следующая команда в терминале
<p>gcc -masm=intel \ 
  <p>-fno-asynchronous-unwind-tables \</p>
  <p>-fno-jump-tables \ </p>
  <p>-fno-stack-protector \ </p>
  <p>-fno-exceptions \ </p>
  <p>./main.c ./modify.c \ </p>
  <p>-S </p>
<p>Полученный ассеблер был вручную избавлен от лишних макросов.</p>
После этого были проведены оптимизации кода на языке ассемблера: из кода modify.s были убраны команды nop, несколько строк типа <p>mov rax, QWORD PTR ...[rbp]</p> <p>mov rdi, rax</p> были заменены на mov rdi, QWORD PTR ...[rbp]
<p>В программе используются локальные переменные, функции с передачей данных через параметры</p>
<p>Был проведен рефакторинг кода на ассемблере за счет оптимизации регистров процессора: -52[rbp] заменен на r12d в main.s, -4[rbp] заменен на r13d в main.s, -20[rbp] заменен на r14d в modify.s, -24[rbp] заменен на r15d в modify.s</p>
<p>В связи с этим удалось достичь уменьшения размеров исполняемых файлов (размеры файлов указаны в файлых <b>IHT2/IHT2/Screenshots/sizeAfterReact</b> и <b>IHT2/IHT2/Screenshots/sizeBeforeReact</b>)</p>

![image](https://user-images.githubusercontent.com/90769620/201541433-d15f5738-2029-4dc8-96ef-a5f7678b73dc.png)
![image](https://user-images.githubusercontent.com/90769620/201541437-a502392f-3493-4ad8-9388-58dac17a4173.png)

<p>Программа реализована в виде двух единиц компиляции.</p>
<p>Используются файлы для ввода данных и вывода результатов. Названия файлов подаются, как параметры командной строки.</p>
<p>Совершена компиляция программы на C и на ассемблере. Запуская исполняемые файлы на тестовых входных данных (расположенных в текстовых файлах) были получены одинаковые корректные результаты. (пункт 5 настоящего отчета).</p>
<p>В коде ассемблера в папке <b>IHT2/IHT2/Assembler/afterRefactor</b> присутствуют коментарии о локальных переменных, передаче параметров в функции, использовании результатов функций, оптимизации за счет регистров процессора.</p>

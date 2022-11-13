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

## 8) Тексты программы на языке ассемблера
<b>main.c</b>:

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
    
<b>modify.c</b>:

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
После этого были проведены оптимизации кода на языке ассемблера: из кода modify.s были убраны команды nop, несколько строк типа <p>mov rax, QWORD PTR -32[rbp]</p> <p>mov rdi, rax</p> были заменены на mov rdi, QWORD PTR -32[rbp]
<p>В программе используются лоакальные переменные, функции с передачей данных через параметры</p>
<p>Был проведен рефакторинг кода на ассемблере за счет оптимизации регистров процессора: -52[rbp] заменен на r12d в main.s, -4[rbp] заменен на r13d в main.s, -20[rbp] заменен на r14d в modify.s, -24[rbp] заменен на r15d в modify.s</p>
<p>В связи с этим удалось достичь уменьшения размеров исполняемых файлов (размеры файлов указаны в файлых <b>IHT2/IHT2/Screenshots/sizeAfterReact</b> и <b>IHT2/IHT2/Screenshots/sizeBeforeReact</b>)</p>

![image](https://user-images.githubusercontent.com/90769620/201541433-d15f5738-2029-4dc8-96ef-a5f7678b73dc.png)
![image](https://user-images.githubusercontent.com/90769620/201541437-a502392f-3493-4ad8-9388-58dac17a4173.png)

<p>Программа реализована в виде двух единиц компиляции.</p>
<p>Используются файлы для ввода данных и вывода результатов. Названия файлов подаются, как параметры командной строки.</p>
<p>Совершена компиляция программы на C и на ассемблере. Запуская исполняемые файлы на тестовых входных данных (расположенных в текстовых файлах) были получены одинаковые корректные результаты. (пункт 5 настоящего отчета).</p>
<p>В коде ассемблера в папке <b>IHT2/IHT2/Assembler/afterRefactor</b> присутствуют коментарии о локальных переменных, передаче параметров в функции, использовании результатов функций, оптимизации за счет регистров процессора.</p>

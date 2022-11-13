#include <stdio.h>

char data[20000];

extern void modify();

FILE* input;
FILE* output;

int main(int argc, char** argv) {
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

	modify(data);

	fprintf(output, "%s", data);

	fclose(input);
	fclose(output);

	return 0;
}

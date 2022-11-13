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

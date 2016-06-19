
#include <stdio.h>
#include "file1.h"
#include "file2.h"

void file1_func1(void) {
	file1_func2();
}

void file1_func2(void) {
	file1_func3();
	file2_func1();
}

void file1_func3(void) {
	return;
}

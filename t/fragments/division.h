#ifndef _DIVISION_H_
#define _DIVISION_H_

#include "person.h"

class Division {
public:
	Division();
	int dividir();
	int divisor;
	int dividirIdadeDaPessoa();

private:
	int numerador;
};

#endif

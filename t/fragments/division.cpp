#include "division.h"

Division::Division(){
	this->numerador = 2;
}

int
Division::dividir(){
	return this->numerador/this->divisor;
}

int
Division::dividirIdadeDaPessoa(){
	Person p(2,1);
	return p.getAge()/this->divisor;
}
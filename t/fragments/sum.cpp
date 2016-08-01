#include <iostream>
#include <math.h>
#include "division.h"

int sum(int a){
    return a+10;
}

int main(){
	Division d;
	d.divisor = 1;
	std::cout << d.dividir() << std::endl;
	std::cout << d.dividirIdadeDaPessoa();

	int ten = 10;
    sum(ten);
    sqrt(ten);
    std::cout << "Chamando a funcao " << std::endl;
}

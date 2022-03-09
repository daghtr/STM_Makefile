#include "stm32f10x.h"
void gpio_output_pin13_init(void)
{
	RCC->APB2ENR |= (1 << 4); //enable clock port c
	GPIOC->CRH &= ~(1 << 20);// clear MODE 13
	GPIOC->CRH &= ~(1 << 22);// clear CNF 13, General purpose output push-pull
	GPIOC->CRH |= 3 << 20; // Output mode, max speed 50 MHz
}

void delay(uint32_t ti)
{
	while(ti--)
	{
		__NOP();
	}
}
int main(void)
{
	gpio_output_pin13_init();
    while(1)
    {
		GPIOC->BSRR = 1 << 13; // set high pin 13
		delay(1000000);
		GPIOC->BRR = 1 << 13; // set low pin 13
		delay(1000000);
    }
}
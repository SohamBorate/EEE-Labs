#include <lpc21xx.h>

void delay1(void) /* 70 ms */
{
    int i, j;
    for(j = 0; j < 700; j++) {
        for(i = 0; i < 10000; i++);
    }
}

void delay2(void) /* 30 ms */
{
    int i, j;
    for(j = 0; j < 300; j++) {
        for(i = 0; i < 10000; i++);
    }
}

int main(void)
{
    IO0DIR = 0x00000004; /* Configure P0.2 as output */
    while(1) {
        IO0SET = 0x00000004; /* Make P0.2 HIGH */
        delay1(); /* Delay */
        IO0CLR = 0x00000004; /* Make P0.2 LOW */
        delay2(); /* Delay */
    }
}

#include <lpc21xx.h>

void delay(void)
{
    int i, j;
    for(j = 0; j < 100; j++) {
        for(i = 0; i < 10000; i++);
    }
}

int main(void)
{
    IO0DIR = 0x00000080; /* Configure P0.7 as output */
    while(1) {
        IO0CLR = 0x00000080; /* Make P0.7 LOW */
        delay(); /* Delay */
        IO0SET = 0x00000080; /* Make P0.7 HIGH */
        delay(); /* Delay */
    }
}

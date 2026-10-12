#include <lpc21xx.h>

void delay(int k) /* k/10 ms */
{
    int i, j;
    for(j = 0; j < k; j++) {
        for(i = 0; i < 10000; i++);
    }
}

int main(void)
{
    IO0DIR = 0x00000004; /* Configure P0.2 as output */
    while(1) {
        IO0SET = 0x00000004; /* Make P0.2 HIGH */
        delay(700); /* Delay */
        IO0CLR = 0x00000004; /* Make P0.2 LOW */
        delay(300); /* Delay */
    }
}

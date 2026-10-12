#include <lpc21xx.h>

void delay(void) /* 100 ms */
{
    for (int j = 0; j < 1000; j++) {
        for(int i = 0; i < 10000; i++);
    }
}

int main(void) {
    IO1DTR = 0x00ff0000; /* Port1 16-23 as output */
    while(1) {
        IO1SET = 0x00010000; /* Port1 16-23 HIGH */
        delay();

        IO1CLR = 0x00010000; /* Port1 16-23 LOW */
        IO1SET = 0x00020000; /* Port1 16-23 HIGH */
        delay();

        IO1CLR = 0x00020000; /* Port1 16-23 LOW */
        IO1SET = 0x00040000; /* Port1 16-23 HIGH */
        delay();

        IO1CLR = 0x00040000; /* Port1 16-23 LOW */
        IO1SET = 0x00080000; /* Port1 16-23 HIGH */
        delay();

        IO1CLR = 0x00080000; /* Port1 16-23 LOW */
        IO1SET = 0x00100000; /* Port1 16-23 HIGH */
        delay();

        IO1CLR = 0x00100000; /* Port1 16-23 LOW */
        IO1SET = 0x00200000; /* Port1 16-23 HIGH */
        delay();

        IO1CLR = 0x00200000; /* Port1 16-23 LOW */
        IO1SET = 0x00400000; /* Port1 16-23 HIGH */
        delay();

        IO1CLR = 0x00400000; /* Port1 16-23 LOW */
        IO1SET = 0x00800000; /* Port1 16-23 HIGH */
        delay();

        IO1CLR = 0x00800000; /* Port1 16-23 LOW */
    }
}

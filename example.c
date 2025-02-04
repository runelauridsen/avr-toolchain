#include <avr/io.h>

int main(void)
{
    UCSR0B = (1 << TXEN0);                      // enable transmitter
    UCSR0C = (1 << UCSZ01) | (1 << UCSZ00);     // 8 data bits, 1 stop bit, no parity

    int baud = 9600;
    int ubrr = (F_CPU / (16ULL * baud)) - 1;    // calculate baud rate register value
    UBRR0L = (ubrr >> 0) & 0xff;                // write low byte of baud rate register
    UBRR0H = (ubrr >> 8) & 0xff;                // write high byte of baud rate register

    while(1)
    {
        char *s = "Hello from example.c\n";
        while (*s)
        {
            while (!(UCSR0A & (1 << UDRE0))); // wait until data register is free
            UDR0 = *s++;                      // write to data register
        }
    }

    return 0;
}

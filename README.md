## Simple 1s Delay using TMR0
This example uses the TMR0 module to generate a 1 sec delay utilizing the internal overflow interrupt
for reference check :

 - [PIC16F877A Data Sheet](https://ww1.microchip.com/downloads/en/devicedoc/39582b.pdf)
 
This program uses the overflow interrupt from TMR0 to inrecment 
a counter that simulates 1 sec of delay using the formula	   
Overflow Time = 4 * Tosc * Prescaler * (256 - TMR0)	   
Where Tosc = (1/4MHz) = 10^-6 s				   
Prescaler = 32 (set in software)			   
TMR0 = 96 (set in software)				   
 So that by repeating the overflow cycle 196 times		   
We obtain a delay of 1 sec


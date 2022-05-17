;*******************************************************************
;* This program uses the overflow interrupt from TMR0 to inrecment *
;*  a counter that simulates 1 sec of delay using the formula	   * 
;*    Overflow Time = 4 * Tosc * Prescaler * (256 - TMR0)	   *
;*    Where Tosc = (1/4MHz) = 10^-6 s				   *
;*	  Prescaler = 32 (set in software)			   *
;*	  TMR0 = 96 (set in software)				   *
;*    So that by repeating the overflow cycle 196 times		   *
;*    We obtain a delay of 1 sec				   *
;*******************************************************************
	  
    
#include <p16f877a.inc>
counter equ 0x20
    org .0
    goto prog
    org .4
    goto isr
prog call bank1
    clrf TRISB		; SET PORTB as output
    movlw B'10000100' 
    movwf OPTION_REG	;Enable Pull Ups and Set TMR 0 Prescaler to 32
    call bank0
    clrf PORTB 
    bsf INTCON,TMR0IE	;Enable Interruption Source TMR0 overflow
    movlw .96		;Initialize TMR0 with 96	
    movwf TMR0
    bsf INTCON,GIE	;Enable Global Interrupts
    clrf counter	;Initialize the counter 
loop
    goto loop		;LOOP
isr			;Interrupt Sub Routine
    movlw .96		;Reset TMR0 to 96 after Overflow
    movwf TMR0
    bcf INTCON,TMR0IF	;Clear the TMR0 overflow interrupt flag
    incf counter,f	;increment the counter by 1
    movlw .196		
    subwf counter,w	;Subtract 196 (working register) from the counter
    btfss STATUS,Z	;Check if the counter has reached 196 (Z=1) 
    retfie		;Return from interrupt to loop
    comf PORTB,f	;if the counter reached 196 (1 second IRL Time) Switch the state of PORTB
    clrf counter
    retfie  
bank0			;Subroutine for changing to bank0
    bcf STATUS,RP0  
    bcf STATUS,RP1
    return
bank1			;Subroutine for changing to bank1
    bsf STATUS,RP0
    bcf STATUS,RP1
    return
    end
    



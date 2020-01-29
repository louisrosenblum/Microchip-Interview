; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR

   ; Define variables
   FVRCON EQU 0x0117
   DAC1CON0 EQU 0x0118
   DAC1CON1 EQU 0x0119
 
   PORTA EQU 0x000C
   LATA EQU 0x010C
   ANSELA EQU 0x18C
   TRISA EQU 0x008C
 
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    mainLoop                  ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

mainLoop

    GOTO $                          ; loop forever
    
    ; Disable watchdog
    ; PIC16F1788 Configuration Bit Settings
    ; Assembly source line config statements
    #include "p16f1788.inc"

    ; CONFIG1
    ; __config 0xFFE7
     __CONFIG _CONFIG1, _FOSC_ECH & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_ON & _FCMEN_ON
    ; CONFIG2
    ; __config 0xFFFF
     __CONFIG _CONFIG2, _WRT_OFF & _VCAPEN_OFF & _PLLEN_ON & _STVREN_ON & _BORV_LO & _LPBOR_OFF & _LVP_ON
     
    ; --From Datasheet-- 
    ; This code example illustrates
    ; initializing the PORTA register. The
    ; other ports are initialized in the same
    ; manner.
    BANKSEL PORTA ;
    CLRF PORTA ;Init PORTA
    BANKSEL LATA ;Data Latch
    CLRF LATA ;
    BANKSEL ANSELA ;
    CLRF ANSELA ;digital I/O
    BANKSEL TRISA ;
    MOVLW 0b00000000 ; Set all of PORTA as outputs
    MOVWF TRISA
    
    ; Enable fixed voltage reference, use 2.048V
    MOVF 0b11101000,  FVRCON
    
    ; Enable DAC as output on DAC1OUT1, use FVR. Enable temperature indicator, high range.
    MOVF 0b10101000, DAC1CON0
    
    ; Set DAC1OUT1 to 1.5V
    MOVF 0x00BC, DAC1CON1

    END
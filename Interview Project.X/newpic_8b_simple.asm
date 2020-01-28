; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

_Startup
 
    ; Disable watchdog
    ; Set bits 4-3 in CONFIG1 to 00
    LDA $8007
    BCLR 
    
 
mainLoop

    GOTO $                          ; loop forever

    END
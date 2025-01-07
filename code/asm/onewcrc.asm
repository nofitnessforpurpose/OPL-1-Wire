/****************************************************************/
/*								*/
/*	Maxim 1-Wire CRC for OPL-1-Wire				*/
/*	(c) NotForPurpose					*/
/*								*/
/*								*/
/*		Rev 0.10	04/01/2024			*/
/*								*/
/****************************************************************/
;
;---------------------------------------
;
; Entry to the routine the D register is supplied with the string location
; Exit from the routine returns the CRC in the lower byte of the X register
;
;-------------------------------------------------------------------------------
; CPU Register configuration
;
;               High Byte             Low Byte
;          +-----------------+   +-----------------+
;          |        A        |   |       B         | Accumulator               
;          | 7 6 5 4 3 2 1 0 |   | 7 6 5 4 3 2 1 0 |
;          +-----------------+---+-----------------+
;          |                   D                   | or 16 bit Accumulator     
;          +---------------------------------------+
;          +---------------------------------------+
;          |                   X                   |                            
;          +---------------------------------------+
;          +---------------------------------------+
;          |                   SP                  |                            
;          +---------------------------------------+
;          +---------------------------------------+
;          |                   PC                  |
;          +---------------------------------------+
;                                +-----------------+
;                                |  1 H I N Z V C  | CCR Condition Code Reg.   
;                                +-----------------+
;                                    : : : : : :                              
;                                    : : : : : +---- Carry                     
;                                    : : : : +------ Over flow                 
;                                    : : : +-------- Zero                      
;                                    : : +---------- Negative                  
;                                    : +------------ Interrupt                 
;                                    +-------------- Half carry      
;   
;-------------------------------------------------------------------------------
;
#include "osvars.inc"		; Contains the MKII operating system variables.
#include "oseror.inc"		; Contains all the operating system errors.
#include "oshead.inc"		; Contains constants and macros for the MKII operating system.
#include "swi.inc"		; Contains the MK2 SWI's. (Software Interrupt Vectors)

; Default config options
;
	.org 000		; Sets address assembly will start (or continue)
	.radix 10		; Sets the default base used by the assembler
;

; Provide with a string pointer in the D register
; A String is length byte followed by string content e.g. STRcrc = 0x07 0x10 0x50 0xA9 0x0A 0x02 0x08 0x00
; The CRC should return 0x37 (55 d) 
; Note: The input string is not null terminated
; 
start:

        xgdx                ; Move D to X - On entry, D contained the string location	
        lda     a,^x00,x    ; Load (length byte) into A
        clr     b           ; clear the b register for the (crc) value

loop:
        psh     a           ; +S1 - Save (length byte) on stack 
        inx                 ; Make X Point to the next character in the string
        lda     a,^x00,x    ; Load (character byte) into A
        psh     a           ; +S2 - Save (original character) byte on stack 
    
        lda     a,#^x08     ; Set loop counter for 8 bits in a register

bitloop:
        psh     a           ; +S3 - Save (bit counter) in a on stack 

        ; Perform the CRC calculation on the byte in b
        tba                 ; transfer a copy of the (crc) to the a register
        lsr     b           ; Shift right the (crc) byte i.e. crc = crc / 2
        eor     a,^x00,x    ; Exclusive-Or a register current (crc) with buffer character pointed to by x
        bit     a,#^x01     ; was the lsb set of the previous XOR operation
        beq     no_xor      ; if bit was not set then don't do an Exclusive Or
        eor     b,#^x8C     ; XOR b register (crc) with the polynomial

no_xor:
        lsr     ^x00,x      ; Shift right the input character right (directly in the source string)
        pul     a           ; -S3 - restore the (bit counter) from the stack
        dec     a           ; Decrement bit loop counter
        bne     bitloop     ; Repeat until all 8 bits are processed i.e. (bit counter) a = 0

        ; Processing of the byte completed  
        pul     a           ; -S2 - Get (original character) from stack 
        sta     a,^x00,x    ; Restore the input strings orginal character
    
        pul     a           ; -S1 - Restore (length byte) from stack
        dec     a           ; Decrement byte length counter, leaving it in register a
        bne     loop        ; Repeat until all characters are processed i.e. (byte counter) a = 0

        ; At this point a (length byte) should be zero and (current crc) is in b (a and b form the D register)
done:
        xgdx		    ; swap the D and X register to return the result in the X register to OPL
        rts

.end

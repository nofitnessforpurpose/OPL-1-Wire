/****************************************************************/
/*								*/
/*	Sendbyte 						*/
/*	(c) NoFitnessForPurpose					*/
/*								*/
/*								*/
/*		Rev 0.10	23/12/2024			*/
/*								*/
/****************************************************************/
;
;---------------------------------------
;
; Entry to the routine the D register is supplied with the string location
; Exit from the routine returns the CRC in the lower byte of the X register
;
;-------------------------------------------------------------------------------
;		
; See 	https://www.jaapsch.net/psion/tech04.htm#p4.2
;     	DATA BUS (PROCESSOR PORT 2)
;     	https://www.jaapsch.net/psion/tech04.htm#p4.5
;     	CONTROL LINES (PROCESSOR PORT 6)
;
; PORT 2 DDR address 0x0001
; PORT 2 State address 0x0003
;
; PORT 2
; *3  D3 - I/P - 8  - 0x08
;  4  D2 - I/P - 4  - 0x04
;  5  D0 - O/P - 1  - 0x01
; *6  D4 - O/P - 16 - 0x10
;---------------------------------------
;
#include "osvars.inc"		; Contains the MKII operating system variables.
#include "oseror.inc"		; Contains all the operating system errors.
#include "oshead.inc"		; Contains constants and macros for the MKII operating system.
#include "swi.inc"			; Contains the MK2 SWI's. (Software Interrupt Vectors)

; Default config options
;
	.org 000		; Sets address assembly will start (or continue)
	.radix 10		; Sets the default base used by the assembler
;

;
start:
;
;-------------------------------------------------------------------------------
sndbyte:
;	Assumes
;	Top slot activated and DDR for port 2 configured as o/p
;       Note port is left powered on purpose
;       A is a local register, trashed as needed
;       B holds the character byte to be sent
;       X is configured as a bit counter


	ldx	#^x0009		; Set the bit counter in X to 8 bits + 1 to send
	
; - nextbit
21$:
	dex			; Decrement X and test to see if we have sent all the bits
	beq	27$		; If X=0 we have Sent all bits exit the routine

	bit	b,#^x01		; Test the least significant bit of B (send LSB to MSB)
	bne	22$		; It's a one so jump to send a one bit
	bra	25$		; It was a zero so jump to send a zero bit

;- one
22$:
	; Set 1 to 15 uS pulse low followed by 55 uS delay (65 uS total)
	lda	a,#^xEF		; load a with value to set D4 low
	sta	a,POB_PORT2:	; ~ 15 uS low including code overhead
	        
	lda	a,#^x01		; Short period low
; - loop counter
23$:	dec	a
	bne	23$		; if count not reached keep looping ~2 uS per loop
	lda	a,#^xFF		; Set line high for remainder of period
	sta	a,POB_PORT2:

	lda	a,#^x0B		; At 4 uS per loop 12 counts = 48 uS plus code overhead + 7 uS
; - loop counter
24$:	dec	a
	bne	24$		; if count not reached keep looping ~2 uS per loop
	ror	b		; rotate B so the next bit is ready to send
	bra	21$             ; send next bit or exit

; - zero
25$:
	; Set 60 uS pulse low followed by 60 to 120 + 5 uS
	lda 	a,#^xEF		; load a with value to set D4 low
	sta	a,POB_PORT2:	; 120 uS low including code overhead

	lda	a,#^x1C	        ; At 4 uS per loop 28 counts =  112 uS plus code overhead + 7 uS
; - loop counter
26$:	dec	a
	bne	26$	        ; if count not reached keep looping ~2 uS per loop
	lda	a,#^xFF
	sta	a,POB_PORT2:		

	ror	b		; rotate B so the next bit is ready to send
        bra	21$             ; send next bit or exit

; - exit
27$:		
	rts         	   	; Return (to OPL).
;-------------------------------------------------------------------------------


;
	.end

/****************************************************************/
/*								*/
/*	1-Wire - Read Bytes   					*/
/*	(c) NoFitnessForPurpose					*/
/*								*/
/*								*/
/*		Rev 0.10	11/12/2024			*/
/*								*/
/****************************************************************/
;
;---------------------------------------
;
; Entry to the routine the D register is supplied with the string location
; Exit from the routine returns the start of the string address in the X register
;
;-------------------------------------------------------------------------------
; Assumes Top Slot is already powered
;
;
;          Top Slot Connector
;          15 13 11  9  7  5  3  1
;          16 14 12 10  8  6  4  2 
;
;          Pin 	Signal 	Description
;          1 	SD7 	Data Bit 7
;          2 	SD0 	Data Bit 0
;          3 	SD6 	Data Bit 6
;          4 	SD1 	Data Bit 1
;          5 	SD5 	Data Bit 5
;          6 	SD2 	Data Bit 2
;          7 	SD4 	Data Bit 4
;          8 	SD3 	Data Bit 3
;          9 	GND 	0 Volts
;          10 	SCK 	Serial clock
;          11 	SVB 	External Power Input / Battery Output Voltage - 0.6 Volt
;          12 	SS3 	Slot Select 3
;          13 	SCVV 	+5 Volts
;          14 	AC 	External On/Clear
;          15 	SOE 	Output enable
;          16 	SMR 	Master Reset
;
;
;
;          Port 6 - Data Register $17
;          bit 7	PACON_B
;          bit 6	SS3_B
;          bit 5	SS2_B
;          bit 4	SS1_B
;	   bit 3	SOE_B
;	   bit 2	SPGM_B
;	   bit 1	SMR
;	   bit 0	SCK	
;
;    
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
;-------------------------------------------------------------------------------;
;
; Pin  Func
;  1  	+5v
;  2  	0v
; *3  	D3 - I/P - 8
;  4  	D2 - I/P - 4
;  5  	D0 - I/P - 1
; *6  	D4 - I/P - 16
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

;
;
start:
;
;	Top slot activated and DDR for port 2 configured as o/p
;       Note port is left powered on purpose
;       A is a local register, trashed as needed
;	D register is supplied with string buffer address when routine called
;       X points to the string where bits are stored - supplied to this routine
;	The first byte (not length byte) is the number of bits to be read
;       Make sure X is longer than B - bits

	xgdx			; Swap the D register into the X register - D is buffer string address
	pshx			; +SP1 - Store the X register to return to calling routine on exit
	lda	b,^x01,X	; load b with the number of bits to read from input string

nextbit:
	inx			; Point to next string location to store a read bit at
	dec	b		; Decrement b and test to see if we have read all the bits
	beq	exit		; If B=0 we have received all bits needed
	bra	one		; Read a bit - Reads at least 1 bit or line state
        nop
        nop

one:
	; Set 1 to 15 uS pulse low followed by 55 uS delay (65 uS total)
	lda	a,#^xEF		; load a with value to set D4 low
	sta	a,POB_PORT2:	; 	        

	lda	a,#^x01		; Short period low  - ~15 uS low including code overhead
loop1:	
	dec	a
	bne	loop1		; if count not reached keep looping ~4 uS per loop
	lda	a,#^xFF		; Set line high for remainder of period - also allows read of bit
	sta	a,POB_PORT2:

	nop		        ; At ~1 uS per nop  = 5 uS plus code overhead + 7 uS
        nop
        nop
        nop
        nop
loop2:

	lda	a,POB_PORT2:	; Read the top slot port
        nop
        nop
        nop
        nop
        nop
        nop
        sta     a,^01,x         ; store the byte into the string
				; - Allow a period for the target to complete its bit period
	lda	a,#^x06		; At ~4 uS per loop 12 counts = 24 uS plus code overhead + 7 uS
loop3:
	dec	a
	bne	loop3		; If count not reached keep looping ~4 uS per loop
        bra	nextbit		; send next bit or exit

exit:		
	pulx			; -S1 - Return the string address
	rts			; return to OPL
;
.end


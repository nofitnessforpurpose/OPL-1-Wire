/****************************************************************/
/*								*/
/*	One Wire Reset Pulse				*/
/*	(c) NotForPurpose					*/
/*								*/
/*								*/
/*		Rev 0.10	22/12/2024			*/
/*								*/
/****************************************************************/
;
; Create a 1-Wire reset pulse and returns the status
; Assumes Top slot selected and interface set (PON & IOB1WSET)
;
;---------------------------------------
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
; Note the original macro assembler is broken for oim and aim hence .byte
;
;-------------------------------------------------------------------------------
;
;-------------------------------------------------------------------------------
; CPU Register configuration
;
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
#include "osvars.inc"
#include "oseror.inc"
#include "oshead.inc"			
#include "swi.inc"

	.org 000
	.radix 10
;
;
start:

rsp:                            ; Send reset pulse

	aim 	#^xEF,POB_PORT2: ; PORT 2 - D4 Pull line low for reset using AND to only clear 4


	lda	a,#^x6B		; Load a with 480 uS delay count at 4.5 uS per iteration
;resetlow
11$:
	dec 	a
	bne 	11$		; If not zero count keep looping ~ 4uS per loop
                         	; D3 High - Set Top Slot As Input allowing line to float as inputs
	oim 	#^x10,POB_PORT2: ;

	
				; Post reset delay pulse
	lda	a,#^x1A		; A as loop ctr > 28 uS - Post Rst Pls Prd i.e. tPDH
                                ; postrst

12$:
	dec 	a
	bne 	12$		; If not zero count keep looping ~ 4uS per loop
		
	lda	b,^x03:		; Rd Port %03 - 
	and 	b,#^x08		; Was D3 pulled low
	psh	b		; +S1 - store result on stack

				; 500 uS Post test recharge
	lda 	a,#^x6F
13$:
	dec 	a
	bne 	13$		; If not zero count keep looping ~ 4uS per loop

	pul	b		; -S1 = Retrieve result from stack - returned to OPL
        xgdx		        ; swap the D and X register to return the result in the X register to OPL
	rts            	        ; Return (to OPL).

.end
;-------------------------------------------------------------------------------

/****************************************************************/
/*								*/
/*	Top Slot State Set						*/
/*	(c) NotForPurpose					*/
/*								*/
/*								*/
/*		Rev 0.10	22/12/2024			*/
/*								*/
/****************************************************************/
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
;
;
; Following slot activation via PK$SETP Slot has +5V for 50 ms
; Set bits SS-0x40, SOE-0x08 etc via OIM ak;a OR Immediate
; via AND Immediate set SS-Low
; CE-HW Active Low = VCC=1 + SS-L=0 + SOE=1
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
start:
	oim	#^x40, POB_PORT6:
	oim	#^x08, POB_PORT6:
	aim	#^xBF, POB_PORT6:

	oim	#^x03, POB_DDR2:	 ; DDR - Set Input / Output direction PORT 2 DDR
	oim	#^x11, POB_PORT2:	 ; Set PORT 2 bit D0 and D4 High

; Note we leave the TOP slot powered to continuously power the 1-Wire system	

	rts		; return to OPL
;
.end

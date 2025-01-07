/****************************************************************/
/*								*/
/*	Top Slot ON						*/
/*	(c) NotForPurpose					*/
/*								*/
/*								*/
/*		Rev 0.10	22/12/2024			*/
/*								*/
/****************************************************************/
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
	lda	b,#^x03		; Pack 3
	os	PK$SETP		; Select the pack
	ldx	#kbb_pkof	; Load x register with address
	lda	a,#^x00		; Load a with mode i.e. always on
	sta	a,0,x		; Write pack always on
		
;
;	Top slot is now activated
;       Note its left on on purpose
	rts		; return to OPL
;
.end

/****************************************************************/
/*								*/
/*	Top Slot OFF						*/
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
start:
	lda	a,#^x00		; Value to be written to PORT 2
	sta	a,POB_PORT2:	; Write 0 to PORT 2 - Set Data Lines Low
       	aim 	#^xFC,POB_DDR2: ; Set Top Slot to Input
	lda     b,#^x03	        ; Pack 3
	os      PK$PKOF         ; Select the pack
	ldx     #kbb_pkof       ; Load x register with address
	lda     a,#^x01	        ; Load a with mode i.e. always on
	sta     a,^x00,x	; Write pack always on
		
;
;	Top slot is now powered off
;       Note the kbb_pkof location set to 1 signifying packs may be powered down

	rts			; return to OPL
;
.end

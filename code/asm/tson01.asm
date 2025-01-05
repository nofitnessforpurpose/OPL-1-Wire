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
#include "osvars.inc"
#include "oseror.inc"
#include "oshead.inc"			
#include "swi.inc"

	.org 000
	.radix 10
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

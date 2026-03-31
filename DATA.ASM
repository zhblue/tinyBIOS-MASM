	;
	; BIOS configuration data
	;
	; (C)1997-2001 Pascal Dornier / PC Engines; All rights reserved.
	; This file is licensed pursuant to the COMMON PUBLIC LICENSE 0.5.
	;
	; This data is modified to store system configuration, such as
	; PCI data, hard disk parameters, etc.
	;
	; pd 991020 add hd_top
	;
	even
	db	"_DAT"	;header for checksum utility
	dw	d_sum-d_beg	;pointer to checksum
	
d_beg:			;start of data	
	;
	; Hard disk parameters
	;
hd_prm0
DB		dpt_len DUP (0)
hd_prm1
DB		dpt_len DUP (0)
hd_top
DB		82h	
	;
	; PCI data
	;
	
	; this is a procedure to avoid problems in protected mode access...
	
getlbus
DB		0b0h	
d_lastbus
DB 	0	
	ret

IFDEF CDBOOT
	even
d_cdlba
DW		0,0	
d_cdbase
DW		0	
d_cddrv
DB		0b0h	
d_cdsec
DB		15	
d_cdflag
DB		0	

ENDIF
	;
	; Data checksum
	;
d_sum
DB		0	
			;(filled in by utility)
	;
	; calculate data checksum
	;
d_dosum:	
IFNDEF M6117
	wbinvd		;write back cache
ENDIF
	mov	al,0
	mov	si,offset d_beg
	mov	cx,d_sum-d_beg
d_dosum1:	add 	al,[cs:si]	;calculate checksum
	inc	si
	loop	d_dosum1
	neg	al
	mov 	[cs:si],al
IFNDEF M6117
	wbinvd
ENDIF
	ret

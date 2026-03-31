	;
	; BIOS messages
	;
	; (C)1997-2001 Pascal Dornier / PC Engines; All rights reserved.
	; This file is licensed pursuant to the COMMON PUBLIC LICENSE 0.5.
	;
	; DO NOT DELETE the following string ! (does not need to be displayed)
	db	"tinyBIOS V1.3a (C)1997-2001 PC Engines",13,10,10,0
	;
	; Error messages
	;
msg_parit:
DB 	"Parity Error !",13,10,0
msg_iochk
DB 	"I/O channel NMI !",13,10,0
msg_halt
DB		"System halted.",0
msg_noboot
DB 	"No boot device available, press Enter to continue.",13,10,0
msg_base
DB		" KB Base Memory",13,10,0
msg_ext
DB 		" KB Extended Memory",13,10,0
msg_crlf
DB		13,10,0
msg_kbd
DB		"Keyboard failure.",13,10,0
msg_bs
DB		8,8,8,8,8,0

IFDEF HD_WAIT
msg_wait
DB		"Waiting for HDD "
msg_dot
DB		".",0
ENDIF

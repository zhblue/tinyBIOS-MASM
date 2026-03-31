	;
	; TinyBIOS, configured for ALI M6117
	;
	; (C)1998-2001 Pascal Dornier / PC Engines; All rights reserved.
	; This file is licensed pursuant to the COMMON PUBLIC LICENSE 0.5.
	;

; start offset
	
.686
_TEXT SEGMENT PARA PUBLIC USE16 'CODE'
ORG 0

STARTOFS = 0C000h
db STARTOFS DUP (0)

BOOTBEEP:			;enables beep on bootup

;DEBUG:			;debug mode (Int 13 trace etc).

;NO_NMI:			;disable NMI code

;NO_RTCFAIL:		;skip hang on RTC failure

;QUICKMEM:			;no memory test (fill only)

; hard disk, boot options

BOOT_AC:			;Boot A: first, then C:
			;comment out for C: then A:

HD_WAIT	equ	20	;Hard disk wait, max. x seconds
HD_ENA	equ	3	;don't check HDD status before x seconds

HDD_LBA:			;enable LBA support

;HDD_NOSLAVE:		;don't look (and wait) for slave device

;HD_TIME	equ	080	;commented out = HDD power down disabled
			;0 = code included, but no timeout
			;1..240 = timeout x * 5 s units
			;241..251 = timeout (x-240)*30 min

; keyboard options

;NO_KBC:			;don't fail if KBC not present

LED_UPDATE:		;Define to enable keyboard LED updates
			;(NumLock, CapsLock, ScrollLock).
			;Not recommended for real-time apps.

KEY_RATE	equ	0102h	;key repeat rate
			;500 ms delay, 20 / second

; serial port options

;CONSOLE	equ	003E8	;serial port for console = COM3
;CONINT	equ	4	;interrupt for console

; PCI options - NOT APPLICABLE

; platform specific options

;FLASHDISK:			;enable flash disk

M6117C:			;include M6117C registers

;M6117B:			;M6117B config register patch

	;
	; Signon prompt
	;
copyrt:
DB		"ALI M6117C",13,10
INCLUDE ..\message.ASM
	;
	; Include files
	;	
INCLUDE ..\equ.ASM;general equates
INCLUDE m6117.ASM;chipset / system specific code
INCLUDE sio_none.ASM;super I/O initialization
INCLUDE ..\post.ASM;POST
INCLUDE ..\post2.ASM;POST routines
INCLUDE ..\debug.ASM;& Debug routines, comment out
INCLUDE ..\vid.ASM;video BIOS
INCLUDE ..\int1x.ASM;miscellaneous interrupts
INCLUDE ..\fdd.ASM;floppy BIOS
INCLUDE ..\hdd.ASM;hard disk BIOS
INCLUDE ..\com.ASM;serial BIOS
INCLUDE ..\kbd.ASM;keyboard BIOS
INCLUDE ..\kbtab.ASM;keyboard table
IFDEF FLASHDISK
INCLUDE sstdisk.ASM;SST 28SF040 flash disk
ENDIF
INCLUDE ..\lpt.ASM;printer BIOS
INCLUDE ..\rtc.ASM;timer / RTC BIOS
;non-PCI	include ..\pci.8	;PCI BIOS
;non-PCI	include	..\pcipnp.8	;PCI plug & play
	;
	; OEM decision: verify diagnostic flags to decide
	; whether to boot or display error messages
	;
decide:	
	;cmp	byte [tmp_rtc],0	;1 -> RTC battery failure
	;cmp	byte [tmp_tim],0	;1 -> timer / RTC update failure
			;(see above)
	;cmp	byte [tmp_kbfail],0	;1 -> keyboard failure
	;cmp	byte [m_fdmed0],0	;0 -> floppy failure / not present
	
ret
	;
	; INT 10 legacy entry point
	;
db	0f065h-$ DUP (0ffh)	;required for Genoa VGA and SPEEDCOM
iret		;benchmark test
	;
	; INT 1A legacy entry point
	;
db	(0fe6e-$) DUP (0ffh)	;explicitly documented in the
jmp	int1a	;PCI BIOS spec.
	;
	; BIOS writeable configuration data
	;
INCLUDE ..\data.ASM
	;
	; PCI interrupt assignment table - NOT APPLICABLE
	;
INCLUDE ..\tables.ASM;ISA initialization tables
INCLUDE ..\reset.ASM;reset vector

END
_TEXT SEGMENT PARA PUBLIC USE16 "CODE"
ORG 0

ret_sp MACRO arg1
	LOCAL _m1
	mov sp,OFFSET _m1
	jmp arg1
_m1 LABEL WORD
	DW $ + 2
ENDM

test_label:
ret_sp test_target
db 0

test_target:
db 0

_TEXT ENDS
END

_TEXT SEGMENT PARA PUBLIC USE16 "CODE"
ORG 0

m_rstflg EQU 472h

rstmem5: mov [ds:0472h], dx
db 0

_TEXT ENDS
END

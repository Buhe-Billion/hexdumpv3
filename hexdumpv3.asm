;DESCRIPTION                : Witness the power of an %include
;Architecture               : X86-64
;CPU                        : Intel® Core™2 Duo CPU T6570 @ 2.10GHz × 2

SECTION .text

%MACRO EXITMACRO 2
MOV RSP,RBP
POP RBP

MOV RAX,%1
MOV RDI,%2
SYSCALL
%ENDMACRO

%INCLUDE "textlib.asm"

GLOBAL _start

_start:
      MOV RBP,RSP     ;Tis but for debugging

      XOR R15,R15
      XOR RSI,RSI
      XOR RCX,RCX

      CALL LOADBUFF
      CMP R15,0
      JBE EXIT

SCAN:
      XOR RAX,RAX
      MOV AL,[BUFF+RCX]
      MOV RDX,RSI
      AND RDX,000000000000000Fh
      CALL DUMPCHAR

      INC RSI
      INC RCX
      CMP RCX,R15
      JB .MODTEST
      CALL LOADBUFF
      CMP R15,0
      JBE DONE

.MODTEST:
      TEST RSI,000000000000000Fh
      JNZ SCAN
      CALL PRINTLINE
      CALL CLEARLINE
      JMP SCAN

DONE:
      CALL PRINTLINE

EXIT:
      EXITMACRO EXIT_SYSCALL,OK_RET_VAL

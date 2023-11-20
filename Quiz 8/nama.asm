.MODEL SMALL
.CODE
ORG 100h
START:
    JMP PRINT
    Data_Diri   DB '+============================+',13,10
                DB '|  Mohammad Farid Hendianto  |',13,10
                DB '|         2200018401         |',13,10
                DB '|        MATA  KULIAH        |',13,10
                DB '|   Dasar Sistem Komputer    |',13,10
                DB '+============================+','$'
PRINT:
    mov ah,09h
    mov dx,OFFSET Data_Diri
    int 21h
SELESAI:
    int 20h
END START
    
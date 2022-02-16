.data
STR: .space 48 ;# 3*16 prende il 1° scanf  
stack: .space 32
msg1: .asciiz "inserire una stringa di soli numeri\n"
msg2: .asciiz "inserire un numero ad una cifra\n"
msg3: .asciiz "Numero di occorrenze del numero %d : %d\n" ;# args N, R

p1sys5: .space 8
N: .space 8 ;# 1 int, prende il 2° scanf (sempre 1, si sovrascrive)
R: .space 8

p1sys3: .word 0
ind: .space 8
dim: .word 16 ;#può leggere max 16 byte, ovvero STR; anche 8(N) ok

.code 
;#init stack
daddi $sp,$0,stack
daddi $sp,$sp,32

;# for i<3
daddi $s0,$0,0 ;# i=0
for: 
    slti $t0,$s0,48 ;# $t0=0 quando $s0(=i) >= 48 (3*16), quando < è 1
    beq $t0,$0,fine ;# quando $t0 = 0, fine loop for
    ;# printf msg1
    daddi $t0,$0,msg1
    sd $t0,p1sys5($0)
    daddi r14,$0,p1sys5
    syscall 5
    ;# scanf %s, STR[i]
    daddi $t0, $s0, STR ;# $t0 = STR[i]
    sd $t0, ind($0)
    daddi r14,$0,p1sys3
    syscall 3
    move $s1,r1 ;# $s1 = strlen STR[i]
    ;#printf msg2
    daddi $t0,$0,msg2
    sd $to,p1sys5($0)
    daddi r14, $0,p1sys5
    syscall 5
    ;#scanf %d,N
    jal input_unsigned ;# include input_unsigned.s
    move $s2,r1 ;# $s2 = N

    ;# R = esegui (STR[i],strlen, N)
    daddi $a0,$s0,STR ;# $a0 = STR[i] con i=$s0 
    move $a1,$s1 ;# $a1 = strlen
    move $a2, $s2 ;# $a2 = N
    jal esegui

    ;# print msg3 con args N R
    sd r1,R($0)
    sd $s2,N($0)
    daddi $t0,$0,msg3
    sd $t0,p1sys5($0)
    daddi r14,$0,p1sys5
    syscall 5

    ;#incremento for
    daddi $so,$s0,16 ;# i++
    j for

fine: syscall 0

esegui:
    daddi $sp,$sp,-16
    sd $s0,0($sp) ;#str
    sd $s1,8($sp) ;#strlen
     
    daddi $s0,$0,0 ;#conta = 0
    daddi $s1,$0,0 ;#i=0 (i della funzione per scorrere str)
for_esegui: 
    slt $t0,$s1,$a1 ;# $t0=0 quando $s1 (i) >= $a1 (strlen)
    beq $t0,$0,return ;# return quando $t0 = 0

    ;#if str[i]-48== c (N)
    dadd $t0,$a0,$s1 ;# $t0=&str[i]
    lbu $t1,0($t0) ;# $t1 = str[i]
    daddi $t1,$t1,-48
    bne $t1,$a2,incr_i ;#se $t1 (str[i] !== $a2 (N) --> continuo for, incremento i; se no incremento conta e poi vado a incr_i
incr_i:
    daddi $s1,$s1,1 ;# i++
    j for_esegui
return:
    move r1,$s0 ;# return conta fine for

    ld $s0,0($sp)
    ld $s1,8($sp)
    daddi $sp,$sp,16

    jr $ra

#include input_unsigned.s


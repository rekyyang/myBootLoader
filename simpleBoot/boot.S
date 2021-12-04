#define BOOTSEG 0x07C0
          .code16
          .section ".bstext", "ax"
          .global bootsect_start
  bootsect_start:
  
          # Normalize the start address
          ljmp    $BOOTSEG, $start2
  
  start2:
          # initial stack & data seg
          movw    %cs, %ax
          movw    %ax, %ds
          movw    %ax, %es
          movw    %ax, %ss
          xorw    %sp, %sp
          # set interpret
          sti
          # set direct flag
          cld
  
          movw    $bugger_off_msg, %si
  
  msg_loop:
          # load btye form *si, and si++
          lodsb
          # check end?
          andb    %al, %al
          # when end, jump
          jz      bs_die
          # prepare param for 0x10
          movb    $0xe, %ah
          movw    $7, %bx
          int     $0x10
          jmp     msg_loop
  
  bs_die:
          # Allow the user to press a key, then reboot
          xorw    %ax, %ax
          # wait for key press
          int     $0x16
          # reload img
          int     $0x19
  
          # int 0x19 should never return.  In case it does anyway,
          # invoke the BIOS reset code...
          ljmp    $0xf000,$0xfff0
  
  bugger_off_msg:
          .ascii  "My Boot!\r\n"
          .ascii  "by rekyyang\r\n"
          .ascii  "\n"
          .byte   0
 
          .org 510
          .word 0xAA55
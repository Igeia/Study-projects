;        Basic Instruction Set                      b.sm

         ;==============================================
         ; Fetch machine instruction, increment pc

fetch:   a.pc c.mar
         a.pc add b.1 c.pc rd

         ;==============================================
         ; Decode instruction
         ; How to proceed:
         ; 1) Analyze the first bit by adding 0 to it. If the n (negative) flag is 1, set the 1st bit to 1 and jump to L1; else execute the next instruction;
         ; 2) Shift left logically by 1 bit the next bit in the opcode from the instruction register;
         ; 3) Analyze the shifted out bit. If it's 1, set the bit to 1 and jump to the next label; else execute the next instruction;
         ; 4) Repeat steps 2 and 3 until the analysis of all 4 bits is complete.
         ; We are done: all 4 bits are decoded, we can now execute the necessary machine instruction.

         a.mdr add b.0 c.ir neg@L1
L0:      a.ir sll b.1 c.dc neg@L01
L00:     a.dc sll b.1 c.dc neg@L001
L000:    a.dc sll b.1 c.dc neg@L0001
         br@L0000

L1:      a.ir sll b.1 c.dc neg@L11
L10:     a.dc sll b.1 c.dc neg@L101
L100:    a.dc sll b.1 c.dc neg@L1001
         br@L1000

L01:     a.dc sll b.1 c.dc neg@L011
L010:    a.dc sll b.1 c.dc neg@L0101
         br@L0100

L11:     a.dc sll b.1 c.dc neg@L111
L110:    a.dc sll b.1 c.dc neg@L1101
         br@L1100

L001:    a.dc sll b.1 c.dc neg@L0011
         br@L0010

L011:    a.dc sll b.1 c.dc neg@L0111
         br@L0110

L101:    a.dc sll b.1 c.dc neg@L1011
         br@L1010

L111:    a.dc sll b.1 c.dc neg@L1111
         br@L1110

         ;==============================================
         ; Interpret machine instruction

L0000:   ; ld ==========================================
         a.ir and b.m12 c.mar    ; extract the address, place into mar
         rd                      ; read the data in mdr
         a.mdr c.ac br@fetch     ; copy the data from mdr to accumulator, fetch a new instruction

L0001:   ; st ==========================================
         a.ir and b.m12 c.mar    ; extract the address, place into mar
         a.ac c.mdr              ; copy the value in accumulator to mdr
         wr br@fetch             ; write the data to the specified address, fetch a new instruction

L0010:   ; add =========================================
         a.ir and b.m12 c.mar            ; extract the address, place into mar
         rd                              ; read the data in mdr
         a.mdr c.ac                      ; copy the value in mdr to accumulator
         a.ac add b.mdr c.ac br@fetch    ; add values in mdr and accumulator, store in accumulator, fetch a new instruction

L0011:   ; sub =========================================
         a.ir and b.m12 c.mar            ; extract the address, place into mar
         rd                              ; read the data in mdr
         a.ac sub b.mdr c.ac br@fetch    ; subtract values in mdr and accumulator, store in accumulator, fetch a new instruction

L0100:   ; ldr =========================================
         a.ir and b.m12 c.mar   ; extract the address, place into mar
         a.mar add b.sp c.mar   ; load data at the relative address and pass the new address to mar
         rd                     ; read the data in mdr
         a.mdr c.ac br@fetch    ; copy the value in mdr to accumulator, fetch a new instruction

L0101:   ; str =========================================
         a.ir and b.m12 c.mar    ; extract the address, place into mar
         a.mar add b.sp c.mar    ; load data at the relative address and pass the new address to mar
         a.ac c.mdr              ; copy the value in accumulator to mdr
         wr br@fetch             ; start write operation and fetch a new instruction

L0110:   ; addr ========================================
         a.ir and b.m12 c.mar            ; extract the address, place into mar
         a.mar add b.sp c.mar            ; load data at the relative address and pass the new address to mar
         rd                              ; read the data in mdr
         a.ac add b.mdr c.ac br@fetch    ; add values in mdr and accumulator, store in accumulator, fetch a new instruction

L0111:   ; subr ========================================
         a.ir and b.m12 c.mar            ; extract the address, place into mar
         a.mar add b.sp c.mar            ; load data at the relative address and pass the new address to mar
         rd                              ; read the data in mdr
         a.ac sub b.mdr c.ac br@fetch    ; subtract values in mdr and accumulator, store in accumulator, fetch a new instruction

L1000:   ; ldi =========================================
         a.ir and b.m12 c.ac br@fetch    ; load accumulator with data from the machine instruction, fetch a new instruction

L1001:   ; asp =========================================
         a.ir and b.m12 c.mar            ; extract the address, place into mar
         rd                              ; read the data in mdr
         a.sp add b.mdr c.sp br@fetch    ; resize stack by adding data from mdr to stack pointer, save the new size, fetch a new instruction

L1010:   ; call ========================================
         a.sp sub b.1 c.sp                  ; decrement sp
         a.sp c.mar                         ; load mar from sp
         a.pc c.mdr                         ; load pc with return address in pc
         a.ir and b.m12 c.pc wr br@fetch    ; load pc, write, branch to subroutine

L1011:   ; ret =========================================
         a.sp c.mar                    ; store sp in mar
         rd                            ; start read operation
         a.mdr c.pc                    ; move return address from mdr to pc
         a.sp add b.1 c.sp br@fetch    ; increment sp, fetch a new instruction

L1100:   ; br ==========================================
         a.ir and b.m12 c.pc br@fetch    ; branch to a new address, fetch new instruction

L1101:   ; brn =========================================
         a.ac add b.0 !neg@fetch         ; start fetch of next instruction if ac is not negative
         a.ir and b.m12 c.pc br@fetch    ; branch to address in branch on negative (brn) instruction

L1110:   ; brz =========================================
         a.ac add b.0 !zer@fetch         ; start fetch of next instruction if ac != 0
         a.ir and b.m12 c.pc br@fetch    ; branch to address in branch on zero (brz) instruction

L1111:   ; trap ========================================
         br@fetch    ; only microcode needed for opcode 1111

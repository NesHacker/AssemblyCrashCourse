.export Main
.segment "CODE"

.proc Main
  ; Initialize each monster's HP
  lda #100
  ldx #7
initialize_hp_loop:
  sta $0300, x
  dex
  bpl initialize_hp_loop

  ; Make a couple changes to test the logic
  lda #0
  sta $0301
  lda #15
  sta $0306

  ; Perform the multi-attack
  ldx #0
multi_attack_loop:
  ; If max HP is zero, skip (monster inactive)
  lda $0300, x
  beq check_condition

  ; Subtract the attack damage
  sec
  sbc #50

  ; If the result >= 0 then write it to memory
  ; Otherwise, set it to 0
  bpl store_hp
  lda #0

store_hp:
  sta $0300, x

check_condition:
  inx
  cpx #8
  bne multi_attack_loop

  ; Loop compete, return from subroutine
  rts
.endproc

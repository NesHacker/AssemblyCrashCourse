.export Main
.segment "CODE"

.proc Main
  monster_hp_table = $0300
  attack_damage = 50

  ; Initialize each monster's HP
  lda #100
  ldx #7
initialize_hp_loop:
  sta monster_hp_table, x
  dex
  bpl initialize_hp_loop

  ; Make a couple changes to test the logic
  lda #0
  sta monster_hp_table + 1
  lda #15
  sta monster_hp_table + 6

  ; Perform the multi-attack
  ldx #0
multi_attack_loop:
  ; If max HP is zero, skip (monster inactive)
  lda monster_hp_table, x
  beq check_condition

  ; Subtract the attack damage
  sec
  sbc #attack_damage

  ; If the result >= 0 then write it to memory
  ; Otherwise, set it to 0
  bpl store_hp
  lda #0

store_hp:
  sta monster_hp_table, x

check_condition:
  inx
  cpx #8
  bne multi_attack_loop

  ; Loop compete, return from subroutine
  rts
.endproc

.export Main

.segment "CODE"

; Include the math library for the "RollDice" subroutine
.include "../math.s"

; Player Stats
player_armor = $0300

; Monster Statistics Table
; Hit Bonus, Damage Dice, Damage Rolls, Damage Bonus
monster_stats:
  .byte 0, 10, 1, 0       ; Index 0 - Slime
  .byte 2, 12, 1, 5       ; Index 1 - Wyvern
  .byte 10, 15, 3, 10     ; Index 2 - Dragon

.proc Main
  ; Initialize some random seed
  Seed $A001

  ; Initialize player stats in RAM
  lda #25
  sta player_health
  lda #13
  sta player_armor
  
  ; Perform a sequence of monster attacks
  lda #0
  sta $00
  jsr MonsterAttack

  lda #1
  sta $00
  jsr MonsterAttack

  lda #2
  sta $00
  jsr MonsterAttack

  rts
.endproc

; Performs a monster attack for the given monster index.
; @param $00 The index of the monster.
; @return [$10-$11] The total damage for the attack.
.proc MonsterAttack
  jsr RollToHit
  bcc miss
  jsr RollDamage
  rts
miss:
  lda #0
  sta $10
  sta $11
  rts
.endproc

; Rolls to hit for a monster with the given index.
; @param $00 The index of the monster.
; @return C Sets the carry flag on a successful hit, clears the flag on a miss.
.proc RollToHit
  ; Calculate the monster_stats table offset
  lda $00
  pha
  asl
  asl
  tax
  
  ; if (1d20 + Hit Bonus >= Player Armor) then HIT else MISS
  lda #20
  sta $00
  lda #1
  sta $01
  lda monster_stats, x
  sta $02

  ; Perform the die roll and compare it to the player's armor
  jsr RollDice
  lda $10
  cmp player_armor

  ; Restore the monster index at $00
  pla
  sta $00
  rts
.endproc

; Rolls damage for a monster with the given index.
; Damage = (Rolls)d(Dice) + Bonus
; @param $00 The index of the monster.
; @return [$10-$11] The damage dealt by the monster.
.proc RollDamage
  ; Calculate the monster_stats table offset
  lda $00
  asl
  asl
  tax

  ; Load the params for the "RollDice" routine
  lda monster_stats+1, x
  sta $00
  lda monster_stats+2, x
  sta $01
  lda monster_stats+3, x
  sta $02

  ; Roll the dice and set the 16-bit result to [$10-$11]
  jsr RollDice
  rts
.endproc

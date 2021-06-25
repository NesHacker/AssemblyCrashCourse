.export Main
.segment "CODE"

.proc Main
  ; Create some assembler variables to make the program easier to read
  HEALTH = #$04
  DAMAGE = #$04

  ; Simulate a "hit" from an enemy by checking the amount of damage vs. the
  ; supposed player's health...
  lda DAMAGE
  cmp HEALTH

  ; The "carry" status register flag will be set if DAMAGE >= HEALTH, in this
  ; case we will want to "branch" to the "@game_over" label. Otherwise we have
  ; the program proceed to the "@continue" label.
  bcs @game_over

@continue:
  ; We should only reach this point if DANAGE < HEALTH
  rts
@game_over:
  ; We should only reach this instruction if DAMAGE >= HEALTH
  rts
.endproc

.export Main
.segment "CODE"

.proc Main
  ; Initialize Health, Damage, and the Return Value
  lda #25
  sta $00
  lda #30
  sta $01
  lda #0
  sta $02

  ; Check if Damage >= Health
  lda $01
  cmp $00
  bcc not_lethal

  ; Set address $01 to "1" to indicate the player has died
  lda #1
  sta $01

  ; Branch to this label when damage isn't lethal
not_lethal:
  rts
.endproc

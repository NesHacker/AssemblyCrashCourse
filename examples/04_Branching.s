.export Main
.segment "CODE"

.proc Main
  ; Initialize Player Health, Damage, and the "Game Over" return value
  lda #25
  sta $00
  lda #30
  sta $01
  lda #0
  sta $02

  ; If (DAMAGE > HEALTH) THEN: Game Over, ELSE: Continue
  lda $01
  cmp $00
  bcc continue

  ; Set address $01 to "1" to indicate a game over
set_gameover:
  lda #1
  sta $01
continue:
  rts
.endproc

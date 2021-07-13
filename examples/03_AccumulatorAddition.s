.export Main
.segment "CODE"

.proc Main
  ; Initialize some RAM
  ldx #$B2
  stx $00
  ldx #$F5
  stx $01

  ; Add $00 and $01
  lda $00
  clc
  adc $01

  ; Store the first byte of the result to $02
  sta $02

  ; Add the carry bit to zero and store it into $03
  lda #0
  adc #0
  sta $03

  rts
.endproc

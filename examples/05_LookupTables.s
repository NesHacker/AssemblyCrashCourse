.export Main
.segment "CODE"

numbersA: .byte $08, $10, $08, $10
numbersB: .byte $18, $00, $00, $58

.proc Main
  ldx #0
  txa
  clc
loopOne:
  adc numbers, x
  inx
  cpx #4
  bne loopOne
  ldx #.LOBYTE(numbersB)
  stx $00
  ldx #.HIBYTE(numbersB)
  stx $01
  ldy #0
loopTwo:
  adc ($00), y
  iny
  cpy #4
  bne loopTwo
  rts
.endproc

.export Main
.segment "CODE"

.proc Main
  ; Use LDA to load a value of $10 (16 decimal) into the accumulator
  lda #$10

  ; Add 4 to the accumulator using using ADC, while making sure to clear any
  ; lingering "carry" bits first...
  clc
  adc #$04

  ; At this point the Accumulator should now equal $14 (20 decimal)
  rts
.endproc

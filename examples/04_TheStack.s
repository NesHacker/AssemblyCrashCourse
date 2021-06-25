.export Main
.segment "CODE"

.proc Main
  lda #1
  ldx #2
  ldy #3
  sec
  pha
  phx
  phy
  php
  jsr MyRoutine
  plp
  ply
  plx
  pla
  rts
.endproc

.proc MyRoutine
  lda #10
  ldx #20
  ldy #30
  clc
  rts
.endproc

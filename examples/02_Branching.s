.segment "CODE"

.export Main

.proc Main
  bit $2002
  lda #$3F
  sta $2006
  lda #$00
  sta $2006
  ldx #0
@loop:
  lda palette, x
  sta $2007
  inx
  cpx #$20
  bne @loop
  rts
.endproc

palette:
  .byte $38, $00, $20, $36
  .byte $38, $00, $20, $36
  .byte $38, $00, $20, $36
  .byte $38, $00, $20, $36
  .byte $38, $00, $20, $36
  .byte $38, $00, $20, $36
  .byte $38, $00, $20, $36
  .byte $38, $00, $20, $36

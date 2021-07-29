.export Main
.segment "CODE"

; Loads data from PRG-ROM into System RAM using a loop
.proc Main
  ldx #11
loop:
  lda data_table, x
  sta $0500, x
  dex
  bpl loop
  rts
.endproc

; The data to place into the PRG-ROM
data_table:
  .byte $00, $01, $01, $02
  .byte $03, $05, $08, $0D
  .byte $15, $22, $37, $59

.export Main
.segment "CODE"

.proc Main
  lda #$30
  sta $00
  lda #$10
  sta $01
  lda #$20
  sta $02
  lda #$00
  clc
  adc #$01
  adc #$02
  sta $03
  lda $00
  cmp $03
  bne not_equal
equal:
  lda #$00
  jmp return
not_equal:
  lda #$01
return:
  sta $04
  rts
.endproc

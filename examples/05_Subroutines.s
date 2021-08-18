.export Main
.segment "CODE"

; Assembler Constants
PLAYER_LEVEL = $0300
PLAYER_EXP = $0301
NEXT_LEVEL_EXP = $0302

; Main procedure for the example
.proc Main
  ; Initialize RAM for the example
  jsr Initialize

  ; Add 30 experience to the player's total
  lda #30
  sta $00
  jsr AddExp

  rts
.endproc

; Initializes the RAM
.proc Initialize
  lda #1
  sta PLAYER_LEVEL
  lda #0
  sta PLAYER_EXP
  lda #25
  sta NEXT_LEVEL_EXP
  rts
.endproc

; Adds player experience
.proc AddExp
  lda PLAYER_EXP
  clc
  adc $00
  sta PLAYER_EXP
  jsr CheckLevelUp
  rts
.endproc

; Checks for level-ups
.proc CheckLevelUp
  lda PLAYER_EXP
  cmp NEXT_LEVEL_EXP
  bcs level_up
  rts
level_up:
  inc PLAYER_LEVEL
  lda NEXT_LEVEL_EXP
  clc
  adc #25
  sta NEXT_LEVEL_EXP
  rts
.endproc

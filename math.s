; math.s
;
; Auxiliary math routines for video example programs. Feel free to use and
; include this file in your own projects!

; The memory location for the low byte of the random number generator seed.
SEED_ADDR = $20

; Multiplies two eight bit numbers and returns a 16-bit result.
; Adapted from: https://llx.com/Neil/a2/mult.html
; @param $00 First 8-bit operand.
; @param $01 Second 8-bit operand.
; @return [$10-$11] The 16-bit result.
.proc Mul8
  NUM1 = $00
  NUM2 = $01
  RESULT = $10
  pha
  txa
  pha
  lda #0
  ldx #8
: lsr NUM2
  bcc :+
  clc
  adc NUM1
: ror a
  ror RESULT
  dex
  bne :--
  sta RESULT+1
  pla
  tax
  pla
  rts
.endproc

; Divides a 16-bit number by another 16-bit number and stores the result.
; Adapted from: https://llx.com/Neil/a2/mult.html
; @param [$00-$01] The numerator of the division.
; @param [$02-$03] The denominator of the division.
; @return [$00-$01] The result of the division.
.proc Div16
  NUM1 = $00
  NUM2 = $02
  REM = $04
  pha
  txa
  pha
  tya
  pha
  lda #0
  sta REM
  sta REM+1
  ldx #16
: asl NUM1
  rol NUM1+1
  rol REM
  rol REM+1
  lda REM
  sec
  sbc NUM2
  tay
  LDA REM+1
  sbc NUM2+1
  bcc :+
  sta REM+1
  sty REM
  inc NUM1
: dex
  bne :--
  pla
  tay
  pla
  tax
  pla
  rts
.endproc

; Sets the random number generator seed.
; @param value The 16-bit seed value to set.
.macro Seed value
  lda #.LOBYTE(value)
  sta SEED_ADDR
  lda #.HIBYTE(value)
  sta SEED_ADDR+1
.endmacro

; Increments the seed value. This is useful for setting random seeds on
; title screens before RNG is needed. Just call this in the NMI until the
; first random number needs to be generated.
.macro IncSeed
  inc SEED_ADDR
  bne :+
  inc SEED_ADDR+1
:
.endmacro

; Generates a random number between 0 and 255 and stores in the accumulator.
; Adapted from: https://github.com/bbbradsmith/prng_6502
.proc Rand
	lda SEED_ADDR+1
	tay ; store copy of high byte
	; compute SEED_ADDR+1 ($39>>1 = %11100)
	lsr ; shift to consume zeroes on left...
	lsr
	lsr
	sta SEED_ADDR+1 ; now recreate the remaining bits in reverse order... %111
	lsr
	eor SEED_ADDR+1
	lsr
	eor SEED_ADDR+1
	eor SEED_ADDR+0 ; recombine with original low byte
	sta SEED_ADDR+1
	; compute SEED_ADDR+0 ($39 = %111001)
	tya ; original high byte
	sta SEED_ADDR+0
	asl
	eor SEED_ADDR+0
	asl
	eor SEED_ADDR+0
	asl
	asl
	asl
	eor SEED_ADDR+0
	sta SEED_ADDR+0
	rts
.endproc

; Rolls the given number of N-sided dice, sums them, then applies a bonus.
; @param $00 The number of sides for the dice to roll.
; @param $01 The number of rolls to perform.
; @param $02 The bonus to apply to the roll.
; @return [$10-$11] The total after calculating all rolls.
.proc RollDice
  lda $02
  pha
  sta $08
  lda #0
  sta $09
  lda $01
  pha
  tax
  lda $00
  sta $06
  pha
@loop:
  ; Perform a 1dN die roll
  jsr Rand
  sta $00
  lda $06
  sta $01
  jsr Mul8
  lda $10
  sta $00
  lda $11
  sta $01
  lda #255
  sta $02
  lda #0
  sta $03
  jsr Div16
  inc $00
  lda $00
  ; Add the roll to the total
  clc
  adc $08
  sta $08
  lda #0
  adc $09
  sta $09
  dex
  bne @loop
  ; Copy the temporary total to the return value
  lda $08
  sta $10
  lda $09
  sta $11
  ; Pull the original params from the stack and restore them
  pla
  sta $00
  pla
  sta $01
  pla
  sta $02
  rts
.endproc

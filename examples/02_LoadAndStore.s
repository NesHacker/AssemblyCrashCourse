.export Main
.segment "CODE"

.proc Main
  ; Initialize some ZeroPage memory
  ldx #10
  stx $00
  stx $01

  ; Increment the memory locations directly
  inc $00
  dec $01

  ; Store the values elsewhere in RAM
  ldx $00
  stx $0300
  ldx $01
  stx $0301

  rts
.endproc

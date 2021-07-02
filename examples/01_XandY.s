.export Main
.segment "CODE"

.proc Main
  ; Start by loading the value 5 into both the X and Y registers
  ldx #5
  ldy #5

  ; Increment the value of X twice
  inx
  inx

  ; Decrement the value of X once
  dex

  ; Decrement the value Y twice
  dey
  dey

  ; Increment the value of Y once
  iny

  ; Since we ran 2 increments and 1 decrement on X, it should now equal 6
  ; Since we ran 2 decrements on Y and 1 increment, it should now equal 4
  rts
.endproc

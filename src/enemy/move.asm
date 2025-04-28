move 
    ldy #offsetStatus
    lda mEnemy0, y
    cmp #status.active
    beq _ok
    rts
_ok
    ldy #offsetPosY
    lda mEnemy0, y
    clc
    adc #1
    sta mEnemy0, y
    iny
    lda mEnemy0, y
    adc #0
    sta mEnemy0, y
    rts

show
    lda #2
    jsr setSpriteNumber

    ldy #offsetPosX
    lda mEnemy0, y
     pha
     iny
     lda mEnemy0, y
     tax
     pla
     jsr setSpriteX

    ldy #offsetPosY
    lda mEnemy0, y
    pha
    iny
    lda mEnemy0, y
    tax
    pla
    jsr setSpriteY
   ; jsr showSprite

    lda #3
    jsr setSpriteNumber
    ldy #offsetPosX
    lda mEnemy0, y
    pha
    iny
    lda mEnemy0, y
    tax
    pla
    jsr setSpriteX

    ldy #offsetPosY
    lda mEnemy0, y
    clc
    adc #16
    pha
    iny
    lda mEnemy0, y
    adc #0
    tax
    pla
    jsr setSpriteY
  ;  jsr showSprite
    rts
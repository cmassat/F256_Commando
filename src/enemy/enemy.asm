handle
    phy
    phx
    pha
    jsr activate
    jsr handleAnimation
    jsr move
    jsr show

    pla
    plx
    ply
    rts

activate 
    ldy #0
    lda mEnemyTileActivate0 ,y
    cmp map.posY
    beq _activate
    rts
_activate
    sty mIdx
    ldy #offsetStatus
    lda mEnemy0, y
    cmp #status.active
    bne _ok
    rts
_ok
    ldy #offsetStatus
    lda #status.active
    sta mEnemy0, y

    ;get x
    ldx mIdx
    ldy #offsetPosX
    lda mEnemy0XLo,x
    sta mEnemy0, y
    iny
    lda mEnemy0XHi, x
    sta mEnemy0, y

    ;get y
    ldy #offsetPosY
    lda mEnemy0YLo,x
    sta mEnemy0, y
    iny
    lda mEnemy0YHi, x
    sta mEnemy0, y

    lda mEnemy0Dir, x
    ldy #offsetDir
    sta mEnemy0, y

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
    jsr showSprite

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
   jsr showSprite
    rts
mIdx
    .byte $0
mEnemyTileActivate0
    .byte 176
mEnemy0XLo
    .byte 128+32
mEnemy0XHi
    .byte 00
mEnemy0YLo
    .byte 32
mEnemy0YHi
    .byte 0
mEnemy0Dir
    .byte dir.south

mEndSection
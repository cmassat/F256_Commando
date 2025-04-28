.section code 
handle
    pha
    phx
    phy
    jsr state.isStart
    jsr loadFrame
    bcc _yes
    ply
    plx
    pla
    rts
_yes
    jsr handleLocalState
    ply
    plx
    pla
    rts

handlePosition
    lda #0
    jsr setSpriteNumber
    lda posX
    ldx posX + 1
    jsr setSpriteX


    lda #1
    jsr setSpriteNumber
    lda posX
    ldx posX + 1
    jsr setSpriteX

    lda #0
    jsr setSpriteNumber
    lda posY
    ldx posY + 1
    jsr setSpriteY
    jsr showSprite


    lda #1
    jsr setSpriteNumber
    lda posY
    clc
    adc #16
    pha
    lda posY + 1
    adc #0
    tax
    pla
    jsr setSpriteY
    jsr showSprite
    rts

handleLocalState
    jsr isSetup
    jsr isMove
    rts

isSetup
    lda mState
    cmp #setupState
    beq _yes
    rts
_yes
    jsr setup
    rts

isMove
    lda mState
    cmp #moveState
    beq _yes
    rts
_yes
    jsr move
    rts



sprite2bitmap
    lda posX
    sec
    sbc #32 - 8
    sta posBitmapX
    lda posX + 1
    sbc #0
    sta posBitmapX + 1

    lda posY
    sec
    sbc #32 - 32
    sta posBitmapY
    lda posY + 1
    sbc #0
    sta posBitmapY + 1
    rts






.endsection


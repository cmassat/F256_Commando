map .namespace
.section code
handlePosition

    lda posY
    ldx pixelsY
    jsr setTilePositionY

    rts

moveNorth
    lda posY
    cmp #0
    bne _continue
    rts
_continue
    lda pixelsY
    cmp #0
    beq _changeTile
    dec pixelsY

    rts
_changeTile
    lda #15
    sta pixelsY
    lda posY
    sec
    sbc #1
    sta posY
    lda posY + 1
    sbc #0
    sta posY + 1
    rts

init
    lda #0
    jsr setTileMapNumber

    lda #<mTileSetStart
    ldx #>mTileSetStart
    ldy #`mTileSetStart
    jsr setTileSetAddress

    lda #<mTileMapStart
    ldx #>mTileMapStart
    ldy #`mTileMapStart
    jsr setTileMapAddress

    lda #85
    sta posY
    lda #0
    sta posY + 1

    lda #0
    sta pixelsY

    lda #21
    ldx #100
    jsr setMapSize

    lda #85
    ldx #0
    jsr setTilePositionY

    rts
.endsection 
.section variables
posX
    .byte 0,0
posY
    .byte 0,0
pixelsX
    .byte 0
pixelsY
    .byte 0
.endsection
.endnamespace
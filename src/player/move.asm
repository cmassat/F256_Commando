.section code
move
    jsr framecontrol
    jsr loadFrame

    jsr direction
    jsr debug
    rts

direction
    jsr isF1Pressed
    bcc _reset

    jsr isNEPressed
    bcc _moveNE

    jsr isNWPressed
    bcc _moveNW

    jsr isSWPressed
    bcc _moveSW

    jsr isSEPressed
    bcc _moveSE

    jsr isWPressed
    bcc _moveNorth

    jsr isAPressed
    bcc _moveWest

    jsr isDPressed
    bcc _moveEast

    jsr isSPressed
    bcc _moveSouth
    rts
_moveNorth
    jsr moveNorth
    lda #dir.north
    sta mDirection
    rts
_moveWest
    jsr moveWest
    lda #dir.west
    sta mDirection
    rts
_moveEast
    jsr moveEast
    lda #dir.east
    sta mDirection
    rts
_moveNW
    jsr moveNorth
    jsr moveWest
    lda #dir.northWest
    sta mDirection
    rts
_moveNE
    jsr moveNorth
    jsr moveEast
    lda #dir.northEast
    sta mDirection
    rts
_moveSW
    jsr moveSouth
    jsr moveWest
    lda #dir.southWest
    sta mDirection
    rts
_moveSE
    jsr moveSouth
    jsr moveEast
    lda #dir.southEast
    sta mDirection
    rts
_moveSouth
    jsr moveSouth
    lda #dir.south
    sta mDirection
    rts
_reset
    jsr map.init
    jsr enemy.init
    jsr init
    jsr setup
    rts

moveNorth
    lda map.pixelsY
    cmp #0
    bne _okNorth
    jsr getNorthTile
    lda map.tileNumber
    cmp #0
    beq _okNorth
    rts
_okNorth
    lda posY
    cmp #160
    bcs _moveSprite
    jsr map.moveNorth
    rts
_moveSprite
    lda posY
    sec
    sbc #1
    sta posY
    lda posY + 1
    sbc #0
    sta posY + 1
    rts

moveWest
    lda posX + 1
    cmp #1
    beq _continueWest

    lda posX
    cmp #32
    bcs _continueWest
    rts
_continueWest
    jsr getWestTile
    lda map.tileNumber
    cmp #0
    beq _okWest

    lda posBitmapX
    and #$0f
    cmp #0
    bne _okWest
    rts
_okWest
    lda posX
    sec
    sbc #1
    sta posX
    lda posX + 1
    sbc #0
    sta posX + 1
    rts
moveEast
    lda posX + 1
    cmp #0
    beq _continueEast
    lda posX
    cmp #$50
    bcc _continueEast
    rts
_continueEast
    jsr getEastTile
    lda map.tileNumber
    cmp #0
    beq _okEast
    lda posBitmapX
    and #$0f
    cmp #0
    bne _okEast
    rts
_okEast
    lda posX
    clc
    adc #1
    sta posX
    lda posX + 1
    adc #0
    sta posX + 1
    rts

moveSouth
   ; lda map.pixelsY
   ; cmp #0
   ; beq _ok
    jsr getSouthTile
    lda map.tileNumber
    cmp #0
    beq _ok
    rts
_ok
    lda posY
    clc
    adc #1
    sta posY
    lda posY + 1
    adc #0
    sta posY + 1
    rts

getNorthTile
    jsr sprite2bitmap
    lda posBitmapX
    ldx posBitmapX + 1
    ldy posBitmapY
    jsr util.tileFromPixel
    lda util.xTile
    ldx util.yTile
    dex
    jsr map.getTile
    rts

getEastTile
    jsr sprite2bitmap
    lda posBitmapX
    ldx posBitmapX + 1
    ldy posBitmapY
    jsr util.tileFromPixel
    lda util.xTile
    inc a
    ldx util.yTile
    jsr map.getTile
    rts

getWestTile
    jsr sprite2bitmap
    lda posBitmapX
    ldx posBitmapX + 1
    ldy posBitmapY
    jsr util.tileFromPixel
    lda util.xTile
    dec a
    ldx util.yTile
    jsr map.getTile
    rts

getSouthTile
    jsr sprite2bitmap
    lda posBitmapX
    ldx posBitmapX + 1
    ldy posBitmapY
    jsr util.tileFromPixel
    lda util.xTile
    ldx util.yTile
    inx
    jsr map.getTile
    rts
.endsection
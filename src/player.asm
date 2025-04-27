
player .namespace
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
    rts
_moveWest
    jsr moveWest
    rts
_moveEast
    jsr moveEast
    rts
_moveNW
    jsr moveNorth
    jsr moveWest
    rts
_moveNE
    jsr moveNorth
    jsr moveEast
    rts
_reset
    jsr map.init
    rts


_moveSW
    jsr moveSouth
    jsr moveWest
    rts
_moveSE
    jsr moveSouth
    jsr moveEast
    rts

_moveSouth
    jsr moveSouth
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

setup
    jsr clearVideo
    jsr enableGrafix
    jsr enableSprite
    jsr enableTile
    jsr enableText
    jsr setVideo

    jsr setTileMapLayer0
    jsr setTileMapLayer1
    jsr setLayers


    lda #0
    jsr setSpriteNumber

    lda <#player_up_top0
    ldx >#player_up_top0
    ldy `#player_up_top0
   ; jsr setSpriteAddress

    lda #<320/2 + 32
    ldx #>320/2 + 32
    jsr setSpriteX
    lda #<200
    ldx #>200
    jsr setSpriteY
    jsr showSprite

    lda #1
    jsr setSpriteNumber

    lda <#player_up_bot0
    ldx >#player_up_bot0
    ldy `#player_up_bot0
   ; jsr setSpriteAddress
    lda #<320/2 + 32
    ldx #>320/2 + 32
    jsr setSpriteX

    lda #<200 + 16
    ldx #>200 + 16
    jsr setSpriteY
   ; jsr showSprite
    lda #moveState
    sta mState
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


framecontrol
    inc mFrameTracker
    lda mFrameTracker
    cmp #10
    beq _incFrame
    rts
_incFrame
    inc mFrame
    stz mFrameTracker
    lda mFrame
    cmp #4
    bcs _reset
    rts
_reset
    stz mFrame
    rts

loadFrame
    lda mFrame
    cmp #0
    beq _fr0

    lda mFrame
    cmp #1
    beq _fr1

    lda mFrame
    cmp #2
    beq _fr2

    lda mFrame
    cmp #3
    beq _fr3
    rts
_fr0
    lda #0
    jsr setSpriteNumber

    lda <#player_up_top0
    ldx >#player_up_top0
    ldy `#player_up_top0
    jsr setSpriteAddress


    lda #1
    jsr setSpriteNumber

    lda <#player_up_bot0
    ldx >#player_up_bot0
    ldy `#player_up_bot0
    jsr setSpriteAddress

    rts
_fr1
   lda #0
    jsr setSpriteNumber

    lda <#player_up_top1
    ldx >#player_up_top1
    ldy `#player_up_top1
    jsr setSpriteAddress
  ;  jsr showSprite

    lda #1
    jsr setSpriteNumber

    lda <#player_up_bot1
    ldx >#player_up_bot1
    ldy `#player_up_bot1
    jsr setSpriteAddress
  ;  jsr showSprite
    rts
_fr2
    lda #0
    jsr setSpriteNumber

    lda <#player_up_top2
    ldx >#player_up_top2
    ldy `#player_up_top2
    jsr setSpriteAddress
   ; jsr showSprite

    lda #1
    jsr setSpriteNumber

    lda <#player_up_bot2
    ldx >#player_up_bot2
    ldy `#player_up_bot2
    jsr setSpriteAddress
   ; jsr showSprite
    rts
_fr3
  lda #0
    jsr setSpriteNumber

    lda <#player_up_top3
    ldx >#player_up_top3
    ldy `#player_up_top3
    jsr setSpriteAddress
    jsr showSprite

    lda #1
    jsr setSpriteNumber

    lda <#player_up_bot3
    ldx >#player_up_bot3
    ldy `#player_up_bot3
    jsr setSpriteAddress
   ; jsr showSprite
    rts

init
    lda #setupState
    sta mState
    lda #0
    sta mFrame
    sta mFrameTracker
    lda #<320/2 + 32
    sta posX
    lda #>320/2 + 32
    sta posX + 1

    lda #<240/2 + 32
    sta posY
    lda #>240/2 + 32
    sta posY + 1
    rts

.endsection
.section variables
setupState = 0
moveState = 1
mState
    .byte $0

mFrame
    .byte $0
mFrameTracker
    .byte $0
posX
    .byte 0,0
posY
    .byte 0,0

posBitmapX
    .byte 0,0
posBitmapY
    .byte 0,0
.endsection
.endnamespace
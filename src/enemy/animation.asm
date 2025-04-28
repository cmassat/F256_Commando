handleAnimation
    jsr frameControl
    jsr loadFrame

    rts
frameControl
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

setSprite
    ldy #offsetDir
    lda mEnemy0, y
    cmp #dir.north
    beq _north

    ldy #offsetDir
    lda mEnemy0, y
    cmp #dir.south
    beq _south

    ldy #offsetDir
    lda mEnemy0, y
    cmp #dir.east
    beq _east

    ldy #offsetDir
    lda mEnemy0, y
    cmp #dir.west
    beq _west

    ldy #offsetDir
    lda mEnemy0, y
    cmp #dir.northEast
    beq _northEast

    ldy #offsetDir
    lda mEnemy0, y
    cmp #dir.northWest
    beq _northWest

    ldy #offsetDir
    lda mEnemy0, y
    cmp #dir.southEast
    beq _southEast

    ldy #offsetDir
    lda mEnemy0, y
    cmp #dir.southWest
    beq _southWest
    rts
_north
   jsr northSprite
_south
    lda <#enemy_s_top
    ldy #offsetAddrTop
    sta mEnemy0, y
    lda >#enemy_s_top
    iny
    sta mEnemy0, y
    lda `#enemy_s_top
    iny
    sta mEnemy0, y

    lda <#enemy_s_bot
    ldy #offsetAddrBot
    sta mEnemy0, y
    lda >#enemy_s_bot
    iny
    sta mEnemy0, y
    lda `#enemy_s_bot
    iny
    sta mEnemy0, y
    rts
_east
    lda <#enemy_e_top
    sta mEnemy0, y
    lda >#enemy_e_top
    iny
    sta mEnemy0, y
    lda `#enemy_e_top
    iny
    sta mEnemy0, y

    lda <#enemy_e_bot
    sta mEnemy0, y
    lda >#enemy_e_bot
    iny
    sta mEnemy0, y
    lda `#enemy_e_bot
    iny
    sta mEnemy0, y
    rts
_west
    jsr westSprite
    rts
_northEast
    jsr northEastSprite
    rts
_northWest
    jsr northWestSprite
    rts
_southEast
    jsr southEastSprite
    rts
_southWest
    jsr southWestSprite
    rts
northSprite
    lda <#enemy_n_top
    ldy #offsetAddrTop
    sta mEnemy0, y
    lda >#enemy_n_top
    iny
    sta mEnemy0, y
    lda `#enemy_n_top
    iny
    sta mEnemy0, y

    lda <#enemy_n_bot
    ldy #offsetAddrBot
    sta mEnemy0, y
    lda >#enemy_n_bot
    iny
    sta mEnemy0, y
    lda `#enemy_n_bot
    iny
    sta mEnemy0, y
    rts
westSprite
    lda <#enemy_w_top
    ldy #offsetAddrTop
    sta mEnemy0, y
    lda >#enemy_w_top
    iny
    sta mEnemy0, y
    lda `#enemy_w_top
    iny
    sta mEnemy0, y

    lda <#enemy_w_bot
    ldy #offsetAddrBot
    sta mEnemy0, y
    lda >#enemy_w_bot
    iny
    sta mEnemy0, y
    lda `#enemy_w_bot
    iny
    sta mEnemy0, y
    rts

northEastSprite
    lda <#enemy_ne_top
    ldy #offsetAddrTop
    sta mEnemy0, y
    lda >#enemy_ne_top
    iny
    sta mEnemy0, y
    lda `#enemy_ne_top
    iny
    sta mEnemy0, y

    lda <#enemy_ne_bot
    ldy #offsetAddrBot
    sta mEnemy0, y
    lda >#enemy_ne_bot
    iny
    sta mEnemy0, y
    lda `#enemy_ne_bot
    iny
    sta mEnemy0, y
    rts
northWestSprite
    lda <#enemy_nw_top
    ldy #offsetAddrTop
    sta mEnemy0, y
    lda >#enemy_nw_top
    iny
    sta mEnemy0, y
    lda `#enemy_nw_top
    iny
    sta mEnemy0, y

    lda <#enemy_nw_bot
    ldy #offsetAddrBot
    sta mEnemy0, y
    lda >#enemy_nw_bot
    iny
    sta mEnemy0, y
    lda `#enemy_nw_bot
    iny
    sta mEnemy0, y
    rts

southEastSprite
    lda <#enemy_se_top
    ldy #offsetAddrTop
    sta mEnemy0, y
    lda >#enemy_se_top
    iny
    sta mEnemy0, y
    lda `#enemy_se_top
    iny
    sta mEnemy0, y

    lda <#enemy_se_bot
    ldy #offsetAddrBot
    sta mEnemy0, y
    lda >#enemy_se_bot
    iny
    sta mEnemy0, y
    lda `#enemy_se_bot
    iny
    sta mEnemy0, y
    rts

southWestSprite
    lda <#enemy_sw_top
    ldy #offsetAddrTop
    sta mEnemy0, y
    lda >#enemy_sw_top
    iny
    sta mEnemy0, y
    lda `#enemy_sw_top
    iny
    sta mEnemy0, y

    lda <#enemy_sw_bot
    ldy #offsetAddrBot
    sta mEnemy0, y
    lda >#enemy_sw_bot
    iny
    sta mEnemy0, y
    lda `#enemy_sw_bot
    iny
    sta mEnemy0, y
    rts

spriteTop .macro spAddrTop
    ldy #offsetAddrTop
    lda \spAddrTop, y
    clc
    adc #$ff
    sta \spAddrTop, y
    iny
    lda \spAddrTop, y
    adc #0
    sta \spAddrTop, y

    ldy #offsetAddrTop
    lda \spAddrTop, y
    clc
    adc #$01
    sta \spAddrTop,y
    iny
    lda \spAddrTop, y
    adc #0
    sta \spAddrTop,y
.endmacro

spriteBot .macro spAddrBot
    ldy #offsetAddrBot
    lda \spAddrBot, y
    clc
    adc #$ff
    sta \spAddrBot, y
    iny
    lda \spAddrBot, y
    adc #0
    sta \spAddrBot, y

    ldy #offsetAddrBot
    lda \spAddrBot, y
    clc
    adc #$01
    sta \spAddrBot,y
    iny
    lda \spAddrBot, y
    adc #0
    sta \spAddrBot,y
.endmacro


showFrame
    lda #2
    jsr setSpriteNumber

    ldy #offsetAddrTop
    lda mEnemy0,y
    pha
    iny
    lda mEnemy0,y
    tax

    iny
    lda mEnemy0,y
    tay
    pla
    jsr setSpriteAddress


    lda #3
    jsr setSpriteNumber

    ldy #offsetAddrBot
    lda mEnemy0,y
    pha
    iny
    lda mEnemy0,y
    tax

    iny
    lda mEnemy0,y
    tay
    pla
    jsr setSpriteAddress

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
    jsr setSprite
    jsr showFrame
    rts
_fr1
    jsr setSprite
    jsr frame1
    jsr showFrame
    rts
_fr2
    jsr setSprite
    jsr frame2
    jsr showFrame
    rts
_fr3
    jsr setSprite
    jsr frame3
    jsr showFrame
    rts
frame1
    #spriteTop mEnemy0
    #spriteBot mEnemy0
    rts
frame2
    #spriteTop mEnemy0
    #spriteBot mEnemy0
    #spriteTop mEnemy0
    #spriteBot mEnemy0
    rts
frame3
    #spriteTop mEnemy0
    #spriteBot mEnemy0
    #spriteTop mEnemy0
    #spriteBot mEnemy0
    #spriteTop mEnemy0
    #spriteBot mEnemy0
    rts
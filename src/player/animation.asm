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

setSprite
    lda mDirection
    cmp #dir.north
    beq _north

    lda mDirection
    cmp #dir.south
    beq _south

    lda mDirection
    cmp #dir.east
    beq _east

    lda mDirection
    cmp #dir.west
    beq _west

    lda mDirection
    cmp #dir.northEast
    beq _northEast

    lda mDirection
    cmp #dir.northWest
    beq _northWest

    lda mDirection
    cmp #dir.southEast
    beq _southEast

    lda mDirection
    cmp #dir.southWest
    beq _southWest
    rts
_north
    lda <#player_up_top0
    sta mSpriteAddressTop
    lda >#player_up_top0
    sta mSpriteAddressTop + 1
    lda `#player_up_top0
    sta mSpriteAddressTop + 2

    lda <#player_up_bot0
    sta mSpriteAddressBot
    lda >#player_up_bot0
    sta mSpriteAddressBot + 1
    lda `#player_up_bot0
    sta mSpriteAddressBot + 2
    rts
_south
    lda <#player_s_top0
    sta mSpriteAddressTop
    lda >#player_s_top0
    sta mSpriteAddressTop + 1
    lda `#player_s_top0
    sta mSpriteAddressTop + 2

    lda <#player_s_bot0
    sta mSpriteAddressBot
    lda >#player_s_bot0
    sta mSpriteAddressBot + 1
    lda `#player_s_bot0
    sta mSpriteAddressBot + 2
    rts
_east
    lda <#player_e_top0
    sta mSpriteAddressTop
    lda >#player_e_top0
    sta mSpriteAddressTop + 1
    lda `#player_e_top0
    sta mSpriteAddressTop + 2

    lda <#player_e_bot0
    sta mSpriteAddressBot
    lda >#player_e_bot0
    sta mSpriteAddressBot + 1
    lda `#player_e_bot0
    sta mSpriteAddressBot + 2
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
westSprite
    lda <#player_w_top0
    sta mSpriteAddressTop
    lda >#player_w_top0
    sta mSpriteAddressTop + 1
    lda `#player_w_top0
    sta mSpriteAddressTop + 2

    lda <#player_w_bot0
    sta mSpriteAddressBot
    lda >#player_w_bot0
    sta mSpriteAddressBot + 1
    lda `#player_w_bot0
    sta mSpriteAddressBot + 2
    rts

northEastSprite
    lda <#player_ne_top0
    sta mSpriteAddressTop
    lda >#player_ne_top0
    sta mSpriteAddressTop + 1
    lda `#player_ne_top0
    sta mSpriteAddressTop + 2

    lda <#player_ne_bot0
    sta mSpriteAddressBot
    lda >#player_ne_bot0
    sta mSpriteAddressBot + 1
    lda `#player_ne_bot0
    sta mSpriteAddressBot + 2
    rts
northWestSprite
    lda <#player_nw_top0
    sta mSpriteAddressTop
    lda >#player_nw_top0
    sta mSpriteAddressTop + 1
    lda `#player_nw_top0
    sta mSpriteAddressTop + 2

    lda <#player_nw_bot0
    sta mSpriteAddressBot
    lda >#player_nw_bot0
    sta mSpriteAddressBot + 1
    lda `#player_nw_bot0
    sta mSpriteAddressBot + 2
    rts

southEastSprite
    lda <#player_se_top0
    sta mSpriteAddressTop
    lda >#player_se_top0
    sta mSpriteAddressTop + 1
    lda `#player_se_top0
    sta mSpriteAddressTop + 2

    lda <#player_se_bot0
    sta mSpriteAddressBot
    lda >#player_se_bot0
    sta mSpriteAddressBot + 1
    lda `#player_se_bot0
    sta mSpriteAddressBot + 2
    rts

southWestSprite
    lda <#player_sw_top0
    sta mSpriteAddressTop
    lda >#player_sw_top0
    sta mSpriteAddressTop + 1
    lda `#player_sw_top0
    sta mSpriteAddressTop + 2

    lda <#player_sw_bot0
    sta mSpriteAddressBot
    lda >#player_sw_bot0
    sta mSpriteAddressBot + 1
    lda `#player_sw_bot0
    sta mSpriteAddressBot + 2
    rts

sprite1 .macro spAddr
    lda \spAddr
    clc
    adc #$ff
    sta \spAddr

    lda \spAddr + 1
    adc #0
    sta \spAddr + 1

    lda \spAddr
    clc
    adc #$01
    sta \spAddr

    lda \spAddr + 1
    adc #0
    sta \spAddr + 1
.endmacro



showFrame
    lda #0
    jsr setSpriteNumber

    lda mSpriteAddressTop
    ldx mSpriteAddressTop + 1
    ldy mSpriteAddressTop + 2
    jsr setSpriteAddress


    lda #1
    jsr setSpriteNumber

    lda mSpriteAddressBot
    ldx mSpriteAddressBot + 1
    ldy mSpriteAddressBot + 2
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
    #sprite1 mSpriteAddressTop
    #sprite1 mSpriteAddressBot
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
frame2
    #sprite1 mSpriteAddressTop
    #sprite1 mSpriteAddressBot
    #sprite1 mSpriteAddressTop
    #sprite1 mSpriteAddressBot
    rts
frame3
    #sprite1 mSpriteAddressTop
    #sprite1 mSpriteAddressBot
    #sprite1 mSpriteAddressTop
    #sprite1 mSpriteAddressBot
    #sprite1 mSpriteAddressTop
    #sprite1 mSpriteAddressBot
    rts
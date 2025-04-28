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

    lda #<240/2 + 16
    sta posY
    lda #>240/2 + 16
    sta posY + 1
    rts

setup
    jsr clearVideo
    jsr enableGrafix
    jsr enableSprite
    jsr enableTile
    ;jsr enableText
    jsr setVideo

   ; jsr setTileMapLayer0
    jsr setTileMapLayer1
    jsr setLayers


    lda #0
    jsr setSpriteNumber

    lda <#player_up_top0
    ldx >#player_up_top0
    ldy `#player_up_top0


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

    lda #<320/2 + 32
    ldx #>320/2 + 32
    jsr setSpriteX

    lda #<200 + 16
    ldx #>200 + 16
    jsr setSpriteY

    lda #moveState
    sta mState
    rts

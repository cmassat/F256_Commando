debug
    phy
    phx
    pha
    lda #2
    sta MMU_IO_CTRL
    jsr printMapPosition
    jsr printTilePosition
    jsr printLocalTilePosition
    jsr printTileNumber
    jsr printBmpPosition

    pla
    plx
    ply
    stz MMU_IO_CTRL

    rts

printMapPosition
    lda #'M'
    sta $C000
    lda #'A'
    sta $C001
    lda #'P'
    sta $C002

    lda map.posX
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C004

    lda player.posX
    and #$0F
    tay
    lda mHex, y
    sta $C005

    lda map.posY
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C007

    lda map.posY
    and #$0F
    tay
    lda mHex, y
    sta $C008
    rts

printTilePosition
    lda #'T'
    sta $C00A
    lda #'I'
    sta $C00B
    lda #'L'
    sta $C00C
    lda #'E'
    sta $C00D

    lda util.xTile
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C00F

    lda util.xTile
    and #$0F
    tay
    lda mHex, y
    sta $C010


    lda util.yTile
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C011

    lda util.yTile
    and #$0F
    tay
    lda mHex, y
    sta $C012

    lda map.pixelsY
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C013

    lda map.pixelsY
    and #$0F
    tay
    lda mHex, y
    sta $C014

    rts

printTileNumber
    lda #'T'
    sta $C000 + 160
    lda #'I'
    sta $C001 + 160
    lda #'L'
    sta $C002 + 160
    lda #'#'
    sta $C003 + 160

    lda map.tileNumber
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C005 + 160

    lda map.tileNumber
    and #$0F
    tay
    lda mHex, y
    sta $C006 + 160

    rts

printBmpPosition
    lda #'S'
    sta $C000 + 160 + 80
    lda #'B'
    sta $C001 + 160 + 80
    lda #'M'
    sta $C002 + 160 + 80
    lda #'P'
    sta $C003 + 160 + 80

    lda player.posBitmapX + 1
    jsr upper
    sta $C005 + 160 + 80

    lda player.posBitmapX + 1
    jsr lower
    sta $C006 + 160 + 80

    lda player.posBitmapX
    jsr upper
    sta $C007 + 160 + 80

    lda player.posBitmapX
    jsr lower
    sta $C008 + 160 + 80



    lda player.posBitmapY + 1
    jsr upper
    sta $C00a + 160 + 80

    lda player.posBitmapY + 1
    jsr lower
    sta $C00b + 160 + 80

    lda player.posBitmapY
    jsr upper
    sta $C00c + 160 + 80

    lda player.posBitmapY
    jsr lower
    sta $C00d + 160 + 80



    lda player.posX + 1
    jsr upper
    sta $C005 + 160 + 160

    lda player.posX + 1
    jsr lower
    sta $C006 + 160 + 160

    lda player.posX
    jsr upper
    sta $C007 + 160 + 160

    lda player.posX
    jsr lower
    sta $C008 + 160 + 160



    lda player.posY + 1
    jsr upper
    sta $C00a + 160 + 160

    lda player.posY + 1
    jsr lower
    sta $C00b + 160 + 160

    lda player.posY
    jsr upper
    sta $C00c + 160 + 160

    lda player.posY
    jsr lower
    sta $C00d + 160 + 160
    rts

printLocalTilePosition
    lda #'L'
    sta $C000 + 80
    lda #'O'
    sta $C001 + 80
    lda #'T'
    sta $C002 + 80
    lda #'I'
    sta $C003 + 80

    lda util.screenX
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C005 + 80

    lda  util.screenX
    and #$0F
    tay
    lda mHex, y
    sta $C006 + 80

    lda util.screenY
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C007 + 80

    lda util.screenY
    and #$0F
    tay
    lda mHex, y
    sta $C008 + 80
    rts

upper
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    rts

lower
    and #$0F
    tay
    lda mHex, y
    rts
mHex
    .text '0123456789ABCDEF'
mDebug
    .byte 0,0
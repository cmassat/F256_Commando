debug
    phy
    phx
    pha
    lda #2
    sta MMU_IO_CTRL
    lda player.posX + 1
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000

    lda player.posX + 1
    and #$0F
    tay
    lda mHex, y
    sta $C001

    lda player.posX
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002

    lda player.posX
    and #$0F
    tay
    lda mHex, y
    sta $C003
;; PLAYER POSITION
    lda player.posBitmapX + 1
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000  + 80

    lda player.posBitmapX + 1
    and #$0F
    tay
    lda mHex, y
    sta $C001   + 80


    lda player.posBitmapX
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002   + 80

    lda player.posBitmapX
    and #$0F
    tay
    lda mHex, y
    sta $C003   + 80


    lda map.posX
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C005  + 80

    lda map.posX
    and #$0F
    tay
    lda mHex, y
    sta $C006   + 80


    lda map.posY
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C007   + 80

    lda map.posY
    and #$0F
    tay
    lda mHex, y
    sta $C008   + 80

;; PLAYER POSITION
    lda util.tempX
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000  + 80  + 80

    lda util.tempX
    and #$0F
    tay
    lda mHex, y
    sta $C001   + 80  + 80


    lda util.tempY
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002   + 80  + 80

    lda util.tempY
    and #$0F
    tay
    lda mHex, y
    sta $C003 + 80  + 80


    lda util.xTile
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000   + 160 + 80

    lda util.xTile
    and #$0F
    tay
    lda mHex, y
    sta $C001   + 160 + 80


    lda util.yTile
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 160 + 80

    lda util.yTile
    and #$0F
    tay
    lda mHex, y
    sta $C003   + 160 + 80

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;

    lda map.tileNumber
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000   + 160 + 160

    lda map.tileNumber
    and #$0F
    tay
    lda mHex, y
    sta $C001   + 160 + 160


    ; lda  POINTER_SRC
    ; lsr
    ; lsr
    ; lsr
    ; lsr
    ; tay
    ; lda mHex, y
    ; sta $C003  + 160 + 80

    ; lda  POINTER_SRC
    ; and #$0F
    ; tay
    ; lda mHex, y
    ; sta $C004   + 160 + 80
    pla
    plx
    ply
    stz MMU_IO_CTRL

    rts
mHex
    .text '0123456789ABCDEF'
mDebug
    .byte 0,0
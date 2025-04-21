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

    pla
    plx
    ply
    stz MMU_IO_CTRL

    rts
mHex
    .text '0123456789ABCDEF'
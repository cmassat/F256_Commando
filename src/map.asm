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

;a x coordinate
;x y coordinate
getTile
    sta xTile
    stx yTile

    lda yTile
    asl
    tay
    lda lookupY,y
    sta tmpPos
    iny
    lda lookupY,y
    sta tmpPos + 1
    lda xTile
    clc
    adc xTile
    adc tmpPos
    sta tmpPos
    lda tmpPos + 1
    adc #0
    sta tmpPos + 1

    lda tmpPos
    sta POINTER_SRC
    lda tmpPos + 1
    adc #0
    sta POINTER_SRC + 1
    lda #$b3
    sta MMU_MEM_CTRL
    lda $d
    pha
    lda #$30
    sta $d
    nop
    nop
    nop
    nop
    nop
    ldy #0
    lda (POINTER_SRC),y
    sta tileNumber
    pla
    sta $d
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

    lda #width
    ldx #height
    jsr setMapSize

    lda #85
    ldx #0
    jsr setTilePositionY

    rts
.endsection 
.section variables
width= 21
height= 100
posX
    .byte 0,0
posY
    .byte 0,0
pixelsX
    .byte 0
pixelsY
    .byte 0

tmpPos
    .byte 0,0
xTile
    .byte 0
yTile
    .byte 0
tileNumber
    .byte 0
lookupY
.word $A000;each line * width of map
.word $A02A
.word $A054
.word $A07E
.word $A0A8
.word $A0D2
.word $A0FC
.word $A126
.word $A150
.word $A17A
.word $A1A4
.word $A1CE
.word $A1F8
.word $A222
.word $A24C
.word $A276
.word $A2A0
.word $A2CA
.word $A2F4
.word $A31E
.word $A348
.word $A372
.word $A39C
.word $A3C6
.word $A3F0
.word $A41A
.word $A444
.word $A46E
.word $A498
.word $A4C2
.word $A4EC
.word $A516
.word $A540
.word $A56A
.word $A594
.word $A5BE
.word $A5E8
.word $A612
.word $A63C
.word $A666
.word $A690
.word $A6BA
.word $A6E4
.word $A70E
.word $A738
.word $A762
.word $A78C
.word $A7B6
.word $A7E0
.word $A80A
.word $A834
.word $A85E
.word $A888
.word $A8B2
.word $A8DC
.word $A906
.word $A930
.word $A95A
.word $A984
.word $A9AE
.word $A9D8
.word $AA02
.word $AA2C
.word $AA56
.word $AA80
.word $AAAA
.word $AAD4
.word $AAFE
.word $AB28
.word $AB52
.word $AB7C
.word $ABA6
.word $ABD0
.word $ABFA
.word $AC24
.word $AC4E
.word $AC78
.word $ACA2
.word $ACCC
.word $ACF6
.word $AD20
.word $AD4A
.word $AD74
.word $AD9E
.word $ADC8
.word $ADF2
.word $AE1C
.word $AE46
.word $AE70
.word $AE9A
.word $AEC4
.word $AEEE
.word $AF18
.word $AF42
.word $AF6C
.word $AF96
.word $AFC0
.word $AFEA
.word $B014
.word $B03E

.endsection
.endnamespace
util .namespace
.section code
;a xLo
;x xHi
;y y only needs 8bits
;gets the tile number based on pixel
tileFromPixel
    jsr getScreenPosition
    lda xTile
    clc
    adc map.posX
    sta xTile

    lda yTile
    clc
    adc map.posY
    sta yTile

    rts
getYScreenPosition
    rts

getScreenPosition
    sta tempX
    stx tempX + 1
    tya
    jsr getRowLo
    lda tmpTile
    sta yTile
    sta screenY

    lda tempX + 1
    cmp #1
    beq _getHi
_getLow
    lda tempX
    jsr getRowLo
    lda tmpTile
    sta xTile
    sta screenX
    rts
_getHi
    lda tempX
    jsr getRowHi
    lda tmpTile
    sta xTile
    sta screenX
    rts

getRowHi
    cmp #$10
    bcc _15
    cmp #$20
    bcc _16
    cmp #$30
    bcc _17
    cmp #$40
    bcc _18
    rts
_15
    lda #$10
    sta tmpTile
    rts
_16
    lda #$11
    sta tmpTile
    rts
_17
    lda #$12
    sta tmpTile
    rts
_18
    lda #$13
    sta tmpTile
    rts

;a is lo 8 if msb is 0
getRowLo
    cmp #$10
    bcc _00
    cmp #$20
    bcc _01
    cmp #$30
    bcc _02
    cmp #$40
    bcc _03
    cmp #$50
    bcc _04
    cmp #$60
    bcc _05
    cmp #$70
    bcc _06
    cmp #$80
    bcc _07
    cmp #$90
    bcc _08
    cmp #$A0
    bcc _09
    cmp #$B0
    bcc _10
    cmp #$C0
    bcc _11
    cmp #$D0
    bcc _12
    cmp #$E0
    bcc _13
    cmp #$F0
    bcc _14
    bcs _15
    rts
_00
    lda #$0
    sta tmpTile
    rts
_01
    lda #$1
    sta tmpTile
    rts
_02
    lda #$2
    sta tmpTile
    rts
_03
    lda #$3
    sta tmpTile
    rts
_04
    lda #$4
    sta tmpTile
    rts
_05
    lda #$5
    sta tmpTile
    rts
_06
    lda #$6
    sta tmpTile
    rts
_07
    lda #$7
    sta tmpTile
    rts
_08
    lda #$8
    sta tmpTile
    rts
_09
    lda #$9
    sta tmpTile
    rts
_10
    lda #$A
    sta tmpTile
    rts
_11
    lda #$B
    sta tmpTile
    rts
_12
    lda #$C
    sta tmpTile
    rts
_13
    lda #$D
    sta tmpTile
    rts
_14
    lda #$E
    sta tmpTile
    rts
_15
    lda #$F
    sta tmpTile
    rts
.endsection 
.section variables 
tempX
    .byte 0,0
screenX
    .byte 0
screenY
    .byte 0
tmpTile
    .byte 0
yTile
    .byte 0
xTile
    .byte 0
.endsection
.endnamespace
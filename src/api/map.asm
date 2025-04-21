.section code
;------------------
;input a register
;set the appropiate 
;sprite pointer
;------------------
setTileMapNumber
    asl a
    tax
    lda mTileMapAttrAddr, x
    sta POINTER_TILE
    inx
    lda mTileMapAttrAddr, x
    sta POINTER_TILE + 1
    rts

;------------------
;input a,x,y register
;a = low
;x = mid
;y = hi
;set address of map
;------------------
setTileMapAddress
   phy 
   ldy #1
   sta (POINTER_TILE), y
  ; sta mTsaddr, y
   ldy #2
   txa
   sta (POINTER_TILE), y
   ;sta mTsaddr, y
   ply
   tya
   ldy #3
   sta (POINTER_TILE), y
   ldy #4
  ; lda #%00001000
   ; sta (POINTER_TILE), y
   ;sta mTsaddr, y
    ;sta $d201
    ;stx $d202
    ;sty $d203
    rts

;------------------
;input a,x register
;a = x size
;x = y size
;set size of map
;Also set default position
;------------------
setMapSize
    ldy #4
    sta (POINTER_TILE), y
    ldy #6
    txa
    sta (POINTER_TILE), y
    lda #$00
    ldy #8
    sta (POINTER_TILE), y
    lda #0
    ldy #9
    sta (POINTER_TILE), y
    lda #0
    ldy #10
    sta (POINTER_TILE), y
    lda #0
    ldy #11
    sta (POINTER_TILE), y
    ;sta $d204
    ;stx $d206
    rts

;a register is tile
;x register is pixels
setTilePositionY
    sta mTileTempA
    txa
    and #$0f
    sta mTileTempL
   
    lda mTileTempA
    asl
    asl
    asl
    asl
    ora mTileTempL
    sta mTileTempL

    lda mTileTempA
    lsr
    lsr
    lsr
    lsr
    sta mTileTempH
    ldy #10
    lda mTileTempL
    sta (POINTER_TILE), y
    ldy #11
    lda mTileTempH
    sta (POINTER_TILE), y
    rts

showTileMap0
    lda #$01
    sta $d200
    rts
showTileMap1
    lda #$01
    sta $D20C
    rts    
    ; lda #0
    ; sta $d208
    ; sta $d209
    ; sta $d20a
    ; sta $d20b
    ; rts
;------------------
;input a register
;set the appropiate 
;SET pointer
;------------------    
setTileSetNumber
    ;asl a
    ;tax
    ;lda mTileSetAttrAddr,x
    ;sta POINTER_SET
    ;inx
    ;lda mTileSetAttrAddr,x
    ;sta POINTER_SET + 1
    lda <#$D280
    sta POINTER_SET

    lda >#$D280
    sta POINTER_SET + 1
    rts

setTileSetAddress
    sta $D280
    stx $D281
    sty $D282
   ;phy 
   ;ldy #0
   ;sta (POINTER_SET), y
   ;
   ;ldy #1
   ;txa
   ;sta (POINTER_SET), y

   ;ply
   ;tya
   ;ldy #2
   ;sta (POINTER_SET), y
    rts
.endsection

.section variables
MAP161 = %00000001


mTileMapAttrAddr
 .word $D200
 .word $D20C
 .word $D218

mTileSetAttrAddr
 .word $D280
 .word $D284 
 .word $D288
 .word $D28C

mTileTempA
    .byte $00
mTileTempL
    .byte $00
mTileTempH
    .byte $00
.endsection
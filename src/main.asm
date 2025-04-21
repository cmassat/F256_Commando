*=$1000
.dsection variables

*=$2000
.dsection code


.section code
start
    jmp main

main
    stz MMU_IO_CTRL
    lda #00
    sta VKY_BKG_COL_B
    lda #$7c
    sta VKY_BKG_COL_R
    lda #$47
    sta VKY_BKG_COL_G

    ; jsr clearVideo
    ; jsr enableGrafix
    ; jsr enableSprite
    ; jsr enableTile
    ; jsr setVideo

    ; lda #0
    ; jsr setTileMapNumber

    ; lda #<mTileSetStart
    ; ldx #>mTileSetStart
    ; ldy #`mTileSetStart
    ; jsr setTileSetAddress

    ; lda #<mTileMapStart
    ; ldx #>mTileMapStart
    ; ldy #`mTileMapStart
    ; jsr setTileMapAddress

    ; lda #21
    ; ldx #100
    ; jsr setMapSize

    ; lda #85
    ; ldx #0
    ; jsr setTilePositionY
    jsr map.init

    lda #$20
    jsr setA000
    jsr clut_load_0

    lda #$21
    jsr setA000
    jsr clut_load_1

    lda #5
    jsr setA000
    lda #0



    stz MMU_IO_CTRL
    jsr initEvents
     jsr mmu_init ; initialize MMU library
    lda #<data_addr
    sta mmu_seekaddr
    lda #>data_addr
    sta mmu_seekaddr+1
    lda #`data_addr
    sta mmu_seekaddr+2
    jsr mmu_seek
    jsr init_vgm
    jsr vgm_start
    jsr vgm_play
    jsr showTileMap0

    jsr state.init
    jsr player.init

    jsr setFrameTimer
    jsr handleEvents

_gameLoop
    jmp _gameLoop
    rts
.endsection
.include "./api/f256k.asm"
.include "./api/kernel.asm"
.include "./api/video.asm"
.include "./api/map.asm"
.include "./api/clut.asm"
.include "./api/mmu.asm"
.include "./api/vgm_mmu.s"
.include "./api/vgm_play.s"
.include "./api/file_util.s"
.include "./api/file_loader.s"
.include "./api/sprite.asm"
.include "./api/vgm.s"
.include "./api/keyboard.asm"
.include "./events.asm"
.include "./state.asm"
.include "./player.asm"
.include "./map.asm"
.include "./debug.asm"
mMusic
*=$10000
.binary "../Assets/theme.mus"

mPalStart
*=$40000
    .binary "../Assets/tiles.pal"
*=$42000
    .binary "../Assets/sprite.pal"

mSpriteStart
*=$50000
    .binary "../Assets/sprite.bin"
*=$60000
mTileMapStart
    .binary "../Assets/lvl1.map"
*=$70000
mTileSetStart
    .binary "../Assets/tiles.bin"
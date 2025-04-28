*=$1000
.dsection variables

*=$2000
.dsection code

.section code
start
    jmp main

main
    jsr clearScreenMemory
    jsr hideAllSprites
    stz MMU_IO_CTRL
    lda #00
    sta VKY_BKG_COL_B
    lda #$7c
    sta VKY_BKG_COL_R
    lda #$47
    sta VKY_BKG_COL_G

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
    jsr showTileMap1

    jsr state.init
    jsr player.init
    jsr enemy.init
    jsr map.init

    jsr setFrameTimer
    jsr handleEvents

_gameLoop
    jmp _gameLoop
    rts
.endsection
.include "./constants/main.asm"
.include "./player/main.asm"
.include "./enemy/main.asm"
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

.include "./map.asm"
.include "./util.asm"
.include "./debug.asm"

*=$10000
mMusic
.binary "../Assets/theme.mus"

*=$40000
mPalStart0
    .binary "../Assets/tiles.pal"
mPalStart1
*=$42000
    .binary "../Assets/sprites.pal"
mBorderMap
    .binary "../Assets/border.map"
*=$50000
mSpriteStart
    .binary "../Assets/sprites.bin"
*=$60000
mTileMapStart
    .binary "../Assets/lvl1.map"
*=$70000
mTileSetStart
    .binary "../Assets/tiles.bin"
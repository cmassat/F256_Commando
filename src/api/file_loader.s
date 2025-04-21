.section code
load_clut0
    lda #<splash_pal
    ldx #>splash_pal
    ldy #$05
    jsr fopen
    rts



load_splash_vgm
    lda #<splash_bin
    ldx #>splash_bin
    ldy #VGM_BANK
    jsr fopen
    rts

.endsection

.section variables
splash_bin
    .text "theme2.mus",0

splash_pal
    .text "splash.pal",0
splash_vgm
    .text "hallow.mus",0
lvl1_set
    .text "lvl1.set",0

lvl1_pal
    .text "lvl1.pal",0

lvl1_map
    .text "lvl1.map",0

lvl1_bak_pal
    .text "bak.pal",0

lvl1_mus
    .text "beetle.mus",0

lvl1_bak_bin
    .text "bak.bin",0

sprite_pc_bin
    .text "pc.bin",0

sprite_pc_pal
    .text "pc.pal",0

sprite_npc_bin
    .text "npc.bin",0

sprite_npc_pal
    .text "npc.pal",0
.endsection

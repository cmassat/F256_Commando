state .namespace
.section code
init
    lda #startGame
    sta mState
    rts

isStart
    lda startGame
    beq _yes
    sec
    rts
_yes
    clc
    rts
.endsection

.section variables
startGame = 0
mState
    .byte 0
.endSection
.endnamespace
init 
    lda #status.inactive
    ldy #offsetStatus
    sta mEnemy0, y
    lda #0
    sta mFrame
    rts 
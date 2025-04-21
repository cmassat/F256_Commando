.section code
gameLoop
    jsr vgm_update
    lda mSOFSemaphore
    cmp #1
    bcs _run
    rts
_run
    pha
    phx
    phy
    jsr player.handle
    stz  mSOFSemaphore
    ply
    plx
    pla
rts

handScreenUpdate
    jsr map.handlePosition
    jsr player.handlePosition
    rts

handleEvents
    jsr gameLoop

_wait_for_event 
; Peek at the queue to see if anything is pending
    lda		kernel.args.events.pending  ; Negated count
    bpl		_done

    ; Get the next event.
    jsr		kernel.NextEvent
    bcs		_done

    ; Handle the event
    jsr		_dispatch
 _done
        ; Continue until the queue is drained.


    bra		handleEvents
    rts

 _dispatch
   ; Get the event's type
    lda	event.type

   ; Call the appropriate handler
    ; cmp	 #kernel.event.mouse.CLICKS
    ; beq	_mouse_clicked

    cmp #kernel.event.key.PRESSED
    beq keyPressed

    cmp #kernel.event.key.RELEASED
    beq keyReleased

    cmp #kernel.event.timer.EXPIRED
    beq handleTimerEvent

    ; cmp	 #kernel.event.mouse.DELTA
    ; beq	_mouse_moved
    rts

handleTimerEvent
    jsr sof_vgm
    jsr setFrameTimer
    inc mSOFSemaphore
    jsr handScreenUpdate
     ;jsr gameLoop
   ;  inc mGameTicks
   ;  lda mGameTicks
   ;  cmp #60
   ;  beq _updateSeconds
;	rts
;_updateSeconds
;    inc mGameSeconds
;    stz mGameTicks
    rts
keyPressed
    pha
    phx
    phy
    lda event.key.ascii
    sta mKeyPress
    jsr keyboardAnykey
    jsr keyboardPressed
    ply
    plx
    pla
    rts

keyReleased
    pha
    phx
    phy
    lda event.key.ascii
    sta mKeyRelease
    jsr keyboardReleased
    ply
    plx
    pla
    rts
setFrameTimer
    lda #0
	sta MMU_IO_CTRL
    lda #kernel.args.timer.FRAMES | kernel.args.timer.QUERY
    sta kernel.args.timer.units

    stz kernel.args.timer.absolute
    jsr kernel.Clock.SetTimer

    adc #1
    sta kernel.args.timer.absolute

    lda #kernel.args.timer.FRAMES
    sta kernel.args.timer.units

    jsr kernel.Clock.SetTimer
    rts
    
initEvents
    lda #<event
    sta kernel.args.events+0
    lda #>event
    sta kernel.args.events+1
    rts


.endsection

event	.dstruct	 kernel.event.event_t

.section variables
mFireTimer
    .byte $0
mSOFSemaphore
    .byte $00
mKeypress
    .byte $00
mKeyRelease
    .byte $01
v_sync
    .byte 0
mGameTicks
    .byte $00
mGameSeconds
    .byte $00
evtMouseDx
    .byte $00
evtMouseDy
    .byte $00
evtMouseBtn
    .byte $00
.endsection


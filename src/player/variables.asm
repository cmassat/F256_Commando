setupState = 0
moveState = 1
.section variables

mState
    .byte $0
mFrame
    .byte $0
mFrameTracker
    .byte $0
posX
    .byte 0,0
posY
    .byte 0,0

posBitmapX
    .byte 0,0
posBitmapY
    .byte 0,0
mDirection
    .byte 0
mSpriteAddressTop
    .byte 0,0,0
mSpriteAddressBot
    .byte 0,0,0
.endsection
offsetStatus = 0
offsetPosX = mPosX - mEnemy0
offsetPosY = mPosY - mEnemy0
offsetBmpX = mBmpX - mEnemy0
offsetBmpY = mBmpy - mEnemy0
offsetDir= mDirection - mEnemy0
offsetAddrTop = mEnemyAddressTop - mEnemy0
offsetAddrBot = mEnemyAddressBot - mEnemy0
mFrameTracker
    .byte $0
mFrame
    .byte $0
mEnemy0
mStatus
    .byte $0
mPosX
    .byte $0, $0
mPosY
    .byte $0, $0
mBmpX
    .byte $0, $0
mBmpY
    .byte $0, $0
mDirection
    .byte $0
mEnemyAddressTop
    .byte $0,$0,$0
mEnemyAddressBot
    .byte $0,$0,$0
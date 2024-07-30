.thumb
.equ ManaSapperID, SkillTester+4
.equ gBattleData, 0x203A4D4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr


@has mage slayer
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @defender data
ldr r1, ManaSapperID
.short 0xf800
cmp r0, #0
beq End

@make sure we're in combat (or battle forecast)
ldrb r3, =gBattleData
ldrb r3, [r3]
cmp r3, #4
beq End

@make sure the enemy is a mage
ldr r0,[r5,#0x4]
mov r1,#0x30
ldr r0,[r0,r1] @so this loads the unit's staff/anima/light/dark prof
cmp r0,#0x0
beq End @if they're all 0 the enemy is not a mage

mov  r6, #0x3A
ldrh r7, [r5, r6] @foe's magic
lsr  r7, #1       @divide foe's magic by 2
mov r1, #0x5E
ldrh r0, [r4, r1] @attack speed
add r0, r7
strh r0, [r4,r1]



End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD ManaSapperID

.thumb
.equ PowerHungryID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has Puissance
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, PowerHungryID
.short 0xf800
cmp r0, #0
beq End

@make sure we're in combat (or combat prep)
ldrb r3, =gBattleData
ldrb r3, [r3]
cmp r3, #4
beq End

ldrb r0, [r4, #0x14] @attacker str
ldrb r1, [r5, #0x14] @defender str
cmp r0, r1
bge End @skip if str is greater or equal

@add half of foe str to damage
mov r1, #0x5a
ldrh r0, [r4, r1] @atk user
mov r2, #0x5a
ldrh r3, [r5, r2] @atk foe
lsr r3,#1   @halves foe str
add r0, r3
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD PowerHungryID

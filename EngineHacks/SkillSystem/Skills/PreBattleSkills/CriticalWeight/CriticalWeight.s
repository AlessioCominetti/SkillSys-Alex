.thumb
.equ CriticalWeightID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@Has full inventory
mov r1, #0x26
ldrb r0, [r4, r1] @fifth item in inventory
cmp r0, #0x0 		 @This item is empty
beq End @skip if holding 4 items or less

@has CriticalWeightID
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, CriticalWeightID
.short 0xf800
cmp r0, #0
beq End

@add +15 crit
mov r1, #0x66
ldrh r0, [r4, r1] @add crit
add r0, #15
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD CriticalWeightID

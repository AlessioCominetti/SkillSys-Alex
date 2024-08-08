.thumb
.equ EvasiveManeuverID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@///
@under 50% hp
ldrb r0, [r4, #0x12]
lsr r0, #1 @max hp/2
ldrb r1, [r4, #0x13] @currhp
cmp r1, r0
bgt End

@has EvasiveManeuver
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @defender data
ldr r1, EvasiveManeuverID
.short 0xf800
cmp r0, #0
beq End

@add 2 Move
@///
ldr r1, =EvasiveManeuverID_Link
ldr r1,[r1]
cmp r0,#0
beq End
add r4,#2  @add Mov


End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD EvasiveManeuverID

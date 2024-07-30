.thumb
.equ EvasiveManeuverID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr



@Is Belle
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @defender data
ldr r1, EvasiveManeuverID
.short 0xf800
cmp r0, #0
beq End


ldrb r0, [r4, #0x12]
ldrb r1, [r4, #0x13]

lsr r0, #2 @max hp/4
cmp r1,r0
ble TwentyHP

lsl r2,r0,#0x1
cmp r1,r2
ble FiftyHP

add r2,r0
cmp r1,r2
bgt End

mov r2,#0x1
b Effect

FiftyHP:
mov r2,#0x2
b Effect

TwentyHP:
mov r2,#0x3


Effect:
mov r3,#0x1
mul r2,r3

mov r1, #0x1D
ldrh r0, [r4, r1] @Move
add r0, r2
strh r0, [r4,r1]


End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD EvasiveManeuverID

@Drive Def: allies within 2 spaces gain +4 defense in combat.
.equ DriveDefID, AuraSkillCheck+4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

mov r0, r5       @Move defender data into r1.
mov r1, #0x4c    @Move to the defender's weapon ability
ldr r1, [r0,r1]
mov r2, #0x42
tst r1, r2
bne     Done @do nothing if magic bit set
mov r2, #0x2
lsl r2, #0x10 @0x20000 negate def/res
tst r1, r2
bne Done

CheckSkill:
@now check for the skill
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
ldr r1, DriveDefID
mov r2, #0 @can_trade
mov r3, #5 @range
.short 0xf800
cmp r0, #0
beq Done

@ mov r0, r5
@ add     r0,#0x5A    @Move to the defender's damage.
@ ldrh    r3,[r0]     @Load the defender's damage into r3.
@ sub     r3,#4    @Subtract 4 from the defender's damage.
@ strh    r3,[r0]     @Store defender avoid.

@ Calculate distance and bonus
@r0=x1
@r1=y1
@r2=x2
@r3=y2
sub   r0, r2 @ X difference 
sub   r1, r3 @ Y difference 

@ Take coordinates'
@ absolute values.                
asr r3, r0, #31
add r0, r0, r3
eor r0, r3

asr r3, r1, #31
add r1, r1, r3
eor r1, r3

add r0, r1 @ distance in r0 
cmp r0, #6 @ if distance is 6 or more...
ble Done   @... skip

@testing
add r4, #0x77 @attacker resistence
ldrh r3, [r4]
add r3, r3, #6  @calculate using  6-distance, if distance is 1, bonus is maxxed at 5
sub r3, r3, r0
strh r3, [r4]


Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
AuraSkillCheck:
@ POIN AuraSkillCheck
@ WORD DriveDefID

@Drive Def: adjacent allies gain +4 defense in combat.
.equ DriveStrID, AuraSkillCheck+4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

mov r0, r4       @Move attacker data into r1.
mov r1, #0x4c    @Move to the attacker's weapon ability
ldr r1, [r0,r1]
mov r2, #0x42
tst r1, r2
bne     Done @do nothing if magic bit set

@now check for the skill
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
ldr r1, DriveStrID
mov r2, #0 @can_trade
mov r3, #5 @range
.short 0xf800
cmp r0, #0
beq Done

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
@add hit
add r4, #0x60 @attacker hit
ldrh r3, [r4]
add r3, r3, #6  @calculate using  6-distance, if distance is 1, bonus is maxxed at 5
sub r3, r3, r0
lsl r3, #2      @multiply hit by 4
strh r3, [r4]
@add avoid
add r4, #0x02 @attacker avoid
ldrh r3, [r4]
add r3, r3, #6  @calculate using  6-distance, if distance is 1, bonus is maxxed at 5
sub r3, r3, r0
lsl r3, #2      @multiply avoid by 4
strh r3, [r4]

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
AuraSkillCheck:
@ POIN AuraSkillCheck
@ WORD DriveStrID

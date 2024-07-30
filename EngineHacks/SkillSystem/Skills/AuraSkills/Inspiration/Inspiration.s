@Spur Def: adjacent allies gain +4 defense in combat.
.equ InspirationID, AuraSkillCheck+4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

CheckSkill:
@now check for the skill
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
ldr r1, InspirationID
mov r2, #0 @can_trade
mov r3, #3 @range
.short 0xf800
cmp r0, #0
beq Done

@ mov r0, r5
@ add     r0,#0x5A    @Move to the defender's damage.
@ ldrh    r3,[r0]     @Load the defender's damage into r3.
@ sub     r3,#3    @Subtract 3 from the defender's damage.
@ strh    r3,[r0]     @Store defender dmg.

@testing
mov r0, r4
add r0, #0x5c @attacker defense
ldrh r3, [r0]
add r3, #2
strh r3, [r0]

mov r0, r4
add     r0,#0x5A    @Move to the attacker's damage.
ldrh    r3,[r0]     @Load the attacker's damage into r3.
add     r3,#3    @add 3 damage.
strh    r3,[r0]     @Store dmg.

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
AuraSkillCheck:
@ POIN AuraSkillCheck
@ WORD InspirationID

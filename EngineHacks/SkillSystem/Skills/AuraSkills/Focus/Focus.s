@Focus: +10crit if no allies in 3 tiles.
.equ GetUnitsInRange, SkillTester+4
.equ FocusID, GetUnitsInRange+4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

CheckSkill:
@now check for the skill
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker
ldr r1, FocusID
.short 0xf800
cmp r0, #0
beq Done

@Check if there are allies in 5 spaces
ldr r0, GetUnitsInRange
mov lr, r0
mov r0, r4 @attacker
mov r1, #0 @allies
mov r2, #5 @range
.short 0xf800
cmp r0, #0
bne Done

mov r0, r4
add     r0,#0x66    @Move to the attacker's crit.
ldrh    r3,[r0]     @Load the attacker's crit into r3.
add     r3,#100    @add 100.
strh    r3,[r0]     @Store.

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
SkillTester:
@ POIN SkillTester
@ POIN GetUnitsInRange
@ WORD FocusID

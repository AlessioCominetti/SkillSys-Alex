.thumb
.equ BlowIDList, SkillTester+4
push {r4-r7, lr}
mov     r4,#0 @loop counter
ldr     r5,=0x203a4ec @attacker
cmp     r0,r5
bne     EndProgram @skip if unit isn't the attacker
mov     r6,r1 
ldr     r1, [r6,#4] @class number
cmp     r1, #0
beq     EndProgram
CheckLoop:
mov r0, r5
ldr     r2,BlowIDList   @Load in the list of Blow Skills.
ldrb    r1,[r2,r4]  @Load in the next Blow Skill in the list.
ldr     r3,SkillTester
mov     lr, r3     
.short 0xf800       @Call Skill Tester.
cmp r0, #0          @Check if unit has the corresponding Faire skill.
bne SkillChecks
SkillReturn:
add     r4, #0x01
cmp     r4, #0x0A
bne     CheckLoop
b       EndProgram
SkillChecks:
cmp     r4, #0x00
beq     DuelistsSkill
cmp     r4, #0x01
beq     DeathSkill
cmp     r4, #0x02
beq     DartingSkill
cmp     r4, #0x03
beq     WardingSkill
cmp     r4, #0x04
beq     CertainSkill
cmp     r4, #0x05
beq     ArmoredSkill
cmp     r4, #0x06
beq     QuickDrawSkill
cmp     r4, #0x07
beq     ChivalrySkill
cmp     r4, #0x08
beq     PragmaticSkill
cmp	r4, #0x09
beq	HeroesDeathSkill
cmp     r4, #0x0A
beq     VengefulSkill
cmp     r4, #0x0B
beq     DextrousSkill
cmp     r4, #0x0C
beq     ChannelingSkill
b SkillReturn
EndProgram:		@I had to move this to stop out of range errors. - Darrman
pop {r4-r7}
pop {r0}
bx r0
DuelistsSkill:
ldr     r0,=0x203A4EC       @Move attacker data into r0.
add     r0,#0x62    @Move to the attacker's avoid.
ldrh    r3,[r0]     @Load the attacker's avoid into r3.
add     r3,#0x1E    @Add 30 to the attacker's avoid.
strh    r3,[r0]     @Store attacker avoid.
b       SkillReturn

DeathSkill:
ldr     r0,=0x203A4EC       @Move attacker data into r0.
add     r0,#0x66    @Move to the attacker's crit.
ldrh    r3,[r0]     @Load the attacker's crit into r3.
add     r3,#0x14    @Add 20 to the attacker's crit.
strh    r3,[r0]     @Store attacker crit.
b       SkillReturn
DartingSkill:
ldr     r0,=0x203A4EC       @Move attacker data into r0.
add     r0,#0x5E    @Move to the attacker's AS.
ldrh    r3,[r0]     @Load the attacker's AS into r3.
add     r3,#0x05    @Add 5 to the attacker's AS.
strh    r3,[r0]     @Store attacker AS.
b       SkillReturn
WardingSkill:
ldr     r0,=0x203A56C       @Move defender data into r1.
mov r1, #0x4c    @Move to the defender's weapon ability
ldr r1, [r0,r1]
mov r2, #0x42
tst r1, r2
beq     SkillReturn @do nothing if magic bit not set
mov r2, #0x2
lsl r2, #0x10 @0x20000 negate def/res
tst r1, r2
bne SkillReturn
ldr r0, =0x203a4ec
@ add     r0,#0x5A    @Move to the defender's damage.
@ ldrh    r3,[r0]     @Load the defender's damage into r3.
@ sub     r3,#0x14    @Subtract 20 from the defender's avoid.
@ strh    r3,[r0]     @Store defender avoid.

@testing
add r0, #0x5c @attacker defense
ldrh r3, [r0]
add r3, #20
strh r3, [r0]

b       SkillReturn
CertainSkill:
ldr     r0,=0x203A4EC       @Move attacker data into r0.
add     r0,#0x60    @Move to the attacker's hit.
ldrh    r3,[r0]     @Load the attacker's hit into r3.
add     r3,#0x1E    @Add 30 to the attacker's hit.
strh    r3,[r0]     @Store attacker hit.
b       SkillReturn
ArmoredSkill:
ldr     r0,=0x203A56C       @Move defender data into r1.
mov r1, #0x4c    @Move to the defender's weapon ability
ldr r1, [r0,r1]
mov r2, #0x42
tst r1, r2
bne     SkillReturn @do nothing if magic bit set
mov r2, #0x2
lsl r2, #0x10 @0x20000 negate def/res
tst r1, r2
bne SkillReturn
ldr r0, =0x203a4ec
@ add     r0,#0x5A    @Move to the defender's damage.
@ ldrh    r3,[r0]     @Load the defender's damage into r3.
@ sub     r3,#10    @Subtract 20 from the defender's avoid.
@ strh    r3,[r0]     @Store defender avoid.

@testing
add r0, #0x5c @attacker defense
ldrh r3, [r0]
add r3, #10
strh r3, [r0]
b SkillReturn

QuickDrawSkill:
ldr     r0,=0x203A4EC       @Move attacker data into r0.
add     r0,#0x5a    @Move to the attacker's dmg.
ldrh    r3,[r0]     @Load the attacker's dmg into r3.
add     r3,#4    @Add 4 to the attacker's dmg.
strh    r3,[r0]     @Store attacker dmg.
b       SkillReturn

ChivalrySkill:
ldr r0, =0x203a56c @defender
ldrb r1, [r0, #0x12] @maxhp
ldrb r0, [r0, #0x13] @currhp
cmp r0, r1
bne SkillReturn
@allows unit to double attack
ldr r0,=0x203A4EC @Move attacker data into r0.
mov r0,r4
add r0,#0x4C @item ability word
ldr r1,[r0]
mov r2,#0x20 @brave flag
orr r1,r2
str r1,[r0]
b       SkillReturn

PragmaticSkill:
ldr r0, =0x203a56c @defender
ldrb r1, [r0, #0x12] @maxhp
ldrb r0, [r0, #0x13] @currhp
cmp r0, r1
beq SkillReturn
ldr r0,=0x203A4EC  @Move attacker data into r0.
mov r0,r4
add r0,#0x4C @item ability word
ldr r1,[r0]
mov r2,#0x20 @brave flag
orr r1,r2
str r1,[r0]
b       SkillReturn

HeroesDeathSkill:
ldr     r0,=0x203A4EC       @Move attacker data into r0.
add     r0,#0x5A    @Move to the attacker's attack.
ldrh    r3,[r0]     @Load the attacker's attack into r3.
add     r3,#0x6    @Add 6 to the attacker's attack.
strh    r3,[r0]     @Store attacker attack.
b       SkillReturn	@Attacker's attack. Redundancy? Nah.

DextrousSkill:
ldr     r0,=0x203A4EC       @Move attacker data into r0.
mov     r2,r0       @save a copy in r2
add     r0,#0x5A    @Move to the attacker's attack.
ldrh    r3,[r0]     @Load the attacker's attack into r3.
add     r2,#0x15   @load attacker skill
lsr     r2,#2      @divide skill by 4
add     r3,r2    @Skl to damage
strh    r3,[r0]     @Store attacker attack.
b       SkillReturn

VengefulSkill:    @add missing unit hp to hit and crit

ldr     r0,=0x203A4EC @Move attacker data into r0.
ldrb    r1,[r0,#0x12] @attacker max hp
ldrb    r2,[r0,#0x13] @attacker current hp
sub     r1,r2         @remaining hp
@ldrh    r2,[r4,r2]
@add     r2,r0,r2
@strh    r2,[r4,r2]
mov     r3,r0         @store remainig hp value

add     r0,#0x60    @Move to the attacker's hit.
ldrh    r2,[r0]     @Load the attacker's hit into r4.
add     r2,r3       @Add r3 (missing hp) to the attacker's hit.
strh    r2,[r0]     @Store attacker hit.

add     r0,#0x6     @Move to the attacker's crit.
ldrh    r2,[r0]     @Load the attacker's crit into r4.
add     r2,r3       @Add r3 (missing hp) to the attacker's crit.
strh    r2,[r0]     @Store attacker crit.

b       SkillReturn

ChannelingSkill:
ldr     r0,=0x203A4EC       @Move attacker data into r0.
add     r2,r0,#0x02        @move here charater status
cmp     r2,#0x0C     @check if unit didn't move
beq Skillreturn
add     r0,#0x66    @Move to the attacker's crit.
ldrh    r3,[r0]     @Load the attacker's crit into r3.
add     r3,#0x64    @Add 100 to the attacker's crit.
strh    r3,[r0]     @Store attacker crit.
b       SkillReturn

.align
.ltorg
SkillTester:
@POIN SkillTester
@POIN BlowIDList

.thumb
.equ AwakenedID, SkillTester+4

push {r4-r5, lr}
mov	r4, r0 @attacker

@has skill
ldr	r0, SkillTester
mov	lr, r0
mov	r0, r4
ldr	r1, AwakenedID
.short	0xf800
cmp	r0, #0
beq	End

@get turn
ldr	r5,=#0x202BCF0
ldrh	r5, [r5,#0x10]
mov	r0, #0x01
sub	r5, r0
cmp	r5, #0x10       @turn 16 in hexadecimal
bls	SkipSet
mov	r5, #0x10       @add damage

SkipSet:
@add turn/4 to damage (if turn is higher than 16, add 4)
mov	r0, #0x5A
ldrh	r1, [r4,r0]	@load attack
lsr     r5, #2          @divide by 4
add	r1, r5		@add turn to attack (max 4)
strh	r1, [r4,r0]     @store


End:
pop	{r4-r5, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD AwakenedID

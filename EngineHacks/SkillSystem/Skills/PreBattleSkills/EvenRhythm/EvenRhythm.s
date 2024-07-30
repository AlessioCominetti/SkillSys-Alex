.thumb
.equ EvenRhythmID, SkillTester+4

push	{r4, lr}
mov	r4, r0 @attacker
mov	r5, r1 @defender

@check if turn is even
ldr	r0,=#0x202BCF0
ldrh	r0, [r0,#0x10]
mov	r1, #0x01
and	r0, r1
cmp	r0, #0x00
bne	End

@has skill
ldr	r0, SkillTester
mov	lr, r0
mov	r0, r4
ldr	r1, EvenRhythmID
.short	0xf800
cmp	r0, #0
beq	Other

@add 10 to hit and avoid
mov	r0, #0x60
ldrh	r1, [r4,r0]	@load hit
add	r1, #0x0A	@add 10 to hit
strh	r1, [r4,r0]     @store

mov	r0, #0x62
ldrh	r1, [r4,r0]	@load avoid
add	r1, #0x0A	@add 10 to avoid
strh	r1, [r4,r0]     @store

beq     End

@add 10 to crit and crit avoid
mov	r0, #0x66
ldrh	r1, [r4,r0]	@load crit
add	r1, #0x0A	@add 10 to crit
strh	r1, [r4,r0]     @store

mov	r0, #0x68
ldrh	r1, [r4,r0]	@load crit avoid
add	r1, #0x0A	@add 10 to crit avoid
strh	r1, [r4,r0]     @store


Other:
End:
pop	{r4, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD EvenRhythmID

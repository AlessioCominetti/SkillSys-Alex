.thumb
.equ LuckySevenID, SkillTester+4

push {r4, lr}
mov	r4, r0 @attacker

@check if turn is bigger than three
ldr	r0,=#0x202BCF0
ldrh	r0, [r0,#0x10]
cmp	r0, #0x03
bhi	End

@has skill
ldr	r0, SkillTester
mov	lr, r0
mov	r0, r4
ldr	r1, LuckySevenID
.short	0xf800
cmp	r0, #0
beq	End

@add 2 to move
ldr r1, =LuckySevenID_Link
ldr r1,[r1]
bl SkillTester
cmp r0,#0
beq End
add r4,#2   @add 2 move

End:
pop	{r4, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD LuckySevenID

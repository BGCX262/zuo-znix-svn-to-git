/////////////////////////////////////////////////////
/*         2012-09-19                                                     */
/*         znix start block                                                 */
/*          zuo yipeng                                                      */
/////////////////////////////////////////////////////
#include <s3c2410.h>

.extern	main
	
.text 
.global _start 
_start:
/*
�ж�����
*/
	b	start_code
	ldr	pc, _undefined_instruction
	ldr	pc, _software_interrupt
	ldr	pc, _prefetch_abort
	ldr	pc, _data_abort
	ldr	pc, _not_used
	ldr	pc, _irq
	ldr	pc, _fiq

_undefined_instruction:	.word undefined_instruction
_software_interrupt:	.word software_interrupt
_prefetch_abort:	.word prefetch_abort
_data_abort:		.word data_abort
_not_used:		.word not_used
_irq:			.word irq
_fiq:		      .word fiq
/*
ȫ�ַ��ű�
*/

_TEXT_BASE:
	.word	TEXT_BASE

.globl _armboot_start
_armboot_start:
	.word _start

.globl _bss_start
_bss_start:
	.word  bss_start

.globl _bss_end
_bss_end:
	.word bss_end

.globl FREE_RAM_END
FREE_RAM_END:
	.word	0x0badc0de

.globl FREE_RAM_SIZE
FREE_RAM_SIZE:
	.word	0x0badc0de

.globl PreLoadedONRAM
PreLoadedONRAM:
	.word	0

/*���뿪ʼ*/
start_code:
	b  Reset
Reset:
	/*
	 ����SVC32 
	 */
	mrs	r0, cpsr
	bic	r0, r0, #0x1f
	orr	r0, r0, #0xd3
	msr	cpsr, r0
	/* �ع� */
	ldr	r0, =pWTCON
	mov	r1, #0x0
	str	r1, [r0]
	/*���ж�*/
	ldr r0, =INTMSK
	mov	r1, #0xffffffff
	str r1,[r0]
	ldr  r1, =0x7fff          
	ldr  r0, =INTSUBMSK
	str  r1, [r0]
	/*����*/
	/*����Ƶ��*/
	/*�ڴ��ʼ��*/
	/*copyϵͳ���ڴ沢��ת��main*/
/*�жϺ���*/	
	
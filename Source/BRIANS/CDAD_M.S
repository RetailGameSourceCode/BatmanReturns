;****************************************************************************
;*                                                                          *
;*			PCM AUDIO DRIVER (MIDI COMPATIBLE)		    *			    *
;*									    *
;* MIDI CONTROL INTERFACE & DRIVER FOR					    *
;* SEGA MEGA CD-ROM (RF5C164 PCM Sound Source)				    *
;*									    *		
;*                                                                          *
;*									    *
;* Developed by:	Brian Howarth                                       *
;*			MALIBU INTERACTIVE INC.				    *
;*                                                                          *
;****************************************************************************
;*                                                                          *
;* MODULE FOR MAIN_CPU							    *
;*									    *
;* FEBRUARY 1 1993 							    *
;*									    *
;****************************************************************************

Z80PATCH	equ	$80
Z80_CMD		equ	$FF
Z80_PRG		equ	$02
Z80_NON		equ	$00
Z80_NOF		equ	$01
Z80_PWC		equ	$04
Z80_ALLNOF	equ	$05
Z80_PAUSE	equ	$0C
Z80_RESUME	equ	$0D
Z80_LEV		equ	$1F

NTOF		equ	$80	;Note Off
NTON		equ	$90	;Note On
VOLM		equ	$B7
EOTRK		equ	$BF
PRGM		equ	$C0	;Program Change

; NOTE VALUE EQUATES - Octave 0

C00		equ	00
C01		equ	01
C0S		equ	01
D0F		equ	01
D00		equ	02
D01		equ	03
D0S		equ	03
E0F		equ	03
E00		equ	04
F00		equ	05
F01		equ	06
F0S		equ	06
G0F		equ	06
G00		equ	07
G01		equ	08
G0S		equ	08
A0F		equ	08
A00		equ	09
A01		equ	10
A0S		equ	10
B0F		equ	10
B00		equ	11

;Octave 1

C10		equ	12
C11		equ  	13
C1S		equ	13
D1F		equ	13
D10		equ	14
D11		equ	15
D1S		equ	15
E1F		equ	15
E10		equ	16
F10		equ	17
F11		equ	18
F1S		equ	18
G1F		equ	18
G10		equ	19
G11		equ	20
G1S		equ	20
A1F		equ	20
A10		equ	21
A11		equ	22
A1S		equ	22
B1F		equ	22
B10		equ	23

;Octave 2

C20		equ	24
C21		equ	25
C2S		equ	25
D2F		equ	25
D20		equ	26
D21		equ	27
D2S		equ	27
E2F		equ	27
E20		equ	28
F20		equ	29
F21		equ	30
F2S		equ	30
G2F		equ	30
G20		equ	31
G21		equ	32
G2S		equ	32
A2F		equ	32
A20		equ	33
A21		equ	34
A2S		equ	34
B2F		equ	34
B20		equ	35

;Octave 3

C30		equ	36	;Middle Note
C31		equ	37
C3S		equ	37
D3F		equ	37
D30		equ	38
D31		equ	39
D3S		equ	39
E3F		equ	39
E30		equ	40
F30		equ	41
F31		equ	42
F3S		equ	42
G3F		equ	42
G30		equ	43
G31		equ	44
G3S		equ	44
A3F		equ	44
A30		equ	45
A31		equ	46
A3S		equ	46
B3F		equ	46
B30		equ	47

;Octave 4

C40		equ	48
C41		equ	49
C4S		equ	49
D4F		equ	49
D40		equ	50
D41		equ	51
D4S		equ	51
E4F		equ	51
E40		equ	52
F40		equ	53
F41		equ	54
F4S		equ	54
G4F		equ	54
G40		equ	55
G41		equ	56
G4S		equ	56
A4F		equ	56
A40		equ	57
A41		equ	58
A4S		equ	58
B4F		equ	58
B40		equ	59

;Octave 5

C50		equ	60
C51		equ	61
C5S		equ	61
D5F		equ	61
D50		equ	62
D51		equ	63
D5S		equ	63
E5F		equ	63
E50		equ	64
F50		equ	65
F51		equ	66
F5S		equ	66
G5F		equ	66
G50		equ	67
G51		equ	68
G5S		equ	68
A5F		equ	68
A50		equ	69
A51		equ	70
A5S		equ	70
B5F		equ	70
B50		equ	71

;Octave 6

C60		equ	72
C61		equ	73
C6S		equ	73
D6F		equ	73
D60		equ	74
D61		equ	75
D6S		equ	75
E6F		equ	75
E60		equ	76
F60		equ	77
F61		equ	78
F6S		equ	78
G6F		equ	78
G60		equ	79
G61		equ	80
G6S		equ	80
A6F		equ	80
A60		equ	81
A61		equ	82
A6S		equ	82
B6F		equ	82
B60		equ	83

;Octave 7

C70		equ	84
C71		equ	85
C7S		equ	85
D7F		equ	85
D70		equ	86
D71		equ	87
D7S		equ	87
E7F		equ	87
E70		equ	88
F70		equ	89
F71		equ	90
F7S		equ	90
G7F		equ	90
G70		equ	91
G71		equ	92
G7S		equ	92
A7F		equ	92
A70		equ	93
A71		equ	94
A7S		equ	94
B7F		equ	94
B70		equ	95

;Octave 8

C80		equ	96
C81		equ	97
C8S		equ	97
D8F		equ	97
D80		equ	98
D81		equ	99
D8S		equ	99
E8F		equ	99
E80		equ	100
F80		equ	101
F81		equ	102
F8S		equ	102
G8F		equ	102
G80		equ	103
G81		equ	104
G8S		equ	104
A8F		equ	104
A80		equ	105
A81		equ	106
A8S		equ	106
B8F		equ	106
B80		equ	107


; - Z80 startup and download main code. ------------------------------------

INIT_AUDIO_MAIN	move.w	MCDC_MODE,D0
		or.w	#%0000011100000000,D0
		move.w	D0,MCDC_MODE

		move.w	#$100,Z80Reset	; Z80 bus reset off

		move.w	#$100,Z80BusReq	; Z80 bus request on
hzlp		btst.b	#0,Z80BusReq	; spin on bus grant
		bne.s	hzlp
	
		lea	Z80_0,A0	;copy from 68k to z80 addr space
		move.l	Z80CLEN,D0	;length to move
		lea	Z80Ram,A1
lzlp1		move.b	(A0)+,(A1)+
		dbra	D0,lzlp1

lzlp2		move.b	#0,(A1)+	; zero fill remainder of 8k block
		cmpa.l	#(Z80Ram+$2000),A1
		bne.s	lzlp2

;Start the Z80
		move.w	#$0,Z80Reset	;Z80 bus reset on (assumes bus request on)
		move.l	#15,D0	  	;a loop > 26 uS
szlp		subq.l	#1,D0
		bne.s	szlp
		move.w	#$0,Z80BusReq	;Z80 bus request off
		move.w	#$100,Z80Reset	;Z80 bus reset off
	       	rts

; - Z80 startup ret. -------------------------------------------------------



AUDIO_VBL_MAIN	movem.l	A0-A2/D0-D2,-(SP)

; - Z80 com. ---------------------------------------------------------------

		move.l	#MAIN_SND_XBUFF,BUFFADD

		tst.w	MSFX_FLAG
		beq	z80_00

		lea	MAIN_SFX_XBUFF,A0
		move.l	A0,BUFFADD
		move.w	#0,(A0)+

		moveq.l	#0,D2
		lea	MMC_BLOKS,A1
		
z80_02		tst.l	MMC_PNTR(A1)
		beq	z80_01


		
z80_08		sub.w	#1,MMC_ticks(A1)
		bpl	z80_01

		move.l	MMC_PNTR(A1),A2
		addq	#1,A2
		moveq.l	#0,D0
z80_09		move.b	(A2),D0

		cmp.b	#PRGM,D0
		bne	z80_03

		move.b	#Z80_CMD,(A0)+
		move.b	#Z80_PRG,(A0)+
		move.b	D2,(A0)+
		addq	#1,A2
		move.b	(A2)+,(A0)+
		add.w	#4,MAIN_SFX_XBUFF
		bra	z80_09		


z80_03		cmp.b	#VOLM,D0
		bne	z80_04
		
		move.b	#Z80_CMD,(A0)+
		move.b	#Z80_LEV,(A0)+
		move.b	D2,(A0)+
		addq	#1,A2
		move.b	(A2)+,(A0)+
		add.w	#4,MAIN_SFX_XBUFF
		bra	z80_09		

z80_04		cmp.b	#NTON,D0
		bne	z80_05

		move.b	#Z80_CMD,(A0)+
		move.b	#Z80_NON,(A0)+
		move.b	D2,(A0)+
		addq	#1,A2
		move.b	(A2)+,D0
		add.b	#12,D0
		move.b	D0,(A0)+
		add.w	#4,MAIN_SFX_XBUFF
		bra	z80_09		


z80_05		cmp.b	#NTOF,D0
		bne	z80_06

		move.b	#Z80_CMD,(A0)+
		move.b	#Z80_NOF,(A0)+
		move.b	D2,(A0)+
		addq	#1,A2
		move.b	(A2)+,D0
		add.b	#12,D0
		move.b	D0,(A0)+
		add.w	#4,MAIN_SFX_XBUFF
		bra	z80_09		

		
z80_06		cmp.b	#EOTRK,D0
		bne	z80_07

		move.b	#Z80_CMD,(A0)+
		move.b	#Z80_ALLNOF,(A0)+
		move.b	D2,(A0)+
		addq	#1,A2
		move.b	(A2)+,(A0)+
		add.w	#4,MAIN_SFX_XBUFF

		move.l	#0,MMC_PNTR(A1)
		move.w	#0,MMC_ticks(A1)
		bra	z80_01

z80_07		move.w	D0,MMC_ticks(A1)
		move.l	A2,MMC_PNTR(A1)
		bra	z80_08	


z80_01		adda.l	#MMC_BLOKLEN,A1
		addq	#1,D2
		cmp	#MMC_NUMBLOKS,D2
		bne	z80_02			
		



z80_00		move.w	#$100,Z80BusReq		;Z80 bus request on

		movea.l	BUFFADD,A0		;A0-> SUB to MAIN Xfer Buffer
		lea	Z80Ram+$36,A1 		;A1-> Z80 Write Pointer
		lea	Z80Ram+$1C40,A2		;A2-> Z80 FIFO

z80w0		btst.b	#0,Z80BusReq   		;wait for bus grant
		bne.s	z80w0



		move.w	(A0)+,D2
		beq	z80exit			;buffer empty?

		move.b	(A1),D1	      		;Read FIFO index from Z80 ram
z80loop		move.b	(A0)+,D0
		ext.w	D1	      		;extend to 16 bits
		move.b	D0,(A2,D1.w)  		;write into FIFO
		addq.b	#1,D1	      		;inc write index
		andi.b	#$3F,D1			;mod 64
       		subq.w	#1,D2			;Sent everything?
		bne	z80loop			;loop back if not
		move.b	D1,(A1)	      		;Done so update FIFO pointer

z80exit

		bsr	JOY1_READ		;now read the Joysticks
	 	move.b	D0,JOY1VAL
 	  	bsr	JOY2_READ
	   	move.b	D0,JOY2VAL

;		bsr	JOY0_READ		;now read the Joysticks
;	 	move.w	D0,MCOM_MDATA+MCOM_JOY0
; 	  	bsr	JOY1_READ
;	   	move.w	D0,MCOM_MDATA+MCOM_JOY1

		move.w	#0,Z80BusReq  		;Release Z80 (bus req off)

		movem.l	(SP)+,A0-A2/D0-D2
		clr.w	MAIN_SND_XBUFF
		rts
		
; - Z80 com ret. -----------------------------------------------------------

MMC_NUMBLOKS	equ	2
		rsreset
MMC_pntr	rs.l	1
MMC_ticks	rs.w	1
MMC_BLOKLEN	rs.b	0

MMC_BLOKS	dc.l	0
		dc.w	0
		dc.l	0
		dc.w	0

MSFX_FLAG	dc.w	0
BUFFADD		dc.l	0
MAIN_SFX_XBUFF	ds.b	128

MAIN_SEQS	dc.w	93
		dc.l	MSFX00
		dc.w	94
		dc.l	MSFX01
		dc.w	95
		dc.l	MSFX02
		dc.w	96
		dc.l	MSFX03
		dc.w	$FF


MSFX00		dc.b	0,PRGM,103
		dc.b	1,VOLM,127
		dc.b	1,NTON,C40,4,NTOF,C40
		dc.b	1,PRGM,115
		dc.b	1,NTON,A2S,6,NTOF,A2S
		dc.b	1,EOTRK
		EVEN

MSFX01		dc.b	0,PRGM,115
		dc.b	1,VOLM,125
		dc.b	1,NTON,C40,2,NTOF,C40
		dc.b	0,NTON,D40,4,NTOF,D40
		dc.b	1,EOTRK		
		EVEN

MSFX02		dc.b	0,PRGM,115
		dc.b	1,VOLM,127
		dc.b	1,NTON,G40,2,NTOF,G40
		dc.b	0,NTON,A40,4,NTOF,A40
		dc.b	1,EOTRK		
		EVEN

MSFX03		dc.b	0,PRGM,115
		dc.b	1,VOLM,127
		dc.b	1,NTON,G30,2,NTOF,G30
		dc.b	1,NTON,C40,3,NTOF,C40
		dc.b	0,NTON,A40,2,NTOF,A40
		dc.b	1,NTON,A40,2,NTOF,A40
		dc.b	1,NTON,C50,3,NTOF,C50
		dc.b	1,EOTRK		
		EVEN		

PLAYMAINSFX
		IF	BATMAN_MUSIC
		IF	CD_ROMVERSION
		IF	GENESISCODE

		move.w	#1,MSFX_FLAG

		movem.l	A0-A1/D0-D5,-(SP)

		and.w	#$7F,D5

		lea	MAIN_SEQS,A1
pmsfx_1		tst.w	(A1)
		bmi	pmsfx_0
		cmp.w	(A1),D5
		bne	pmsfx_2

		movea.l	2(A1),A1
		moveq.l	#0,D2
		lea	MMC_BLOKS,A0
pmsfx_3		tst.l	MMC_pntr(A0)
		bne	pmsfx_4

		move.l	A1,MMC_pntr(A0)
		moveq.l	#0,D0
		move.b	(A1),D0
		move.w	D0,MMC_ticks(A0)
		bra	pmsfx_0

pmsfx_4		adda.l	#MMC_BLOKLEN,A0
		addq	#1,D2
		cmp.w	#MMC_NUMBLOKS,D2
		bne	pmsfx_3
		bra	pmsfx_0
		
pmsfx_2		addq	#6,A1
		bra	pmsfx_1
		
pmsfx_0		movem.l	(SP)+,A0-A1/D0-D5
		rts


CLOSE_MSEQ	movem.l	A0/D0,-(SP)
cms_3		move.w	#0,MSFX_FLAG

		lea	MMC_BLOKS,A0
		moveq.l	#0,D0
cms_0		tst.l	MMC_pntr(A0)
		beq	cms_1

		move.w	#1,MSFX_FLAG
		bra	cms_2

cms_1		adda.l	#MMC_BLOKLEN,A0
		addq	#1,D0
		cmp.w	#MMC_NUMBLOKS,D0
		bne	cms_0
		

cms_2		tst.w	MSFX_FLAG
		bne	cms_3

		movem.l	(SP)+,A0/D0
		rts

		ENDIF
		ENDIF
		ENDIF

STOPMAINSFX	IF	BATMAN_MUSIC
		IF	CD_ROMVERSION
		IF	GENESISCODE
		rts
		ENDIF
		ENDIF
		ENDIF

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
;* MODULE FOR SUB_CPU (Code,Data)					    *
;*									    *
;* APRIL 6 1993 							    *
;*									    *
;****************************************************************************
;*									    *
;*	 		USER CALLABLE ROUTINES				    *
;*									    *
;* PLAY_SONG								    *
;* PLAY_SFX	       							    *	
;* STOP_SFX								    *
;* SEND_EVENT -	SRT_START						    *
;*		SRT_STOP						    *
;*		SRT_CONTINUE						    *
;*									    *
;****************************************************************************
;
ON		equ	1
OFF		equ	0

MIDI_IN		equ	OFF
VELOCITY	equ	OFF						    *
RUNNING_STATUS	equ	OFF						    *
CONTROL_14_BIT	equ	OFF						    *

; GENERAL DEFAULTS

COFF_CNT	equ	5	;VBL count from STOP-SFX until Chan Free.

DEF_PCM_MLEV	equ	127	;MASTER VOLUME FOR PCM CHIP

DEF_Z80_MLEV	equ	127	;MASTER VOLUME FOR Z80 FM & PSG CHIP

; MIDI Channel Defaults

MC_DEF_prgrm	equ	0
MC_DEF_panlr	equ	$40
MC_DEF_pbend	equ	$2000
MC_DEF_level	equ	127
MC_DEF_plevp	equ	127
MC_DEF_plevz	equ	127
MC_DEF_trans	equ	0

;****************************************************************************

SUB_INT3_JMP	equ	$5F84

SUB_INT3_TIMER	equ	$ff8030
SUB_INT_MASK	equ	$ff8032

ISR_BLKLN	equ	4095
LEVEL0		equ	0

MIDI_bufsize	equ	128
EVNT_bufsize	equ	128
Z80_XBSIZE	equ	128

PCM_ON		equ	$80
PCM_OFF		equ	0

NO_PCM		equ	$80

INHIBIT		equ	1
UNINHIBIT	equ	0

PENDING		equ	%01000000
;									    *
MSW_ON		equ	$7F	;Controller above midway or ON
MSW_OFF		equ	$00	;Controller below or OFF
;
;****************************************************************************
;Status Bytes
;
NTOF		equ	$80	;Note Off
NTON		equ	$90	;Note On
PKPR		equ	$A0	;Poly Key Pressure
CTRL		equ	$B0	;Control Change
PRGM		equ	$C0	;Program Change
CHPR		equ	$D0	;Channel Pressure
PWCH		equ	$E0	;Pitch Wheel Change

SRT_START	equ	$FA	;System Real-Time START
SRT_CONTINUE	equ	$FB	;System Real-Time CONTINUE
SRT_STOP	equ	$FC	;System Real-Time STOP

META		equ	$FF	;Meta Event

SS		equ	$7F	;sequencer specific META EVENT
GTO		equ	$1E
JTO		equ	$1F
STOPSFXONEI	equ	$20	;stop 1 instance of a SFX sequence
STOPSFXMULI	equ	$21	;stop all instances of a SFX sequence
STOPSFXALLI	equ	$22	;stop all SFX
PBM		equ	$23	;start Pitch Bend Macro
VLM		equ	$24	;start Volume Macro

EOTRK		equ	$2F

;Controller (CTRL) ID Nums.

VOLM		equ	$07	;MSB for Main Volume Controller
VOL14L		equ	$27	;LSB for Main Volume Controller
PANM		equ	$0A	;MSB for PAN Controller
PAN14L		equ	$2A	;LSB for PAN Controller
SUST		equ	$40	;Damper Pedal (Sustain)
ALL_NOTES_OFF	equ	$7B	;All notes off for the voice channel


Z80PATCH	equ	$80
Z80_CMD		equ	$FF
Z80_PRG		equ	$02
Z80_NON		equ	$00
Z80_NOF		equ	$01
Z80_PWC		equ	$04
Z80_ALLNOF	equ	$05
Z80_PAUSE	equ	$0C
Z80_RESUME	equ	$0D
Z80_STOPALL	equ	$16
Z80_LEV		equ	$1F
;********************************

PCM_BaseAddress	equ	$00FF0000
PCM_ENV		equ	PCM_BaseAddress
PCM_PAN		equ	PCM_BaseAddress+2
PCM_FDL		equ	PCM_BaseAddress+5
PCM_FDH		equ	PCM_BaseAddress+7
PCM_LSL		equ	PCM_BaseAddress+8
PCM_LSH		equ	PCM_BaseAddress+10
PCM_ST		equ	PCM_BaseAddress+12
PCM_CTL		equ	PCM_BaseAddress+14
PCM_ONF		equ	PCM_BaseAddress+16

PCM_Ch0PtrL	equ	PCM_BaseAddress+($10*2)	;lsb
PCM_Ch0PtrH	equ	PCM_BaseAddress+($11*2)	;msb
PCM_Ch1PtrL	equ	PCM_BaseAddress+($12*2)	;lsb
PCM_Ch1PtrH	equ	PCM_BaseAddress+($13*2)	;msb
PCM_Ch2PtrL	equ	PCM_BaseAddress+($14*2)	;lsb
PCM_Ch2PtrH	equ	PCM_BaseAddress+($15*2)	;msb
PCM_Ch3PtrL	equ	PCM_BaseAddress+($16*2)	;lsb
PCM_Ch3PtrH	equ	PCM_BaseAddress+($17*2)	;msb
PCM_Ch4PtrL	equ	PCM_BaseAddress+($18*2)	;lsb
PCM_Ch4PtrH	equ	PCM_BaseAddress+($19*2)	;msb
PCM_Ch5PtrL	equ	PCM_BaseAddress+($1A*2)	;lsb
PCM_Ch5PtrH	equ	PCM_BaseAddress+($1B*2)	;msb
PCM_Ch6PtrL	equ	PCM_BaseAddress+($1C*2)	;lsb
PCM_Ch6PtrH	equ	PCM_BaseAddress+($1D*2)	;msb
PCM_Ch7PtrL	equ	PCM_BaseAddress+($1E*2)	;lsb
PCM_Ch7PtrH	equ	PCM_BaseAddress+($1F*2)	;msb


WAVEMEMORY	equ	PCM_BaseAddress+$2000
WAVEBANKSIZE	equ	$1000

NUMPCMCHANS	equ	8


; ADSR ENVELOPE EQUATES 

eADSR00		equ	0
eADSR01		equ	1
eADSR02		equ	2
eADSR03		equ	3
eADSR04		equ	4
eADSR05		equ	5
eADSR06		equ	6
eADSR07		equ	7
eADSR08		equ	8
eADSR09		equ	9
eADSR10		equ	10
eADSR11		equ	11
eADSR12		equ	12
eADSR13		equ	13
eADSR14		equ	14
eADSR15		equ	15
eADSR16		equ	16
eADSR17		equ	17
eADSR18		equ	18
eADSR19		equ	19
eADSR20		equ	20
LASTe		equ	eADSR20+1


; NOTE DURATION EQUATES

nd1		equ	96
nd2		equ	48
nd4		equ	24
nd8		equ	12
nd16		equ	6
nd32		equ	3

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



;*****************************************************************************
;*****************************************************************************
;*****************************************************************************			

; PCM CHANNEL CONTROL BLOCK STRUCTURE

;*****************************************************************************			
;
; Hardware Shadow Registers per channel
;
		rsreset
PCM_ENVshd	rs.w	1
PCM_PANshd	rs.w	1
PCM_FDHshd	rs.b	1
PCM_FDLshd	rs.b	1
PCM_LSHshd	rs.w	1
PCM_LSLshd	rs.w	1
PCM_STshd	rs.w	1
;
; Software Vars for Note/Channel Control
;			  -------------------------------------------------
;			  |Bit7 |Bit6 |Bit5 |Bit4 |Bit3 |Bit2 |Bit1 |Bit0 |
;			  -------------------------------------------------

PCM_FLGsts	rs.b	1 ;1=on	 1=new
PCM_MIDchn	rs.b	1
PCM_MIDpit	rs.b	1
PCM_MIDsfx	rs.b	1
PCM_ENVslh	rs.w	1
PCM_ENVptr	rs.w	1
PCM_ENVtim	rs.w	1
PCM_ENVlst	rs.w	1
PCM_ENVsll	rs.b	1
PCM_ENVsl0	rs.b	1
PCM_ENVdtlA	rs.b	1
PCM_ENVdtrA	rs.b	1
PCM_ENVdtlD	rs.b	1
PCM_ENVdtrD	rs.b	1	
PCM_ENVdtlS	rs.b	1
PCM_ENVdtrS	rs.b	1
PCM_ENVdtlR	rs.b	1
PCM_ENVdtrR	rs.b	1
PCM_WVHptr	rs.b	1
PCM_WVLptr	rs.b	1	
PCM_WVBnum	rs.b	1
		rs.b	1
PCM_BLKLN	rs.b	0	
;*****************************************************************************			

; MIDI CHANNEL CONTROL BLOCK STRUCTURE

;*****************************************************************************			
  		rsreset
MC_addrs	rs.l	1
MC_index	rs.l	1
MC_wsrce	rs.l	1
MC_paddr	rs.l	1	; address of current patch block
MC_PBadd	rs.l	1	; current macro stage, 0 is inactive
MC_PBtim	rs.w	1	; current stage ticks left
MC_pbend	rs.w	1
MC_z80no	rs.w	3	; z80 note number
MC_wavst	rs.w	1
MC_stats	rs.w	1
MC_pg68k	rs.b	1
MC_pgz80	rs.b	1
MC_panlr	rs.b	1
MC_level	rs.b	1
MC_plevp	rs.b	1
MC_plevz	rs.b	1
MC_trans	rs.b	1	; current Channel Transpose value
MC_ticks	rs.b	1

MC_BLKLN	rs.b	0
;*****************************************************************************			
;
; PATCH CONTROL BLOCK STRUCTURE 
;
;*****************************************************************************
		rsreset
PCH_prt0	rs.b	1	; Partial Tone #0 = 0-127 or 128-255 (FM/PSG)
PCH_trn0	rs.b	1	; Transpose from recorded pitch
PCH_wst0	rs.w	1	; offset into Waveform for START
PCH_wls0	rs.w	1	; offset of Loop Start
PCH_wle0	rs.w	1	; offset of Loop End
PCH_env0	rs.b	1	; ADSR #
PCH_pan0	rs.b	1	; Initial Pan Value
PCH_lev0	rs.b	1	; Volume of Tone0

PCH_prt1	rs.b	1	; Partial Tone #1 = 0-127 or 128-255 (FM/PSG)
PCH_trn1	rs.b	1	; Transpose Tone 1
PCH_lev1	rs.b	1	; Level for Tone 1

PCH_BLKLN	rs.b	0
;*****************************************************************************			
;
; WAVEFORM CONTROL BLOCK STRUCTURE
;
;*****************************************************************************			
		rsreset
WAVE_ADDRS	rs.l	1	; Address of Source Wave	 
WAVE_LENGT	rs.l	1	; Length of Source Wave
WAVE_STMEM	rs.w	1	; Start PCM_WaveMem # (-ve if not loaded)	
WAVE_COMPR	rs.w	1	; Compress(0=NO, 1=Delta)
WAVE_HDLEN	rs.b	0
;*****************************************************************************			
;
; ADSR CONTROL BLOCK STRUCTURE 
;
;*****************************************************************************			
		rsreset
ADSR_AL0	rs.b	1	; Level to Attack to 
ADSR_AT0	rs.b	1	; Ticks for A stage
ADSR_DL0	rs.b	1	; Level to Decay to
ADSR_DT0	rs.b	1	; Ticks for D stage
ADSR_SL0	rs.b	1	; Level of Sustain
ADSR_ST0	rs.b	1	; Time of Sustain
ADSR_RL0	rs.b	1
ADSR_RT0	rs.b	1	; Ticks for R stage (from note off)
ADSR_BLKLN	rs.b	0
;*****************************************************************************			
;
; SFX CONTROL BLOCK STRUCTURE 
;
;*****************************************************************************			
			rsreset
EC_HANDLE	rs.w	1	;Handle - Set to 0 by caller to init 
EC_SFXNUM	rs.b	1	;SFX Number to run
EC_SFXNML	rs.b	1
EC_XREL		rs.w	1	;X distance relative to Camera
EC_ZREL		rs.w	1	;Z distance relative to Camera
EC_PARM0	rs.w	1	;First parameter GFORCE, SPEED, etc. 
EC_PARM1	rs.w	1	;Second parameter

;*****************************************************************************			

BUMPINDEX	MACRO
		addq.l	#1,D1
		and.l	D4,D1
		ENDM

BUMP_Z80WP	MACRO
		addq.l	#1,D5
		and.l	#Z80_XBSIZE-1,D5
		ENDM

Z80BYTE		MACRO		
		move.b	\1,0(A5,D5.w)
		addq.l	#1,D5
		and.l	#Z80_XBSIZE-1,D5
		ENDM

Z80CHAN		MACRO
		move.b	Curchan+1,0(A5,D5.w)
		addq.l	#1,D5
		and.l	#Z80_XBSIZE-1,D5
		ENDM

Z80D0BY		MACRO		
		move.b	D0,0(A5,D5.w)
		addq.l	#1,D5
		and.l	#Z80_XBSIZE-1,D5
		ENDM

Z80D1BY		MACRO		
		move.b	D1,0(A5,D5.w)
		addq.l	#1,D5
		and.l	#Z80_XBSIZE-1,D5
		ENDM


Z80D2BY		MACRO		
		move.b	D2,0(A5,D5.w)
		addq.l	#1,D5
		and.l	#Z80_XBSIZE-1,D5
		ENDM

;****************************************************************************
;
; AUDIO routines (primary event controller for entire Audio Driver)

AUDIO_VBL_SUB	tst.w	PCM_inhibit		; Is the Inhibit flag set?
		bne	PCM_VBL_skip		; exit if it is
		
		movem.l	A0-A6/D0-D7,-(SP)

		move.w	#0,SUBS_XBUFF
		lea	SUBS_BBUFF,A5
		move.l	XBW_PNT,D5

		tst.w	AUDIO_PAUSED		;are we in PAUSE mode?
		bmi	CHK_evbuff


; Check all Midi Channels and Execute appropriate events
;
		move.l	#-1,D4			;Set Wraparound limit
		move.w	#0,LIVE_CHANS
		move.w	#0,Curchan
				
		lea	MC_BLOKS,A0		;point to MIDI Chan Blocks
mvbl00		tst.l	MC_addrs(A0)		;is it in use?
		beq	mvbl01			;no so skip to next

		move.w	#1,LIVE_CHANS
		cmp.l	#1,MC_addrs(A0)		;going off?
		bne	mvbl05
		sub.l	#1,MC_index(A0)		;dead yet?
		bne	mvbl01

		moveq.l	#0,D0
		move.l	D0,MC_addrs(A0)
		move.l	D0,MC_paddr(A0)
		move.l	D0,MC_PBadd(A0)
		move.w	#-1,MC_PBtim(A0)
		lea	SFX_STATTAB,A3
		move.w	MC_stats(A0),D0
		and.l	#$7F,D0
		tst.b	0(A3,D0.w)
		beq	mvbl06
		subi.b	#1,0(A3,D0.w)				
mvbl06		bra	mvbl01		
		

mvbl05		tst.l	MC_PBadd(A0)		;is a PB Macro running?
		beq	mvbl03

		tst.w	MC_PBtim(A0)
		bmi	mvbl03

		move.w	MC_pbend(A0),D0
		move.l	MC_PBadd(A0),A1
		add.w	2(A1),D0
		move.w	D0,MC_pbend(A0)
		movea.l	MC_paddr(A0),A3
		tst.b	PCH_prt1(A3)
		bpl	ntz80p0

		eor.w	#$C000,D0
		asr.w	#2,D0
		Z80BYTE	#Z80_CMD		;send "CMD" to main
		Z80BYTE	#Z80_PWC		;send "PWC" to main
		Z80CHAN				;send "Midi Channel" to main
		Z80D0BY				;send "Pitch Wheel" to main
		asr.w	#8,D0
		Z80D0BY

ntz80p0		subi.w	#1,MC_PBtim(A0)
		bpl	mvbl03

		addq.l	#4,A1
		move.w	(A1),MC_PBtim(A0)
		bpl	mvbl00a

		movea.l	#0,A1
		move.w	#MC_DEF_pbend,D0
		move.w	D0,MC_pbend(A0)
		tst.b	PCH_prt1(A3)
		bpl	mvbl00a

		eor.w	#$C000,D0
		asr.w	#2,D0
		Z80BYTE	#Z80_CMD		;send "CMD" to main
		Z80BYTE	#Z80_PWC		;send "PWC" to main
		Z80CHAN				;send "Midi Channel" to main
		Z80D0BY				;send "Pitch Wheel" to main
		asr.w	#8,D0
		Z80D0BY

mvbl00a		move.l	A1,MC_PBadd(A0)

mvbl03		subi.b	#1,MC_ticks(A0)		;has delta ticks reached 0?
		bpl	mvbl01			;Not yet

		movea.l	MC_addrs(A0),A1		;get current seq base pointer
		move.l	MC_index(A0),D1		;get current index pointer
		BUMPINDEX
		move.b	0(A1,D1.w),D0		;get the next event
		bpl	mvbl02			;+ve means not status byte

		BUMPINDEX
		lea	META_EVENT,A2
		cmp.b	#META,D0
		beq	mvbl04
			
		move.b	D0,D2
		andi.l	#$70,D2			;mask out the LS nibble
		lsr.l	#2,D2			;convert to index
		lea	MIDI_STTAB,A2
		movea.l	0(A2,D2.w),A2
mvbl04		jsr	(A2)			;jsr to the Trk Event routine

mvbl02		cmp.l	#1,MC_addrs(A0)
		beq	mvbl01
		move.l	D1,MC_index(A0)		;store the pointer
		tst.l	MC_addrs(A0)		;was it EOTRK?
		beq	mvbl01			;yes so exit

		move.b	0(A1,D1.w),MC_ticks(A0)	;store the new delta
		bra	mvbl00

mvbl01		adda.l	#MC_BLKLN,A0
		addi.w	#1,Curchan
		cmpi.w	#16,Curchan
		bne	mvbl00

;------------------------------------------------
; Now check the Event (EVNT) Buffer

CHK_evbuff	move.l	EVNT_buftail,D1
		cmp.l	EVNT_bufhead,D1
		beq.s	evblx1

		lea	EVNT_buf,A1
		move.l	#EVNT_bufsize-1,D4

evbl0		cmp.l	EVNT_bufhead,D1
		beq.s	evblx0

		move.b	0(A1,D1.w),D0
		BUMPINDEX
		tst.b	D0
		bpl	evbl0

evbl1  		lea	META_EVENT,A2
		cmp.b	#META,D0
		beq	evbl2
		
		move.b	D0,D2	    		
		and.l	#15,D2			;get MIDI Channel #
		move.w	D2,Curchan
		mulu.w	#MC_BLKLN,D2
		lea	MC_BLOKS,A0		;Point to MIDI Control Block
		adda.l	D2,A0

		move.b	D0,D2
		andi.l	#$70,D2			;mask out the LS nibble
		lsr.l	#2,D2			;convert to index
		lea	MIDI_STTAB,A2
		movea.l	0(A2,D2.w),A2
evbl2		jsr	(A2)			;jsr to the Event routine

		tst.w	AUDIO_PAUSED
		bpl.s	evbl0

evblx0		move.l	D1,EVNT_buftail		;update the buffer pointer	
evblx1
		

; Reads Midi from External device and merges data internally
; NB: Not implemented yet

;------------------------------------------------

XBUFF_TERMINATE	move.l	D5,XBW_PNT	
		cmp.l	XBR_PNT,D5
		beq	CHK_PCM

		lea	SUBS_XBUFF+2,A0
		move.l	XBR_PNT,D5
xbt000		move.b	0(A5,D5.w),(A0)+

		IF	FM_INC
		addi.w	#1,SUBS_XBUFF
		ENDIF
		addq.l	#1,D5
		and.l	#Z80_XBSIZE-1,D5
		cmp.l	XBW_PNT,D5
		beq	xbt001
		cmp.w	#62,SUBS_XBUFF
		bne	xbt000	

xbt001		move.l	D5,XBR_PNT		

;------------------------------------------------
; Update PCM Voice Channels

CHK_PCM		tst.w	AUDIO_PAUSED
		bmi	PCM_VBL_exit
		
		lea	PCM_BLOKS,A0
		move.w	PCM_ONFshd,D1
		move.w	D1,-(SP)		;push it for now

		move.w	#0,D3			;Current PCM Channel

udpcm00		move.w	D3,D0
		ori.w	#%11000000,D0
		move.w	D0,PCM_CTLshd
		move.w	D0,PCM_CTL

		move.b	PCM_FLGsts(A0),D0
		and.b	#%11000000,D0		;is chan on or pending?
		beq	gnextc


		move.b	PCM_MIDchn(A0),D1
		and.l	#$0F,D1
		mulu.w	#MC_BLKLN,D1
		lea	MC_BLOKS,A1
		adda.l	D1,A1


		cmp.b	#%01000000,D0		;pending ON?
		beq	udpcm01

		cmp.b	#%11000000,D0		;pending OFF?
		bne	udpcm02

;----------------------------------------
; update for a current voice note OFF

		tst.l	MC_addrs(A1)
		beq	envdone			;was its MIDI Chan dead?
		cmp.l	#1,MC_addrs(A1)
		beq	envdone

		moveq	#0,D0
		move.b	PCM_ENVdtrR(A0),D0	;release rate
		beq	envdone			;kill immediately

		move.b	D0,PCM_ENVsl0(A0)	;store ticks for R phase
		move.w	PCM_ENVshd(A0),D0
		beq	envdone			;zero so kill it anyway!
		
		move.w	D0,PCM_ENVlst(A0)	;store it's current val
		neg.w	D0
		move.w	D0,PCM_ENVslh(A0)	;store the slope
		move.w	#6,PCM_ENVptr(A0)	;store the pointer
		move.w	#0,PCM_ENVtim(A0)	;zero timer
		
		bclr.b	D3,PCM_nonflag		;clear its quick ref flag	

		move.b	#$80,PCM_FLGsts(A0)	;reset the pending bit
		bra	gnextc

;----------------------------------------
; update for a new channel being started

udpcm01		move.b	#%10000000,PCM_FLGsts(A0)
		bclr.b	D3,PCM_ONFshd+1
		
;set loop parms
		move.w	PCM_LSHshd(A0),PCM_LSH
		move.w	PCM_LSLshd(A0),PCM_LSL
		move.w	PCM_STshd(A0),PCM_ST	

;----------------------------------------
; common for new & current, get ENV first

udpcm02

;ENV calc	
		cmpi.b	#$ff,PCM_ENVsl0(A0)		;sustain phase?
		bne	envclc3

		moveq	#0,D0
		move.b	PCM_ENVdtlS(A0),D0		;sustain level
		beq	envdone

		move.w	#1,D1
		bra	envclc2

envclc3		addi.w	#1,PCM_ENVtim(A0)
		move.w	PCM_ENVtim(A0),D0
		move.w	D0,D1
		muls.w	PCM_ENVslh(A0),D0
		divs.w	PCM_ENVsll(A0),D0
		add.w	PCM_ENVlst(A0),D0
		bmi	envclc4
		cmp.w	#256,D0
		bcs	envclc2
		move.w	#255,D0
		bra	envclc2
envclc4		move.w	#0,D0


envclc2		move.w	D0,PCM_ENVshd(A0)
		cmp.w	PCM_ENVsll(A0),D1
		bne	Chk_freq	;Chk_volume		

envclc0		addi.w	#2,PCM_ENVptr(A0)		;bump to next stage
		cmpi.w	#8,PCM_ENVptr(A0)		;is R stage over
		beq	envdone				;yes so kill voice

		move.w	D0,PCM_ENVlst(A0)		;store the level
		move.w	#0,PCM_ENVtim(A0)		;zero the time
		move.w	PCM_ENVptr(A0),D1		;get stage pointer
		moveq	#0,D2
		move.b	PCM_ENVdtlA(A0,D1.w),D2		;get next level
		sub.w	D0,D2				;find the difference
		move.w	D2,PCM_ENVslh(A0)		;store it for slope
		move.b	PCM_ENVdtrA(A0,D1.w),PCM_ENVsl0(A0)
		bne	Chk_freq ;Chk_volume

		add.w	D2,D0
		move.w	PCM_ENVsll(A0),D1
		bra	envclc2

envdone		move.b	#0,PCM_FLGsts(A0)
		move.w	#0,PCM_ENVshd(A0)
		move.w	#0,PCM_ENV
		bset.b	D3,PCM_ONFshd+1
		bclr.b	D3,PCM_useflag
		bclr.b	D3,PCM_nonflag
		bra	gnextc

;------------------------------------------------
; Update the frequency
; (Pitch bend, Pitch Transpose, Tune)
;
;FDH/FDL calc
Chk_freq	move.w	PCM_FDHshd(A0),D1

		move.w	MC_pbend(A1),D0
 		
		and.l	#$3FFF,D0
		sub.w	#$2000,D0
		beq	pbc1			;no difference
		bpl	pbc0			;positive increase
		
		neg	D0
		move.w	D1,D2
		lsr.w	#3,D2
		sub.w	D2,D1
		mulu.w	D0,D1
		lsr.l	#7,D1
		lsr.l	#7,D1
		neg	D1
		add.w	PCM_FDHshd(A0),D1
		bra	pbc1

pbc0		asl.w	#3,D1			;get the octave value
		sub.w	PCM_FDHshd(A0),D1	;calc the offset
		mulu.w	D0,D1
		lsr.l	#7,D1
		lsr.l	#7,D1
		add.w	PCM_FDHshd(A0),D1	;add the base value

pbc1		move.b	D1,PCM_FDL		;set the LSB
		lsr.w	#8,D1
		move.b	D1,PCM_FDH		;set the MSB

;------------------------------------------------
; Update the Level
;
Chk_volume	moveq.l	#0,D0

		move.l	D0,D1
		move.b	MC_plevp(A1),D0
		move.b	MC_level(A1),D1
		mulu.w	D1,D0
		lsr.w	#7,D0			;divu.w	#$7F,D0

		mulu.w	PCM_MASTER_LEV,D0
		lsr.w	#7,D0			;divu.w	#$7F,D0

		mulu.w	PCM_ENVshd(A0),D0
		lsr.w	#7,D0			;divu.w	#$7F,D0
		move.w	D0,PCM_ENVshd(A0)
		move.w	D0,PCM_ENV

;------------------------------------------------
; Update the PAN control
;
Chk_Panlr	move.b	MC_panlr(A1),D0
		lsr.w	#2,D0
		and.l	#31,D0
		lea	PANTAB,A4
		move.b	0(A4,D0.w),D0

		IF	MONO_SFX
		tst.w	STEREO_MONO
		beq	monpan
		move.w	#$FF,D0
monpan
		ENDIF
		move.w	D0,PCM_PANshd(A0)
		move.w	D0,PCM_PAN

;------------------------------------------------
;
gnextc		adda.l	#PCM_BLKLN,A0
		addi.w	#1,D3
		andi.w	#7,D3
		bne	udpcm00

		move.w	(SP)+,D1		;retrieve ON/OFF
		cmp.w	PCM_ONFshd,D1		;has it changed?
		beq	PCM_VBL_exit		;no so exit

		move.w	PCM_ONFshd,PCM_ONF	;update the chan ON/OFF reg.
		
PCM_VBL_exit	movem.l	(SP)+,A0-A6/D0-D7
PCM_VBL_skip	rts


;****************************************************************************

PLAY_SONG	rts

;****************************************************************************

PLAY_SFX	move.w	#1,PCM_inhibit
		move.l	(SP)+,Ret_addr
		link	A6,#0
		movem.l	A0-A4/D0-D4,-(SP)
		
		move.w	#-1,AUDIO_STATUS	;preset error status
		tst.w	AUDIO_PAUSED
		bmi	psfxx			;can't do that whilst paused!

		lea	SFX_STATTAB,A3
		move.w	6(A6),D0		;get SFX #
		and.l	#$7F,D0
		move.b	0(A3,D0.w),D1
		lea	SFX_INSTTAB,A3
		cmp.b	0(A3,D0.w),D1
		bcc	psfxx		

		move.l	4(A6),D0		;Get SFX #
		and.l	#$7F,D0
		asl.l	D0
		lea	SFX_ADDR_TAB,A1
		move.w	0(A1,D0),D0		;get the sequence address
		adda.l	D0,A1
		move.l	A1,A4			;hold SFX base in A4
		moveq.l	#0,D3
		move.b	(A1)+,D3		;D3=# of Tracks for this SFX

; now find a free MIDI channel for this sequence

		moveq.l	#0,D4			;Init D4 as MIDI channel #
		lea	MC_BLOKS,A0
mch_lp0		cmp.w	#16,D4			;run out of channels?
		beq	psfxx
		tst.l	MC_addrs(A0)		;is it zero i.e. free?
		bne	mch_lp1			;no so go bump it

		moveq.l	#0,D1			;init the channel
		move.l	D1,MC_PBadd(A0)
		move.l	D1,MC_index(A0)		;zero the Track Index Pointer
		move.b	D1,MC_ticks(A0)		;zero the Ticker
		move.b	(A1)+,D1
		asl.w	#8,D1
		move.b	(A1)+,D1
		add.l	A4,D1
		move.l	D1,MC_addrs(A0)		;store sequence pointer
		
		tst.w	AUDIO_STATUS		;have we already tagged
		bpl	gotmc0			;a MIDI Channel?

		lea	SFX_STATTAB,A3
		move.w	6(A6),D0		;get SFX #
		and.l	#$7F,D0
		addi.b	#1,0(A3,D0.w)		;add another instance of SFX

		move.w	D4,AUDIO_STATUS		;put MIDI Chan # in ret stat

gotmc0		move.w	6(A6),MC_stats(A0)	;store the seq # (ls 7 bits)
		move.b	#MC_DEF_level,MC_level(A0)	;Transfer "Level"
		moveq.l	#0,D0
		move.b	MC_stats(A0),D0
		beq	gotmc1

		lsr.w	D0
		add.w	#90,D0
		cmp.w	#128,D0
		bcs	lvadj0
		move.w	#127,D0
lvadj0		move.b	D0,MC_level(A0)

gotmc1		adda.l	#MC_BLKLN,A0
		addq	#1,D4
		dbra	D3,mch_lp0		;go try next chan. up
		bra	psfxx

mch_lp1		adda.l	#MC_BLKLN,A0
		addq	#1,D4
		bra	mch_lp0

psfxx		movem.l	(SP)+,A0-A4/D0-D4
		unlk	A6
		addq.l	#4,SP
		move.l	Ret_addr,-(SP)
		move.w	#0,PCM_inhibit
		rts

;****************************************************************************

; STOP_SFX ->	SFX Number (Long word pushed onto Stack)
;		Preserves ALL regs
;		Clips all notes belonging to this SFX

STOP_SFX	
		move.l	(SP)+,Ret_addr
		link	A6,#0
		movem.l	A0/D0,-(sp)
		
		move.w	#0,AUDIO_STATUS		;reset error status

		tst.b	7(A6)
		beq	nstop0

		move.l	EVNT_bufhead,D0
		lea	EVNT_buf,A0

		move.b	#META,0(A0,D0.w)
		addq.l	#1,D0
		and.l	#EVNT_bufsize-1,D0

		move.b	#SS,0(A0,D0.w)
		addq.l	#1,D0
		and.l	#EVNT_bufsize-1,D0

		move.b	#STOPSFXMULI,0(A0,D0.w)
		addq.l	#1,D0
		and.l	#EVNT_bufsize-1,D0

		move.b	7(A6),0(A0,D0.w)	;SFX #
		addq.l	#1,D0
		and.l	#EVNT_bufsize-1,D0

		move.l	D0,EVNT_bufhead

nstop0		movem.l	(SP)+,A0/D0
		unlk	A6
		addq.l	#4,SP
		move.l	Ret_addr,-(SP)
		rts

;****************************************************************************

; STOP_ALL_SFX ->	No entry Parameters

STOP_ALL_SFX	tst.w	AUDIO_PAUSED
		bmi	sasfxx

		movem.l	A0/D0,-(sp)

		move.l	EVNT_bufhead,D0
		lea	EVNT_buf,A0

		move.b	#META,0(A0,D0.w)
		addq.l	#1,D0
		and.l	#EVNT_bufsize-1,D0

		move.b	#SS,0(A0,D0.w)
		addq.l	#1,D0
		and.l	#EVNT_bufsize-1,D0

		move.b	#STOPSFXALLI,0(A0,D0.w)
		addq.l	#1,D0
		and.l	#EVNT_bufsize-1,D0

		move.l	D0,EVNT_bufhead

.vwait		tst.w	LIVE_CHANS
		bne.s	.vwait

		movem.l	(SP)+,A0/D0
sasfxx		rts

;****************************************************************************

; SEND_EVENT - Send any MIDI event to the Driver
;		
; Entry example:	move.l	#MY_EVNT_STR,-(SP)
;			jsr	SEND_EVENT
 
SEND_EVENT	move.l	(SP)+,Ret_addr
		link	A6,#0
		movem.l	A0-A1/D0-D1,-(SP)
		clr.w	AUDIO_STATUS			;clear the Err flag
		move.l	EVNT_bufhead,D1
		lea	EVNT_buf,A1
		movea.l	4(A6),A0

		tst.w	AUDIO_PAUSED			;are we paused?
		bpl	sev01

		cmpi.b	#SRT_CONTINUE,1(A0)		;paused, so only
		beq	sev01				;accept CONTINUE					
		move.w	#-1,AUDIO_STATUS
		bra.s	sev0x2

sev01		moveq	#0,D0

sev0l  		cmp.b	(A0),D0
		beq.s	sev0x
		
		move.b	1(A0,D0.w),0(A1,D1.w)
		addq	#1,D0
		addq	#1,D1
		and.l	#EVNT_bufsize-1,D1
		bra.s	sev0l

sev0x		move.l	D1,EVNT_bufhead

sev0x2		movem.l	(SP)+,A0-A1/D0-D1
		unlk	A6
		addq.l	#4,SP
		move.l	Ret_addr,-(SP)	
		rts


;***************************************

; General Flags etc.

PCM_MASTER_LEV	dc.w	0
Z80_MASTER_LEV	dc.w	0
STEREO_MONO	dc.w	0

PCM_drvflag	dc.w	0
PCM_inhibit	dc.w	INHIBIT		;to ensure VBL routine is inactive
PCM_useflag	dc.b	0
PCM_nonflag	dc.b	0
PCM_SaveArea	dc.w	0
LIVE_CHANS	dc.w	0

SysExBank	dc.l	0

TOT_FM_NONS	dc.w	0

Curchan		dc.w	0
CurVoic		dc.w	0
BHtimer		dc.w	0
Ret_addr	dc.l	0
AUDIO_PAUSED	dc.w	0
AUDIO_STATUS	dc.w	0
PCM_source	dc.l	0
PCM_destination	dc.l	0
PCM_count	dc.w	0
PCM_CTL_ISR	dc.w	0

SFX_STATTAB	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
CSFX_EVNT_STR	dc.b	0,0,0,0,0,0

;***************************************
; Hardware Shadow Registers
; Common Registers

PCM_CTLshd	dc.w	0		;Main Control Register
PCM_ONFshd	dc.w	0	    	;Chan ON/OFF
PCM_BLOKS	ds.b	8*PCM_BLKLN
PCM_WaveMems	ds.b	32
PCM_WaveMemX

MC_BLOKS	ds.b	16*MC_BLKLN

;*****************************************************************************

		IF	MIDI_IN

; FIFO MIDI buffer for all externally generated events

MIDI_Buf	ds.b	MIDI_BufSize
MIDI_BufHead	dc.l	0
MIDI_BufTail	dc.l	0

		ENDIF

;*****************************************************************************

; FIFO buffer for all internally generated events

EVNT_buf	ds.b	EVNT_bufsize
EVNT_bufhead	dc.l	0
EVNT_buftail	dc.l	0

SUBS_XBUFF	ds.b	64		;Matches size of Z80 FIFO
SUBS_BBUFF	ds.b	Z80_XBSIZE

XBW_PNT		dc.l	0
XBR_PNT		dc.l	0

;*****************************************************************************
;
;		MIDI FUNCTIONS
;
;*****************************************************************************
;
FQTAB
C00_00	dc.w	$0080,136,144,152,161,171,181,192,203,215,229,242
C10_12	dc.w	$0100,271,287,304,323,342,362,384,406,431,456,483
C20_24	dc.w	$0200,542,575,609,645,683,724,767,813,861,912,967
C30_36	dc.w	$0400,1085,1149,1218,1290,1367,1448,1534,1625,1722,1825,1933
C40_48	dc.w	$0800,2070,2299,2435,2580,2734,2896,3068,3251,3444,3649,3866
C50_60	dc.w	$1000,4340,4598,4871,5161,5468,5793,6137,6502,6889,7298,7732
C60_72	dc.w	$2000,8679,9195,9742,10321,10935,11585,12274,13004,13777,14596,15464
C70_84	dc.w	$4000,$43ce,$47d6,$4c1b,$50a2,$556e
	dc.w	$5a82,$5fe4,$6597,$6ba2,$7208,$78d0
C80_96	dc.w	$8000,$879c,$8fac,$9837,$a145,$aadc
	dc.w	$b504,$bfc8,$cb2f,$d744,$e411,$f1a1

MIDI_STTAB	dc.l	NOTE_OFF		; 8n
		dc.l	NOTE_ON			; 9n
		dc.l	POLY_PRESS		; An
		dc.l	CTRL_CHNGE		; Bn
		dc.l	PRGM_CHANGE		; Cn
		dc.l	CHAN_PRESS		; Dn
		dc.l	PITCH_WHEEL		; En
		dc.l	SYSTEM_EVNT		; Fn

PANTAB		dc.b	$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9,$fa,$fb,$fc,$fd,$fe
		dc.b	$ff,$ff
		dc.b	$ef,$df,$cf,$bf,$af,$9f,$8f,$7f,$6f,$5f,$4f,$3f,$2f,$1f,$0f

;--------------------------------------------------------
;
NOTE_OFF	move.b	0(A1,D1.w),D2			;get MIDI note
		add.b	MC_trans(A0),D2			;add Chan. Transpose
		movea.l	MC_paddr(A0),A3			;get Patch Data Block
		add.b	PCH_trn1(A3),D2			;add Transpose Val.
		
		moveq.l	#5,D0
nof_z00		cmp.b	MC_z80no(A0,D0.w),D2
		bne	nof_z01

		Z80BYTE	#Z80_CMD
		Z80BYTE	#Z80_NOF
		Z80CHAN
		Z80D2BY
		
		move.b	#-1,MC_z80no(A0,D0.w)
		tst.w	TOT_FM_NONS
		beq	nof_z01

		subi.w	#1,TOT_FM_NONS

nof_z01		sub.w	#1,D0
		bpl	nof_z00

;--------------------------------------------------------
; Z80 Note-Offs sent.... Now do the PCMs

		lea	PCM_BLOKS,A2
		move.w	#8-1,D3		
meno0		tst.b	PCM_FLGsts(A2)
		bpl	meno1
		
		move.w	Curchan,D0
		cmp.b	PCM_MIDchn(A2),D0		;note from this chan?
		bne	meno1

		cmp.b	PCM_MIDpit(A2),D2		;right note?
		bne	meno1

		move.b	#%11000000,PCM_FLGsts(A2)	;set note off pending
		bra	NTOFx		

meno1		adda.l	#PCM_BLKLN,A2
		dbra	D3,meno0

;note was not found
NTOFx		BUMPINDEX
		rts

;--------------------------------------------------------
; NOTE ON from SONG or SFX
; A0 -> MIDI Channel Control Block
; A1 -> MIDI Data stream (Status byte+1)
;
;NBH!	If MIDI velocity is implemented, check for NOTE-ON with V=0
;	and jump to NOTE_OFF if so.
;
NOTE_ON		move.b	0(A1,D1.w),D2			;get the note
		add.b	MC_trans(A0),D2			;add Chan. Transpose
		movea.l	MC_paddr(A0),A3			;get Patch Data Block
		
		tst.b	PCH_prt1(A3)			;is this for Z80?
		bpl	n_nonz80

		cmp.w	#7,TOT_FM_NONS
		bcc	n_nonz80			;no more than 6

		move.b	D2,D0
		add.b	PCH_trn1(A3),D0			;add Transpose Val.


		moveq.l	#5,D2
non_z00		tst.b	MC_z80no(A0,D2.w)
		bmi	non_z01

		sub.w	#1,D2
		bmi	n_nonz80
		bra	non_z00	

non_z01		move.b	D0,MC_z80no(A0,D2.w)
	
		Z80BYTE	#Z80_CMD
		Z80BYTE	#Z80_NON
		Z80CHAN
		Z80D0BY
		
		addi.w	#1,TOT_FM_NONS

n_nonz80	move.b	0(A1,D1.w),D2
		tst.b	PCH_prt0(A3)			;valid PCM?
		bmi	NTONx

		cmpi.b	#%11111111,PCM_useflag
		bne	tpcm2				;any voices free?

		cmpi.b	#%11111111,PCM_nonflag		;any notes releasing?
		beq	tpcm3

		lea	PCM_BLOKS,A2
		move.w	Curchan,D0
		move.w	#0,D3
tpcr0		btst.b	D3,PCM_nonflag
		beq	gfpcm0				;chan unused?

tpcr1		adda.l	#PCM_BLKLN,A2
		add.w	#1,D3
		and.w	#7,D3
		bne	tpcr0
		bra	NTONx

tpcm2		lea	PCM_BLOKS,A2
		move.w	Curchan,D0
		move.w	#0,D3
tpcm0		tst.b	PCM_FLGsts(A2)
		beq	gfpcm0				;chan unused?

tpcm1		adda.l	#PCM_BLKLN,A2
		add.w	#1,D3
		and.w	#7,D3
		bne	tpcm0
;

; Maybe one last attempt to try a Steal based on priority
; no free voices so return without note on for now

tpcm3		bra	NTONx

		


; got an unused pcm chan. so first get pntr to Patch Data
gfpcm0		tst.w	MC_wavst(A0)
		bmi	NTONx

		bset.b	D3,PCM_useflag			;set the bit flags
		bset.b	D3,PCM_nonflag			;for use & note on/off

		move.b	#PENDING,PCM_FLGsts(A2)		;switch ON
		move.b	PCH_prt0(A3),PCM_WVBnum(A2)	;WAVE number
		move.w	MC_wavst(A0),D0
;		bmi	wnres0				;wave resident?

		move.w	D0,PCM_STshd(A2)		;Wave start addr(lsb)
		add.b	PCH_wls0(A3),D0
		move.w	D0,PCM_LSHshd(A2)

		move.w	PCH_wls0(A3),D0
		move.w	D0,PCM_LSLshd(A2)
;		bra	gfpcm1
;
;wnres0		bra	wnres0
;		move.w	#$8F,D0				;ori.w	#$80,D0
;		move.w	D0,PCM_CTL_ISR
;		move.w	D0,PCM_CTL
;		lea	WAVEMEMORY+(ISR_BLKLN*2),A4
;		move.w	#$FF,(A4)			;set loopback at Blockend
;
;		asl.w	#4,D0
;		move.w	D0,PCM_STshd(A2)
;		move.w	D0,PCM_LSHshd(A2)
;		move.w	#0,PCM_LSLshd(A2)
;		move.l	#WAVEMEMORY,PCM_destination
;		move.l	MC_wsrce(a0),PCM_source
;		move.w	#ISR_BLKLN,PCM_count
;		move.w	#1,SUB_INT3_TIMER

gfpcm1		move.w	Curchan,D0
		move.b	D0,PCM_MIDchn(A2)		;MIDI chan #
		move.b	D2,PCM_MIDpit(A2)		;store the note #	
		move.b	MC_stats+1(A0),PCM_MIDsfx(A2)	;store sfx #			
		add.b	PCH_trn0(A3),D2			;add Transpose Val.
		and.l	#$7f,D2
		lea	FQTAB,A4
		asl.w	D2
		move.b	0(A4,D2.w),PCM_FDHshd(A2)
		move.b	1(A4,D2.w),PCM_FDLshd(A2)

		move.b	PCH_env0(A3),D0
		asl.w	#3,D0
		lea	ADSR00,A3
		move.l	0(A3,D0.w),PCM_ENVdtlA(A2)
		move.l	4(A3,D0.w),PCM_ENVdtlS(A2)	;ADSR data
		move.w	#-2,PCM_ENVptr(A2)		;ADSR stage
		move.w	#0,PCM_ENVtim(A2)		;ADSR timer
		move.w	#0,PCM_ENVslh(A2)
		move.w	#1,PCM_ENVsll(A2)
		move.w	#0,PCM_ENVlst(A2)
		move.w	#0,PCM_ENVshd(A2)		;ADSR shadow

NTONx		BUMPINDEX				;bump the index
		rts

;--------------------------------------------------------
;
POLY_PRESS
		rts
;--------------------------------------------------------
;
CTRL_CHNGE	moveq.l	#0,D0
		move.b	0(A1,D1.w),D0			;get Controller ID
		BUMPINDEX
		cmp	#PANM,D0
		beq	cc_Setpan

		cmp	#VOLM,D0
		beq	cc_Setvol

		cmp	#ALL_NOTES_OFF,D0
		beq	cc_allnotesoff

		BUMPINDEX
		rts

cc_Setvol	move.b	MC_stats(A0),D0
		bne.s	ovrlev1			;override if non-zero

		move.b	0(A1,D1.w),D0
		move.b	D0,MC_level(A0)

		moveq.l	#0,D0
		moveq.l	#0,D3

		move.b	MC_level(A0),D0
		move.b	MC_plevz(A0),D3

		mulu.w	D3,D0
		lsr.w	#7,D0			;divu.w	#$7F,D0
		
		mulu.w	Z80_MASTER_LEV,D0
		lsr.w	#7,D0			;divu.w	#$7F,D0

		Z80BYTE	#Z80_CMD		;send "CMD" to main
		Z80BYTE	#Z80_LEV		;send "LEV" to main
		Z80CHAN				;send "Midi Channel" to main
		Z80D0BY				;send "Level value" to main
	
ovrlev1		BUMPINDEX
		rts


cc_Setpan	move.b	0(A1,D1.w),MC_panlr(A0)
		BUMPINDEX
		rts


cc_allnotesoff	lea	PCM_BLOKS,A3
    		move.w	Curchan,D2
		
		Z80BYTE	#Z80_CMD
		Z80BYTE	#Z80_ALLNOF
		Z80CHAN
		jsr	CH_ALLNOF

		move.w	#0,D3			;Current PCM Channel

ano0		cmp.b	PCM_MIDchn(A3),D2
		bne	ano1

		move.w	D3,D0
		ori.w	#%11000000,D0
		move.w	D0,PCM_CTLshd
		move.w	D0,PCM_CTL

		move.b	#0,PCM_FLGsts(A3)	;kill voice flags
		move.w	#0,PCM_ENVshd(A3)
		move.w	#0,PCM_ENV
		bset.b	D3,PCM_ONFshd+1
		move.w	PCM_ONFshd,PCM_ONF
		
		bclr.b	D3,PCM_useflag
		bclr.b	D3,PCM_nonflag


ano1		adda.l	#PCM_BLKLN,A3
		addi.w	#1,D3
		andi.w	#7,D3
		bne	ano0

		BUMPINDEX
		rts


CH_ALLNOF	moveq.l	#5,D0
challno0	tst.b	MC_z80no(A0,D0.w)
		bmi	challno1
		move.b	#-1,MC_z80no(A0,D0.w)
		tst.w	TOT_FM_NONS
		beq	challno1
		subi.w	#1,TOT_FM_NONS
challno1	sub.w	#1,D0
		bpl	challno0
		rts

;--------------------------------------------------------
; Program change from SONG or SFX
; A0 -> MIDI Channel Control Block
; A1 -> MIDI Data stream (Status byte+1)
; 
PRGM_CHANGE	moveq.l	#0,D0

		move.b	MC_stats+1(A0),D3
		and.l	#$7F,D3
		move.w	Curchan,D2
		lea	PCM_BLOKS,A3
pg1		cmp.b	PCM_MIDchn(A3),D2
		beq	pg2
		cmp.b	PCM_MIDsfx(A3),D3
		bne	pg3
pg2		move.b	#%11000000,PCM_FLGsts(A3)	;set note off pending
pg3		adda.l	#PCM_BLKLN,A3
		addi.w	#1,D0
		andi.w	#7,D0
		bne	pg1

		Z80BYTE	#Z80_CMD
		Z80BYTE	#Z80_ALLNOF
		Z80CHAN
		jsr	CH_ALLNOF

		moveq.l	#0,D0
		move.b	0(A1,D1.w),D0		;get the Program #
		BUMPINDEX

		mulu.w	#PCH_BLKLN,D0
		lea	PCH_BANK,A3		;Get "prgrm" Control Block
		adda.l	D0,A3
		move.l	A3,MC_paddr(A0)

		move.b	PCH_lev0(A3),MC_plevp(A0)
		move.b	PCH_lev1(A3),MC_plevz(A0)

		move.b	PCH_prt0(A3),MC_pg68k(A0)	;store it
		move.b	PCH_prt1(A3),D2
		move.b	D2,MC_pgz80(A0)

		and.l	#$7F,D2			;make it 0 - 127

		Z80BYTE	#Z80_CMD		;send "CMD" to main
		Z80BYTE	#Z80_PRG		;send "PRG" to main
		Z80CHAN				;send "Midi Channel" to main
		Z80D2BY				;send "Program #" to main

		moveq.l	#0,D0
		move.b	MC_level(A0),D0
		move.b	MC_plevz(A0),D2
		mulu.w	D2,D0	       
		lsr.w	#7,D0			;divu.w	#$7F,D0
		
		mulu.w	Z80_MASTER_LEV,D0
		lsr.w	#7,D0			;divu.w	#$7F,D0

		Z80BYTE	#Z80_CMD		;send "CMD" to main
		Z80BYTE	#Z80_LEV		;send "LEV" to main
		Z80CHAN				;send "Midi Channel" to main
		Z80D0BY				;send "Level value" to main

		move.w	#MC_DEF_pbend,D0
		move.w	D0,MC_pbend(A0)
		eor.w	#$C000,D0
		asr.w	#2,D0
		Z80BYTE	#Z80_CMD		;send "CMD" to main
		Z80BYTE	#Z80_PWC		;send "PWC" to main
		Z80CHAN				;send "Midi Channel" to main
		Z80D0BY				;send "Pitch Wheel" to main
		asr.w	#8,D0
		Z80D0BY

		move.b	PCH_pan0(A3),MC_panlr(A0)	;Transfer "PanLR"

		move.b	MC_pg68k(A0),D0			;Get Waveform #
		bmi	PRGMx

		andi.l	#$7F,D0
		mulu.w	#WAVE_HDLEN,D0
		lea	WAVE_HDBLOKS,A3
		move.w	WAVE_STMEM(A3,D0.w),D2
		bmi	PRGM_notres		
		asl.w	#3,D2			;obtain actual WaveBank ST
PRGM_notres	move.w	D2,MC_wavst(A0)		;store it (-1 if not resident)
		move.l	WAVE_ADDRS(A3,D0.w),MC_wsrce(A0)
		
;
;NBH!	Some code will go here which checks to see if "Waveform" has
;	changed, then check to see if it is loaded or not.

PRGMx		rts

;--------------------------------------------------------
;
CHAN_PRESS	
		rts
;--------------------------------------------------------
;
PITCH_WHEEL	move.b	0(A1,D1.w),D2
		BUMPINDEX
		move.b	0(A1,D1.w),D0
		BUMPINDEX
		and.w	#$7F,D0
		asl.w	#7,D0
		or.b	D2,D0

		move.w	D0,MC_pbend(A0)

		eor.w	#$C000,D0
		asr.w	#2,D0

		Z80BYTE	#Z80_CMD		;send "CMD" to main
		Z80BYTE	#Z80_PWC		;send "PWC" to main
		Z80CHAN				;send "Midi Channel" to main
		Z80D0BY				;send "Pitch Wheel" to main
		asr.w	#8,D0
		Z80D0BY
		rts

;--------------------------------------------------------
;
SYSTEM_EVNT	cmp.b	#SRT_STOP,D0
		bne	nsrt_stop

;Process System Real-Time STOP

		tst.w	AUDIO_PAUSED
		bmi	SYSTEMx

		move.w	#-1,AUDIO_PAUSED
		move.w	PCM_ONFshd,PCM_SaveArea
		move.w	#$FF,PCM_ONFshd
		move.w	PCM_ONFshd,PCM_ONF

		Z80BYTE	#Z80_CMD		;send "CMD" to main
		Z80BYTE	#Z80_PAUSE		;send "PAUSE" to main
		bra	SYSTEMx

nsrt_stop	cmp.b	#SRT_CONTINUE,D0
		bne	SYSTEMx
		tst.w	AUDIO_PAUSED		
		bpl	SYSTEMx			;not paused, do nothing!

srt_resume	move.w	#0,AUDIO_PAUSED
		move.w	PCM_SaveArea,PCM_ONFshd
		move.w	PCM_ONFshd,PCM_ONF


		Z80BYTE	#Z80_CMD		;send "CMD" to main
		Z80BYTE	#Z80_RESUME		;send "RESUME" to main

		movem.l	A0-A1/D0-D1,-(SP)
		move.w	Curchan,-(SP)
		lea	MC_BLOKS,A0
		move.w	#0,Curchan		
srt_resl	movea.l	MC_paddr(A0),A1
		tst.b	PCH_prt1(A1)
		bpl	srt_rese

		moveq.l	#5,D0
srt_res0	move.b	MC_z80no(A0,D0.w),D1
		bmi	srt_res1
		Z80BYTE	#Z80_CMD
		Z80BYTE	#Z80_NON
		Z80CHAN
		Z80D1BY
srt_res1	sub.w	#1,D0
		bpl	srt_res0

srt_rese	adda.l	#MC_BLKLN,A0
		add.w	#1,Curchan
		and.w	#15,Curchan
		bne	srt_resl
		move.w	(SP)+,Curchan
		movem.l	(SP)+,A0-A1/D0-D1
SYSTEMx		rts

;--------------------------------------------------------

;Process META EVENT

META_EVENT	move.b	0(A1,D1.w),D0
		BUMPINDEX
		cmp.b	#SS,D0
		beq	nmev1

		cmp.b	#EOTRK,D0
		bne	nmev0
		moveq.l	#0,D1
		move.l	#1,MC_addrs(A0)		;kill track address
		move.l	#COFF_CNT,MC_index(A0)	;kill the MIDI channel (soon)

eot4		move.w	Curchan,D2
		move.w	#0,D0			;Current PCM Channel
		lea	PCM_BLOKS,A3
eot2		cmp.b	PCM_MIDchn(A3),D2
		bne	eot3
		move.b	#%11000000,PCM_FLGsts(A3)	;set note off pending
eot3		adda.l	#PCM_BLKLN,A3
		addi.w	#1,D0
		andi.w	#7,D0
		bne	eot2

		Z80BYTE	#Z80_CMD		;kill Z80 Notes on this chan
		Z80BYTE	#Z80_ALLNOF
		Z80D2BY
		jsr	CH_ALLNOF
		rts
		
nmev1		move.b	0(A1,D1.w),D0
		cmp.b	#GTO,D0
		bne	nmev0

		move.b	1(A1,D1.w),D0
		asl.w	#8,D0
		move.b	2(A1,D1.w),D0

		swap	D0

		move.b	3(A1,D1.w),D0
		asl.w	#8,D0
		move.b	4(A1,D1.w),D0

		move.l	D0,D1
		rts

nmev0		cmp.b	#JTO,D0
		bne	nmev2

		move.b	2(A1,D1.w),D2
		asl.w	#8,D2
		move.b	3(A1,D1.w),D2
		swap	D2
		move.b	4(A1,D1.w),D2
		asl.w	#8,D2
		move.b	5(A1,D1.w),D2

		move.b	6(A1,D1.w),D3
		asl.w	#8,D3
		move.b	7(A1,D1.w),D3
		swap	D3
		move.b	8(A1,D1.w),D3
		asl.w	#8,D3
		move.b	9(A1,D1.w),D3

		move.l	D2,A1
		move.l	A1,MC_addrs(A0)
		move.l	D3,D1
		rts

nmev2		cmp.b	#PBM,D0
		bne	nmev3
		BUMPINDEX
		moveq.l	#0,D0
		move.b	0(A1,D1.w),D0
		BUMPINDEX
		asl.w	D0
		lea	PBMacros,A2
		move.w	0(A2,D0.w),D0
		adda.l	D0,A2
		move.w	(A2)+,MC_pbend(A0)		;get initial bend
		move.l	A2,MC_PBadd(A0)
		move.w	(A2),MC_PBtim(A0)
		rts		

;-----------------------------------------------------------------------------

nmev3		cmp.b	#STOPSFXONEI,D0		;kill the SFX ?
		bne	nmev4

		BUMPINDEX
		moveq.l	#0,D3
		move.b	0(A1,D1.w),D3		;get SFX # in D3
		BUMPINDEX

		moveq.l	#0,D2
		move.b	0(A1,D1.w),D2		;get MIDI CHAN in D2
		BUMPINDEX

		move.l	D2,-(SP)
		mulu.w	#MC_BLKLN,D2
		lea	MC_BLOKS,A0
		adda.l	D2,A0
		move.l	(SP)+,D2
		
		
		Z80BYTE	#Z80_CMD		;kill Z80 Notes on this chan
		Z80BYTE	#Z80_ALLNOF
		Z80D2BY
		jsr	CH_ALLNOF
		move.l	#1,MC_addrs(A0)		;kill the MIDI channel (soon)
		move.l	#COFF_CNT,MC_index(A0)	;over this many ticks

		moveq.l	#0,D0			;Current PCM Channel
		lea	PCM_BLOKS,A3
s1sfx1		cmp.b	PCM_MIDchn(A3),D2
		beq	s1sfx2a
		cmp.b	PCM_MIDsfx(A3),D3
		bne	s1sfx2

s1sfx2a		move.b	#%11000000,PCM_FLGsts(A3)	;set note off pending

s1sfx2		adda.l	#PCM_BLKLN,A3
		addi.w	#1,D0
		andi.w	#7,D0
		bne	s1sfx1

		bra	nmevx

;-----------------------------------------------------------------------------
nmev4		cmp.b	#STOPSFXMULI,D0		;kill the SFX ?
		bne	nmev5

		BUMPINDEX
		moveq.l	#0,D3
		move.b	0(A1,D1.w),D3		;get SFX # in D3
		BUMPINDEX

; now find all MIDI channels that are running this SFX

		moveq.l	#0,D2			;D2 holds current MIDI chan #
		lea	MC_BLOKS,A0
ssfx0		tst.l	MC_addrs(A0)		;is channel active?
		beq	ssfx1
		cmp.l	#1,MC_addrs(A0)
		beq	ssfx1
		
		cmp.b	MC_stats+1(A0),D3	;is the SFX on this channel?
     		bne	ssfx1

		Z80BYTE	#Z80_CMD		;kill Z80 Notes on this chan
		Z80BYTE	#Z80_ALLNOF
		Z80D2BY
		jsr	CH_ALLNOF
		move.l	#1,MC_addrs(A0)		;kill the MIDI channel (soon)
		move.l	#COFF_CNT,MC_index(A0)	;over this many ticks

		move.w	#0,D0			;Current PCM Channel
		lea	PCM_BLOKS,A3
ssfx2		cmp.b	PCM_MIDchn(A3),D2
		beq	ssfx2a

		cmp.b	PCM_MIDsfx(A3),D3
		bne	ssfx3

ssfx2a		tst.b	PCM_FLGsts(A3)
		beq	ssfx3

		move.b	#%11000000,PCM_FLGsts(A3)	;set note off pending

ssfx3		adda.l	#PCM_BLKLN,A3
		addi.w	#1,D0
		andi.w	#7,D0
		bne	ssfx2

ssfx1		adda.l	#MC_BLKLN,A0
		addq	#1,D2
		and.w	#15,D2
		bne	ssfx0

     		bra	nmevx

;-----------------------------------------------------------------------------

nmev5		cmp.b	#STOPSFXALLI,D0
		bne	nmev6

		moveq.l	#0,D2			;D2 holds current MIDI chan #
		lea	MC_BLOKS,A0
sasfx0		tst.l	MC_addrs(A0)		;is channel active?
		beq	sasfx1
		cmp.l	#1,MC_addrs(A0)		;dying?
		beq	sasfx1
		move.l	#1,MC_addrs(A0)		;kill the MIDI channel (soon)
		move.l	#COFF_CNT,MC_index(A0)	;over this many ticks
sasfx1		adda.l	#MC_BLKLN,A0
		addq	#1,D2
		and.w	#15,D2
		bne	sasfx0

		move.w	#NUMPCMCHANS-1,D0		;Current PCM Channel
		lea	PCM_BLOKS,A3
sasfx2		move.b	#%11000000,PCM_FLGsts(A3)	;set note off pending
		adda.l	#PCM_BLKLN,A3
		dbra	D0,sasfx2

		Z80BYTE	#Z80_CMD		;kill all Z80 Notes
		Z80BYTE	#Z80_STOPALL

		move.l	D5,XBW_PNT	
		cmp.l	XBR_PNT,D5
		beq	xbt012

		lea	SUBS_XBUFF+2,A0
		move.l	XBR_PNT,D5
xbt010		move.b	0(A5,D5.w),(A0)+

		IF	FM_INC
		addi.w	#1,SUBS_XBUFF
		ENDIF
		addq.l	#1,D5
		and.l	#Z80_XBSIZE-1,D5
		cmp.l	XBW_PNT,D5
		beq	xbt011
		cmp.w	#62,SUBS_XBUFF
		bne	xbt010	

xbt011		move.l	D5,XBR_PNT		
xbt012		move.l	#0,EVNT_bufhead
		move.l	#0,EVNT_buftail	

		lea	SFX_STATTAB,A0
		move.w	#32-1,D0
xbt013		move.l	#0,(A0)+
		dbra	D0,xbt013

		jsr	INIT_USER_VARS

		moveq.l	#0,D1
nmev6
nmevx		rts
;
;****************************************************************************

SFX_CLR_STATE	movem.l	A0/D0,-(SP)
		lea	SFX_STATTAB,A0
		tst.b	D0
      		bpl	clsfx01

		move.w	#32-1,D0
clsfx00		move.l	#0,(A0)+
		dbra	D0,clsfx00
		bra.s	clsfxxx

clsfx01		and.l	#$7F,D0
		move.b	#0,0(A0,D0.w)

clsfxxx		movem.l	(SP)+,A0/D0
		rts


;*****************************************************************************

SFX_CHECK_STATE	and.w	#$7F,D0
		lea	SFX_STATTAB,A0
		tst.b	0(A0,D0.w)
		rts

;*****************************************************************************
;
; Interrupt routine to "Fly-in" non resident Sample data
;
SUB_INT3_ISR	rte
;		movem.l	A0-A1/D0,-(SP)
;		movea.l	PCM_source,A0			;Setup WaveMem write
;		movea.l	PCM_destination,A1		
;		move.w	PCM_CTL_ISR,PCM_CTL		;Set Control reg.
;
;		move.b	(A0)+,D0			;write the byte
;		move.w	D0,(A1)+	
;
;		move.w	(A0)+,D0
;		movep.w	D0,0(A1)
;		add.l	#4,PCM_destination
;
;
;		move.l	A0,PCM_source
;		move.l	A1,PCM_destination		;Store new Pointers
;
;		move.w	PCM_CTLshd,PCM_CTL		;restore Control reg.
;		cmp.b	#$FF,D0				;hit end of Sample?
;		beq	si300
;
;		sub	#1,PCM_count			;Block done?
;		beq	INT3_STPexit
;
;		movem.l	(SP)+,A0-A1/D0
;		move.w	#1,SUB_INT3_TIMER		;reenable Timer Countdown
;		rte
;
;si300		move.w	#$7F,WAVEMEMORY			;Sample all done so
;		move.w	#$FF,WAVEMEMORY+2		;create dummy loop
;		move.w	#0,SUB_INT3_TIMER		;disable Timer
;		movem.l	(SP)+,A0-A1/D0
;		rte		
;
;INT3_STPexit	move.l	#WAVEMEMORY,PCM_destination	;Reset pointers back
;		move.w	#ISR_BLKLN,PCM_count		;to start of block
;		move.w	#2,SUB_INT3_TIMER
;		movem.l	(SP)+,A0-A1/D0
;		rte
;
;*****************************************************************************			
; PCM DRIVER INITIALIZATION
;
PCM_DrvInit	move.w	#0,PCM_drvflag		;Ensure driver is inactive
		move.w	#INHIBIT,PCM_inhibit
		move.w	#0,AUDIO_PAUSED

; INITIALIZES ALL RF5C164 REGISTERS
;
		move.w	#%10000000,PCM_CTLshd
		move.w	PCM_CTLshd,PCM_CTL

		move.w	#$FF,PCM_ONFshd
		move.w	PCM_ONFshd,PCM_ONF

		lea	PCM_BLOKS,A0
		moveq.l	#0,D1
		moveq	#8-1,D0
		move.w	#%11000000,PCM_CTLshd
pcmi00		move.w	PCM_CTLshd,PCM_CTL

		move.w	#$00,PCM_ENVshd(A0)
		move.w	#$FF,PCM_PANshd(A0)
		move.b	#$08,PCM_FDHshd(A0)
		move.b	#$00,PCM_FDLshd(A0)
		move.w	#$00,PCM_LSHshd(A0)
		move.w	#$00,PCM_LSLshd(A0)
		move.w	#$00,PCM_STshd(A0)

		move.l	D1,PCM_FLGsts(A0)
		move.l	D1,PCM_ENVslh(A0)
		move.l	D1,PCM_ENVtim(A0)
		move.l	D1,PCM_ENVsll(A0)
		move.l	D1,PCM_ENVdtlD(A0)
		move.l	D1,PCM_ENVdtlR(A0)
		move.w	D1,PCM_WVBnum(A0)

		move.w	#$00,PCM_ENV
		move.w	#$FF,PCM_PAN
		move.b	#$08,PCM_FDH
		move.b	#$00,PCM_FDL
		move.w	#$00,PCM_LSH
 		move.w	#$00,PCM_LSL
		move.w	#$00,PCM_ST

		add.w	#1,PCM_CTLshd
		adda.l	#PCM_BLKLN,A0
		dbra	D0,pcmi00

		move.b	#0,PCM_useflag
		move.b	#0,PCM_nonflag
		move.w	#0,TOT_FM_NONS
;
; now zero(128) all the Waveform Memory
;
		move.w	#%10000000,PCM_CTLshd
	      	move.w	#16-1,D2
cwv0:	      	move.w	PCM_CTLshd,PCM_CTL

	      	lea	WAVEMEMORY,A0
	      	move.w	#WAVEBANKSIZE-1,D1
	      	move.w	#$80,D0
cwv1	      	move.w	D0,(A0)+
	      	dbra	D1,cwv1

	      	addi.w	#1,PCM_CTLshd
	      	dbra	D2,cwv0
	      

		move.w	#SFX_MASTER_LEV,PCM_MASTER_LEV
		move.w	#SFX_MASTER_LEV,D0
		add.w	#7,D0
		cmp.w	#128,D0
		bcs	imc1
		move.w	#127,D0
imc1		move.w	D0,Z80_MASTER_LEV
		move.w	#MONO_SFX,STEREO_MONO

		lea	MC_BLOKS,A0
		move.w	#16-1,D0
imc0		move.l	#0,MC_addrs(A0)
		move.l	#0,MC_index(A0)
		move.l	#0,MC_PBadd(A0)
		move.w	#-1,MC_PBtim(A0)

		move.w	#MC_DEF_pbend,MC_pbend(A0)
		move.b	#MC_DEF_prgrm,MC_pg68k(A0)
		move.b	#0,MC_pgz80(A0)
		move.w	#0,MC_stats(A0)

		move.b	#0,MC_ticks(A0)
		move.b	#MC_DEF_panlr,MC_panlr(A0)
		move.b	#MC_DEF_level,MC_level(A0)
		move.b	#MC_DEF_plevp,MC_plevp(A0)
		move.b	#MC_DEF_plevz,MC_plevz(A0)
		move.b	#MC_DEF_trans,MC_trans(A0)
		move.l	#$FFFFFFFF,MC_z80no(A0)
		move.w	#$FFFF,MC_z80no+4(A0)
		
		adda.l	#MC_BLKLN,A0
		dbra	D0,imc0


		IF	MIDI_IN

; Initialize FIFO buffer for processing of Incoming MIDI Data 
; (From PC Sequencer or MIDI Device, Keyboard etc.) VBL driven
;
		move.l	#0,MIDI_bufhead
		move.l	#0,MIDI_buftail	

		ENDIF

; Initialize FIFO buffer for processing of Internal MIDI Data
; (From SONG, SFX, or DIRECT input from game code)

		move.l	#0,EVNT_bufhead
		move.l	#0,EVNT_buftail	
		move.l	#0,XBW_PNT
		move.l	#0,XBR_PNT
		move.w	#0,CurVoic
		move.w	#0,Curchan

		move.l	SysExBank,D0		
		jsr	MIDI_sysex

; Set up Interrupt 3 for updating of waveforms etc;

;		move.w	SUB_INT_MASK,D0
;		and.w	#%11110111,D0
;		move.w	D0,SUB_INT_MASK

;		move.l	#SUB_INT3_ISR,SUB_INT3_JMP
;		or.w	#%00001000,D0
;		move.w	D0,SUB_INT_MASK

; Set the PCM_drvflag to start the driver running

		move.w	#1,PCM_drvflag	
		move.w	#UNINHIBIT,PCM_inhibit 
		rts

;*****************************************************************************			
;
MIDI_sysex	lea	PCM_WaveMems,A0		;set PCM WaveMems use
		move.l	#0,(A0)+		;flags to 0 to indicate
		move.l	#0,(A0)+		;cleared		
		move.l	#0,(A0)+
		move.l	#0,(A0)+
		move.l	#0,(A0)+
		move.l	#0,(A0)+
		move.l	#0,(A0)+
		move.l	#0,(A0)+

		lea	SysExTAB,A0
		asl.w	#2,D0
		tst.l	0(A0,D0.w)
		beq	SysExDone		;nothing to load

		movea.l	0(A0,D0.w),A0		;get address of list

LISTLOOP	move.b	(A0)+,D0
		bmi	SysExDone		;-ve means list terminator	

		move.l	A0,-(SP)		;save list pointer

		andi.l	#$7f,D0
		move.l	D0,D3			;save this Wave # in D3
		mulu.w	#WAVE_HDLEN,D0
		lea	WAVE_HDBLOKS,A0
		adda.l	D0,A0

		move.w	#-1,WAVE_STMEM(A0)	;reset its load status
		movea.l	WAVE_ADDRS(A0),A1
		move.l	WAVE_LENGT(A0),D0

; Now derive # of 2K blocks this Waveform needs

		move.l	D0,D1
		divu	#$800,D1
		and.w	#$7FF,D0
		beq	mse00

     		addi.w	#1,D1
;
; Now Look for the required number of Contiguous free WaveMem Blocks
;
mse00		lea	PCM_WaveMems,A2
		
mse01		tst.b	(A2)
		bne	mse03			;in use so skip
		
		moveq	#0,D2
mse02		tst.b	0(A2,D2.w)
		bne	mse03			;in use so skip

		addi.w	#1,D2
		cmp.w	D1,D2		
		bne	mse02
;
; Now we have found a loadable area, proceed with load

		move.l	A2,D0			;A2 = Address of Start WaveMem
		sub.l	#PCM_WaveMems,D0
		move.w	D0,WAVE_STMEM(A0)	;Store Start WaveMem #
		move.w	D0,D4
		lsr.w	D0

		sub	#1,D2
		ori.b	#$80,D3
mse04		move.b	D3,(A2)+		;tag the Blocks as now busy
		dbra	D2,mse04

		ori.w	#$80,D0
		move.w	D0,PCM_CTLshd
		move.w	D0,PCM_CTL


		move.l	WAVE_LENGT(A0),D3	;get total bytes to transfer
WVLOOP		tst.l	D3
	   	beq	mse05			;Finished transfer of blocks

		move.l	#$800,D2
wvl5		sub.l	D2,D3
		bpl	wvl4
		
		add.l	D2,D3
		move.l	D3,D2
		bra	wvl5
	
wvl4		sub.w	#1,D2
		lea	WAVEMEMORY,A2
		btst	#0,D4
		beq	wvl0
		adda.l	#$1000,A2
wvl0	   	move.b	(A1)+,D0
		addq.l	#1,A2
	   	move.b	D0,(A2)+
		dbra	D2,wvl0

		addq	#1,D4
; now put the stop bytes on the end (enough to ensure that the CPU cannot
; jump past when playing at a higher rate than recorded)

		addq.l	#1,A2
		move.b	#$ff,(A2)+		;add loop byte to end
		addq.l	#1,A2
		move.b	#$ff,(A2)+		;add loop byte to end
		addq.l	#1,A2
		move.b	#$ff,(A2)+		;add loop byte to end
		addq.l	#1,A2
		move.b	#$ff,(A2)+		;add loop byte to end
		addq.l	#1,A2
		move.b	#$ff,(A2)+		;add loop byte to end
		addq.l	#1,A2
		move.b	#$ff,(A2)+		;add loop byte to end
		addq.l	#1,A2
		move.b	#$ff,(A2)+		;add loop byte to end
;		addq.l	#1,A2
;		move.b	#$ff,(A2)+		;add loop byte to end

		btst	#0,D4
		bne	WVLOOP

		addi.w	#1,PCM_CTLshd
		move.w	PCM_CTLshd,PCM_CTL

      		bra	WVLOOP

mse03		addq.l	#1,A2
		cmpa.l	#PCM_WaveMemX,A2	;reached end of block
		bne	mse01		

mse05		move.l	(SP)+,A0		;restore list pointer
		bra	LISTLOOP

SysExDone	rts	

;*****************************************************************************			


PCM_SUB_close	move.w	#0,PCM_drvflag
		move.w	#INHIBIT,PCM_inhibit
		move.w	#0,AUDIO_PAUSED
		move.w	#0,PCM_CTLshd
		move.w	#0,PCM_CTL

		move.w	#$FF,PCM_ONFshd
		move.w	#$FF,PCM_ONF

		move.w	#0,SUBS_XBUFF
		rts

;*****************************************************************************			
;
;			END OF DRIVER CODE
;
;*****************************************************************************			

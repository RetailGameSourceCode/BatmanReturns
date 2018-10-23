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
;* DATA MODULE (Contains PCM Patches for SUB-CPU + Z80 FM & PSG Patches)    *
;*									    *
;* FEBRUARY 1 1993 							    *
;*									    *
;****************************************************************************
;
; Start of 68K Patch + Sequence + Sample data

		IF	AUDIO_SUB

****************************************************************************

INIT_USER_VARS	rts

****************************************************************************

PCH_BANK

;Patch 0 (Beep0) LOOPED
		dc.b	0
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E00-WAVE_S00
		dc.b	eADSR01
		dc.b	64
		dc.b	120
		dc.b	0
		dc.b	0
		dc.b	0

;Patch 1 (Beep0) LOOPED
		dc.b	0
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E00-WAVE_S00
		dc.b	eADSR06
		dc.b	64
		dc.b	120
		dc.b	0
		dc.b	0
		dc.b	0

;Patch 2 (BANG0)
		dc.b	1	;BANG0
		dc.b	0
		dc.w	0
		dc.w	WAVE_E01-WAVE_S01
		dc.w	WAVE_E01-WAVE_S01
		dc.b	eADSR02
		dc.b	64
		dc.b	127
		dc.b	0
		dc.b	0
		dc.b	0
;Patch 3 (BANG0)
		dc.b	1	;BANG0
		dc.b	0
		dc.w	0
		dc.w	WAVE_E01-WAVE_S01
		dc.w	WAVE_E01-WAVE_S01
		dc.b	eADSR01
		dc.b	64
		dc.b	127
		dc.b	0
		dc.b	0
		dc.b	0
;Patch 4
		dc.b	6	;TRUCK1
		dc.b	0
		dc.w	0
		dc.w	0			;loop start at START
		dc.w	0
		dc.b	eADSR00
		dc.b	64
		dc.b	80
		dc.b	0
		dc.b	0
		dc.b	0
;Patch 5
		dc.b	7	;CLANG0
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	64
		dc.b	127
		dc.b	0	;13+Z80PATCH
		dc.b	20
		dc.b	127
;Patch 6 (Bang1)
		dc.b	1
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E01-WAVE_S01
		dc.b	eADSR04
		dc.b	64
		dc.b	100
		dc.b	0
    		dc.b	0
		dc.b	0

;Patch 7
		dc.b	1	;Batmobile Road
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR01
		dc.b	64
		dc.b	50
		dc.b	0
		dc.b	0
		dc.b	0

;*********************************************************			
;
; ADSR ENVELOPE BANK 
;
;*********************************************************			

ADSR00		dc.b	255,0,255,0,255,255,0,10
ADSR01		dc.b	255,0,255,0,255,255,0,1
ADSR02		dc.b	255,4,255,0,255,255,0,1
ADSR03		dc.b	255,0,255,0,255,255,0,40
ADSR04		dc.b	255,0,255,0,255,255,0,6
ADSR05		dc.b	255,0,255,0,255,255,0,24
ADSR06		dc.b	255,0,255,0,255,255,0,20
ADSR07		dc.b	255,0,255,0,255,255,0,20
ADSR08		dc.b	255,0,255,0,255,255,0,20
ADSR09		dc.b	255,0,255,0,255,255,0,20
ADSR10		dc.b	255,0,255,0,255,255,0,2
ADSR11		dc.b	255,0,255,0,255,255,0,20
ADSR12		dc.b	255,0,255,0,255,255,0,20
ADSR13		dc.b	255,0,255,0,255,255,0,1
ADSR14		dc.b	255,0,255,0,255,255,0,20
ADSR15		dc.b	255,24,255,0,255,255,0,12
ADSR16		dc.b	255,0,255,0,255,255,0,15

;*********************************************************			
;
; SFX SEQUENCE BANK (replayed at fixed 150 bpm)
;
;*********************************************************			

PBMacros	dc.w	PBM00-PBMacros
		dc.w	PBM01-PBMacros

PBM00		dc.w	$2000
		dc.w	0,8000
		dc.w	0,-8000
		dc.w	30,100
		dc.w	60,-180
		dc.w	32,20
		dc.w	-1

PBM01		dc.w	$1000
		dc.w	0,8000
		dc.w	0,-8000
		dc.w	20,100
		dc.w	60,-100
		dc.w	32,10
		dc.w	-1
		dc.w	2,200
		dc.w	4,-250
		dc.w	-1

;*****************************************************************************			
;
;			SYSEX Lists
;
;*****************************************************************************			

		EVEN
SysExTAB	dc.l	SX00	;Each entry here represents
		dc.l	0	;a game level and points to
				;list of Source Wave #s to load

SX00		dc.b	0,1,-1
		EVEN	

	
;*********************************************************			
;
; WAVEFORM SAMPLE BANK
;
;*********************************************************			

		EVEN

WAVE_HDBLOKS	dc.l	WAVE_S00		;Wave Source Address
		dc.l	WAVE_E00-WAVE_S00	;Wave Length
		dc.w	0			;Start Wave Address(ST)
		dc.w	0

		dc.l	WAVE_S01
		dc.l	WAVE_E01-WAVE_S01
		dc.w	0
		dc.w	0

;*********************************************************			
;
; SONG BANK
;
;*********************************************************			
;
;		EVEN
;
;SONG_ADDR_TAB	dc.l	SONG_S00
;
;SONG_S00	dc.b	0
;SONG_E00
;
;*********************************************************			
;
; SFX SEQUENCE BANK (replayed at fixed 150 bpm)
;
;*********************************************************			

		EVEN
SFX_INSTTAB	dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2

		EVEN
SFX_ADDR_TAB	dc.w	SFX_S00-SFX_ADDR_TAB
		dc.w	SFX_S01-SFX_ADDR_TAB
		dc.w	SFX_S02-SFX_ADDR_TAB
		dc.w	SFX_S03-SFX_ADDR_TAB
		dc.w	SFX_S04-SFX_ADDR_TAB
		dc.w	SFX_S05-SFX_ADDR_TAB
		dc.w	SFX_S06-SFX_ADDR_TAB
		dc.w	SFX_S07-SFX_ADDR_TAB
		dc.w	SFX_S08-SFX_ADDR_TAB
		dc.w	SFX_S09-SFX_ADDR_TAB
		dc.w	SFX_S10-SFX_ADDR_TAB
		dc.w	SFX_S11-SFX_ADDR_TAB
;================================================
SFX_S00		dc.b	1-1
		dc.w	sfx0a-SFX_S00
sfx0a		dc.b	0,PRGM,0
		dc.b	1,CTRL,VOLM,120
		dc.b	0,NTON,C50,12,NTOF,C50
		dc.b	11,META,EOTRK,0
;================================================ SFX 1 (BOOT)
;SFX_S01		dc.b	1-1
;		dc.w	sfx1a-SFX_S01
;sfx1a		dc.b	0,PRGM,0
;		dc.b	1,CTRL,VOLM,70
;		dc.b	1,NTON,C60,30,NTOF,C60
;		dc.b	11,META,EOTRK,0
;================================================ SFX 1 (BOOT)
SFX_S01		dc.b	1-1
		dc.w	sfx1a-SFX_S01
sfx1a		dc.b	0,PRGM,0
		dc.b	1,CTRL,VOLM,80
		dc.b	0,NTON,C50,2,NTOF,C50
		dc.b	2,NTON,D5S,2,NTOF,D5S
		dc.b	2,NTON,A5S,2,NTOF,A5S
		dc.b	2,NTON,C60,3,NTOF,C60
		dc.b	6,META,EOTRK,0
;================================================ SFX 2 (BUTTON1) (illegal)
SFX_S02		dc.b	1-1
		dc.w	sfx2a-SFX_S02
sfx2a		dc.b	0,PRGM,0
		dc.b	0,CTRL,VOLM,120
		dc.b	0,NTON,G30,3,NTOF,G30
		dc.b	8,NTON,B10,13,NTOF,B10
		dc.b	1,META,EOTRK,0
;================================================ SFX 3 (CLICK0)
SFX_S03		dc.b	1-1
		dc.w	sfx3a-SFX_S03
sfx3a		dc.b	0,PRGM,3
		dc.b	1,CTRL,VOLM,115
		dc.b	1,NTON,E30,2,NTOF,E30
		dc.b	1,META,EOTRK,0

;================================================ SFX 4 (Move Cursor)
SFX_S04		dc.b	1-1
		dc.w	sfx4a-SFX_S04
sfx4a		dc.b	0,PRGM,1
		dc.b	0,CTRL,VOLM,50
		dc.b	13,NTON,C60,2,NTOF,C60
		dc.b	21,META,EOTRK,0
;=============================================== SFX 5 (BASHOBJ_A)
SFX_S05		dc.b	1-1
		dc.w	sfx05a-SFX_S05
sfx05a		dc.b	1,PRGM,12
		dc.b	0,CTRL,VOLM,97
		dc.b	0,NTON,C20,4,NTOF,C20
		dc.b	11,META,EOTRK,0
;================================================ SFX 6 (BATDISK FIRE)
SFX_S06		dc.b	1-1
		dc.w	sfx6a-SFX_S06
sfx6a		dc.b	0,PRGM,6		;Bang0
		dc.b	0,CTRL,VOLM,107
		dc.b	0,NTON,G20
		dc.b	1,CTRL,PANM,64
		dc.b	1,CTRL,PANM,0
		dc.b	2,CTRL,PANM,127
		dc.b	2,CTRL,PANM,64
		dc.b	2,NTOF,G20
		dc.b	12,META,EOTRK,0
;================================================ SFX 7 (Road Noise)
SFX_S07		dc.b	1-1
		dc.w	sfx7a-SFX_S07
sfx7a		dc.b	0,PRGM,7
		dc.b	0,PWCH,0,0
		dc.b	0,NTON,G00
SFX_S7L		dc.b	120,META,SS,GTO
		dc.l	SFX_S7L-sfx7a
;================================================ SFX 8 (Missile 0)
SFX_S08		dc.b	1-1
		dc.w	sfx8a-SFX_S08
sfx8a		dc.b	0,PRGM,3
		dc.b	0,CTRL,VOLM,0	;127
		dc.b	0,NTON,C30
		dc.b	2,META,SS,PBM,0
		dc.b	12,CTRL,PANM,90
		dc.b	12,CTRL,PANM,50
		dc.b	12,CTRL,PANM,64
		dc.b	120,NTOF,C30
		dc.b	0,META,EOTRK,0
;================================================ SFX 9 (Missile 1)
SFX_S09		dc.b	1-1
		dc.w	sfx9a-SFX_S09
sfx9a		dc.b	0,PRGM,3
		dc.b	0,META,EOTRK,0
;================================================ SFX 10 (I am Catwoman)
SFX_S10		dc.b	2-1
		dc.w	sfx10a-SFX_S10
		dc.w	sfx10b-SFX_S10
sfx10a		dc.b	1,PRGM,10
		dc.b	1,CTRL,VOLM,127
		dc.b	1,CTRL,PANM,0
		dc.b	1,NTON,F3S
		dc.b	75,NTOF,F3S
		dc.b	31,META,EOTRK,0

sfx10b		dc.b	1,PRGM,10
		dc.b	1,CTRL,VOLM,127
		dc.b	1,CTRL,PANM,127
		dc.b	6,NTON,F3S
		dc.b	73,NTOF,F3S
		dc.b	31,META,EOTRK,0
;================================================ SFX 11 (Hear me Roar)
SFX_S11		dc.b	2-1
		dc.w	sfx11a-SFX_S11
		dc.w	sfx11b-SFX_S11
sfx11a		dc.b	1,PRGM,11
		dc.b	1,CTRL,VOLM,127
		dc.b	1,CTRL,PANM,0
		dc.b	1,NTON,F30
		dc.b	85,NTOF,F30
		dc.b	11,META,EOTRK,0

sfx11b		dc.b	1,PRGM,11
		dc.b	1,CTRL,VOLM,127
		dc.b	1,CTRL,PANM,127
		dc.b	6,NTON,F30
		dc.b	83,NTOF,F30
		dc.b	11,META,EOTRK,0
;================================================

		EVEN
WAVE_S00	incbin	"..\cdad\BEEP0.CD8"
WAVE_E00
		EVEN
WAVE_S01	incbin	"..\cdad\CLICK0.CD8"
WAVE_E01
		EVEN

		ENDIF


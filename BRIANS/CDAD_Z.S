******************************************************************************
*                                                                            *
*			PCM AUDIO DRIVER (MIDI COMPATIBLE)		     *
*									     *
* MIDI CONTROL INTERFACE & DRIVER FOR					     *
* SEGA MEGA CD-ROM (RF5C164 PCM Sound Source)				     *
*									     *		
*                                                                            *
*									     *
* Developed by:	Brian Howarth                                       	     *
*			MALIBU INTERACTIVE INC.				     *
*                                                                            *
******************************************************************************
*                                                               	     *
* FM CONTROL MODULE FOR DOWNLOAD TO Z80 CPU (Code,Data)			     *
*									     *
* Derived from GEMS Driver - 2.5 Copyright (c) 1991,1992 SEGA		     *
* All Rights Reserved							     *
*									     *
* FEBRUARY 1 1993 							     *
*              								     *
******************************************************************************

VOL_ONTHEFLY	equ	1
FM_SOFTER	equ	1

******************************************************************************

PATCHDATA	equ	01990H
EOPATCHDATA	equ	01C00H	; PATCHDATA + (39*16)
STACKINIT	equ	01C20H	; initialize stack pointer right below here
CMDFIFO		equ	01C40H	; command fifo - 64 bytes
CCB		equ	01C80H	; CCB - 512 bytes
CH0BUF		equ	01E80H	; channel cache - 256 bytes
ENV0BUF		equ	01F80H	; envelope buffers - 128 bytes

PBPBL		equ	0	; offset in PBTBL to 16 chans' pitchbend LSB
PBPBH		equ	16	; offset in PBTBL to 16 chans' pitchbend MSB
PBEBL		equ	32	; offset in PBTBL to 16 chans' envelopebend LSB
PBEBH		equ	48	; offset in PBTBL to 16 chans' envelopebend MSB
PBRETRIG	equ	64	; offset in PBTBL to 16 chans' retrigger flag
;
VTBLFLAGS	equ	0	
VTBLPRIO	equ	1
VTBLCH		equ	3
VTBLDL		equ	4
VTBLDH		equ	5
VTBLRT		equ	6
;
ECBCHAN		equ	0	; offset to 4 envelopes' channel numbers and flags
				; [7]=eot, [6]=free, [5]=sfx tempo
ECBPTRL		equ	5	;	"		 segment ptr LSBs
ECBPTRH		equ	9	;	"		 segment ptr MSBs
ECBCTR		equ	13	; 	"		 segment ctrs
ECBDELL		equ	17	;	"		 segment delta LSBs
ECBDELH		equ	21	;	"		 segment delta MSBs
ECBBUFP		equ	25	; LSB of pointer to 32 byte envelope buffer
;
* CCB Entries:	2,1,0	tag addr of 1st byte in 32-byte channel buffer
*		5,4,3	addr of next byte to fetch
*				so: 0 <= addr-tag <= 31 means hit in buffer
*		6	flags
*		8,7	timer (contains 0-ticks to delay)
*		10,9	delay
*		12,11	duration

CCBTAGL		equ	0	; lsb of addr of 1st byte in 32-byte sequence buffer
CCBTAGM		equ	1	; mid of "
CCBTAGH		equ	2	; msb of "
CCBADDRL	equ	3	; lsb of addr of next byte to read from sequence
CCBADDRM	equ	4	; mid of "
CCBADDRH	equ	5	; msb of "
CCBFLAGS	equ	6	; 80 = sustain
				; 40 = env retrigger
				; 20 = lock (for 68k based sfx)
				; 10 = running (not paused)
				; 08 = use sfx (150 bpm) timebase
				; 02 = muted (running, but not executing note ons)
				; 01 = in use
CCBTIMERL	equ	7	; lsb of 2's comp, subbeat (1/24th) timer till next event
CCBTIMERH	equ	8	; msb of "
CCBDELL		equ	9	; lsb of registered subbeat delay value
CCBDELH		equ	10	; msb of "
CCBDURL		equ	11	; lsb of registered subbeat duration value
CCBDURH		equ	12	; msb of "
CCBPNUM		equ	13	; program number (patch)
CCBSNUM		equ	14	; sequence number (in sequence bank)
CCBVCHAN	equ	15	; MIDI channel number within sequence CCBSNUM
CCBLOOP0	equ	16	; loop stack (counter, lsb of start addr, mid of start addr)
CCBLOOP1	equ	19
CCBLOOP2	equ	22
CCBLOOP3	equ	25
CCBPRIO		equ	28	; priority (0 lowest, 127 highest)
CCBENV		equ	29	; envelope number
CCBATN		equ	30	; channel attenuation (0=loud, 127=quiet)
CCBy		equ	31

*** psg command processor/envelope emulator

COM		equ	0
LEV		equ	4
ATK		equ	8
DKY		equ	12
SLV		equ	16
RRT		equ	20
MODE		equ	24
DTL		equ	28
DTH		equ	32
ALV		equ	36
FLG		equ	40


FMWrite		MACRO
		ld	A,\2
wfmr\@		bit	7,(IY+0)
		jr	nz,wfmr\@
		ld	(IY+0),\1
		ld	(IY+1),A
		ENDM

FMWr		MACRO
		ld	L,0
		ld	A,\1
		add	A,E
		ld	B,A
		ld	C,\2
fmwr\@		ld	A,80H
		and	(HL)
		jp	M,fmwr\@
		ld	L,D
		ld	(HL),B
		inc	L
		ld	(HL),C
		ENDM

FMWrgl		MACRO
fmwrg\@		bit	7,(IY+0)
		jr	NZ,fmwrg\@
		ld	A,L
		ld	(4000H),A
		ld	A,H
		ld	(4001H),A
		ENDM
		
************************************* RESET VECTOR *******************************************

		org	0

Z80CODEBASE	di
		im      1
		ld	SP,STACKINIT
		jp      main

*********************************** 60 Hz Interrupt ******************************************

psgcom		db	00H,00H,00H,00H	;  0 command 1 = key on, 2 = key off, 4 = stop snd
psglev		db	255,255,255,255	;  4 output level attenuation (4 bit)
psgatk		db	00H,00H,00H,00H	;  8 attack rate
psgdec		db	00H,00H,00H,00H	; 12 decay rate
psgslv		db	00H,00H,00H,00H	; 16 sustain level attenuation
psgrrt		db	00H,00H,00H,00H	; 20 release rate
psgenv		db	00H,00H,00H,00H	; 24 envelope mode 0 = off, 1 = attack, 2 = decay, 3 = sustain, 4
psgdtl		db	00H,00H,00H,00H	; 28 tone bottom 4 bits, noise bits
psgdth		db      00H,00H,00H,00H	; 32 tone upper 6 bits
psgalv		db      00H,00H,00H,00H	; 36 attack level attenuation
whdflg		db      00H,00H,00H,00H	; 40 flags to indicate hardware should be updated
		db	0

;****************************************

CMDWPTR		db	0	    	; cmd fifo wptr @ $36
CMDRPTR		db	0	    	; read pointer @ $37

;****************************************

VBLINT		ld	(TICKFLG),SP	; msb of SP in TICKFLG+1 will be >0
		reti                   	; leave disabled - will be enabled by CHECKTICK

TICKFLG		db	0,0	    	; (TICKFLG+1) set by ^^
TICKCNT		db	0	    	; tick accumulated by CHECKTICK

CHECKTICK	di		    	; (if TICKFLG+1 is set, then ints are disabled!)
		push	AF
		push	HL
		ld	HL,TICKFLG+1
		ld	A,(HL)		; check TICKFLG+1
		or	A
		jr	Z,ctnotick	; return if not set yet

; at this point, can't reenable ints until we're
; sure VBL (64 uS) has gone away, so do some
; GDACMEs and a delay (in case GDACME is off)

		ld	(HL),0		; clear flag (ints are disabled!)
		inc	HL		; point to counter
		inc	(HL)		; and inc it

		push	DE
		ld	HL,(SBPTACC)	; add sub beats per tick to its accumulator
		ld	DE,(SBPT)
		add	HL,DE
		ld	(SBPTACC),HL	; this is all 8 frac bits, so (SBPTACC+1)
		pop	DE		; is the # of subbeats gone by

ctnotick	pop	HL
		pop	AF
		ei
		ret

DOPSGENV	ld      IY,psgcom	; load psg pseudo registers
		ld      HL,7F11H 	; load hardware register address
		ld      D,80H	 	; load command mask
		ld      E,4	 	; load loop counter

vloop		ld	C,(IY+COM)	; load command bits
		ld      (IY+COM),0	; clear command bits
stop		bit     2,C            	; test bit 2
		jr      Z,ckof         	; nope...

		ld      (IY+LEV),0FFH  	; reset output level
		ld      (IY+FLG),1     	; flag hardware update
		ld      (IY+MODE),0    	; shut off envelope processing
		ld	A,1
		cp	E	     	; was this TG4 (noise)
		jr	NZ,ckof

		ld	IX,PSGVTBLTG3	; yes - clear locked bit in TG3
		res	5,(IX)
ckof		bit     1,C            	; test bit 1
		jr      Z,ckon         	; nope...

		ld      A,(IY+MODE)    	; load envelope mode
		cp      0              	; check for key on
		jr      Z,ckon         	; nope...

		ld      (IY+FLG),1     	; flag hardware update
		ld      (IY+MODE),4    	; switch to envelope release phase
ckon		bit     0,C            	; test bit 0
		jr      Z,envproc      	; nope...

		ld      (IY+LEV),0FFH  	; reset level
		ld      A,(IY+DTL)     	; load tone lsb
		or     	D              	; mix with command stuff
		ld      (HL),A         	; write tone lsb or noise data
		ld	A,1            	; check for last channel ***BAS***
		cp      E              	; is it?
		jr      Z,nskip        	; skip msb set (noise channel)

		ld      A,(IY+DTH)     	; load tone msb
		ld      (HL),A         	; write tone msb
nskip		ld      (IY+FLG),1     	; flag hardware update
		ld      (IY+MODE),1    	; initiate envelope processing (attack phase)

envproc		ld      A,(IY+MODE)    	; load envelope phase
		cp      0              	; test for on/off
		jp      Z,vedlp        	; off.

		cp      1              	; attack mode?
		jr      NZ,chk2        	; nope...

mode1		ld      (IY+FLG),1     	; flag hardware update
		ld      A,(IY+LEV)     	; load level
		ld      B,(IY+ALV)     	; load attack level
		sub    (IY+ATK)        	; subtract attack rate
		jr      C,atkend       	; attack finished
		jr      Z,atkend       	; attack finished
		cp      B              	; test level
		jr      C,atkend       	; attack finished
		jr      Z,atkend       	; attack finished
		ld      (IY+LEV),A     	; save new level
		jp      vedlp          	; done

atkend		ld      (IY+LEV),B     	; save attack level as new level
		ld      (IY+MODE),2    	; switch to decay mode
		jp      vedlp          	; done

chk2		cp      2              	; decay mode?
		jp      NZ,chk4        	; nope...

mode2		ld      (IY+FLG),1     	; flag hardware update
		ld      A,(IY+LEV)     	; load level
		ld      B,(IY+SLV)     	; load sustain level
		cp      B              	; compare levels
		jr      C,dkadd        	; add to decay
		jr      Z,dkyend       	; decay finished
		sub     (IY+DKY)       	; subtract decay rate
		jr	C,dkyend   	; if the sub caused a wrap then we're done
		cp      B              	; compare levels
		jr      C,dkyend       	; decay finished
		jr      dksav      	; save decay

dkadd		add     A,(IY+DKY)     	; add decay rate
		jr	C,dkyend   	; caused a wrap - we're done
		cp      B              	; compare levels
		jr      NC,dkyend      	; decay finished
dksav		ld      (IY+LEV),A     	; save level
		jr      vedlp          	; done

dkyend		ld      (IY+LEV),B     	; save sustain level
		ld      (IY+MODE),3    	; set sustain mode
		jr      vedlp          	; done

chk4		cp      4              	; check for sustain phase
		jr      NZ,vedlp       	; nope
mode4		ld      (IY+FLG),1     	; flag hardware update
		ld      A,(IY+LEV)     	; load level
		add    A,(IY+RRT)      	; add release rate
		jr      C,killenv      	; release finished
		ld      (IY+LEV),A     	; save new level
		jr      vedlp          	; done

killenv		ld      (IY+LEV),0FFH  	; reset level
		ld      (IY+MODE),0    	; reset envelope mode
		ld	A,1
		cp	E	     	; was this TG4 we just killed?
		jr	NZ,vedlp
		ld	IX,PSGVTBLTG3	; yes - clear locked bit in TG3
		res	5,(IX)
vedlp		inc     IY             	; point to next channel registers
		ld      A,20H          	; for tone command byte fixup
		add     A,D            	; add tone command byte
		ld      D,A            	; move back into D
		dec     E      		; decrement counter
		jp      NZ,vloop       	; until done ***BAS***

		ld      IY,psgcom      	; reset psg envelope pointer
uch1		bit     0,(IY+FLG)     	; test update flag
		jr      Z,uch2         	; next channel

		ld      (IY+FLG),0     	; clear update flag
		ld      A,(IY+LEV)     	; load level
		srl     A
		srl     A
		srl     A
		srl     A
		or      90H	       	; set command bits
		ld      (HL),A         	; write new level
uch2		bit     0,(IY+FLG+1)   	; test update flag
		jr      Z,uch3         	; next channel

		ld      (IY+FLG+1),0   	; clear update flag
		ld      A,(IY+LEV+1)   	; load level
		srl     A
		srl     A
		srl     A
		srl     A
		or      0B0H           	; set command bits
		ld      (HL),A         	; write new level
uch3		bit     0,(IY+FLG+2)   	; test update flag
		jr      Z,uch4         	; next channel
		ld      (IY+FLG+2),0   	; clear update flag
		ld      A,(IY+LEV+2)   	; load level
		srl     A
		srl     A
		srl     A
		srl     A
		or	0D0H	    	; set command bits
		ld      (HL),A         	; write new level
uch4		bit     0,(IY+FLG+3)   	; test update flag
		jr      Z,vquit        	; next channel
		ld      (IY+FLG+3),0   	; clear update flag
		ld      A,(IY+LEV+3)   	; load level
		srl     A
		srl     A
		srl     A
		srl     A
		or      0F0H	    	; set command bits
		ld      (HL),A         	; write new level
vquit		ret

****************************** Command FIFO (from 68000) *************************************
*
* GETCBYTE -	returns the next command byte in the fifo from the 68k.
*		will wait for one if the queue is empty when called.
*
*		parameters:	NONE
*		returns:	A	byte from queue
*

GETCBYTE	push	BC
		push	HL
getcbytel	ld	A,(CMDWPTR)
		ld	B,A
		ld	A,(cmdrptr)	; compare read and write pointers
		cp	B
		jr	Z,getcbytel	; loop if equal

		ld	B,0
		ld	C,A		; BC gets 16 bit read ptr
		ld	HL,cmdfifo	; IX points at fifo
		add	HL,BC		; add 'em
		inc	A		; increment read ptr
		and	3FH		;  (mod 64)
		ld	(cmdrptr),A
		ld	A,(HL)		; read actual entry
		pop	HL
		pop	BC
		ret
*
*  VTIMER - updates the voice timers - first note on and then release values
*

VTIMER	   	ld	DE,7
		ld	A,(TBASEFLAGS)
		ld	B,A			; B <- tbase flags
		ld	H,0			; indicates FM voices
		ld	IX,FMVTBL
		call	vtimerloop
		inc	H			; indicates PSG voices
		ld	IX,PSGVTBL
		call	vtimerloop
		ld	IX,PSGVTBLNG
		call	vtimerloop
		ret

vtimerloop0	add	IX,DE

vtimerloop	ld	A,(IX+0)
		cp	0FFH			; if eot
		ret	Z			;   return

		bit	3,A			; sfx tempo driven?
		jr	NZ,vtimersfx

		bit	1,B			; no - music beat flag set?
		jr	Z,vtimerloop0
		jr	vtimerdoit

vtimersfx	bit	0,B
		jr	Z,vtimerloop0

vtimerdoit	bit	6,A			; if in release
		jr	Z,vtimerloop2

		dec	(IX+6)			;   decrement release timer
		jr	NZ,vtimerloop0		;   not at zero, loop

		res	6,A			;   turn off release flag
		ld	(IX+0),A
		jr	vtimerloop0

vtimerloop2	bit	4,A			; self timed note?
		jr	Z,vtimerloop0

		and	7			; yes - save voice # in C
		ld	C,A
		inc	(IX+4)			; inc lsb of timer
		jr	NZ,vtimerloop0

		inc	(IX+5)			; if zero (carry), inc msb
		jr	NZ,vtimerloop0

		res	4,(IX+0)		; timed out - clear self timer bit
		res	3,(IX+0)		;   and clear sfx bit
		ld	A,(IX+0)		; A <- note flags
		and	2FH			; mask lock and voice number
		set	6,(IX+0)		;   no - set release bit
		set	7,(IX+0)		;        set free bit
vtnoteoff	bit	0,H			; note off... voice type?
		jr	Z,vtnoteofffm

		ld	E,C			; psg - DE <- psg voice num
		ld      IY,psgcom		; load psg register table
		add	IY,DE			; point to correct register
		ld	E,7			; restore DE to 7
		set	1,(IY+0)		; set key off command
		jr	vtimerloop0

vtnoteofffm	ld      IY,4000H        	; load fm register address
		FMWrite 28H,C           	; key off
		jr	vtimerloop0

**************************************  MAIN LOOP  *****************************************

*
* GETCCBPTR - gets one byte from command queue for channel number, multiplies by 32,
*	and returns pointer to that channel's CCB in IX, as well as the channel #
*	in A
* GETCCBPTR2 - alternate entry point to providing channel # in A (skips GETCBYTE)
*
*	trashes DE
*

GETCCBPTR	call	GETCBYTE
GETCCBPTR2	ld	D,0
		ld	E,A
		sla	E
		sla	E
		sla	E
  		sla	E
		sla	E
		rl	D		; DE <- 32 * channel
		ld	IX,CCB
		add	IX,DE		; IX <- pointer to this channel's CCB
		ret
*
*  main - initialize command fifo, dispatch on commands
*

SBPT		dw	204		; sub beats per tick (8frac), default is 120bpm
SBPTACC		dw	0		; accumulates ^^ each tick to track sub beats
TBASEFLAGS	db	0

main	   	exx			; ints are disabled upon entry here
		   			; initialize alternate regs for GDACME calls
		ld	B,15H		; timer reset command (also hold CH3 mode bits)
		ld	D,1FH		; read pointer from GDACFIFO - msb always = 1FH
		ld	HL,4000H	; points to base of FM chip
		exx
		ei
		ld	HL,7F11H	; silence the psg voices
		ld	(HL),09FH
		ld	(HL),0BFH
		ld	(HL),0DFH
		ld	(HL),0FFH
		ld	HL,PATCHDATA	; set all patch buffers to undefined
		ld	DE,39
		ld	B,16
pinitloop	ld	(HL),0FFH
		add	HL,DE
		dec	B
		jr	NZ,pinitloop

		ld	IX,CCB		; start with CCB 0
		ld	DE,32
		ld	B,16
lockallloop	set	5,(IX+CCBFLAGS)
		add	IX,DE
		dec	B
		jr	NZ,lockallloop

loop	 	call	CHECKTICK
		call	CHECKTICK
		ld	B,0		; b[0] if 60Hz tick, b[1] if 1/24 beat tick
		ld	A,(TICKCNT)	; check tick counter
		sub	1
		jr	C,noticks

		ld	(TICKCNT),A	; a tick's gone by...
		call	DOPSGENV   	; do PSG envs and set tick flag
		call	CHECKTICK
		ld	B,1	   	; set tick flag
noticks	 	ld	A,(SBPTACC+1)	; check beat counter (scaled by tempo)
		sub	1
  		jr	C,nobeats

		ld	(SBPTACC+1),A	; a beat (1/24 beat) 's gone by...
		set	1,B	     	; set beat flag
nobeats	 	ld	A,B
		or	A
		jr	Z,neithertick

		ld	(TBASEFLAGS),A
		call	DOENVELOPE   	; call the envelope processor
		call	CHECKTICK
		call	VTIMER	     	; update voice timers
		call	CHECKTICK

neithertick	call	APPLYBEND    	; check if bends need applying
		
		IF	VOL_ONTHEFLY
		call	APPLYVOL	;bh 
		ENDIF


		ld	A,(CMDWPTR)  	; check for command bytes...
		ld	B,A
		ld	A,(cmdrptr)  	; compare read and write pointers
		cp	B
		jp	Z,loop	     	; loop if no command bytes waiting

		call	GETCBYTE     	; main loop
		cp	0FFH	     	; start of command?
		jp	NZ,loop	     	; no, wait for one

		call	GETCBYTE     	; get command
		cp	0	     	; note on?
		jp	Z,cmdnoteon
		cp	1
		jp	Z,cmdnoteoff
		cp	2
		jp	Z,cmdpchange
		cp	3
		jp	Z,cmdpupdate
		cp	4
		jp	Z,cmdpbend
		cp	5
		jp	z,cmdallnotesoff
		cp	6
		jp	Z,cmdenv
		cp	7
		jp	Z,cmdretrig

		cp	12
		jp	Z,cmdpause
		cp	13
		jp	Z,cmdresume
		cp	14
		jp	Z,cmdsussw

		cp	20
		jp	Z,cmdsetprio

		cp	22
		jp	Z,cmdstopall
		cp	23
		jp	Z,cmdmute

		cp	28
		jp	Z,cmdlockch
		cp	29
		jp	Z,cmdunlockch
		cp	30
		jp	Z,cmdpbendvch
		cp	31
		jp	Z,cmdvolume
		cp	32
		jp	Z,cmdmasteratn
		jp	loop

CHPATPTR	dw	0
cmdnoteon  	call	GETCCBPTR	; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		ld	B,A	 	; B <- channel
		call	GETPATPTR	; HL <- PATCHDATA + 39 * A
		ld	(CHPATPTR),HL	; set pointer to this channel's patch buffer
		call	GETCBYTE
		ld	C,A	     	; C <- note
		call	NOTEON
		jp	loop

cmdnoteoff	call	GETCBYTE		; yes
		ld	B,A			; B <- channel
		call	GETCBYTE
		ld	C,A			; C <- note
		call	NOTEOFF
		jp	loop

cmdallnotesoff	call	GETCBYTE		; yes
		ld	B,A			; B <- channel
		call	NOTESOFF
		jp	loop

cmdpchange	call	PCHANGE
		jp	loop

cmdpupdate	call	GETCBYTE
		call	PATCHLOAD
		jp	loop

cmdpbend  	call	GETCBYTE	; get midi channel
		call	DOPITCHBEND	; PITCHBEND gets its own bend data
		jp	loop		; from the cmd queue

cmdpbendvch	call	GETCBYTE
		ld	C,A	       	; C <- seq #
		call	GETCBYTE
		ld	H,A	       	; H <- midi ch #
		ld	L,0	       	; L <- gems ch # (CCB num)
		ld	IX,CCB	       	; start with CCB 0
		ld	DE,32
		ld	B,16	       	; only 16 CCB's to try
pbvchloop  	bit	0,(IX+CCBFLAGS)	; is this channel in use?
		jr	Z,pbvchskip    	; no - skip it

		ld	A,(IX+CCBSNUM) 	; yes - is it for this seq number?
		cp	C
		jr	NZ,pbvchskip

		ld	A,(IX+CCBVCHAN)	; yes - for this channel ?
		cp	H
		jr	NZ,pbvchskip

		ld	A,L	       	; yes - bend this channel
		call	DOPITCHBEND
		jp	loop

pbvchskip  	add	IX,DE
		inc	L
		dec	B
		jr	NZ,pbvchloop

		call	GETCBYTE
		call	GETCBYTE
		jp	loop

cmdenv		call	GETCCBPTR	; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		ld	B,A	 	; B <- channel
		call	GETCBYTE 	; A <- envelope number
		ld	(IX+CCBENV),A	; store new env number
		bit	6,(IX+CCBFLAGS)	; retrigger mode?
		jp	NZ,loop

		ld	C,A		; C <- env num
		ld	E,B		; E <- channel
		call	TRIGENV			; no - trigger immediately
		jp	loop

cmdretrig	call	GETCCBPTR		; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		call	GETCBYTE		; A <- 80h for retrigg, 0 for immediate
		or	A			; set retrigger?
		jr	Z,retrigclr

		set	6,(IX+CCBFLAGS)
		jp	loop

retrigclr	res	6,(IX+CCBFLAGS)
		jp	loop

cmdpause	ld	IX,CCB	       		; pause all CCB's current running
		ld	B,16
		ld	DE,32
cmdpsloop	res	4,(IX+CCBFLAGS)		; go through CCB's
						; shut off running flags
		add	IX,DE
		dec	B
		jr	NZ,cmdpsloop

		call	CLIPALL
		jp	loop

cmdresume	call	RESUMEALL
		jp	loop

cmdsussw	call	GETCCBPTR	; set sustain flag for this channel
					; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		call	GETCBYTE
		or	A		; switch on?
		jr	Z,cmdsusoff
		set	7,(IX+CCBFLAGS)	; yes
		jp	loop

cmdsusoff	res	7,(IX+CCBFLAGS)	; no
		jp	loop

cmdsetprio	call	GETCCBPTR	; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		call	GETCBYTE 	; set priority for this channel
		ld	(IX+CCBPRIO),A
		jp	loop

cmdstopall	ld	IX,CCB		; start with CCB 0
		ld	DE,32
		ld	B,16		; only 16 CCB's to try

stopallloop	ld	(IX+CCBFLAGS),0	; yes - make it free, no retrig, no sustain
		ld	(IX+CCBDURL),0 	; clear duration to enable live play
		ld	(IX+CCBDURH),0
		add	IX,DE
		dec	B
		jr	NZ,stopallloop
		call	CLIPALL	       	; chop off all notes
		jp	loop

cmdmute		call	GETCBYTE
		ld	C,A		; C <- seq #
		call	GETCBYTE
		ld	H,A		; H <- ch #
		call	GETCBYTE
		ld	L,A		; L <- 1 to mute, 0 to unmute
		ld	IX,CCB		; start with CCB 0
		ld	DE,32
		ld	B,16  		; only 16 CCB's to try
muteseqloop	bit	0,(IX+CCBFLAGS)	; is this channel in use?
		jr	Z,muteseqskip  	; no - skip it

		ld	A,(IX+CCBSNUM) 	; yes - is it for this seq number?
		cp	C
		jr	NZ,muteseqskip

		ld	A,(IX+CCBVCHAN)	; yes - for this channel ?
		cp	H
		jr	NZ,muteseqskip

		bit	0,L	       	; mute or unmute?
		jr	NZ,muteit

		res	1,(IX+CCBFLAGS)	; unmute
		jr	muteseqskip

muteit	   	set	1,(IX+CCBFLAGS)	; mute

muteseqskip	dec	B
		jp	Z,loop
		add	IX,DE
		jr	muteseqloop

cmdlockch	call	GETCCBPTR      	; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		set	5,(IX+CCBFLAGS)
		jp	loop

cmdunlockch	call	GETCCBPTR      	; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		res	5,(IX+CCBFLAGS)
		jp	loop

RESUMEALL	ld	IX,CCB	       	; resume all enabled CCB's
		ld	B,16
		ld	DE,32
cmdresloop	bit	5,(IX+CCBFLAGS)	; go through CCB's, locked? then dont resume
		jr	NZ,cmdresnext

		bit	0,(IX+CCBFLAGS)
		jr	Z,cmdresnext

		set	4,(IX+CCBFLAGS)	; set any enabled CCB's running again
cmdresnext	dec	B
		ret	Z

		add	IX,DE
		jr	cmdresloop

cmdvolume 	call	GETCCBPTR	; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		call	GETCBYTE 	; get attenuation value
		cpl	A
		and	07FH
		cp	(IX+CCBATN)
		jr	Z,novchg
		ld	(IX+CCBATN),A
		ld	A,1
		ld	(NEEDVOL),A
novchg		jp	loop

cmdmasteratn	call	GETCBYTE
		ld	(MASTERATN),A
		jp	loop
*
*  CLIPALL - called by STOPALL and PAUSEALL - cancels all envelopes, voices
*
*	scans voice tables, clipping off notes from inactive (not running channels)
*

CLIPVNUM	db	0
CLIPALL		ld	IX,FMVTBL		; do fm voices
		ld	E,0
		call	CLIPLOOP
		ld	IX,PSGVTBL
		ld	E,1
		call	CLIPLOOP
		ld	IX,PSGVTBLNG
		ld	E,1
		call	CLIPLOOP
		ld	IY,ECB-1		; now clip envelopes
clipenvloop	inc	IY
		ld	A,(IY+ECBCHAN)
		bit	7,A			; end of list?
		ret	NZ

		bit	6,A			; in use?
		jr	NZ,clipenvloop

		ld	B,0
		sla	A
		sla	A
		sla	A
		sla	A
		sla	A
		ld	C,A
		rl	B
		ld	HL,CCB+CCBFLAGS
		add	HL,BC
		bit	4,(HL)			; running?
		jp	NZ,clipenvloop		; yes - don't clip this env

		set	6,(IY+ECBCHAN)
		jr	clipenvloop

* IX <- voice table, E <- 0 for fm, 1 for psg

CLIPLOOP	ld	A,(IX+VTBLFLAGS)	; get vtbl entry
		cp	0FFH
		ret	Z

		ld	D,A			; save it
		ld	B,0
		ld	C,(IX+VTBLCH)		; see if this ccb is running
		sla	C
		sla	C
		sla	C
		sla	C
		sla	C
		rl	B
		ld	HL,CCB+CCBFLAGS
		add	HL,BC
		bit	4,(HL)			; running?
		jp	NZ,clipnxt		; yes - don't clip

		ld	A,D
		and	7			; get voice num
		or	80H			; add free flag
		ld	(IX+VTBLFLAGS),A	; update table
		ld	(IX+VTBLDL),0		; clear release and duration timers
		ld	(IX+VTBLDH),0
		ld	(IX+VTBLRT),0
		and	7			; get voice num back
		ld	(CLIPVNUM),A
		bit	0,E			; fm or psg?
		jp	NZ,clippsg
clipdig
clipfm		ld	D,0			; point to bank 0
		cp	3			; is voice in bank 1 ?
		jr	C,clpafm0

		sub	4			; yes, subtract 4 (map 4-6 >> 0-2)
		ld	D,2			; point to bank 1
clpafm0		push	DE
		ld	E,A			; E <- channel within bank
		ld	H,40H
 		FMWr	040H,7FH		; clamp all EGs
 		FMWr	044H,7FH
 		FMWr	048H,7FH
 		FMWr	04CH,7FH
		pop	DE
		ld	A,(CLIPVNUM)
		ld	IY,4000H
		FMWrite 28H,A           	; key off
clipnxt		ld	BC,7
		add	IX,BC
		jp	CLIPLOOP

clippsg		ld      IY,psgcom		; load psg register table
		ld      C,A			; BC <- 0A
		ld      B,0
		add	IY,BC			; point to correct register
		ld      (IY+COM),4		; set stop command
		jr	clipnxt

*
*  TRIGENV - initialize an envelope
*
*	parameters:		C	envelope number
*				E	midi channel
*				IX	pointer to CCB
*
*	trashes:		everything
*

TRIGENV		ld	B,(IX+CCBFLAGS)		; save channel's flags (for sfx tempo flag) in B
		ld	D,0
		ld	IY,PBTBL
		add	IY,DE
		ld	IX,ECB			; point at the envelope control blocks
retrigloop	ld	A,(IX+ECBCHAN)		; first see if an ECB already exists for this channel
		bit	7,A			; end of list?
		jr	NZ,tryfree

		cp	E
		jr	Z,trigger

		inc	IX
		jr	retrigloop

tryfree		ld	IX,ECB
trigloop					; then try to find a free ECB
		ld	A,(IX+ECBCHAN)		; A <- channel number and flags
		bit	7,A			; end of list?
		ret	NZ			; yup - return

		bit	6,A			; active ?
		jr	NZ,trigger		; nope - go allocate

		inc	IX
		jr	trigloop

trigger						; trigger envelope
		bit	3,B			; sfx flag set in CCB?
		jr	Z,trigger1

		set	5,E			; yes - set sfx flag in ECB
trigger1	ld	(IX+ECBCHAN),E		; set channel
		ld	(IX+ECBCTR),0		; clear counter to trigger segment update
		ld	B,0
		sla	C			; BC <- 2 * envelope #
;		ld	HL,(ETBL68K)
;		ld	A,(ETBL68K+2)		; AHL <- pointer to env table in 68k space
		add	HL,BC
		adc	A,0			; AHL <- pointer to this env's offset
		ld	C,2			; read 2 byte offset, into...
;		ld	DE,fpoffset		; local fpoffset (shared w/ fetchpatch)

;call	XFER68K

;		ld	DE,(fpoffset)		; DE <- the offset
;		ld	HL,(ETBL68K)
;		ld	A,(ETBL68K+2)
		add	HL,DE
		adc	A,0			; AHL <- pointer to env data
		ld	C,32			; xfer the 32 byte env into
		ld	D,01EH
		ld	E,(IX+ECBBUFP)		; this ECB's envelope buffer

;call	XFER68K

		ld	D,01EH
		ld	E,(IX+ECBBUFP)		; DE <- ptr to this ECB's envelope buffer
		ld	A,(DE)			; initialize envelope bend value
		ld	(IY+PBEBL),A
		inc	DE
		ld	A,(DE)
		ld	(IY+PBEBH),A
		inc	DE
		ld	(IX+ECBPTRL),E		; point ECB at envelope after initial value
		ld	(IX+ECBPTRH),D
		ret
*
*  DOENVELOPE - update the pitch envelope processor
*
*		trashes:	everything
*

ECB		db	040H,040H,040H,040H	; 4 envelopes worth of control blocks (ECB's)
		db	0FFH
		db	0,0,0,0
		db	0,0,0,0
		db	0,0,0,0
		db	0,0,0,0
		db	0,0,0,0
		db	80H,0A0H,0C0H,0E0H

DOENVELOPE	ld	IX,ECB		; point at the envelope control blocks
envloop		ld	C,(IX+ECBCHAN)	; C <- channel number and flags
		bit	7,C	      	; end of list?
		ret	NZ	      	; yup - return

		bit	6,C	      	; active ?
		jr	Z,envactive

envnext		inc	IX		; nope - loop
		jr	envloop

envactive	ld	A,(TBASEFLAGS)	; check if this envelope's timebase has ticked
		bit	5,C	      	; sfx timebase?
		jr	NZ,envsfx

		bit	1,A	      	; no - check music tick flag
		jr	NZ,envticked
		jr	envnext

envsfx		bit	0,A		; yes - check sfx tick flag
		jr	Z,envnext

envticked	ld	A,(IX+ECBCTR)
		sub	1	   	; ctr at 0?
		jr	NC,envseg  	; no - process segment

envnextseg	ld	L,(IX+ECBPTRL)	; yes -
		ld	H,(IX+ECBPTRH)	; HL <- ptr to segment data
		ld	A,(HL)	      	; A <- counter value for next segment
		sub	1
		jr	C,envdone

		inc	HL
		ld	B,(HL)
		ld	(IX+ECBDELL),B
		inc	HL
		ld	B,(HL)
		ld	(IX+ECBDELH),B	; ECB's delta <- this segment's delta
		inc	HL
		ld	(IX+ECBPTRL),L	; ECB's segment ptr <- ptr to next segment
		ld	(IX+ECBPTRH),H

envseg		ld	IY,PBTBL	; process segment
		ld	B,0
		res	5,C
		add	IY,BC		; IY <- ptr to this channel's pitchbend entries
		ld	(IX+ECBCTR),A	; save ECB's counter
		ld	A,(IY+PBEBL)
		add	A,(IX+ECBDELL)
		ld	(IY+PBEBL),A
		ld	A,(IY+PBEBH)
		adc	A,(IX+ECBDELH)
		ld	(IY+PBEBH),A 	; this ch's envelope bend += this envelope's delta

envneedupd	set	0,(IY+PBRETRIG)
		ld	A,1
		ld	(NEEDBEND),A
		jr	envnext

envdone		ld	IY,PBTBL
		ld	B,0
		res	5,C
		add	IY,BC		; IY <- ptr to this channel's pitchbend entries
		ld	(IY+PBEBL),0	; zero the envelope bend on this channel
		ld	(IY+PBEBH),0
		ld	(IX+ECBCHAN),040H	; shut off this envelope
		jr	envneedupd
*
*  DOPITCHBEND- updates the (pitchbend) value for the gems channel (= MIDI channel during perf
*
* inputs:	A				CCB number (0-15)
*	 	(next 2 bytes in cmd queue)	pbend value
*
DOPITCHBEND	ld	C,A
		ld	B,0
		ld	IX,PBTBL
		add	IX,BC			; IX <- ptr to this ch's bends
		call	GETCBYTE		; get pitch bend in half steps (8 fracs) into
		ld	(IX+PBPBL),A		; pitch bend for channel 0
		call	GETCBYTE
		ld	(IX+PBPBH),A
		set	0,(IX+PBRETRIG)
		ld	A,1
		ld	(NEEDBEND),A
		ret

* APPLYBEND -	if NEEDBEND is set, apply the pitch and envelope bends to
*		all channels, and reset NEEDBEND
* trashes:	everything

NEEDBEND	db	0				; set to 1 to trigger a need to bend


PBTBL		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	; pitch bend LSB
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	; pitch bend MSB
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	; env bend LSB
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	; env bend MSB
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	; [0]=apply bend - set by pbend/mod,

APPLYBEND	ld	A,(NEEDBEND)		; return if no bend needed
		or	A
		ret	Z

		xor	A
		ld	(NEEDBEND),A		; clear the flag and do it
		call	CHECKTICK
		ld	IY,FMVTBL		; go through FM voice table

pbfmloop	ld	A,(IY+0)
		cp	0FFH			; eot?
		jr	Z,pbpsg			; yup - all done

		and	7
		ld	B,A			; B <- voice number
		ld	C,(IY+2)		; C <- note number
		ld	E,(IY+3)		; E <- channel number
		ld	A,0			; indicate FM type voice

;FOR TESTING ONLY
;		jr	pbfmskip
		ld	IX,PBTBL
		ld	D,0
		add	IX,DE			; IX <- ptr to pitch/envelope bend for this ch
		bit	0,(IX+PBRETRIG)		; check for change in bend on this channel
		jr	Z,pbfmskip

		call	GETFREQ			; get the new freq num for this voice
		ld	(noteonffreq),DE	; save freq number
		ld	D,0			; indicates bank 0 to FMWr
		ld	A,B
		cp	3			; is voice in bank 1 ?
		jr	C,pbfmbank0

		sub	4			; yes, subtract 4 (map 4-6 >> 0-2)
		ld	D,2			; indicates bank 1 to FMWr
pbfmbank0	ld	E,A			; E <- channel within bank
		ld	H,40H
		push	IY
		ld	IY,noteonffreq		; IY <- ptr to freq number from GETFREQ
		FMWr	0A4H,(IY+1)
 		FMWr	0A0H,(IY+0)		; set frequency lsb
		pop	IY
pbfmskip	ld	DE,7
		add	IY,DE
		jr	pbfmloop


* New Register Usage ^^^
*   H <- 40H (MSB of FM chip register address)
*   D <- 0 for bank 0 (channels 0,1,2) or 2 for bank 1 (channels 3,4,5)
*   E <- channel within bank (0-2)
* FMWrch uses these plus A,B,C,L
*

pbpsg		ld	IY,PSGVTBL	; go through PSG voice table
pbpsgloop	ld	A,(IY+0)
		cp	0FFH		; eot?
		jr	Z,pbdone	; yup - all done

		and	7
		ld	B,A		; B <- voice number
		ld	C,(IY+2)	; C <- note number
		ld	E,(IY+3)  	; DE <- channel number
		ld	A,1	  	; flag psg type voice

;FOR TESTING ONLY
;		jr	pbpsgskip
		ld	IX,PBTBL
		ld	D,0
		add	IX,DE			; IX <- ptr to pitch/envelope bend for this ch
		bit	0,(IX+PBRETRIG)		; check for change in bend on this channel
		jr	Z,pbpsgskip

		call	GETFREQ			; get the new freq num for this voice
		rrc	B
		rrc	B
		rrc	B
		ld	A,E
		and	0FH
		or	80H
		or	B
		ld	(07F11H),A
		srl	D
		rr	E
		srl	D
		rr	E
		srl	D
		rr	E
		srl	D
		rr	E
		ld	A,E
		ld      (07F11H),A		; write tone msb
pbpsgskip	ld	DE,7
		add	IY,DE
		jr	pbpsgloop

pbdone		ld	HL,PBTBL+PBRETRIG
		ld	A,16
pbdoneloop	ld	(HL),0
		inc	HL
		dec	A
		jr	NZ,pbdoneloop

		ret


*  GETFREQ - gets a frequency (for FM) or wavelength (for PSG) value from a note
*	number and a channel # (for adding pitch and envelope bends)
*
*	parameters:	A	0 for FM, 1 for PSG
*			C	note (0=C0, 95=B7)
*			E	channel
*			IX	pointer to this channel's PBTBL entry

*	returns:	DE	freq or wavelength value
*
*	trashs:		A,IX

gfpbend		dw	0		; local pitch bend
GETFREQ		push	BC
		push	HL
		ld	B,A		; B <- voice type
		ld	A,(IX+PBPBL)
		add	A,(IX+PBEBL)
		ld	E,A
		ld	A,(IX+PBPBH)
		adc	A,(IX+PBEBH)
		ld	D,A		; DE <- pitchbend(IX) + envelopebend(IX)
		ld	(gfpbend),DE	; save pitch bend
		ld	A,C
		add	A,D		; A <- semitone + semitone portion of bend
		cp	96		; is it outside 0..95?
		jr	C,gflookup	; no - go to lookup
		bit	7,D		; yes - was bend up or down?
		jr	Z,gftoohi

		ld	A,0		; down - peg at 0 (C0)
		ld	(gfpbend),A
		jr	gflookup

gftoohi		ld	A,0FFH
		ld	(gfpbend),A
		ld	A,95			; up - peg at 95 (B7) and max frac pbend
gflookup	bit	0,B			; voice type ? (dictates lookup method)
		jr	NZ,gflupsg

gfllufm						; fm style lookup
		ld	C,0			; C <- A / 12; A <- A % 12
		cp	48
		jr	C,nobit2

		sub	48
		set	2,C
nobit2		cp	24
		jr	C,nobit1

		sub	24
		set	1,C
nobit1		cp	12
		jr	C,nobit0

		sub	12
		set	0,C
nobit0		ld	IX,fmftbl
		jr	gfinterp

gflupsg						; psg style lookup
		sub	33			; lowest note for PSG is A2
		jr	NC,gflupsg1
		ld	A,0
		ld	(gfpbend),A
gflupsg1	ld	IX,psgftbl

gfinterp					; interpolate up from value at (IX) by (gfpbend)
		rlca
		ld	E,A			; DE <- 2 * A
		ld	D,0
		add	IX,DE			; (IX) <- ptr in appropriate table (clears carry)
		ld	A,(IX+2)
		sub	(IX+0)
		ld	E,A
		ld	A,(IX+3)
		sbc	A,(IX+1)
		ld	D,A			; DE <- next table entry - this table entry
		ld	A,(gfpbend)		; A <- frac part of pitch bend
		call	MULTIPLY		; HL <- (DE (table delta) * A (frac bend) ) * 256
		ld	L,0			; L <- 8 bits sign extention of H
		bit	7,H
		jr	Z,gfnoextnd

		ld	L,0FFH
gfnoextnd	ld	A,(IX+0)
		add	A,H
		ld	E,A
		ld	A,(IX+1)
		adc	A,L
		ld	D,A			; DE <- this entry + (delta * frac)
		bit	0,B			; voice type ?
		jr	NZ,gfdone		; all done for PSG

		ld	A,C			; for FM, put octave in F number 13:11
		rlca
		rlca
		rlca
		or	D
		ld	D,A

gfdone		pop	HL
      		pop	BC
		ret

*
*  MULTIPLY - unsigned 8 x 16 multiply: HL <- A * DE
*	MULADD entry point: for preloading HL with an offset
*	GETPATPTR entry point: HL <- PATCHDATA + 39 * A


GETPATPTR	ld	HL,PATCHDATA
		ld	DE,39
		jr	MULADD

MULTIPLY	ld	HL,0
MULADD		srl	A
		jr	NC,mulbitclr

		add	HL,DE
mulbitclr	ret	Z
		sla	E			; if more bits still set in A, DE*=2 and loop
		rl	D
		jr	MULADD

;*****************************************************************************

		IF	VOL_ONTHEFLY
NEEDVOL		db	0
NVATTEN		db	0

APPLYVOL	ld	A,(NEEDVOL)	; return if no vol needed
		or	A
		ret	Z

		xor	A
		ld	(NEEDVOL),A	; clear the flag and do it
		call	CHECKTICK
		ld	IY,FMVTBL	; go through FM voice table
avfmloop	ld	A,(IY+0)
		cp	0FFH		; eot?
		jp	Z,avpsg		; yup - all done

		ld	E,(IY+3)	; E <- channel number
		ld	D,0
		sla	E
		sla	E
		sla	E
		sla	E
		sla	E
		rl	D
		ld	IX,CCB
		add	IX,DE
		ld	A,(IX+CCBATN)	;get Channel Attenuation		
		ld	(NVATTEN),A  	;store it for now

		ld	A,(IY+3)	;get Patch Pointer
		call	GETPATPTR
		push	HL
		pop	IX	      	; IX <- patch pointer + 1 (past type byte)

		ld	A,(IX+0)
		or	A
		jr	NZ,avfmskip

		inc	IX
		ld	A,(IY+0)
		and	7
		ld	D,0		; indicates bank 0 to FMWr
		cp	3  		; is voice in bank 1 ?
		jr	C,avbank0

		sub	4	    	; yes, subtract 4 (map 4-6 >> 0-2)
		ld	D,2	    	; indicates bank 1 to FMWr
avbank0		ld	E,A	    	; E <- channel within bank
		ld	A,(IX+2)	; lookup up carrier mask by alg number
		and	7
		ld	B,0
		ld	C,A
		ld	HL,CARRIERTBL
		add	HL,BC
		ld	A,(HL)
		ld	(CARRIERS),A	; bit 0 for op 1 carrier, bit 1 for op 2 carrier...
		ld	BC,AVADDRTBL
wfmloop		ld	A,(BC)		; get reg num
		or	A
		jr	Z,avfmskip	; (0 = EOT)
		
		inc	BC
		ld	HL,CARRIERS	; is this a carrier?
		rr	(HL)
		jp	NC,noalter	; no - normal output

		ld	HL,4000H	; point to 4000
wfmspin		bit	7,(HL)		; spin on busy bit
		jr	NZ,wfmspin

		ld	L,D		; point at bank's addr port
		add	A,E		; add voice # to point at correct reg.
		ld	(HL),A
		inc	L		; point at data port
		ld	A,(BC)		; get data offset
		push	HL
		push	DE
		ld	(avmod0+2),A	; modify LD instr. with this offset
		ld	A,127
avmod0		sub	(IX+0)		; becomes sub (IX+dataoffset)
		push	AF		; save level (0=soft, 127=loud)

		IF	FM_SOFTER
		sla	A
		ENDIF

		ld	E,A
		ld	D,0		; DE is level (0=soft, 254=loud)
		ld	A,(NVATTEN)
		call	MULTIPLY
		pop	AF		; get back level
		sub	H		; reduce by attenuation amount
		ld	H,A
		ld	A,127
		sub	H
		pop	DE
		pop	HL
		ld	(HL),A
noalter		inc	BC
		jp	wfmloop

avfmskip	ld	DE,7
		add	IY,DE
		jp	avfmloop

avpsg		ret

AVADDRTBL	db	40H,5		;5+128	; set total level
		db	48H,17		;17+128	; set total level
		db	44H,11		;11+128	; set total level
		db	4CH,23		;23+128	; set total level
		db	0

		ENDIF

******************************************************************************
*
*  NOTEON - note on (key on)
*
*	parameters:	B		midi channel
*			C		note number: 0..95 = C0..B7
*			IX		pointer to this channel's CCB
*			(CHPATPTR)	pointer to this channel's patch
*
*	trashes:	all registers
*

* fmftbl contains a 16 bit freq number for each half step in a single octave (C-C)

fmftbl		dw	644,682,723,766,811,859,910
		dw	965,1022,1083,1147,1215,1288

* psgftbl contains the 16 bit wavelength numbers for the notes A2 thru B7 (33-95)

psgftbl		dw	03F9H,03C0H,038AH	; A2 > B2
		dw	0357H,0327H,02FAH,02CFH	; C3 > B3
		dw	02A7H,0281H,025DH,023BH
		dw	021BH,01FCH,01E0H,01C5H
		dw	01ACH,0194H,017DH,0168H	; C4 > B4
		dw	0153H,0140H,012EH,011DH
		dw	010DH,00FEH,00F0H,00E2H
		dw	00D6H,00CAH,00BEH,00B4H	; C5 > B5
		dw	00AAH,00A0H,0097H,008FH
		dw	0087H,007FH,0078H,0071H
		dw	006BH,0065H,005FH,005AH	; C6 > B6
		dw	0055H,0050H,004CH,0047H
		dw	0043H,0040H,003CH,0039H
		dw	0035H,0032H,002FH,002DH	; C7 > B7 (not very accurate!)
		dw	002AH,0028H,0026H,0023H
		dw	0021H,0020H,001EH,001CH
		dw	001CH				; extra value for interpolation of B7

noteonnote	db	0			; note on note (keep these together - stored as BC)
noteonch	db	0			; note on channel
noteonvoice	db	0			; allocated voice
noteonatten	db	0			; attenuation for this voice

NOTEON
;; LAST MINUTE FIX FOR TAZ LEVELS - down 7
		ld	A,(MASTERATN)

;;		add	A,10
		add	A,(IX+CCBATN)		; sum channel and master attenuations, limit to 127

		jp	P,legalatten

		ld	A,127
legalatten	ld	(noteonatten),A
		ld	(noteonnote),BC		; save note and channel
		call	CHECKTICK

		ld	HL,(CHPATPTR)
		ld	A,(HL)			; A <- patch type (byte 0 of patch)
		cp	0
		jp	Z,noteonfm		; 0 for fm patches
		cp	2
		jp	Z,noteontone
		cp	3
		jp	Z,noteonnoise
		ret

* here to allocate a voice for a PSG patch

noteonnoise	ld	IY,PSGVTBLNG		; try to get TG4 (noise ch)
		call	ALLOCSPEC
		jr	noteoneither

noteontone	ld	IY,PSGVTBL
		call	ALLOC
noteoneither	cp	0FFH
		ret	Z			; return if unable to allocate a voice

		call	VTANDET			; call code shared by FM and PSG to update
						; VoiceTable AND Envelope Trigger
		ld	A,1			; indicates PSG
		ld	E,B			; E <- channel
		ld	IX,PBTBL
		ld	D,0
		add	IX,DE			; IX <- ptr to pitch/envelope bend for this ch
		call	GETFREQ
		ld	IX,(CHPATPTR)		; IX <- patch pointer
		inc	IX
		ld	A,(noteonvoice)		; A <- PSG voice number
		ld      C,A
		ld      B,0
		ld      IY,psgcom
		add	IY,BC			; IY <- psg control registers for this voice
		ld	A,E
		and	0FH
		ld      (IY+DTL),A		; write tone lsb
		srl	D
		rr	E
		srl	D
		rr	E
		srl	D
		rr	E
		srl	D
		rr	E
		ld      (IY+DTH),E		; write tone msb
		ld	A,(noteonvoice)
		cp	3
		jr	NZ,pskon		; for TG1-TG3, go on to rest of control regs

		ld	HL,PSGVTBLTG3		; assume TG3 is not locked by this noise patch
		res	5,(HL)

		ld	A,(IX-1)		; its TG4 - is it clocked by TG3?
		and	3
		cp	3
		jr	NZ,psgnoise

		ld	HL,7F11H		; yes - move the frequency directly to TG3
		ld	A,(IY+DTL)
		or	0C0H
		ld	(HL),A
		ld	A,(IY+DTH)
		ld	(HL),A
		ld	HL,PSGVTBLTG3		; in the voice table...
		ld	(HL),0A2H		; show TG3 free and locked
		inc	HL
		inc	HL
		ld	BC,(noteonnote)
		ld	(HL),C			; and store note and channel (for pitch mod)
		inc	HL
		ld	(HL),B
		ld	HL,psgcom+2		; and send a stop command to TG3 env processor
		ld	(HL),4
psgnoise	ld      A,(IX+0)		; load noise data
		ld      (IY+DTL),A		; write noise data
pskon      	ld      A,(IX+1)		; load attack rate
		ld      (IY+ATK),A		; write attack rate
		ld      A,(IX+2)		; load sustain level
		sla     A			; fix significance (<<4)
		sla     A
		sla     A
		sla     A
		ld      (IY+SLV),A		; write sustain level
		ld      A,(IX+3)		; load attack level
		sla     A			; fix significance (<<4)
		sla     A
		sla     A
		sla     A
		ld      (IY+ALV),A		; write attack level
		ld      A,(IX+4)		; load decay rate
		ld      (IY+DKY),A		; write decay rate
		ld      A,(IX+5)		; load release rate
		ld      (IY+RRT),A		; write release rate
		set     0,(IY+COM)		; key on command
		ret

* here to allocate a voice for an FM patch

noteonffreq	dw	0
noteonfm	inc	HL
		inc	HL
		ld	D,(HL)	    		; (D <- CH3 mode byte)
		bit	6,D
		jr	Z,noteonfm1

		ld	IY,FMVTBLCH3		; only CH3 will do for a CH3
		call	ALLOCSPEC		; mode patch
		jr	noteonfm15
noteonfm1	ld	IY,FMVTBL
		call	ALLOC
noteonfm15	cp	0FFH
		ret	Z			; return if unable to allocate a voice

		bit	7,A			; was it in use?
		jr	NZ,noteonfm2

		and	7			; yes - do a keyoff
		ld	IY,4000H
		FMWrite	28H,A
		ld	A,(HL)			; get flags back
noteonfm2	push	DE
		call	VTANDET
		pop	DE
		bit	6,D			; skip freq computation for CH3 mode
		jr	NZ,noteonfm3

		ld	A,0			; FM type voice
		ld	E,B			; E <- channel
		ld	IX,PBTBL
		ld	D,0
		add	IX,DE			; IX <- ptr to pitch/envelope bend for this ch
		call	GETFREQ
		ld	(noteonffreq),DE	; save freq number

noteonfm3	ld	IX,(CHPATPTR)		; IX <- patch pointer + 1 (past type byte)
		inc	IX
		ld	A,(noteonvoice)
		ld	C,A			; C  <- key on code
		ld	IY,4000H		; IY <- FM chip
		cp	2			; channel 3 ?
		jr	NZ,noteonfm4

		ld	A,(IX+1)		; yes - add CH3 mode bits to GDACME's reset cmd
		or	15H
		exx
		ld	B,A			;  which is kept in B'
		exx
		ld	A,(IX+1)		; CH3 mode bits again, plus bits to
		or	5			; KEEP TIMER A ENABLED AND RUNNING, but not reset
		ld	H,A
		ld	L,27H			; send now
		FMWrgl
noteonfm4	ld	D,0		; indicates bank 0 to FMWr
		ld	A,C
		cp	3  		; is voice in bank 1 ?
		jr	C,fmbank0

		sub	4	    	; yes, subtract 4 (map 4-6 >> 0-2)
		ld	D,2	    	; indicates bank 1 to FMWr
fmbank0		ld	E,A	    	; E <- channel within bank
		ld      H,(IX+0)    	; load lfo data
		bit	3,H	    	; only load if LFO on in this patch
		jr	Z,fmlfodis

		ld      L,22H	    	; load register number
		FMWrgl		    	; write lfo register
fmlfodis	push	BC		; save C (note on number)
		ld	HL,CARRIERTBL
		ld	B,0
		ld	A,(IX+2)	; lookup up carrier mask by alg number
		and	7
		ld	C,A
		add	HL,BC
		ld	A,(HL)
		ld	(CARRIERS),A	; bit 0 for op 1 carrier, bit 1 for op 2 carrier...
		ld	H,40H
		ld	BC,FMADDRTBL
		call	WRITEFM
FOO2		bit     6,(IX+1)    	; check channel 3 mode
		jr      NZ,fmc3on   	; go set channel 3 frequency

		ld	IY,noteonffreq	; IY <- ptr to freq number from GETFREQ
		FMWr	0A4H,(IY+1)   	; set frequency msb
 		FMWr	0A0H,(IY+0)   	; set frequency lsb
		jp      fmkon	      	; go key on

fmc3on		ld	IY,4000H
		FMWrite	0A6H,(IX+28)	; ch3 op1 msb
 		FMWrite 0A2H,(IX+29)	; ch3 op1 lsb
 		FMWrite 0ACH,(IX+30)	; ch3 op2 msb
 		FMWrite 0A8H,(IX+31)	; ch3 op2 lsb
 		FMWrite 0ADH,(IX+32)	; ch3 op3 msb
 		FMWrite 0A9H,(IX+33)	; ch3 op3 lsb
 		FMWrite 0AEH,(IX+34)	; ch3 op4 msb
 		FMWrite 0AAH,(IX+35)	; ch3 op4 lsb

fmkon:		ld      A,(IX+36)   	; load operator on mask
		sla     A	    	; fix significance
		sla     A
		sla     A
		sla     A
		pop	BC		; UGLY!!!!!
		or	C	      	; mix with channel code
		ld      IY,4000H      	; global fm register
		FMWrite 28H,A	      	; key on
		ret

CARRIERTBL	db	08H		; alg 0, op 4 is carrier
		db	08H		; alg 1, op 4 is carrier
		db	08H		; alg 2, op 4 is carrier
		db	08H		; alg 3, op 4 is carrier
		db	0AH		; alg 4, op 2 and 4 are carriers
		db	0EH		; alg 5, op 2 and 3 and 4 are carriers
		db	0EH		; alg 6, op 2 and 3 and 4 are carriers
		db	0FH		; alg 7, all ops carriers
CARRIERS	db	0
MASTERATN	db	0		; master attenuation is 7 frac bits (0 = full volume)
*
* WRITEFM	Write a string of values to the FM chip. BC points to a
*		null-terminated	list of reg/data pairs, where data is an
*		offset from IX. If data is 0, the indirection is skipped and
*		a 0 written (for the "proprietary register")
*		H <- 40H (MSB of FM chip register address)
*		D <- 0 for bank 0 (chans 0,1,2) or 2 for bank 1 (chans 3,4,5)
*		E <- channel within bank (0-2)
*
WRITEFM		ld	A,(BC)		; get reg num
		or	A
		ret	Z		; (0 = EOT)

		inc	BC
		ld	L,0		; point to 4000
wrspin		bit	7,(HL)		; spin on busy bit
		jr	NZ,wrspin
		ld	L,D		; point at bank's addr port
		add	A,E		; add voice # to point at correct reg.
		ld	(HL),A
		inc	L		; point at data port
		ld	A,(BC)		; get data offset
		or	A		; if data offset 0, just write 0
		jp	Z,writefm0

		jp	P,nottl		; msb indicates total level values

		and	7FH		; mask off tl flag
		push	HL
		ld	HL,CARRIERS	; is this a carrier?
		rr	(HL)
		jp	NC,nottl0	; no - normal output

		push	DE
		ld	(SELFMOD2+2),A	; modify LD instr. with this offset
		ld	A,127
SELFMOD2	sub	(IX+0)		; becomes ld A,(IX+dataoffset)
		push	AF		; save level (0=soft, 127=loud)

		IF	FM_SOFTER
		sla	A
		ENDIF

		ld	E,A
		ld	D,0		; DE is level (0=soft, 254=loud)
		ld	A,(noteonatten)
		call	MULTIPLY
		pop	AF		; get back level
		sub	H		; reduce by attenuation amount
		ld	H,A
		ld	A,127
		sub	H
		pop	DE
		pop	HL
		jr	writefm0

nottl0		pop	HL
nottl		ld	(SELFMOD+2),A	; modify LD instruction with this offset
SELFMOD		ld	A,(IX+0)     	; becomes ld A,(IX+dataoffset)
writefm0	ld	(HL),A
		inc	BC
		jp	WRITEFM

FMADDRTBL	db	0B0H,2		; set feedback, algorithm
		db	0B4H,3		; set output, ams, fms
		db	30H,4		; operator 1 - set detune, mult
		db	40H,133		;5+128	; set total level
		db	50H,6		; set rate scaling, attack rate
		db	60H,7		; set am enable, decay rate
		db	70H,8		; set sustain decay rate
		db	80H,9		; set sustain level, release rate
		db	90H,0		; set proprietary register
		db	38H,16		; operator 2 - set detune, mult
		db	48H,145		;17+128	; set total level
		db	58H,18		; set rate scaling, attack rate
		db	68H,19		; set am enable, decay rate
		db	78H,20		; set sustain decay rate
		db	88H,21		; set sustain level, release rate
		db	98H,0		; set proprietary register
		db	34H,10		; operator 3 - set detune, mult
		db	44H,139		;11+128	; set total level
		db	54H,12		; set rate scaling, attack rate
		db	64H,13		; set am enable, decay rate
		db	74H,14		; set sustain decay rate
		db	84H,15		; set sustain level, release rate
		db	94H,0		; set proprietary register
		db	3CH,22		; operator 4 - set detune, mult
		db	4CH,151		;23+128	; set total level
		db	5CH,24		; set rate scaling, attack rate
		db	6CH,25		; set am enable, decay rate
		db	7CH,26		; set sustain decay rate
		db	8CH,27		; set sustain level, release rate
		db	9CH,0		; set proprietary register
		db	0
EOWRITEFM

*
*  VTANDET - code shared between FM and PSG note on routines for stuffing the
*    voice table entry and checking for envelope retrigger
*

VTANDET		and	7		; clear flags
		ld	(noteonvoice),A	; save allocated voice
		ld	(HL),A
		ld	E,(IX+CCBDURL)
		ld	D,(IX+CCBDURH)
		ld	A,D
		or	E
		jr	Z,noselftime	; if non-zero duration, set self-time flag
		set	4,(HL)
noselftime	bit	3,(IX+CCBFLAGS)	; sfx tempo based?
		jr	Z,nosfxtempo
		set	3,(HL)	       	;  yes - set voice tbl sfx flag
nosfxtempo	inc	HL
		ld	A,(IX+CCBPRIO)
		ld	(HL),A
		ld	BC,(noteonnote)	; C <- note, B <- channel
		inc	HL	       	; store note and channel in table
		ld	(HL),C
		inc	HL
		ld	(HL),B
		inc	HL
		ld	(HL),E
		inc	HL
		ld	(HL),D
		inc	HL
		ld	(HL),254       	; init release timer
		bit	6,(IX+CCBFLAGS)	; envelope retrigger on?
		ret	Z

		push	BC	       	; yes - trigger the envelope
		ld	C,(IX+CCBENV)
		ld	E,B
		call	TRIGENV
		pop	BC
		ret
*
*  NOTEOFF - note off (key off)
*
*	parameters:	B	midi channel
*			C	note number: bits 6:4 = octave, bits 3:0 = note (0-11)
*
*	trashes:	all registers
*

noteoffnote	db	0
noteoffch	db	0

NOTEOFF		ld	(noteoffnote),BC
		ld	IX,FMVTBL
		call	DEALLOC
		cp	0FFH	       	; was note found?
		jr	Z,trypsg

		and	7	       	;   no - get note number
		ld      IY,4000H       	; load fm register address
		FMWrite 28H,A          	; key off
		ret

trypsg		ld	BC,(noteoffnote)
		ld	IX,PSGVTBL
		call	DEALLOC
		cp	0FFH
		jr	Z,trynoise

		and	3
		ld      IX,psgcom		; load psg register table
		ld      C,A			; BC <- 0A
		ld      B,0
		add	IX,BC			; point to correct register
		set	1,(IX+0)		; set key off command
		ret

trynoise  	ld	BC,(noteoffnote)
		ld	IX,PSGVTBLNG
		call	DEALLOC
		cp	0FFH
		ret	Z
		
		and	3
		ld      IX,psgcom		; load psg register table
		ld      C,A			; BC <- 0A
		ld      B,0
		add	IX,BC			; point to correct register
		set	1,(IX+0)		; set key off command
		ret


NOTESOFF	ld	(noteoffnote),BC
		ld	IX,FMVTBL

		ld	DE,7
		jr	dvstarts

dvloops		add	IX,DE
dvstarts	ld	A,(IX+0) 	; get flags
		ld	H,A	 	; save em
		cp	0FFH
		ret	Z	 	; eot - return FF in A for not found

		bit	7,A
		jr	NZ,dvloops	; if if free skip this voice

		ld	A,(IX+3)
		cp	B	 	; yes - check channel
		jr	NZ,dvloops

		ld	A,H
		and	27H	 	; check for digital - locked and voice num=6
		or	0C0H		; set free and release
		ld	(IX+0),A	; save flags
		ld	A,H


		and	7	       	;   no - get note number
		ld      IY,4000H       	; load fm register address
		FMWrite 28H,A          	; key off

		jr	dvloops



;*****************************************************************************
;
; PCHANGE	Program change
; Trashes:	all registers
;
PCHANGE		call	GETCCBPTR     	; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		call	GETPATPTR     	; HL <- PATCHDATA + 39 * A
		ld	(CHPATPTR),HL 	; set pointer to this channel's patch buffer
		call	GETCBYTE
		ld	(IX+CCBPNUM),A	; set program number in CCB
FETCHPATCH	ld	D,0
		ld	E,(IX+CCBPNUM)
		sla	E		; DE <- pnum * 2
		ld	HL,Patches
		add	HL,DE
		ld	E,(HL)		; DE <- the offset
		inc	HL
		ld	D,(HL)
		ld	HL,Patches
		add	HL,DE
		ld	BC,39		; xfer the 39 byte patch into
		ld	DE,(CHPATPTR)	; this channel's patch buffer
		ldir
		ret

PATCHLOAD	ld	B,A		; B <- patchnum
		ld	C,16		; C <- loop counter
		ld	IX,CCB
		ld	HL,PATCHDATA
		ld	(CHPATPTR),HL
plloop	 	ld	A,B
		cp	(IX+CCBPNUM)
		jr	NZ,plloop1

		push	BC
		call	FETCHPATCH
		pop	BC
plloop1	 	ld	DE,32
		add	IX,DE
		ld	DE,39
		ld	HL,(CHPATPTR)
		add	HL,DE
		ld	(CHPATPTR),HL
		dec	C
		jr	NZ,plloop
		ret

***************************  Dynamic Voice Allocation ***************************

*  FMVTBL - contains (6) 7-byte entires, one per voice:
*    byte 0: FRLxxVVV	flag byte, where F=free, R=release phase, L=locked,
*			VVV=voice num. VVV is numbered (0,1,2,4,5,6) for
*		 	writing directly to key on/off reg
*    byte 1: priority	only valid for in-use (F=0) voices
*    byte 2: notenum	    "
*    byte 3: channel	    "
*    byte 4: lsb of duration timer (for sequenced notes)
*    byte 5: msb of duration timer
*    byte 6: release timer


FMVTBL		db	080H,0,050H,0,0,0,0		; fm voice 0
		db	081H,0,050H,0,0,0,0		; fm voice 1
		db	084H,0,050H,0,0,0,0		; fm voice 3
		db	085H,0,050H,0,0,0,0		; fm voice 4

FMVTBLCH6	db	086H,0,050H,0,0,0,0		; fm voice 5 (supports digital)

FMVTBLCH3	db	082H,0,050H,0,0,0,0		; fm voice 2 (supports CH3 poly mode)
		db	0FFH

PSGVTBL		db	080H,0,050H,0,0,0,0		; normal type voice, number 0
		db	081H,0,050H,0,0,0,0		; normal type voice, number 1

PSGVTBLTG3	db	082H,0,050H,0,0,0,0		; normal type voice, number 2
		db	0FFH

PSGVTBLNG	db	083H,0,050H,0,0,0,0		; noise type voice, number 3
		db	0FFH

*  ALLOC     - dynamic voice allocation routine
*  ALLOCSPEC - special entry point for only allocating or not the single voice at (IY)
*
*	parameters:	B	channel
*			IX	pointer to this channel's CCB
*			IY	first entry in appropriate voice table
*
*	uses:		?????
*
*	returns:	A	flags of voice allocated, or FF if none allocated
*			HL	pointer to entry allocated

avlowestp	dw	0		; pointer to lowest priority
avfreestp	dw	0		; pointer to longest free

ALLOC		ld	C,0FFH		; C <- lowest prio so far (max actually 7FH)
		ld	L,0FFH		; L <- freest so far (max actually 0FE)
		ld	DE,7		; for incrementing HL to next entry
		ld	H,(IX+CCBFLAGS)	; bit 7 is sustain
		jr	avstart

avloop		add	IY,DE		; point to next entry
avstart		ld	A,(IY+VTBLFLAGS)
		cp	0FFH		; end of table?
		jr	Z,aveot		;   yes - look into taking an in use voice

		bit	5,A		; channel locked?
		jr	NZ,avloop	; yup - skip it

		bit	7,A			; check free/used
		jr	NZ,avfree		;

		ld	A,(IY+VTBLPRIO)		; in use - check priority against lowest so far
		cp	C			; lower than lowest so far?
		jr	NC,avloop

		ld	C,A			; yes - so make this lowest
		ld	(avlowestp),IY
		jr	avloop

avfree		ld	A,(IY+VTBLCH)		; its free - same channel is requester?
		cp	B
		jr	NZ,avdiffch

		bit	7,H			; yes - sustain on?
		jr	NZ,avdiffch

		push	IY
		pop	HL
		ld	A,(HL)			; yes return A and HL
		ret

avdiffch	ld	A,(IY+VTBLRT)		; freer than freest so far?
		cp	L
		jr	NC,avloop

		ld	L,A			; yes - so make this the freest
		ld	(avfreestp),IY
		jr	avloop

aveot		ld	A,L
		cp	0FFH			; any found free?
		jr	Z,avtakeused

		ld	HL,(avfreestp)		; yes take freest
		ld	A,(HL)
		ret

avtakeused	ld	A,C			; no free ones - check lowest so far priority
avspecprio	cp	(IX+CCBPRIO)		; compare to priority of this channel
	  	jr	Z,avtakeit
		jr	C,avtakeit		; this channel >= lowest priority

		ld	A,0FFH			; failed to allocate
		ret

avtakeit	ld	HL,(avlowestp)
		ld	A,(HL)
		ret


ALLOCSPEC	ld	A,(IY+VTBLFLAGS)	; here to only try to allocate the voice at (IY)
		bit	7,A			; free?
		jr	Z,avspecused

		push	IY
		pop	HL
		ret				; yes - take it

avspecused	ld	A,(IY+VTBLPRIO)		; no - have to check priority first
		ld	(avlowestp),IY
		jr	avspecprio

*  DEALLOC - deallocate a voice by searching for a match on notenum and channel.
*    for now - for digital do nuthing
*    if release timer (byte 6) is zero, then set free bit immediately, otherwise
*    set release bit (a 60 Hz routine will count this down and set free when its zero)
*
*	parameters:	B	channel
*			C	note
*			IX	top of voice table
*
*	uses:		D,E,H
*
*	returns:	A	flags byte of deallocated voice, or
*				  0FFH if note not found

DEALLOC		ld	DE,7
		jr	dvstart

dvloop		add	IX,DE
dvstart		ld	A,(IX+0) 	; get flags
		ld	H,A	 	; save em
		cp	0FFH
		ret	Z	 	; eot - return FF in A for not found

		bit	7,A
		jr	NZ,dvloop	; if if free skip this voice

		ld	A,(IX+2)
		cp	C
		jr	NZ,dvloop	; did note match?

		ld	A,(IX+3)
		cp	B	 	; yes - check channel
		jr	NZ,dvloop

		ld	A,H
		and	27H	 	; check for digital - locked and voice num=6
		or	0C0H		; set free and release
		ld	(IX+0),A	; save flags
		ld	A,H
		ret

;*****************************************************************************

Patches


	

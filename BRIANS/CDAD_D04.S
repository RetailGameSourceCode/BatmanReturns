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
; PROGRAM PATCH BANK (Z80 FM+PSG first)
;
		IF	AUDIO_MAIN

		dc.b	$00,$01		; Offset to patch #0: 256
		dc.b	$27,$01		; Offset to patch #1: 295
		dc.b	$4E,$01		; Offset to patch #2: 334
		dc.b	$75,$01		; Offset to patch #3: 373
		dc.b	$9C,$01		; Offset to patch #4: 412
		dc.b	$A3,$01		; Offset to patch #5: 419
		dc.b	$CA,$01		; Offset to patch #6: 458
		dc.b	$D1,$01		; Offset to patch #7: 465
		dc.b	$F8,$01		; Offset to patch #8: 504
		dc.b	$1F,$02		; Offset to patch #9: 543
		dc.b	$46,$02		; Offset to patch #10: 582
		dc.b	$6D,$02		; Offset to patch #11: 621
		dc.b	$94,$02		; Offset to patch #12: 660
		dc.b	$BB,$02		; Offset to patch #13: 699
		dc.b	$C2,$02		; Offset to patch #14: 706
		dc.b	$E9,$02		; Offset to patch #15: 745
		dc.b	$10,$03		; Offset to patch #16: 784
		dc.b	$37,$03		; Offset to patch #17: 823
		dc.b	$5E,$03		; Offset to patch #18: 862
		dc.b	$85,$03		; Offset to patch #19: 901
		dc.b	$8C,$03		; Offset to patch #20: 908
		dc.b	$B3,$03		; Offset to patch #21: 947
		dc.b	$DA,$03		; Offset to patch #22: 986
		dc.b	$01,$04		; Offset to patch #23: 1025
		dc.b	$28,$04		; Offset to patch #24: 1064
		dc.b	$4F,$04		; Offset to patch #25: 1103
		dc.b	$76,$04		; Offset to patch #26: 1142
		dc.b	$9D,$04		; Offset to patch #27: 1181
		dc.b	$C4,$04		; Offset to patch #28: 1220
		dc.b	$CB,$04		; Offset to patch #29: 1227
		dc.b	$F2,$04		; Offset to patch #30: 1266
		dc.b	$19,$05		; Offset to patch #31: 1305
		dc.b	$40,$05		; Offset to patch #32: 1344
		dc.b	$67,$05		; Offset to patch #33: 1383
		dc.b	$8E,$05		; Offset to patch #34: 1422
		dc.b	$B5,$05		; Offset to patch #35: 1461
		dc.b	$DC,$05		; Offset to patch #36: 1500
		dc.b	$03,$06		; Offset to patch #37: 1539
		dc.b	$2A,$06		; Offset to patch #38: 1578
		dc.b	$51,$06		; Offset to patch #39: 1617
		dc.b	$78,$06		; Offset to patch #40: 1656
		dc.b	$7F,$06		; Offset to patch #41: 1663
		dc.b	$86,$06		; Offset to patch #42: 1670
		dc.b	$8D,$06		; Offset to patch #43: 1677
		dc.b	$94,$06		; Offset to patch #44: 1684
		dc.b	$9B,$06		; Offset to patch #45: 1691
		dc.b	$A2,$06		; Offset to patch #46: 1698
		dc.b	$A9,$06		; Offset to patch #47: 1705
		dc.b	$D0,$06		; Offset to patch #48: 1744
		dc.b	$F7,$06		; Offset to patch #49: 1783
		dc.b	$FE,$06		; Offset to patch #50: 1790
		dc.b	$25,$07		; Offset to patch #51: 1829
		dc.b	$4C,$07		; Offset to patch #52: 1868
		dc.b	$73,$07		; Offset to patch #53: 1907
		dc.b	$9A,$07		; Offset to patch #54: 1946
		dc.b	$C1,$07		; Offset to patch #55: 1985
		dc.b	$E8,$07		; Offset to patch #56: 2024
		dc.b	$EF,$07		; Offset to patch #57: 2031
		dc.b	$16,$08		; Offset to patch #58: 2070
		dc.b	$1D,$08		; Offset to patch #59: 2077
		dc.b	$24,$08		; Offset to patch #60: 2084
		dc.b	$2B,$08		; Offset to patch #61: 2091
		dc.b	$32,$08		; Offset to patch #62: 2098
		dc.b	$59,$08		; Offset to patch #63: 2137
		dc.b	$80,$08		; Offset to patch #64: 2176
		dc.b	$A7,$08		; Offset to patch #65: 2215
		dc.b	$CE,$08		; Offset to patch #66: 2254
		dc.b	$D5,$08		; Offset to patch #67: 2261
		dc.b	$FC,$08		; Offset to patch #68: 2300
		dc.b	$03,$09		; Offset to patch #69: 2307
		dc.b	$2A,$09		; Offset to patch #70: 2346
		dc.b	$31,$09		; Offset to patch #71: 2353
		dc.b	$38,$09		; Offset to patch #72: 2360
		dc.b	$3F,$09		; Offset to patch #73: 2367
		dc.b	$66,$09		; Offset to patch #74: 2406
		dc.b	$8D,$09		; Offset to patch #75: 2445
		dc.b	$94,$09		; Offset to patch #76: 2452
		dc.b	$BB,$09		; Offset to patch #77: 2491
		dc.b	$E2,$09		; Offset to patch #78: 2530
		dc.b	$09,$0A		; Offset to patch #79: 2569
		dc.b	$30,$0A		; Offset to patch #80: 2608
		dc.b	$57,$0A		; Offset to patch #81: 2647
		dc.b	$7E,$0A		; Offset to patch #82: 2686
		dc.b	$A5,$0A		; Offset to patch #83: 2725
		dc.b	$CC,$0A		; Offset to patch #84: 2764
		dc.b	$F3,$0A		; Offset to patch #85: 2803
		dc.b	$1A,$0B		; Offset to patch #86: 2842
		dc.b	$41,$0B		; Offset to patch #87: 2881
		dc.b	$68,$0B		; Offset to patch #88: 2920
		dc.b	$8F,$0B		; Offset to patch #89: 2959
		dc.b	$B6,$0B		; Offset to patch #90: 2998
		dc.b	$DD,$0B		; Offset to patch #91: 3037
		dc.b	$04,$0C		; Offset to patch #92: 3076
		dc.b	$2B,$0C		; Offset to patch #93: 3115
		dc.b	$52,$0C		; Offset to patch #94: 3154
		dc.b	$79,$0C		; Offset to patch #95: 3193
		dc.b	$A0,$0C		; Offset to patch #96: 3232
		dc.b	$A7,$0C		; Offset to patch #97: 3239
		dc.b	$CE,$0C		; Offset to patch #98: 3278
		dc.b	$F5,$0C		; Offset to patch #99: 3317
		dc.b	$1C,$0D		; Offset to patch #100: 3356
		dc.b	$43,$0D		; Offset to patch #101: 3395
		dc.b	$6A,$0D		; Offset to patch #102: 3434
		dc.b	$91,$0D		; Offset to patch #103: 3473
		dc.b	$B8,$0D		; Offset to patch #104: 3512
		dc.b	$DF,$0D		; Offset to patch #105: 3551
		dc.b	$06,$0E		; Offset to patch #106: 3590
		dc.b	$2D,$0E		; Offset to patch #107: 3629
		dc.b	$34,$0E		; Offset to patch #108: 3636
		dc.b	$5B,$0E		; Offset to patch #109: 3675
		dc.b	$62,$0E		; Offset to patch #110: 3682
		dc.b	$89,$0E		; Offset to patch #111: 3721
		dc.b	$B0,$0E		; Offset to patch #112: 3760
		dc.b	$D7,$0E		; Offset to patch #113: 3799
		dc.b	$FE,$0E		; Offset to patch #114: 3838
		dc.b	$05,$0F		; Offset to patch #115: 3845
		dc.b	$2C,$0F		; Offset to patch #116: 3884
		dc.b	$53,$0F		; Offset to patch #117: 3923
		dc.b	$7A,$0F		; Offset to patch #118: 3962
		dc.b	$A1,$0F		; Offset to patch #119: 4001
		dc.b	$C8,$0F		; Offset to patch #120: 4040
		dc.b	$EF,$0F		; Offset to patch #121: 4079
		dc.b	$16,$10		; Offset to patch #122: 4118
		dc.b	$1D,$10		; Offset to patch #123: 4125
		dc.b	$44,$10		; Offset to patch #124: 4164
		dc.b	$6B,$10		; Offset to patch #125: 4203
		dc.b	$92,$10		; Offset to patch #126: 4242
		dc.b	$B9,$10		; Offset to patch #127: 4281
*
* Patch Data
*

* Patch 0 "Flute/Piccolo ": FM
		dc.b	0
		dc.b	$0A,$00,$17,$F2,$32,$10,$C8,$00
		dc.b	$00,$08,$32,$26,$8C,$8C,$0A,$C8
		dc.b	$72,$25,$88,$13,$00,$78,$12,$24
		dc.b	$C8,$8D,$00,$78,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 1 "DXBASS.FM ": FM
		dc.b	0
		dc.b	$0C,$00,$1A,$C0,$01,$23,$DB,$05
		dc.b	$00,$29,$07,$39,$DF,$06,$00,$50
		dc.b	$0A,$16,$DF,$08,$00,$2F,$01,$03
		dc.b	$9F,$07,$06,$29,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 2 "GRAPPLE HIT": FM
		dc.b	0
		dc.b	$07,$40,$04,$F5,$11,$08,$1F,$14
		dc.b	$09,$05,$70,$19,$1F,$12,$1E,$D8
		dc.b	$01,$02,$1F,$15,$1F,$C8,$00,$06
		dc.b	$1D,$13,$10,$F8,$2E,$E0,$3F,$CC
		dc.b	$3F,$E8,$3F,$82,$0F,$00

* Patch 3 "Funky Clav": FM
		dc.b	0
		dc.b	$0F,$00,$23,$C4,$3F,$30,$1A,$0E
		dc.b	$0E,$5F,$30,$1C,$5C,$12,$06,$3C
		dc.b	$30,$10,$18,$0F,$04,$1F,$31,$0A
		dc.b	$5F,$93,$07,$2A,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 4 "GRAPPLE THROW": PSG Noise
		dc.b	3
		dc.b	$0C,$1F,$1F,$E0,$17,$12
* Patch 5 "SYNBASS3.FM ": FM
		dc.b	0
		dc.b	$0B,$00,$2D,$D2,$30,$13,$1F,$8B
		dc.b	$0B,$5A,$50,$1D,$1F,$1F,$00,$3D
		dc.b	$70,$13,$1E,$1F,$00,$3D,$00,$04
		dc.b	$1E,$1B,$00,$2D,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 6 "GEAR LEVER SWITCH ": PSG Noise
		dc.b	3
		dc.b	$06,$FF,$0F,$00,$1D,$15
* Patch 7 "BELL IN TOWER": FM
		dc.b	0
		dc.b	$00,$00,$0D,$C0,$33,$20,$1F,$02
		dc.b	$1F,$25,$25,$00,$1F,$02,$1F,$35
		dc.b	$75,$0B,$1F,$02,$1F,$25,$00,$0F
		dc.b	$1F,$02,$1F,$85,$2E,$E0,$3F,$CC
		dc.b	$27,$10,$3F,$82,$09,$00
* Patch 8 "FOOT STEPS": FM
		dc.b	0
		dc.b	$00,$40,$33,$C0,$10,$00,$DF,$18
		dc.b	$00,$F7,$72,$00,$DF,$18,$00,$F7
		dc.b	$30,$00,$5F,$18,$00,$F7,$51,$00
		dc.b	$1F,$98,$00,$F7,$1F,$FF,$2E,$E0
		dc.b	$3A,$98,$27,$10,$0F,$00
* Patch 9 "Nunchuka": FM
		dc.b	0
		dc.b	$00,$00,$38,$C0,$37,$0A,$0E,$00
		dc.b	$00,$0C,$26,$0A,$0E,$14,$00,$0C
		dc.b	$78,$0B,$0E,$1F,$00,$0C,$00,$09
		dc.b	$0F,$14,$00,$FD,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$0F,$00
* Patch 10 "DXBASS.FM QUIET": FM
		dc.b	0
		dc.b	$0C,$00,$1A,$C0,$01,$23,$DB,$05
		dc.b	$00,$29,$07,$39,$DF,$06,$00,$50
		dc.b	$0A,$16,$DF,$08,$00,$2F,$01,$09
		dc.b	$9F,$07,$06,$29,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 11 "MINI MOOG 2 LOUD": FM
		dc.b	0
		dc.b	$00,$00,$24,$F4,$00,$0A,$99,$04
		dc.b	$0D,$88,$00,$0C,$18,$07,$1F,$BF
		dc.b	$01,$17,$17,$02,$05,$48,$00,$1A
		dc.b	$55,$89,$00,$1F,$3F,$FF,$3F,$FF
		dc.b	$3F,$FF,$00,$00,$0F,$00
* Patch 12 "Section Trumpets": FM
		dc.b	0
		dc.b	$0A,$00,$35,$C0,$21,$17,$8E,$00
		dc.b	$00,$0A,$20,$0A,$8F,$1F,$00,$0A
		dc.b	$38,$00,$8F,$1F,$00,$0A,$14,$00
		dc.b	$8F,$00,$00,$0A,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 13 "Metal crash long decay": PSG Noise
		dc.b	3
		dc.b	$04,$FF,$0F,$00,$08,$08
* Patch 14 "Celesta ": FM
		dc.b	0
		dc.b	$09,$00,$00,$F0,$13,$12,$53,$01
		dc.b	$1B,$40,$3B,$1F,$1D,$0F,$1F,$F3
		dc.b	$71,$11,$5B,$03,$1D,$03,$71,$1B
		dc.b	$1F,$00,$0D,$0F,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 15 "MINI MOOG 1 LOUD": FM
		dc.b	0
		dc.b	$0A,$00,$24,$D4,$00,$0A,$9F,$04
		dc.b	$0D,$78,$31,$0C,$DF,$07,$1F,$BF
		dc.b	$71,$17,$5F,$02,$05,$48,$00,$1A
		dc.b	$5F,$09,$00,$1F,$3F,$FF,$3F,$FF
		dc.b	$3F,$FF,$00,$00,$0F,$00
* Patch 16 "Woody thwack": FM
		dc.b	0
		dc.b	$0F,$00,$3A,$C7,$00,$13,$1F,$8E
		dc.b	$00,$0F,$00,$0E,$1F,$91,$00,$0F
		dc.b	$00,$03,$1F,$86,$00,$0F,$00,$01
		dc.b	$1F,$95,$1F,$FF,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$0F,$00
* Patch 17 "CatchBall": FM
		dc.b	0
		dc.b	$03,$00,$3A,$C7,$30,$02,$95,$0C
		dc.b	$1E,$FF,$00,$10,$56,$0D,$1E,$F6
		dc.b	$30,$07,$55,$0C,$1E,$FA,$00,$08
		dc.b	$51,$11,$1F,$F9,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 18 "Heavy thud": FM
		dc.b	0
		dc.b	$03,$00,$3A,$C0,$30,$08,$9F,$12
		dc.b	$1F,$FF,$04,$0D,$5E,$12,$1F,$FF
		dc.b	$30,$12,$5F,$12,$1F,$FE,$00,$05
		dc.b	$5D,$11,$1F,$FF,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 19 "Scratch Noise": PSG Noise
		dc.b	3
		dc.b	$07,$1B,$10,$C0,$00,$1E
* Patch 20 "DX SLAP QUIET ": FM
		dc.b	0
		dc.b	$00,$00,$02,$C0,$00,$1D,$D3,$05
		dc.b	$00,$29,$02,$27,$DF,$06,$12,$50
		dc.b	$05,$13,$DF,$0A,$00,$8F,$00,$12
		dc.b	$9F,$07,$00,$09,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 21 "WARMORG2.FM ": FM
		dc.b	0
		dc.b	$09,$00,$1C,$C5,$32,$0E,$CD,$0A
		dc.b	$00,$47,$71,$0F,$DD,$02,$00,$26
		dc.b	$32,$13,$94,$09,$00,$25,$31,$13
		dc.b	$5C,$06,$03,$05,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0E,$00
* Patch 22 "Shoe Squeak": FM
		dc.b	0
		dc.b	$00,$00,$28,$C7,$32,$10,$C8,$00
		dc.b	$00,$08,$32,$00,$8C,$0C,$0A,$08
		dc.b	$72,$16,$88,$13,$00,$78,$12,$00
		dc.b	$C8,$0D,$00,$78,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 23 "Batmobile (High Whistle": FM
		dc.b	0
		dc.b	$00,$00,$3A,$C0,$01,$0F,$1F,$1F
		dc.b	$00,$06,$03,$22,$1F,$1F,$00,$06
		dc.b	$03,$1C,$1F,$1F,$00,$06,$01,$00
		dc.b	$11,$1F,$00,$08,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$0F,$00
* Patch 24 "Smashing Glass": FM
		dc.b	0
		dc.b	$0D,$00,$3A,$C0,$00,$00,$1F,$15
		dc.b	$00,$F5,$05,$0E,$1F,$11,$0C,$F6
		dc.b	$09,$1D,$1F,$0C,$10,$F6,$0B,$06
		dc.b	$1E,$11,$14,$FC,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 25 "TRUMPWAH LOUD": FM
		dc.b	0
		dc.b	$09,$00,$35,$C1,$21,$14,$0E,$89
		dc.b	$0B,$27,$23,$15,$15,$89,$07,$4A
		dc.b	$31,$15,$1B,$88,$0B,$49,$14,$19
		dc.b	$14,$8B,$0A,$4A,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 26 "slow brass": FM
		dc.b	0
		dc.b	$0A,$00,$3D,$D2,$02,$1F,$85,$05
		dc.b	$01,$E8,$05,$21,$88,$00,$02,$18
		dc.b	$04,$18,$90,$0B,$02,$47,$02,$0E
		dc.b	$94,$80,$02,$07,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 27 "FM bass": FM
		dc.b	0
		dc.b	$0B,$00,$2D,$F0,$00,$10,$1F,$0B
		dc.b	$0B,$5A,$00,$0E,$1F,$1F,$00,$2D
		dc.b	$00,$11,$1E,$1F,$00,$2D,$01,$0D
		dc.b	$1E,$1F,$00,$2D,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 28 "psg chunk": PSG Tone
		dc.b	2
		dc.b	$00,$FF,$08,$01,$FF,$1E
* Patch 29 "BRASS WAH/ QUIET ": FM
		dc.b	0
		dc.b	$00,$00,$06,$C0,$23,$17,$CE,$01
		dc.b	$0C,$29,$20,$2B,$55,$04,$02,$19
		dc.b	$31,$23,$1B,$02,$0D,$39,$12,$29
		dc.b	$94,$05,$02,$09,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0B,$00
* Patch 30 "BLOCK-N-BRASS": FM
		dc.b	0
		dc.b	$0B,$00,$2E,$D2,$32,$11,$C8,$80
		dc.b	$00,$0A,$32,$17,$DA,$0C,$07,$18
		dc.b	$72,$15,$D6,$93,$00,$28,$12,$1C
		dc.b	$DC,$0D,$00,$48,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 31 "B3 Organ ": FM
		dc.b	0
		dc.b	$00,$00,$07,$C0,$33,$20,$DF,$0B
		dc.b	$01,$8B,$03,$0C,$DA,$1D,$00,$2A
		dc.b	$02,$24,$DC,$1F,$00,$1A,$01,$20
		dc.b	$DB,$1C,$00,$0F,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 32 "PIANO E CLAVE ": FM
		dc.b	0
		dc.b	$00,$00,$12,$C0,$00,$0D,$58,$07
		dc.b	$09,$7A,$62,$2C,$57,$09,$08,$9B
		dc.b	$72,$0B,$1F,$17,$09,$0A,$31,$19
		dc.b	$99,$07,$06,$6A,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 33 "RIM shot ": FM
		dc.b	0
		dc.b	$0C,$00,$21,$F5,$02,$00,$1F,$07
		dc.b	$00,$25,$00,$08,$1F,$1F,$0C,$18
		dc.b	$00,$11,$1F,$11,$10,$28,$00,$09
		dc.b	$1D,$10,$14,$1B,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 34 "Batmobile low end 2": FM
		dc.b	0
		dc.b	$08,$00,$3A,$E0,$59,$1E,$19,$1F
		dc.b	$00,$0B,$72,$1D,$15,$0B,$00,$0B
		dc.b	$20,$09,$14,$04,$00,$0B,$30,$00
		dc.b	$0E,$1C,$05,$0B,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$0F,$00
* Patch 35 "baaaaad ": FM
		dc.b	0
		dc.b	$09,$00,$1B,$C1,$71,$27,$1F,$0F
		dc.b	$00,$88,$32,$00,$09,$1F,$00,$0B
		dc.b	$01,$00,$11,$1F,$00,$0C,$31,$09
		dc.b	$1B,$19,$00,$2A,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 36 "Heavy Metal/Feedback": FM
		dc.b	0
		dc.b	$08,$00,$3D,$D2,$02,$15,$96,$01
		dc.b	$03,$3F,$03,$22,$1A,$01,$01,$2F
		dc.b	$12,$18,$D8,$06,$01,$0F,$61,$18
		dc.b	$15,$83,$0D,$0F,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 37 "SWEEPING BASS": FM
		dc.b	0
		dc.b	$00,$00,$06,$C0,$00,$04,$19,$07
		dc.b	$07,$5F,$00,$7F,$1C,$03,$05,$8F
		dc.b	$00,$0C,$16,$04,$05,$8F,$00,$07
		dc.b	$16,$02,$05,$5F,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$0B,$00
* Patch 38 "SlapPopBass.FM": FM
		dc.b	0
		dc.b	$07,$00,$1B,$C4,$37,$29,$DA,$0E
		dc.b	$0E,$5F,$70,$18,$DC,$12,$06,$0C
		dc.b	$70,$10,$D9,$0F,$09,$3F,$30,$08
		dc.b	$5F,$15,$09,$1A,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 39 "WHISTLER VIA VIBRATO": FM
		dc.b	0
		dc.b	$0A,$00,$38,$F5,$32,$7F,$58,$80
		dc.b	$0B,$5C,$1A,$7F,$D3,$82,$14,$B4
		dc.b	$35,$7F,$56,$80,$00,$2F,$02,$0B
		dc.b	$8E,$80,$06,$28,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 40 "FIRE BREATHER": PSG Noise
		dc.b	3
		dc.b	$04,$1F,$04,$00,$04,$12
* Patch 41 "KNIFE THROW": PSG Noise
		dc.b	3
		dc.b	$04,$1F,$0F,$00,$1B,$18
* Patch 42 "KNIFE SPIN": PSG Noise
		dc.b	3
		dc.b	$04,$1F,$0F,$00,$1C,$18
* Patch 43 "BOMBS": PSG Noise
		dc.b	3
		dc.b	$06,$FF,$0E,$00,$06,$0F
* Patch 44 "AIR FLOW": PSG Noise
		dc.b	3
		dc.b	$05,$04,$00,$00,$07,$01
* Patch 45 "CHAIN LIFT": PSG Noise
		dc.b	3
		dc.b	$04,$FF,$0F,$00,$1D,$15
* Patch 46 "WATER BURST": PSG Noise
		dc.b	3
		dc.b	$04,$15,$0F,$00,$07,$03
* Patch 47 "QUAKEING": FM
		dc.b	0
		dc.b	$08,$40,$15,$C3,$00,$00,$1F,$00
		dc.b	$00,$74,$02,$00,$1F,$1F,$0C,$18
		dc.b	$00,$00,$1F,$01,$02,$97,$04,$00
		dc.b	$1D,$12,$14,$2A,$03,$E8,$17,$70
		dc.b	$03,$6B,$0A,$BE,$0F,$00
* Patch 48 "Batmobile (High 2)": FM
		dc.b	0
		dc.b	$00,$00,$38,$C0,$0B,$0F,$1F,$1F
		dc.b	$00,$06,$08,$22,$1F,$1F,$00,$06
		dc.b	$09,$1C,$1F,$1F,$00,$06,$04,$00
		dc.b	$11,$1F,$00,$08,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$0F,$00
* Patch 49 "SIZZLE": PSG Noise
		dc.b	3
		dc.b	$0C,$40,$3F,$F0,$06,$05
* Patch 50 "DEREZ": FM
		dc.b	0
		dc.b	$0F,$00,$13,$F3,$00,$00,$19,$00
		dc.b	$0B,$74,$00,$05,$19,$1F,$0C,$28
		dc.b	$00,$05,$19,$12,$0A,$57,$00,$0B
		dc.b	$0C,$04,$14,$4A,$03,$E8,$17,$70
		dc.b	$03,$6B,$0A,$BE,$0F,$00
* Patch 51 "POPING": FM
		dc.b	0
		dc.b	$00,$FF,$07,$C0,$01,$00,$14,$17
		dc.b	$1F,$FF,$01,$00,$14,$17,$1F,$FF
		dc.b	$01,$00,$14,$17,$1F,$FF,$01,$00
		dc.b	$14,$17,$1F,$FF,$27,$10,$27,$10
		dc.b	$27,$10,$27,$10,$0F,$00
* Patch 52 "BAT SQUEEKS": FM
		dc.b	0
		dc.b	$00,$BF,$07,$C0,$02,$0B,$14,$17
		dc.b	$1F,$FF,$01,$0B,$14,$17,$1F,$FF
		dc.b	$02,$0B,$14,$17,$1F,$FF,$01,$0B
		dc.b	$14,$17,$1F,$FF,$2C,$EC,$2C,$EC
		dc.b	$2C,$EC,$2C,$EC,$0F,$00
* Patch 53 "LEAD SYNTH.": FM
		dc.b	0
		dc.b	$08,$00,$35,$C2,$01,$15,$96,$01
		dc.b	$03,$3F,$01,$16,$1A,$01,$01,$2F
		dc.b	$11,$0C,$D8,$06,$01,$0F,$61,$0C
		dc.b	$15,$83,$0D,$0F,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 54 "MINI MOOG ": FM
		dc.b	0
		dc.b	$0A,$00,$24,$D4,$00,$0A,$9F,$04
		dc.b	$0D,$78,$31,$0C,$DF,$07,$1F,$BF
		dc.b	$71,$1A,$5F,$02,$05,$48,$00,$1D
		dc.b	$5F,$09,$00,$1F,$3F,$FF,$3F,$FF
		dc.b	$3F,$FF,$00,$00,$0F,$00
* Patch 55 "Analog Synth Bass": FM
		dc.b	0
		dc.b	$0A,$00,$1D,$D0,$01,$12,$1F,$8A
		dc.b	$00,$9F,$22,$09,$14,$01,$00,$1F
		dc.b	$33,$09,$50,$0D,$0C,$3D,$00,$08
		dc.b	$11,$1B,$00,$2D,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 56 "psg 84": PSG Tone
		dc.b	2
		dc.b	$00,$FF,$08,$05,$10,$09
* Patch 57 "FeedbackGuitarsus.": FM
		dc.b	0
		dc.b	$02,$00,$25,$D0,$03,$07,$9E,$86
		dc.b	$03,$38,$03,$0E,$1E,$08,$00,$28
		dc.b	$12,$0C,$DE,$89,$06,$09,$61,$0B
		dc.b	$1F,$83,$07,$08,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 58 "REVERB 1": PSG Tone
		dc.b	2
		dc.b	$00,$FF,$0F,$06,$01,$0B
* Patch 59 "REVERB 2 ": PSG Tone
		dc.b	2
		dc.b	$00,$FF,$0F,$08,$01,$0B
* Patch 60 "PSG PULSE TONE": PSG Tone
		dc.b	2
		dc.b	$00,$FF,$0F,$04,$0A,$0B
* Patch 61 "PSG PULSE TONE LOUD": PSG Tone
		dc.b	2
		dc.b	$00,$FF,$0F,$04,$0A,$0B
* Patch 62 "Chorused Strat": FM
		dc.b	0
		dc.b	$0A,$00,$29,$D3,$31,$09,$D8,$00
		dc.b	$09,$5C,$12,$29,$D3,$00,$14,$B8
		dc.b	$37,$13,$D6,$08,$00,$2F,$02,$09
		dc.b	$96,$87,$06,$29,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 63 "Bugle.FM": FM
		dc.b	0
		dc.b	$0A,$00,$3A,$D2,$21,$1F,$8F,$05
		dc.b	$01,$E8,$21,$21,$8C,$00,$02,$18
		dc.b	$32,$18,$9B,$0B,$02,$47,$33,$0E
		dc.b	$94,$80,$02,$09,$1F,$FF,$1F,$FF
		dc.b	$1F,$FF,$1F,$FF,$0F,$00

		ENDIF

; End of Z80 Patch data
;*****************************************************************************			

;*****************************************************************************			
; Start of 68K Patch + Sequence + Sample data

		IF	AUDIO_SUB

;****************************************************************************
;
; THIS SECTION CONTAINS GAME SPECIFIC SFX CONTROL ROUTINES
;
;****************************************************************************
;
BUMPL		MACRO
		addq.l	#1,D3
		and.l	#EVNT_bufsize-1,D3
		ENDM

BUMPLU		MACRO
		addq.l	#1,D3
		and.l	#EVNT_bufsize-1,D3
		move.l	D3,EVNT_bufhead
		clr.w	AUDIO_STATUS
		ENDM
; Bit Flags
;
BSK_GUTTR	equ	0
BSK_SCRAPE	equ	1
BSK_BRAKEON	equ	2
BSK_GASPED	equ	3
BSK_SKID	equ	4
BSK_TURBO	equ	5
BSK_AIR		equ	6
BSK_ONFIRE	equ	7

SFX_BSK_TURBO	equ	3
SFX_BSK_SCRAPE	equ	17

BSK_DEFREV	equ	$2000
NORM_REDLINE	equ	$2400
TURB_REDLINE	equ	$3FFF
NORM_ACCEL	equ	25
TURB_ACCEL	equ	140
NORMDECEL	equ	50
BRAKEDECEL	equ	250

BSK_DEFVOL	equ	64
BSK_DEFSKV	equ	10
BSK_DEFSKN	equ	$2000

BSK_ENGCHAN	dc.b	-1
BSK_engvol	dc.b	0
BSK_engnote	dc.w	0
BSK_prevnote	dc.w	0
BSK_moving	dc.w	0
BSK_redline	dc.w	0
BSK_accel	dc.w	0
BSK_speed	dc.w	0
BSK_skichan	dc.w	0
BSK_rndtim0	dc.w	0

BSK_DEFSCRVOL	equ	0
BSK_scrapechan	dc.b	-1
BSK_scrapevol	dc.b	0
BSK_scrapenote	dc.w	0

USER_VAR_CNT	dc.w	(USER_VAR_END-USER_VAR_TAB)-1
USER_VAR_BEG	dc.l	BSK_ENGCHAN
USER_VAR_TAB	dc.b	-1
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	-1
		dc.b	0
		dc.w	0
USER_VAR_END
		EVEN

INIT_USER_VARS	movem.l	A0/A1/D0,-(SP)
		lea	USER_VAR_TAB,A0
		movea.l	USER_VAR_BEG,A1
		move.w	USER_VAR_CNT,D0
iuv0		move.b	(A0)+,(A1)+
		dbra	D0,iuv0
		movem.l	(SP)+,A0/A1/D0		
		rts

CSFX_BATSKI	movem.l	A0-A3/D0-D3,-(SP)
		lea	EVNT_buf,A3
		tst.b	SFX_STATTAB
		bne	cb00

		move.b	#-1,BSK_ENGCHAN
		move.w	#-1,BSK_prevnote

		move.w	#NORM_ACCEL,BSK_accel
		move.w	#NORM_REDLINE,BSK_redline
		move.w	#0,BSK_moving

		move.l	#0,-(SP)
		jsr	PLAY_SFX
		move.w	AUDIO_STATUS,D0
		bmi	csfx_bx
		move.b	D0,BSK_ENGCHAN

		move.b	#BSK_DEFVOL,BSK_engvol
		move.w	#BSK_DEFREV,BSK_engnote
		bra	csfx_bx

cb00		move.w	D1,BSK_speed
		bpl	cb13

		move.w	#0,BSK_speed
cb13		cmp.w	#128,BSK_speed
		bcs	cb14

		move.w	#127,BSK_speed

cb14		move.l	D1,-(SP)
		move.l	D0,-(SP)

		btst.b	#BSK_GASPED,3(SP)	; gas pedal on?
		beq	cb00a			; no so go decrement turbine

		btst.b	#BSK_TURBO,3(SP)		;Turbo on?
     		bne	cb00c

 		cmpi.w	#NORM_REDLINE,BSK_engnote
		bcc	cb00a

cb00c		move.w	BSK_engnote,D0
cb00b		add.w	BSK_accel,D0
		cmp.w	BSK_redline,D0
		bcc	cb06

		jsr	BSK_SendNote
		bra	cb06

cb00a		move.w	BSK_engnote,D0		
		beq	cb06
		move.w	#NORMDECEL,D1
		btst.b	#BSK_BRAKEON,3(SP)	;Brakes on?
		beq	cb04
		move.w	#BRAKEDECEL,D1
cb04		sub.w	D1,D0
		bmi	cb06
		cmp.w	#BSK_DEFREV,D0
		bcs	cb06

		jsr	BSK_SendNote


;------------------------------------------------
;Check for TURBO

cb06		btst.b	#BSK_TURBO,3(SP)		;Turbo on?
		beq	cb06a
		move.w	#TURB_ACCEL,BSK_accel	;switch turbo flag on
		move.w	#TURB_REDLINE,BSK_redline
		tst.b	SFX_STATTAB+SFX_BSK_TURBO
		bne	cb07
		move.l	#SFX_BSK_TURBO,-(SP)	;trigger TURBO SFX (#3)
		jsr	PLAY_SFX
		bra	cb07

cb06a		move.w	#NORM_ACCEL,BSK_accel	;switch turbo flag off
		move.w	#NORM_REDLINE,BSK_redline
		tst.b	SFX_STATTAB+SFX_BSK_TURBO
		beq	cb07
		move.l	EVNT_bufhead,D3
		move.b	#META,0(A3,D3.w)
		BUMPL
		move.b	#SS,0(A3,D3.w)
		BUMPL
		move.b	#STOPSFXMULI,0(A3,D3.w)
		BUMPL
		move.b	#SFX_BSK_TURBO,0(A3,D3.w)		;SFX #
		BUMPLU

;------------------------------------------------
;Check for SCRAPE

cb07		btst.b	#BSK_SCRAPE,3(SP)
		beq	cb07a

		tst.b	SFX_STATTAB+SFX_BSK_SCRAPE
		bne	cb070

		move.l	#SFX_BSK_SCRAPE,-(SP)
		jsr	PLAY_SFX
		move.w	AUDIO_STATUS,D0
		bmi	cb0v
		move.b	D0,BSK_scrapechan
		bra	cb0v

cb070		move.w	BSK_speed,D0
		asl.w	#3,D0
		add.w	#$2000,D0
		cmp.w	#$4000,D0
		bcs	cb071

		move.w	#$3FFF,D0	

;		move.w	D0,BSK_engnote
;		cmp.w	BSK_prevnote,D0
;		beq	cb06			;only send a changed note
;		move.w	D0,BSK_prevnote

cb071		move.b	BSK_scrapechan,D1	;MIDI channel handle
		or.b	#PWCH,D1		;Pitch Wheel
		move.l	EVNT_bufhead,D3
		move.b	D1,0(A3,D3.w)
		BUMPL
		move.w	D0,D1
		and.b	#$7F,D0
		move.b	D0,0(A3,D3.w)		;Wheel - LSB FIRST
		BUMPL
		lsr	#7,D1
		and.b	#$7F,D1
		move.b	D1,0(A3,D3.w)		;Wheel - MSB LAST
		BUMPLU
		bra	cb0v
		


cb07a		tst.b	SFX_STATTAB+SFX_BSK_SCRAPE
		bmi	cb0v			;not running, so dont kill
		move.l	EVNT_bufhead,D3
		move.b	#META,0(A3,D3.w)	;Kill SKID SFX (#1)
		BUMPL
		move.b	#SS,0(A3,D3.w)
		BUMPL
		move.b	#STOPSFXMULI,0(A3,D3.w)
		BUMPL
		move.b	#SFX_BSK_SCRAPE,0(A3,D3.w)	;SFX #
		BUMPLU
		move.b	#-1,BSK_scrapechan



;------------------------------------------------
;Check for SKI NOISE ETC

cb0v		tst.w	BSK_speed
		beq	cb10
		tst.w	BSK_moving
		bne	cb11
		
		move.l	#1,-(SP)
		jsr	PLAY_SFX
		move.w	AUDIO_STATUS,D0
		bmi	csfxx
		
		move.w	#5,BSK_rndtim0
		move.w	D0,BSK_skichan
		move.w	#1,BSK_moving
		bra	csfxx

cb10		tst.w	BSK_moving
		beq	csfxx
		move.w	#0,BSK_moving
		move.l	EVNT_bufhead,D3
		move.b	#META,0(A3,D3.w)
		BUMPL
		move.b	#SS,0(A3,D3.w)
		BUMPL
		move.b	#STOPSFXMULI,0(A3,D3.w)
		BUMPL
		move.b	#1,0(A3,D3.w)		;SFX #
		BUMPLU
		move.w	#0,BSK_rndtim0
		bra	csfxx

cb11		btst.b	#BSK_AIR,3(SP)
		beq	cb18
		move.w	BSK_skichan,D0		;MIDI channel handle
		or.b	#CTRL,D0
		move.l	EVNT_bufhead,D3
		move.b	D0,0(A3,D3.w)
		BUMPL
		move.b	#VOLM,0(A3,D3.w)
		BUMPL
		move.b	#0,0(A3,D3.w)
		BUMPLU
		bra	csfiax

cb18		tst.w	BSK_rndtim0
		bne	csfxx
    		move.w	#1,BSK_rndtim0
		jsr	RANDOM_NO
		and.w	#15,D7
		move.w	#128,D0
		sub.w	BSK_speed,D0
		lsr.w	#3,D0
		beq	cb16

		move.w	D0,BSK_rndtim0

cb16		move.w	BSK_skichan,D0		;MIDI channel handle
		or.b	#CTRL,D0
		move.l	EVNT_bufhead,D3
		move.b	D0,0(A3,D3.w)
		BUMPL
		move.b	#VOLM,0(A3,D3.w)
		BUMPL
		jsr	RANDOM_NO
		and.b	#$7F,D7
		lsr.b	D7
		move.w	BSK_speed,D0
		lsr.w	D0
		add.b	D7,D0
		and.b	#$7F,D0
		cmp.b	#100,BSK_speed
		bcc	cb17
		
		lsr.b	D0
		cmp.w	#30,BSK_speed
		bcc	cb17
		
		lsr.b	D0

cb17		add.b	#BSK_DEFSKV,D0		;base at half level
		and.b	#$7F,D0
		move.b	D0,0(A3,D3.w)
		BUMPLU				;send the Volume event


;		move.b	#3,MY_EVNT_STR		;# of MIDI Bytes to send
;
;		move.w	BSK_skichan,D1		;MIDI channel handle
;		or.b	#PWCH,D1		;Pitch Wheel
;		move.b	D1,MY_EVNT_STR+1
;
;		move.w	BSK_speed,D0
;		asl.w	#2,D0
;		add.w	#$1000,D0
;		move.w	D0,D1
;		and.b	#$7F,D0
;		move.b	D0,MY_EVNT_STR+2	;Wheel - LSB FIRST
;
;		lsr	#7,D1
;		and.b	#$7F,D1
;		move.b	D1,MY_EVNT_STR+3	;Wheel - MSB LAST
;
;		move.l	#MY_EVNT_STR,-(SP)
;		jsr	SEND_EVENT

cb15
csfxx		sub.w	#1,BSK_rndtim0
csfiax		move.l	(SP)+,D0
		move.l	(SP)+,D1

csfx_bx		movem.l	(SP)+,A0-A3/D0-D3
		rts

BSK_SendNote	move.w	D0,BSK_engnote
		cmp.w	BSK_prevnote,D0
		beq	cb17x			;only send a changed note
		move.w	D0,BSK_prevnote
		move.b	BSK_ENGCHAN,D1		;MIDI channel handle
		or.b	#PWCH,D1		;Pitch Wheel
		move.l	EVNT_bufhead,D3
		move.b	D1,0(A3,D3.w)
		BUMPL
		move.w	D0,D1
		and.b	#$7F,D0
		move.b	D0,0(A3,D3.w)		;Wheel - LSB FIRST
		BUMPL
		lsr	#7,D1
		and.b	#$7F,D1
		move.b	D1,0(A3,D3.w)		;Wheel - MSB LAST
		BUMPL

		move.b	BSK_ENGCHAN,D0		;MIDI channel handle
		or.b	#CTRL,D0
		move.b	D0,0(A3,D3.w)
		BUMPL
		move.b	#VOLM,0(A3,D3.w)
		BUMPL
		move.w	BSK_engnote,D0
		sub.w	#BSK_DEFREV,D0
		lsr.w	#7,D0
		add.w	#BSK_DEFVOL,D0
		cmp.w	#128,D0
		bcs	cb171
		move.w	#127,D0
cb171		move.b	D0,0(A3,D3.w)
		BUMPLU
cb17x	    	rts

;****************************************************************************
;
; CONTROL_SFX ->	A0 points to Control Block

		IF	CSFX

CONTROL_SFX	tst.w	AUDIO_PAUSED		;do nothing during PAUSE
		bmi	csfxnop
		movem.l	A0-A3/D0-D3,-(SP)
		lea	EVNT_buf,A3


		tst.w	EC_HANDLE(A0)
		beq	csfx00			;init

		tst.w	EC_SFXNUM(A0)
		bpl	csfx02			;caller sets to -ve to end SFX

		move.l	EVNT_bufhead,D3
		move.b	#META,0(A3,D3.w)
		BUMPL
		move.b	#SS,0(A3,D3.w)
		BUMPL
		move.b	#STOPSFXONEI,0(A3,D3.w)
		BUMPL
		move.w	EC_SFXNUM(A0),D0
		and.l	#$7F,D0
		move.b	D0,0(A3,D3.w)		;SFX #
		BUMPL
		move.w	EC_HANDLE(A0),D0
		and.l	#15,D0
		move.b	D0,0(A3,D3.w)		;MIDI CHAN #
		BUMPLU

		move.w	#0,EC_HANDLE(A0)		;deactivate it
		bra	csfxxx

csfx02		and.w	#$7F,EC_SFXNUM(A0)
		cmp.w	#18,EC_SFXNUM(A0)	;is the SFX moving relative?
		bcs	csfxxx
		cmp.w	#28,EC_SFXNUM(A0)
		bcc	csfxxx


;----------------------------------------------------------------------------
; this section deals with moving objects i.e. XREL and/or ZREL is non-zero

csfx10		move.w	EC_ZREL(A0),D0
		bpl	csfx11
		neg.w	D0

csfx11		move.w	D0,-(SP)		;save it for now
		lsr.w	D0			;reduce range
		move.w	EC_PARM0(A0),D1		;get SPEED parameter
		lsr.w	D1
		add.w	#$2000,D1		;add Pbend center value
		sub.w	D0,D1			;drop pitch
		move.w	EC_HANDLE(A0),D2	;get handle
		or.w	#PWCH,D2
		move.l	EVNT_bufhead,D3
		move.b	D2,0(A3,D3.w)
		BUMPL
		move.w	D1,D0			;build a MIDI Event string
		and.b	#$7F,D0
		move.b	D0,0(A3,D3.w)
		BUMPL
		lsr.w	#7,D0
		and.b	#$7F,D0
		move.b	D0,0(A3,D3.w)
		BUMPL				;send the Pitch bend event

;Send a Volume change to reflect Z RELATIVE

		move.w	EC_HANDLE(A0),D2	;get handle
		or.w	#CTRL,D2
		move.b	D2,0(A3,D3.w)
		BUMPL
		move.b	#VOLM,0(A3,D3.w)
		BUMPL
		move.w	(SP)+,D1
		lsr.w	#6,D1
		move.w	#$40,D0			;get ZREL again
		sub.b	D1,D0
		bpl	csfx12
		moveq	#0,D0
csfx12		move.b	D0,0(A3,D3.w)
		BUMPL				;send the Volume event

;Send a PAN change to reflect X RELATIVE

		move.w	EC_HANDLE(A0),D2	;get handle
		or.w	#CTRL,D2
		move.b	D2,0(A3,D3.w)
		BUMPL
		move.b	#PANM,0(A3,D3.w)
		BUMPL
		move.w	EC_XREL(A0),D0		;get X Relative val
		asr.w	#3,D0			;scale it down from +/- 200
		add.w	#64,D0			;make it relative to center
		move.b	D0,0(A3,D3.w)
		BUMPLU				;send the PAN event
		bra	csfxxx

;----------------------------------------------------------------------------
; Initialise a sequence of SFX Controls

csfx00		tst.w	EC_SFXNUM(A0)		;check for valid SFXNUM
		bmi	csfxxx

		move.l	(A0),D0
		and.l	#$7F,D0
		beq	csfxxx			;zero not allowed!

		move.l	D0,-(SP)		;LS word contains SFX #
		jsr	PLAY_SFX
		move.w	AUDIO_STATUS,D0
		bmi	csfxxx

		or.w	#$FF00,D0		;Set top byte of chan handle
		move.w	D0,EC_HANDLE(A0)

;----------------------------------------------------------------------------
; Exit back to caller

csfxxx		movem.l	(SP)+,A0-A3/D0-D3
csfxnop		rts

		ELSE

CONTROL_SFX	rts

		ENDIF

;****************************************************************************
;
		IF	CSFX1
CSFX_ONESHOT	tst.b	D0
		beq	coxx		

		move.l	D0,-(SP)
		jsr	PLAY_SFX

coxx		rts

		ELSE

CSFX_ONESHOT	rts

		ENDIF

;****************************************************************************

PCH_BANK

		IF	BMSFX

;Patch 0 (Batski Turbine noise)
		dc.b	2 
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E02-WAVE_S02
		dc.b	eADSR01
		dc.b	64
		dc.b	25
		dc.b	48+Z80PATCH
		dc.b	50
		dc.b	87

		ELSE

		dc.b	2 
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E02-WAVE_S02
		dc.b	eADSR01
		dc.b	64
		dc.b	0
		dc.b	0
		dc.b	0
		dc.b	0

		ENDIF

;Patch 1 (Ski-Water)
		dc.b	4
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E04-WAVE_S04
		dc.b	eADSR01
		dc.b	64
		dc.b	90
		dc.b	0	
		dc.b	0
		dc.b	0

;Patch 2 (BASHOBJ_A0)
		dc.b	7	;CLANG0
		dc.b	0
		dc.w	0
		dc.w	WAVE_E07-WAVE_S07
		dc.w	WAVE_E07-WAVE_S07
		dc.b	eADSR00
		dc.b	64
		dc.b	127
		dc.b	0
		dc.b	0
		dc.b	0

;Patch 3 (Afterburner)
		dc.b	5	;BAFBRN0
		dc.b	0
		dc.w	0
		dc.w	0			;loop start at START
		dc.w	WAVE_E05-WAVE_S05
		dc.b	eADSR03
		dc.b	64
		dc.b	100
		dc.b	0
		dc.b	0
		dc.b	0
;Patch 4 (Splash)
		dc.b	4
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E04-WAVE_S04
		dc.b	eADSR04
		dc.b	64
		dc.b	120
		dc.b	0	
		dc.b	0
		dc.b	0

;Patch 5 (Rotating Bulkheads)
		dc.b	10	;JET
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E10-WAVE_S10
		dc.b	eADSR13
		dc.b	64
		dc.b	127
		dc.b	0
		dc.b	0
		dc.b	0
;Patch 6 (Bang0)
		dc.b	8
		dc.b	0
		dc.w	0
		dc.w	WAVE_E08-WAVE_S08	;loop start at end ie. 1 shot
		dc.w	WAVE_E08-WAVE_S08
		dc.b	eADSR06
		dc.b	64
		dc.b	127
		dc.b	0
    		dc.b	0
		dc.b	0

;Patch 7
		dc.b	2	;Jet2 (for RAMP)
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E02-WAVE_S02
		dc.b	eADSR14
		dc.b	64
		dc.b	90
		dc.b	0
		dc.b	0
		dc.b	0

;Patch 8
		dc.b	2	;Jet2 (for Sparks)
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E02-WAVE_S02
		dc.b	eADSR10
		dc.b	64
		dc.b	80
		dc.b	0
		dc.b	0
		dc.b	0

;Patch 9
		dc.b	0	;Motorbike
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E00-WAVE_S00
		dc.b	eADSR01
		dc.b	64
		dc.b	127
		dc.b	0
		dc.b	0
		dc.b	0

;Patch 10 (Explosion 0)

		dc.b	9
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E09-WAVE_S09
		dc.b	eADSR06
		dc.b	64
		dc.b	127
		dc.b	0
		dc.b	0
		dc.b	0
;Patch 11
		dc.b	10	;DEBRIS0
		dc.b	0
		dc.w	0
		dc.w	WAVE_E10-WAVE_S10
		dc.w	WAVE_E10-WAVE_S10
		dc.b	eADSR05
		dc.b	64
		dc.b	60
		dc.b	0
		dc.b	0
		dc.b	0
;Patch 12 (METALLIC)
		dc.b	10	;CLANG0
		dc.b	0
		dc.w	0
		dc.w	WAVE_E10-WAVE_S10
		dc.w	WAVE_E10-WAVE_S10
		dc.b	eADSR12
		dc.b	64
		dc.b	122
		dc.b	7+Z80PATCH
		dc.b	12
		dc.b	109
;Patch 13 (Spring)
		dc.b	128
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	64
		dc.b	0
		dc.b	21+Z80PATCH
		dc.b	0
		dc.b	127
;Patch 14 (for Molitov)
		dc.b	5	;Jet2
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E05-WAVE_S05
		dc.b	eADSR04
		dc.b	64
		dc.b	70
		dc.b	0
		dc.b	0
		dc.b	0
;Patch 15 (Rocket)
		dc.b	5	;BAFBRN0
		dc.b	0
		dc.w	0
		dc.w	0			;loop start at START
		dc.w	WAVE_E05-WAVE_S05
		dc.b	eADSR15
		dc.b	64
		dc.b	115
		dc.b	0
		dc.b	0
		dc.b	0
;Patch 16 (For JIB door Open)
		dc.b	7
		dc.b	0
		dc.w	0
		dc.w	WAVE_E07-WAVE_S07
		dc.w	WAVE_E07-WAVE_S07
		dc.b	eADSR10
		dc.b	64
		dc.b	120
		dc.b	16+Z80PATCH
		dc.b	0
		dc.b	115

;Patch 17 (For waterplops)
		dc.b	5
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E05-WAVE_S05
		dc.b	eADSR17
		dc.b	64
		dc.b	60
		dc.b	17+Z80PATCH
		dc.b	0
		dc.b	110
;Patch 18 (Bang0)
		dc.b	8
		dc.b	0
		dc.w	0
		dc.w	WAVE_E08-WAVE_S08	;loop start at end ie. 1 shot
		dc.w	WAVE_E08-WAVE_S08
		dc.b	eADSR10
		dc.b	64
		dc.b	100
		dc.b	0
    		dc.b	0
		dc.b	0
;Patch 19 (Bang0)
		dc.b	8
		dc.b	0
		dc.w	0
		dc.w	WAVE_E08-WAVE_S08	;loop start at end ie. 1 shot
		dc.w	WAVE_E08-WAVE_S08
		dc.b	eADSR02
		dc.b	64
		dc.b	100
		dc.b	0
    		dc.b	0
		dc.b	0
;Patch 20 (Crash0)
		dc.b	4
		dc.b	0
		dc.w	0
		dc.w	WAVE_E04-WAVE_S04	;loop start at end ie. 1 shot
		dc.w	WAVE_E04-WAVE_S04
		dc.b	eADSR02
		dc.b	64
		dc.b	70
		dc.b	0
    		dc.b	0
		dc.b	0
;Patch 21 (Boom)
		dc.b	5
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E05-WAVE_S05
		dc.b	eADSR09
		dc.b	64
		dc.b	127
		dc.b	7+Z80PATCH
    		dc.b	0
		dc.b	127
;Patch 22 (Truck Horn)
		dc.b	NO_PCM
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	64
		dc.b	0
		dc.b	12+Z80PATCH
    		dc.b	0
		dc.b	127
;Patch 23 (for TRASHCAN)
		dc.b	7	;CLANG0
		dc.b	0
		dc.w	0
		dc.w	WAVE_E07-WAVE_S07
		dc.w	WAVE_E07-WAVE_S07
		dc.b	eADSR14
		dc.b	64
		dc.b	120
		dc.b	0
		dc.b	0
		dc.b	0

;Patch 24 (smashing glass)
		dc.b	NO_PCM
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	64
		dc.b	0
		dc.b	24+Z80PATCH
    		dc.b	0
		dc.b	127
;Patch 25 (Catchball)
		dc.b	NO_PCM
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR04
		dc.b	64
		dc.b	0
		dc.b	17+Z80PATCH
    		dc.b	0
		dc.b	127
;Patch 26 (uses woody Thwack)
		dc.b	NO_PCM
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR04
		dc.b	64
		dc.b	0
		dc.b	16+Z80PATCH
    		dc.b	0
		dc.b	127
;Patch 27 (uses woody Thwack)
		dc.b	NO_PCM
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR13
		dc.b	64
		dc.b	0
		dc.b	16+Z80PATCH
    		dc.b	16
		dc.b	127
;Patch 28 (for PROFANE CAN)
		dc.b	NO_PCM
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	0
		dc.b	0
		dc.b	0
		dc.b	7+Z80PATCH
		dc.b	17
		dc.b	120
;Patch 29 (for PROFANE RELEASE)
		dc.b	NO_PCM
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	0 ;4+Z80PATCH
		dc.b	0
		dc.b	127

;Patch 30 (for Profane RELEASE)
		dc.b	NO_PCM
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	0
		dc.b	0
		dc.b	0
;Patch 31 (for BRFIRE)
		dc.b	4
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E04-WAVE_S04
		dc.b	eADSR01
		dc.b	64
		dc.b	115
		dc.b	0	
		dc.b	0
		dc.b	0
;Patch 32 (smashing glass)
		dc.b	NO_PCM
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	64
		dc.b	0
		dc.b	24+Z80PATCH
    		dc.b	0
		dc.b	127
;Patch 33 (smashing ice)
		dc.b	NO_PCM
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR04
		dc.b	64
		dc.b	0
		dc.b	16+Z80PATCH
    		dc.b	0
		dc.b	119
;Patch 34 (smashing ice)
		dc.b	NO_PCM
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR13
		dc.b	64
		dc.b	0
		dc.b	0 ;13+Z80PATCH
    		dc.b	0
		dc.b	127
;Patch 35 (for Ice Block)
		dc.b	8
		dc.b	0
		dc.w	0
		dc.w	WAVE_E08-WAVE_S08	;loop start at end ie. 1 shot
		dc.w	WAVE_E08-WAVE_S08
		dc.b	eADSR00
		dc.b	64
		dc.b	127
		dc.b	18+Z80PATCH
    		dc.b	12
		dc.b	127
;Patch 36 (for Ice Block)
		dc.b	8
		dc.b	0
		dc.w	0
		dc.w	WAVE_E08-WAVE_S08	;loop start at end ie. 1 shot
		dc.w	WAVE_E08-WAVE_S08
		dc.b	eADSR10
		dc.b	64
		dc.b	127
		dc.b	18+Z80PATCH
    		dc.b	0
		dc.b	127
;Patch 37 (Flames)
		dc.b	11
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E11-WAVE_S11
		dc.b	eADSR00
		dc.b	64
		dc.b	127
		dc.b	47+Z80PATCH
    		dc.b	12
		dc.b	127
;Patch 38 (Skid for BATS)
		dc.b	3	;SKID2
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E03-WAVE_S03
		dc.b	eADSR00
		dc.b	64
		dc.b	127
		dc.b	22+Z80PATCH	
		dc.b	24
		dc.b	127
;Patch 39 (Bang0)
		dc.b	8
		dc.b	0
		dc.w	0
		dc.w	WAVE_E08-WAVE_S08	;loop start at end ie. 1 shot
		dc.w	WAVE_E08-WAVE_S08
		dc.b	eADSR05
		dc.b	64
		dc.b	125
		dc.b	16+Z80PATCH ;9
    		dc.b	0
		dc.b	127
;Patch 40 (for powerup)
		dc.b	2
		dc.b	0
		dc.w	0
		dc.w	WAVE_E02-WAVE_S02
		dc.w	WAVE_E02-WAVE_S02
		dc.b	eADSR10
		dc.b	64
		dc.b	90
		dc.b	1+Z80PATCH
    		dc.b	0
		dc.b	127
;Patch 41 (for AARG)
		dc.b	2
		dc.b	0
		dc.w	0
		dc.w	WAVE_E02-WAVE_S02
		dc.w	WAVE_E02-WAVE_S02
		dc.b	eADSR10
		dc.b	64
		dc.b	90
		dc.b	22+Z80PATCH
    		dc.b	18
		dc.b	120
;Patch 42 (Crash0)
		dc.b	4
		dc.b	0
		dc.w	0
		dc.w	WAVE_E04-WAVE_S04	;loop start at end ie. 1 shot
		dc.w	WAVE_E04-WAVE_S04
		dc.b	eADSR16
		dc.b	64
		dc.b	120
		dc.b	18+Z80PATCH
    		dc.b	0
		dc.b	125
;Patch 43 (Crash0)
		dc.b	NO_PCM
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0	;WAVE_E02-WAVE_S02
		dc.b	eADSR00
		dc.b	64
		dc.b	0	;5
		dc.b	21+Z80PATCH
    		dc.b	24
		dc.b	127
;Patch 44 (Bang0)
		dc.b	8
		dc.b	0
		dc.w	0
		dc.w	WAVE_E08-WAVE_S08	;loop start at end ie. 1 shot
		dc.w	WAVE_E08-WAVE_S08
		dc.b	eADSR10
		dc.b	64
		dc.b	100
		dc.b	0
    		dc.b	0
		dc.b	0

;*********************************************************			
;
; ADSR ENVELOPE BANK 
;
;*********************************************************			

ADSR00		dc.b	255,0,255,0,255,255,0,10
ADSR01		dc.b	255,4,255,0,255,255,0,10
ADSR02		dc.b	255,0,255,0,255,255,0,11
ADSR03		dc.b	255,0,255,0,255,255,0,40
ADSR04		dc.b	255,10,255,0,255,255,0,30
ADSR05		dc.b	255,0,255,0,255,255,0,24
ADSR06		dc.b	255,1,255,0,255,255,0,3
ADSR07		dc.b	255,0,255,0,255,255,0,20
ADSR08		dc.b	255,0,255,0,255,255,0,20
ADSR09		dc.b	255,0,255,0,255,255,0,60
ADSR10		dc.b	255,3,255,0,255,255,0,3
ADSR11		dc.b	255,0,255,0,255,255,0,20
ADSR12		dc.b	255,0,255,0,255,255,0,30
ADSR13		dc.b	255,0,255,0,255,255,0,1
ADSR14		dc.b	255,10,255,0,255,255,0,2
ADSR15		dc.b	255,24,255,0,255,255,0,12
ADSR16		dc.b	255,0,255,0,255,255,0,15
ADSR17		dc.b	255,6,255,0,255,255,0,30

;*********************************************************			
;
; SFX SEQUENCE BANK (replayed at fixed 150 bpm)
;
;*********************************************************			

PBMacros	dc.w	PBM00-PBMacros
		dc.w	PBM01-PBMacros
		dc.w	PBM02-PBMacros
		dc.w	PBM03-PBMacros
		dc.w	PBM04-PBMacros
		dc.w	PBM05-PBMacros
		dc.w	PBM06-PBMacros
		dc.w	PBM07-PBMacros
		dc.w	PBM08-PBMacros
		dc.w	PBM09-PBMacros
		dc.w	PBM10-PBMacros
		dc.w	PBM11-PBMacros
		dc.w	PBM12-PBMacros
		dc.w	PBM13-PBMacros
		dc.w	PBM14-PBMacros
		dc.w	PBM15-PBMacros
		dc.w	PBM16-PBMacros
		dc.w	PBM17-PBMacros
		dc.w	PBM18-PBMacros
		dc.w	PBM19-PBMacros
		dc.w	PBM20-PBMacros
		dc.w	PBM21-PBMacros
		dc.w	PBM22-PBMacros

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

PBM02		dc.w	$2000
		dc.w	0,8000
		dc.w	0,-8000
		dc.w	2,1000
		dc.w	70,-100
		dc.w	32,10
		dc.w	-1

PBM03		dc.w	$2000
		dc.w	36,-200
		dc.w	-1

PBM04		dc.w	$2000			;for Jack-in-the-Box Spring
		dc.w	14,70
		dc.w	-1

PBM05		dc.w	$2000			;for Jack-in-the-Box Spring
		dc.w	36,-140
		dc.w	-1

PBM06		dc.w	$2000
		dc.w	0,8000
		dc.w	0,-8000
		dc.w	0,8000
		dc.w	0,-8000
		dc.w	2,-200
		dc.w	2,200
		dc.w	3,-150
		dc.w	2,150
		dc.w	3,-200
		dc.w	-1

PBM07		dc.w	$2000
		dc.w	2,200
		dc.w	4,-250
		dc.w	-1

PBM08		dc.w	$2000
		dc.w	32,150
		dc.w	50,-100
		dc.w	-1

PBM09		dc.w	$2000
		dc.w	64,60
		dc.w	-1

PBM10		dc.w	$2000
		dc.w	10,30
		dc.w	15,-20
		dc.w	-1

PBM11		dc.w	10
		dc.w	50,185
		dc.w	110,-110
		dc.w	-1

PBM12		dc.w	$2000
		dc.w	10,85
		dc.w	40,-220
		dc.w	-1

PBM13		dc.w	$1800
		dc.w	20,195
		dc.w	20,-20
		dc.w	-1

PBM14		dc.w	$1000
		dc.w	30,160
		dc.w	20,20
		dc.w	-1

PBM15		dc.w	$2000
		dc.w	1,$900
		dc.w	8,-500
		dc.w	-1

PBM16		dc.w	$2000
		dc.w	0,6000
		dc.w	0,-6000
		dc.w	0,8000
		dc.w	0,-8000
		dc.w	8,1000
		dc.w	8,-1000
		dc.w	-1

PBM17		dc.w	$2000
		dc.w	10,100
		dc.w	-1

PBM18		dc.w	$2000
		dc.w	9,200
		dc.w	17,-250
		dc.w	-1

PBM19		dc.w	$2000
		dc.w	6,30
		dc.w	1,-1200
		dc.w	10,-1
		dc.w	-1

PBM20		dc.w	$2000
		dc.w	1,700
		dc.w	2,-700
		dc.w	2,700
		dc.w	2,-700
		dc.w	2,700
		dc.w	2,-700
		dc.w	2,700
		dc.w	2,-700
		dc.w	2,700
		dc.w	2,-700
		dc.w	2,700
		dc.w	2,-700
		dc.w	2,700
		dc.w	2,-700
		dc.w	2,700
		dc.w	2,-700
		dc.w	2,700
		dc.w	-1

PBM21		dc.w	$2000
		dc.w	10,500
		dc.w	200,0
		dc.w	-1

PBM22		dc.w	$2000
		dc.w	100,-50
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

SX00		dc.b	0,1,2,3,4,5,6,7,8,9,10,11,-1
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

		dc.l	WAVE_S02
		dc.l	WAVE_E02-WAVE_S02
		dc.w	0
		dc.w	0

		dc.l	WAVE_S03
		dc.l	WAVE_E03-WAVE_S03
		dc.w	0
		dc.w	0

		dc.l	WAVE_S04
		dc.l	WAVE_E04-WAVE_S04
		dc.w	0
		dc.w	0

		dc.l	WAVE_S05
		dc.l	WAVE_E05-WAVE_S05
		dc.w	0
		dc.w	0

		dc.l	WAVE_S06
		dc.l	WAVE_E06-WAVE_S06
		dc.w	0
		dc.w	0

		dc.l	WAVE_S07
		dc.l	WAVE_E07-WAVE_S07
		dc.w	0
		dc.w	0

		dc.l	WAVE_S08
		dc.l	WAVE_E08-WAVE_S08
		dc.w	0
		dc.w	0

		dc.l	WAVE_S09
		dc.l	WAVE_E09-WAVE_S09
		dc.w	0
		dc.w	0

		dc.l	WAVE_S10
		dc.l	WAVE_E10-WAVE_S10
		dc.w	0
		dc.w	0

		dc.l	WAVE_S11
		dc.l	WAVE_E11-WAVE_S11
		dc.w	0
		dc.w	0



;*********************************************************			
;
; SONG BANK
;
;*********************************************************			

		EVEN

SONG_ADDR_TAB	dc.l	SONG_S00

SONG_S00	dc.b	0
SONG_E00


;*********************************************************			
;
; SFX SEQUENCE BANK (replayed at fixed 150 bpm)
;
;*********************************************************			

BENDSKID	equ	1
MOBIKE		equ	18

		EVEN
SFX_INSTTAB	dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2

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
		dc.w	SFX_S12-SFX_ADDR_TAB
		dc.w	SFX_S13-SFX_ADDR_TAB
		dc.w	SFX_S14-SFX_ADDR_TAB
		dc.w	SFX_S15-SFX_ADDR_TAB
		dc.w	SFX_S16-SFX_ADDR_TAB
		dc.w	SFX_S17-SFX_ADDR_TAB
		dc.w	SFX_S18-SFX_ADDR_TAB
		dc.w	SFX_S19-SFX_ADDR_TAB
		dc.w	SFX_S20-SFX_ADDR_TAB
		dc.w	SFX_S21-SFX_ADDR_TAB
		dc.w	SFX_S22-SFX_ADDR_TAB
		dc.w	SFX_S23-SFX_ADDR_TAB
		dc.w	SFX_S24-SFX_ADDR_TAB
		dc.w	SFX_S25-SFX_ADDR_TAB
		dc.w	SFX_S26-SFX_ADDR_TAB
		dc.w	SFX_S27-SFX_ADDR_TAB
		dc.w	SFX_S28-SFX_ADDR_TAB
		dc.w	SFX_S29-SFX_ADDR_TAB
		dc.w	SFX_S30-SFX_ADDR_TAB
		dc.w	SFX_S31-SFX_ADDR_TAB
		dc.w	SFX_S32-SFX_ADDR_TAB
		dc.w	SFX_S33-SFX_ADDR_TAB
		dc.w	SFX_S34-SFX_ADDR_TAB
		dc.w	SFX_S35-SFX_ADDR_TAB
		dc.w	SFX_S36-SFX_ADDR_TAB
		dc.w	SFX_S37-SFX_ADDR_TAB
		dc.w	SFX_S38-SFX_ADDR_TAB
		dc.w	SFX_S39-SFX_ADDR_TAB
		dc.w	SFX_S40-SFX_ADDR_TAB
		dc.w	SFX_S41-SFX_ADDR_TAB
		dc.w	SFX_S42-SFX_ADDR_TAB
		dc.w	SFX_S43-SFX_ADDR_TAB
		dc.w	SFX_S44-SFX_ADDR_TAB
		dc.w	SFX_S45-SFX_ADDR_TAB
		dc.w	SFX_S46-SFX_ADDR_TAB
		dc.w	SFX_S47-SFX_ADDR_TAB
		dc.w	SFX_S48-SFX_ADDR_TAB
		dc.w	SFX_S49-SFX_ADDR_TAB
		dc.w	SFX_S50-SFX_ADDR_TAB
		dc.w	SFX_S51-SFX_ADDR_TAB
		dc.w	SFX_S52-SFX_ADDR_TAB
		dc.w	SFX_S53-SFX_ADDR_TAB
		dc.w	SFX_S54-SFX_ADDR_TAB
		dc.w	SFX_S55-SFX_ADDR_TAB
		dc.w	SFX_S56-SFX_ADDR_TAB
		dc.w	SFX_S57-SFX_ADDR_TAB
		dc.w	SFX_S58-SFX_ADDR_TAB
		dc.w	SFX_S59-SFX_ADDR_TAB
		dc.w	SFX_S60-SFX_ADDR_TAB
		dc.w	SFX_S61-SFX_ADDR_TAB
		dc.w	SFX_S62-SFX_ADDR_TAB
		dc.w	SFX_S63-SFX_ADDR_TAB
		dc.w	SFX_S64-SFX_ADDR_TAB
		dc.w	SFX_S65-SFX_ADDR_TAB
		dc.w	SFX_S66-SFX_ADDR_TAB
		dc.w	SFX_S67-SFX_ADDR_TAB
		dc.w	SFX_S68-SFX_ADDR_TAB
		dc.w	SFX_S69-SFX_ADDR_TAB
		dc.w	SFX_S70-SFX_ADDR_TAB
		dc.w	SFX_S71-SFX_ADDR_TAB
		dc.w	SFX_S72-SFX_ADDR_TAB
		dc.w	SFX_S73-SFX_ADDR_TAB
		dc.w	SFX_S74-SFX_ADDR_TAB
		dc.w	SFX_S75-SFX_ADDR_TAB
		dc.w	SFX_S76-SFX_ADDR_TAB
		dc.w	SFX_S77-SFX_ADDR_TAB
		dc.w	SFX_S78-SFX_ADDR_TAB
		dc.w	SFX_S79-SFX_ADDR_TAB
		dc.w	SFX_S80-SFX_ADDR_TAB
		dc.w	SFX_S81-SFX_ADDR_TAB
		dc.w	SFX_S82-SFX_ADDR_TAB
		dc.w	SFX_S83-SFX_ADDR_TAB
		dc.w	SFX_S84-SFX_ADDR_TAB
		dc.w	SFX_S85-SFX_ADDR_TAB
		dc.w	SFX_S86-SFX_ADDR_TAB
		dc.w	SFX_S87-SFX_ADDR_TAB
		dc.w	SFX_S88-SFX_ADDR_TAB
		dc.w	SFX_S89-SFX_ADDR_TAB
		dc.w	SFX_S90-SFX_ADDR_TAB

;================================================ SFX 0 (BatSki)
SFX_S00		dc.b	1-1
		dc.w	sfx0a-SFX_S00
sfx0a		dc.b	1,PRGM,0
		dc.b	1,PWCH,0,$40
		dc.b	1,CTRL,VOLM,BSK_DEFVOL
		dc.b	1,NTON,C10
SFX_S0L		dc.b	120,META,SS,GTO
		dc.l	SFX_S0L-sfx0a
;================================================ SFX 1 (Skis in Water)
SFX_S01		dc.b	1-1
		dc.w	sfx1a-SFX_S01
sfx1a		dc.b	1,PRGM,1
		dc.b	1,CTRL,VOLM,0
		dc.b	1,NTON,G20
SFX_S1L		dc.b	120,META,SS,GTO
		dc.l	SFX_S1L-sfx1a

;================================================ SFX 2 (BASHBLD_A)
SFX_S02		dc.b	1-1
		dc.w	sfx2a-SFX_S02
sfx2a		dc.b	0,PRGM,2
		dc.b	1,CTRL,VOLM,110
		dc.b	0,NTON,F20,3,NTOF,F20
		dc.b	0,NTON,D20,2,NTOF,D20
		dc.b	0,NTON,G10,60,NTOF,G10
		dc.b	11,META,EOTRK,0
;================================================ SFX 3 (BATSKI_TURB)
SFX_S03		dc.b	1-1
		dc.w	sfx3a-SFX_S03
sfx3a		dc.b	0,PRGM,3
		dc.b	1,CTRL,VOLM,60
		dc.b	0,CTRL,PANM,64
		dc.b	0,NTON,G10
SFX_S3L		dc.b	16,CTRL,PANM,48
		dc.b	16,CTRL,PANM,80
		dc.b	16,CTRL,PANM,64
		dc.b	16,META,SS,GTO
		dc.l	SFX_S3L-sfx3a

;================================================ SFX 4 (Truck 0)
SFX_S04		dc.b	1-1
		dc.w	sfx4a-SFX_S04
sfx4a		dc.b	0,PRGM,4
		dc.b	1,CTRL,VOLM,20
		dc.b	0,NTON,C20
SFX_S4L		dc.b	120,META,SS,GTO
		dc.l	SFX_S4L-sfx4a
;=============================================== SFX 5 (BASHOBJ_A)
SFX_S05		dc.b	1-1
		dc.w	sfx05a-SFX_S05
sfx05a		dc.b	0,PRGM,12
		dc.b	1,CTRL,VOLM,97
		dc.b	0,NTON,C20,4,NTOF,C20
		dc.b	11,META,EOTRK,0
;================================================ SFX 6 (BATDISK FIRE)
SFX_S06		dc.b	1-1
		dc.w	sfx6a-SFX_S06
sfx6a		dc.b	1,PRGM,6		;Bang0
		dc.b	1,CTRL,VOLM,85
		dc.b	0,NTON,C20
		dc.b	1,META,SS,PBM,15
		dc.b	1,CTRL,PANM,64
		dc.b	1,CTRL,PANM,0
		dc.b	1,CTRL,PANM,127
		dc.b	1,CTRL,PANM,64
		dc.b	6,NTOF,C20
		dc.b	3,META,EOTRK,0
;================================================ SFX 7 (Road Noise)
SFX_S07		dc.b	1-1
		dc.w	sfx7a-SFX_S07
sfx7a		dc.b	0,PRGM,7
		dc.b	1,PWCH,0,0
		dc.b	0,NTON,G00
SFX_S7L		dc.b	120,META,SS,GTO
		dc.l	SFX_S7L-sfx7a
;================================================ SFX 8 (Missile 0)
SFX_S08		dc.b	1-1
		dc.w	sfx8a-SFX_S08
sfx8a		dc.b	0,PRGM,3
		dc.b	1,CTRL,VOLM,0	;127
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
;================================================ SFX 10 (BRFIRE)
SFX_S10		dc.b	1-1
		dc.w	sfx10a-SFX_S10
sfx10a		dc.b	0,PRGM,31
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,C20
		dc.b	2,META,SS,PBM,2		
		dc.b	12,CTRL,PANM,90
		dc.b	12,CTRL,PANM,50
		dc.b	5,CTRL,PANM,64
		dc.b	40,NTOF,C20
		dc.b	11,META,EOTRK,0
;================================================ SFX 11 (BITSGND_A)
SFX_S11		dc.b	1-1
		dc.w	sfx11a-SFX_S11
sfx11a		dc.b	0,PRGM,11	;DEBRIS0
		dc.b	1,NTON,G40
		dc.b	1,META,SS,PBM,3		
		dc.b	26,NTOF,G40
		dc.b	26,META,EOTRK,0
;================================================ SFX 12 (EXPLD_A) BIG!!
SFX_S12		dc.b	1-1
		dc.w	sfx12a-SFX_S12
sfx12a		dc.b	0,PRGM,10
		dc.b	1,CTRL,VOLM,127
		dc.b	0,CTRL,PANM,64
		dc.b	0,NTON,G20,24,NTOF,G20
		dc.b	0,NTON,B10
		dc.b	6,CTRL,PANM,0
		dc.b	3,CTRL,PANM,100
		dc.b	4,CTRL,PANM,127
		dc.b	3,CTRL,PANM,64
		dc.b	16,NTOF,B10
		dc.b	0,NTON,A00,6,NTOF,A00
		dc.b	10,NTON,D10,6,NTOF,D10
		dc.b	10,NTON,E00,36,NTOF,E00
		dc.b	22,META,EOTRK,0
;================================================ SFX 13 (EXPLD_B)
SFX_S13		dc.b	1-1
		dc.w	sfx13a-SFX_S13
sfx13a		dc.b	0,PRGM,10
		dc.b	1,CTRL,VOLM,127
		dc.b	0,CTRL,PANM,64
		dc.b	0,NTON,C30,16,NTOF,C30
		dc.b	0,NTON,D20
		dc.b	6,CTRL,PANM,0
		dc.b	3,CTRL,PANM,100
		dc.b	4,CTRL,PANM,127
		dc.b	2,CTRL,PANM,64
		dc.b	12,NTOF,D20
		dc.b	0,NTON,C10,3,NTOF,C10
		dc.b	6,CTRL,PANM,64
		dc.b	0,NTON,A10,3,NTOF,A10
		dc.b	5,NTON,G00,30,NTOF,G00
		dc.b	22,META,EOTRK,0

;================================================ SFX 14 (EXPLD_C)
SFX_S14		dc.b	1-1
		dc.w	sfx14a-SFX_S14
sfx14a		dc.b	0,PRGM,19
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,G30,10,NTOF,G30
		dc.b	0,NTON,C20
		dc.b	4,CTRL,PANM,0
		dc.b	6,CTRL,PANM,64
		dc.b	6,CTRL,PANM,127
		dc.b	6,CTRL,PANM,64
		dc.b	18,NTOF,C20
		dc.b	12,META,EOTRK,0
;================================================ SFX 15 (EXPLD_D) SMALLEST
SFX_S15		dc.b	1-1
		dc.w	sfx15a-SFX_S15
sfx15a		dc.b	0,PRGM,19
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,C40,3,NTOF,C40
		dc.b	0,NTON,A00
		dc.b	3,CTRL,PANM,0
		dc.b	3,CTRL,PANM,64
		dc.b	3,CTRL,PANM,127
		dc.b	3,CTRL,PANM,64
		dc.b	8,NTOF,A00
		dc.b	12,META,EOTRK,0
;================================================ SFX 16 (Bat Bashes 0)
SFX_S16		dc.b	1-1
		dc.w	sfx16a-SFX_S16
sfx16a		dc.b	0,PRGM,4
		dc.b	1,CTRL,VOLM,110
		dc.b	1,NTON,C20,15,NTOF,C20
		dc.b	31,META,EOTRK,0
;================================================ SFX 17 (Sparks 0)
SFX_S17		dc.b	1-1
		dc.w	sfx17a-SFX_S17
sfx17a		dc.b	0,PRGM,8
		dc.b	1,NTON,G20
SFX_S17L	dc.b	1,CTRL,PANM,64
		dc.b	2,CTRL,PANM,32
		dc.b	1,CTRL,PANM,64
		dc.b	2,CTRL,PANM,96
		dc.b	1,CTRL,PANM,64
		dc.b	3,CTRL,PANM,40
		dc.b	1,META,SS,GTO
		dc.l	SFX_S17L-sfx17a
;================================================ SFX 18 (Mobike)
SFX_S18		dc.b	1-1
		dc.w	sfx18a-SFX_S18
sfx18a		dc.b	0,PRGM,9
		dc.b	1,CTRL,VOLM,0
		dc.b	1,NTON,C60
SFX_S18L	dc.b	10,META,SS,GTO
		dc.l	SFX_S18L-sfx18a
;================================================ SFX 19 (BASHER)
SFX_S19		dc.b	1-1
		dc.w	sfx19a-SFX_S19
sfx19a		dc.b	0,PRGM,9
		dc.b	1,CTRL,VOLM,0
		dc.b	1,NTON,E40
SFX_S19L	dc.b	10,META,SS,GTO
		dc.l	SFX_S19L-sfx19a

;================================================ SFX 20 (VILLAN)
SFX_S20		dc.b	1-1
		dc.w	sfx20a-SFX_S20
sfx20a		dc.b	0,PRGM,9
		dc.b	1,CTRL,VOLM,0
		dc.b	1,NTON,E50
SFX_S20L	dc.b	10,META,SS,GTO
		dc.l	SFX_S20L-sfx20a

;================================================ SFX 21 (JACKINBOX)
SFX_S21		dc.b	1-1
		dc.w	sfx21a-SFX_S21
sfx21a		dc.b	0,PRGM,4
		dc.b	1,CTRL,VOLM,0
		dc.b	1,NTON,E20
SFX_S21L	dc.b	1,META,SS,GTO
		dc.l	SFX_S21L-sfx21a

;================================================ SFX 22 (EFTRUCK_A)
SFX_S22		dc.b	1-1
		dc.w	sfx22a-SFX_S22
sfx22a		dc.b	1,PRGM,4
		dc.b	1,CTRL,VOLM,0
		dc.b	1,NTON,C20
SFX_S22L	dc.b	1,META,SS,GTO
		dc.l	SFX_S22L-sfx22a
;================================================ SFX 23 (ETANKER_A)
SFX_S23		dc.b	1-1
		dc.w	sfx23a-SFX_S23
sfx23a		dc.b	1,PRGM,4
		dc.b	1,CTRL,VOLM,0
		dc.b	1,NTON,C20
SFX_S23L	dc.b	1,META,SS,GTO
		dc.l	SFX_S23L-sfx23a
;================================================ SFX 24 (ECANNON_A)
SFX_S24		dc.b	1-1
		dc.w	sfx24a-SFX_S24
sfx24a		dc.b	1,PRGM,9
		dc.b	1,CTRL,VOLM,0
		dc.b	1,NTON,E50
SFX_S24L	dc.b	10,META,SS,GTO
		dc.l	SFX_S24L-sfx24a
;================================================ SFX 25 (EMINICAN_A)
SFX_S25		dc.b	1-1
		dc.w	sfx25a-SFX_S25
sfx25a		dc.b	1,PRGM,4
		dc.b	1,CTRL,VOLM,0
		dc.b	1,NTON,E20
SFX_S25L	dc.b	1,META,SS,GTO
		dc.l	SFX_S25L-sfx25a
;================================================ SFX 26 (EPCVAN_A)
SFX_S26		dc.b	1-1
		dc.w	sfx26a-SFX_S26
sfx26a		dc.b	1,PRGM,4
		dc.b	1,CTRL,VOLM,0
		dc.b	1,NTON,C20
SFX_S26L	dc.b	1,META,SS,GTO
		dc.l	SFX_S26L-sfx26a
;================================================ SFX 27 (ROTATING HOLE_A)
SFX_S27		dc.b	1-1
		dc.w	sfx27a-SFX_S27
sfx27a		dc.b	1,PRGM,5
		dc.b	1,CTRL,VOLM,0
SFX_S27L	dc.b	1,NTON,E20,18,NTOF,E20 ;*g00
		dc.b	1,NTON,A1S,27,NTOF,A1S ;d0S
		dc.b	1,META,SS,GTO
		dc.l	SFX_S27L-sfx27a
;================================================ SFX 28 (BITSGND_D)
SFX_S28		dc.b	1-1
		dc.w	sfx28a-SFX_S28
sfx28a		dc.b	0,PRGM,11	;DEBRIS0
		dc.b	1,NTON,E30
		dc.b	2,META,SS,PBM,3		
		dc.b	12,NTOF,E30
		dc.b	26,META,EOTRK,0
;=============================================== SFX 29 (BASHOBJ_B)
SFX_S29		dc.b	1-1
		dc.w	sfx29a-SFX_S29
sfx29a		dc.b	0,PRGM,12		;CLANG0
		dc.b	1,CTRL,VOLM,97
		dc.b	0,NTON,C10,12,NTOF,C10
		dc.b	11,META,EOTRK,0
;================================================ SFX 30 (JBDOOR_A)
SFX_S30		dc.b	1-1
		dc.w	sfx30a-SFX_S30
sfx30a		dc.b	0,PRGM,16
		dc.b	1,CTRL,VOLM,127
		dc.b	2,NTON,C10,2,NTOF,C10
		dc.b	2,NTON,C30,1,NTOF,C30
		dc.b	3,PRGM,13
		dc.b	1,CTRL,VOLM,127
		dc.b	1,NTON,G20
		dc.b	1,META,SS,PBM,4
		dc.b	64,NTOF,G20
		dc.b	11,META,EOTRK,0
;================================================ SFX 31 (WATERPLOP_A)
SFX_S31		dc.b	1-1
		dc.w	sfx31a-SFX_S31
sfx31a		dc.b	0,PRGM,17
		dc.b	1,NTON,G50,3,NTOF,G50
		dc.b	31,META,EOTRK,0
;================================================ SFX 32 (WATERPLOP_B)
SFX_S32		dc.b	1-1
		dc.w	sfx32a-SFX_S32
sfx32a		dc.b	0,PRGM,17
		dc.b	1,NTON,B40,4,NTOF,B40
		dc.b	31,META,EOTRK,0
;================================================ SFX 33 (WATERPLOP_C)
SFX_S33		dc.b	1-1
		dc.w	sfx33a-SFX_S33
sfx33a		dc.b	0,PRGM,17
		dc.b	1,NTON,E30,4,NTOF,E30
		dc.b	31,META,EOTRK,0
;================================================ SFX 34 (ROCKET_A)
SFX_S34		dc.b	1-1
		dc.w	sfx34a-SFX_S34
sfx34a		dc.b	0,PRGM,15
		dc.b	1,CTRL,VOLM,100
		dc.b	1,NTON,C20
		dc.b	0,CTRL,PANM,64
		dc.b	2,META,SS,PBM,8		
		dc.b	6,CTRL,PANM,48
		dc.b	6,CTRL,PANM,80
		dc.b	6,CTRL,PANM,64
		dc.b	64,NTOF,C20
		dc.b	12,META,EOTRK,0
;================================================ SFX 35 (SKULL_A)
SFX_S35		dc.b	1-1
		dc.w	sfx35a-SFX_S35
sfx35a		dc.b	0,PRGM,14
		dc.b	1,NTON,E30
		dc.b	1,META,SS,PBM,21
		dc.b	70,NTOF,E30		
		dc.b	12,META,EOTRK,0
;================================================ SFX36 (LADDER_A)
SFX_S36		dc.b	1-1
		dc.w	sfx36a-SFX_S36
sfx36a		dc.b	0,PRGM,27
		dc.b	1,NTON,F50
		dc.b	1,META,SS,PBM,0
		dc.b	70,NTOF,F50		
		dc.b	12,META,EOTRK,0
;================================================ SFX 37 (BITSGND_E) 
SFX_S37		dc.b	1-1
		dc.w	sfx37a-SFX_S37
sfx37a		dc.b	0,PRGM,11	;DEBRIS0
		dc.b	1,NTON,C30
		dc.b	2,META,SS,PBM,3		
		dc.b	15,NTOF,C30
		dc.b	26,META,EOTRK,0
;================================================ SFX 38 (BITSGND_F)
SFX_S38		dc.b	1-1
		dc.w	sfx38a-SFX_S38
sfx38a		dc.b	0,PRGM,11	;DEBRIS0
		dc.b	1,NTON,B20
		dc.b	2,META,SS,PBM,3		
		dc.b	18,NTOF,B20
		dc.b	26,META,EOTRK,0
;================================================ SFX 39 (BITSGND_G)
SFX_S39		dc.b	1-1
		dc.w	sfx39a-SFX_S39
sfx39a		dc.b	0,PRGM,11	;DEBRIS0
		dc.b	1,NTON,G20
		dc.b	2,META,SS,PBM,3		
		dc.b	21,NTOF,G20
		dc.b	26,META,EOTRK,0
;================================================ SFX 40 (BITSGND_H)
SFX_S40		dc.b	1-1
		dc.w	sfx40a-SFX_S40
sfx40a		dc.b	0,PRGM,11	;DEBRIS0
		dc.b	1,NTON,E20
		dc.b	2,META,SS,PBM,3		
		dc.b	24,NTOF,E20
		dc.b	26,META,EOTRK,0
;================================================ SFX 41 (ICEDROP_A)
SFX_S41		dc.b	1-1
		dc.w	sfx41a-SFX_S41
sfx41a		dc.b	0,PRGM,11	;DEBRIS0
		dc.b	1,NTON,E20
		dc.b	12,NTOF,E20
		dc.b	26,META,EOTRK,0
;================================================ SFX 42 (BDHIT_B)
SFX_S42		dc.b	1-1
		dc.w	sfx42a-SFX_S42
sfx42a		dc.b	0,PRGM,20	;Crash0
		dc.b	1,NTON,G30,1,NTOF,G30
		dc.b	2,NTON,A20,2,NTOF,A20
		dc.b	2,META,EOTRK,0
;================================================ SFX 43 (FTFLAME_A)
SFX_S43		dc.b	1-1
		dc.w	sfx43a-SFX_S43
sfx43a		dc.b	0,PRGM,21
		dc.b	2,NTON,C20
		dc.b	100,NTOF,C20
		dc.b	10,META,EOTRK,0
;================================================ SFX 44 (METWALL_A)
SFX_S44		dc.b	1-1
		dc.w	sfx44a-SFX_S44
sfx44a		dc.b	1,PRGM,12
		dc.b	1,NTON,E30
		dc.b	3,CTRL,PANM,64
		dc.b	2,CTRL,PANM,0
		dc.b	1,CTRL,PANM,100
		dc.b	3,CTRL,PANM,64
		dc.b	10,NTOF,E30
		dc.b	31,META,EOTRK,0
;================================================ SFX 45 (BASHTREE_A)
SFX_S45		dc.b	1-1
		dc.w	sfx45a-SFX_S45
sfx45a		dc.b	0,PRGM,21
		dc.b	1,NTON,C20,3,NTOF,C20
		dc.b	61,META,EOTRK,0
;================================================ SFX 46 (METPIPE_A)
SFX_S46		dc.b	1-1
		dc.w	sfx46a-SFX_S46
sfx46a		dc.b	1,PRGM,12
		dc.b	1,CTRL,VOLM,127
		dc.b	1,NTON,G30
		dc.b	1,CTRL,PANM,64
		dc.b	1,CTRL,PANM,0
		dc.b	1,CTRL,PANM,100
		dc.b	2,CTRL,PANM,64
		dc.b	6,NTOF,G30
		dc.b	4,META,EOTRK,0
;================================================ SFX 47 (METRHOLE)
SFX_S47		dc.b	1-1
		dc.w	sfx47a-SFX_S47
sfx47a		dc.b	0,PRGM,21
		dc.b	1,NTON,C30,2,NTOF,C30
		dc.b	1,NTON,E20,3,NTOF,E20
		dc.b	61,META,EOTRK,0
;================================================ SFX 48 (METCRUNCH)
SFX_S48		dc.b	1-1
		dc.w	sfx48a-SFX_S48
sfx48a		dc.b	1,PRGM,12
		dc.b	1,NTON,A20,4,NTOF,A20
		dc.b	1,PRGM,21
		dc.b	1,NTON,G20,2,NTOF,G20	
		dc.b	61,META,EOTRK,0
;================================================ SFX 49 (BASHBOUY_A)
SFX_S49		dc.b	1-1
		dc.w	sfx49a-SFX_S49
sfx49a		dc.b	0,PRGM,28
		dc.b	1,NTON,E30,1,NTOF,E30
		dc.b	3,NTON,F40,5,NTOF,F40
		dc.b	10,META,EOTRK,0
;================================================ SFX 50 (TRASHGND_A)
SFX_S50		dc.b	1-1
		dc.w	sfx50a-SFX_S50
sfx50a		dc.b	0,PRGM,23
		dc.b	1,CTRL,VOLM,100
		dc.b	0,NTON,G10,2,NTOF,G10	
		dc.b	3,CTRL,VOLM,120
		dc.b	0,CTRL,PANM,64
		dc.b	0,NTON,B20
		dc.b	2,CTRL,PANM,0
		dc.b	1,CTRL,PANM,100
		dc.b	2,CTRL,PANM,64
		dc.b	4,NTOF,B20
		dc.b	21,META,EOTRK,0
;================================================ SFX 51 (TRASHGND_B)
SFX_S51		dc.b	1-1
		dc.w	sfx51a-SFX_S51
sfx51a		dc.b	0,PRGM,23
		dc.b	1,CTRL,VOLM,90
		dc.b	0,NTON,F10,2,NTOF,F10	
		dc.b	3,CTRL,VOLM,120
		dc.b	0,CTRL,PANM,64
		dc.b	4,NTON,C30
		dc.b	2,CTRL,PANM,0
		dc.b	1,CTRL,PANM,100
		dc.b	2,CTRL,PANM,64
		dc.b	8,NTOF,C30
		dc.b	22,META,EOTRK,0
;================================================ SFX 52 (TRASHGND_C)
SFX_S52		dc.b	1-1
		dc.w	sfx52a-SFX_S52
sfx52a		dc.b	0,PRGM,23
		dc.b	1,CTRL,VOLM,90
		dc.b	0,NTON,D10,2,NTOF,D10	
		dc.b	4,NTON,C10,2,NTOF,C10	
		dc.b	3,CTRL,VOLM,115
		dc.b	0,CTRL,PANM,64
		dc.b	4,NTON,A20
		dc.b	2,CTRL,PANM,0
		dc.b	1,CTRL,PANM,100
		dc.b	2,CTRL,PANM,64
		dc.b	16,NTOF,A20
		dc.b	22,META,EOTRK,0
;================================================ SFX 53 (TRASHGND_D)
SFX_S53		dc.b	1-1
		dc.w	sfx53a-SFX_S53
sfx53a		dc.b	0,PRGM,23
		dc.b	1,CTRL,VOLM,90
		dc.b	0,NTON,B00
		dc.b	0,CTRL,PANM,0
		dc.b	1,CTRL,PANM,80
		dc.b	2,CTRL,PANM,64
		dc.b	10,NTOF,B00	
		dc.b	5,CTRL,VOLM,110
		dc.b	0,NTON,F20
		dc.b	2,CTRL,PANM,0
		dc.b	4,CTRL,PANM,100
		dc.b	2,CTRL,PANM,64
		dc.b	18,NTOF,F20
		dc.b	24,META,EOTRK,0
;================================================ SFX 54 (BDHIT_A)
SFX_S54		dc.b	1-1
		dc.w	sfx54a-SFX_S54
sfx54a		dc.b	0,PRGM,6
		dc.b	1,CTRL,VOLM,40
		dc.b	0,NTON,G10
		dc.b	2,CTRL,PANM,0
		dc.b	2,CTRL,PANM,64
		dc.b	2,CTRL,PANM,127
		dc.b	2,CTRL,PANM,64
		dc.b	2,NTOF,G10
		dc.b	12,META,EOTRK,0
;================================================ SFX 55 (AXEAIR_A)
SFX_S55		dc.b	1-1
		dc.w	sfx55a-SFX_S55
sfx55a		dc.b	0,PRGM,14
		dc.b	2,CTRL,VOLM,50
		dc.b	0,NTON,D40,1,META,SS,PBM,7,9,NTOF,D40	
		dc.b	0,NTON,C40,1,META,SS,PBM,7,10,NTOF,C40	
		dc.b	0,NTON,G30,1,META,SS,PBM,7,10,NTOF,G30	
		dc.b	0,NTON,C30,1,META,SS,PBM,7,10,NTOF,C30	
		dc.b	0,NTON,G20,1,META,SS,PBM,7,11,NTOF,G20	
		dc.b	0,NTON,F20,1,META,SS,PBM,7,11,NTOF,F20	
		dc.b	0,NTON,D20,1,META,SS,PBM,7,12,NTOF,D20	
		dc.b	0,NTON,B10,1,META,SS,PBM,7,12,NTOF,B10	
		dc.b	0,NTON,G10,1,META,SS,PBM,7,13,NTOF,G10	
		dc.b	11,META,EOTRK,0
;================================================ SFX 56 (AXEHIT_A)
SFX_S56		dc.b	1-1
		dc.w	sfx56a-SFX_S56
sfx56a		dc.b	0,PRGM,24
		dc.b	1,CTRL,VOLM,120
		dc.b	0,NTON,A10,3,NTOF,A10
		dc.b	0,NTON,F10,4,NTOF,F10
		dc.b	0,NTON,E00,2,NTOF,E00
		dc.b	2,META,EOTRK,0
;================================================ SFX 57 (CONEHIT_A)
SFX_S57		dc.b	1-1
		dc.w	sfx57a-SFX_S57
sfx57a		dc.b	0,PRGM,25
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,C20,1,NTOF,C20
		dc.b	2,PRGM,26
		dc.b	1,CTRL,VOLM,115
		dc.b	0,NTON,G00,3,NTOF,G00
		dc.b	3,META,EOTRK,0
;================================================ SFX 58 (CONEGND_A)
SFX_S58		dc.b	1-1
		dc.w	sfx58a-SFX_S58
sfx58a		dc.b	0,PRGM,25
		dc.b	1,CTRL,VOLM,110
		dc.b	0,NTON,C00,1,NTOF,C00
		dc.b	3,NTON,A10,1,NTOF,A10
		dc.b	7,META,EOTRK,0
;================================================ SFX 59 (CONEGND_B)
SFX_S59		dc.b	1-1
		dc.w	sfx59a-SFX_S59
sfx59a		dc.b	0,PRGM,25
		dc.b	1,CTRL,VOLM,112
		dc.b	0,NTON,G00,2,NTOF,G00
		dc.b	2,CTRL,VOLM,115
		dc.b	2,NTON,A20,3,NTOF,A20
		dc.b	7,META,EOTRK,0
;================================================ SFX 60 (CONEGND_C)
SFX_S60		dc.b	1-1
		dc.w	sfx60a-SFX_S60
sfx60a		dc.b	0,PRGM,25
		dc.b	1,CTRL,VOLM,115
		dc.b	0,NTON,G10,2,NTOF,G10
		dc.b	2,CTRL,VOLM,119
		dc.b	2,NTON,D30,2,NTOF,D30
		dc.b	4,META,EOTRK,0
;================================================ SFX 61 (CONEGND_D)
SFX_S61		dc.b	1-1
		dc.w	sfx61a-SFX_S61
sfx61a		dc.b	0,PRGM,25
		dc.b	1,CTRL,VOLM,118
		dc.b	0,NTON,G20,2,NTOF,G20
		dc.b	2,CTRL,VOLM,122
		dc.b	1,NTON,F30,3,NTOF,F30
		dc.b	5,META,EOTRK,0
;================================================ SFX 62 (RAMP_A)
SFX_S62		dc.b	1-1
		dc.w	sfx62a-SFX_S62
sfx62a		dc.b	0,PRGM,7
		dc.b	1,NTON,E10
		dc.b	1,META,SS,PBM,4
		dc.b	12,NTOF,E10
		dc.b	3,META,EOTRK,0
;================================================ SFX 63 (PCGND_A)
SFX_S63		dc.b	1-1
		dc.w	sfx63a-SFX_S63
sfx63a		dc.b	0,PRGM,28
		dc.b	1,CTRL,VOLM,110
		dc.b	0,NTON,C30,1,META,SS,PBM,10,2,NTOF,C30	
		dc.b	26,META,EOTRK,0

;================================================ SFX 64 (TARGETHIT_A)
SFX_S64		dc.b	1-1
		dc.w	sfx64a-SFX_S64
sfx64a		dc.b	0,PRGM,28
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,G40,2,NTOF,G40
		dc.b	2,NTON,C50,3,NTOF,C50
		dc.b	12,PRGM,31
		dc.b	1,CTRL,VOLM,127
		dc.b	0,META,SS,PBM,11
		dc.b	1,NTON,G30,3,NTOF,G30		
		dc.b	2,NTON,G30,3,NTOF,G30		
		dc.b	1,NTON,G30,3,NTOF,G30		
		dc.b	2,NTON,G30,3,NTOF,G30		
		dc.b	1,NTON,G30,3,NTOF,G30		
		dc.b	2,NTON,G30,3,NTOF,G30		
		dc.b	1,NTON,G30,3,NTOF,G30		
		dc.b	2,NTON,G30,3,NTOF,G30		
		dc.b	1,NTON,G30,3,NTOF,G30		
		dc.b	2,NTON,G30,3,NTOF,G30		
		dc.b	1,NTON,G30,3,NTOF,G30		
		dc.b	2,NTON,G30,3,NTOF,G30		
		dc.b	1,NTON,G30,3,NTOF,G30		
		dc.b	2,NTON,G30,3,NTOF,G30
		dc.b	1,NTON,G30,3,NTOF,G30		
		dc.b	2,NTON,G30,3,NTOF,G30		
		dc.b	1,NTON,G30,3,NTOF,G30		
		dc.b	2,NTON,G30,3,NTOF,G30		
		dc.b	1,NTON,G30,3,NTOF,G30
		dc.b	2,NTON,G30,3,NTOF,G30		
		dc.b	1,NTON,G30,3,NTOF,G30		
		dc.b	2,NTON,G30,3,NTOF,G30		
		dc.b	1,NTON,G30,3,NTOF,G30		
		dc.b	6,META,EOTRK,0
;================================================ SFX 65 (LIGHTGND_A)
SFX_S65		dc.b	1-1
		dc.w	sfx65a-SFX_S65
sfx65a		dc.b	0,PRGM,6
		dc.b	1,CTRL,VOLM,125
		dc.b	0,NTON,G10	;,2,NTOF,G10
		dc.b	1,PRGM,32
		dc.b	1,CTRL,VOLM,127
		dc.b	0,META,SS,PBM,12
		dc.b	0,NTON,C20,2,NTOF,C20	
		dc.b	2,NTON,F30,1,NTOF,F30	
		dc.b	2,NTON,D30,1,NTOF,D30	
		dc.b	0,NTON,B40,2,NTOF,B40	
		dc.b	1,NTOF,G10
		dc.b	2,NTON,E30,1,NTOF,E30	
		dc.b	1,NTON,A20,1,NTOF,A20	
		dc.b	2,NTON,E30,1,NTOF,E30	
		dc.b	2,NTON,C30,4,NTOF,C30	
		dc.b	20,META,EOTRK,0
;================================================ SFX 66 (LIGHTGND_B)
SFX_S66		dc.b	1-1
		dc.w	sfx66a-SFX_S66
sfx66a		dc.b	0,PRGM,6
		dc.b	1,CTRL,VOLM,125
		dc.b	0,NTON,C20	;,2,NTOF,G10
		dc.b	1,PRGM,32
		dc.b	1,CTRL,VOLM,127
		dc.b	0,META,SS,PBM,13
		dc.b	0,NTON,C20,2,NTOF,C20	
		dc.b	2,NTON,F30,1,NTOF,F30	
		dc.b	2,NTON,D30,1,NTOF,D30	
		dc.b	0,NTON,B40,2,NTOF,B40	
		dc.b	1,NTOF,C20
		dc.b	2,NTON,E30,1,NTOF,E30	
		dc.b	1,NTON,A20,1,NTOF,A20	
		dc.b	2,NTON,E30,1,NTOF,E30	
		dc.b	2,NTON,C30,4,NTOF,C30	
		dc.b	20,META,EOTRK,0
;================================================ SFX 67 (LIGHTGND_C)
SFX_S67		dc.b	1-1
		dc.w	sfx67a-SFX_S67
sfx67a		dc.b	0,PRGM,6
		dc.b	1,CTRL,VOLM,125
		dc.b	0,NTON,G10	;,2,NTOF,G10
		dc.b	1,PRGM,32
		dc.b	1,CTRL,VOLM,127
		dc.b	0,META,SS,PBM,14
		dc.b	0,NTON,C20,2,NTOF,C20	
		dc.b	2,NTON,F30,1,NTOF,F30	
		dc.b	2,NTON,D30,1,NTOF,D30	
		dc.b	0,NTON,B40,2,NTOF,B40	
		dc.b	1,NTOF,G10
		dc.b	2,NTON,E30,1,NTOF,E30	
		dc.b	1,NTON,A20,1,NTOF,A20	
		dc.b	2,NTON,E30,1,NTOF,E30	
		dc.b	2,NTON,C30,4,NTOF,C30	
		dc.b	20,META,EOTRK,0
;================================================ SFX 68 (LIGHTGND_D)
SFX_S68		dc.b	1-1
		dc.w	sfx68a-SFX_S68
sfx68a		dc.b	0,PRGM,6
		dc.b	1,CTRL,VOLM,125
		dc.b	0,NTON,E30
		dc.b	1,PRGM,32
		dc.b	1,CTRL,VOLM,127
		dc.b	0,META,SS,PBM,15
		dc.b	0,NTON,C20,2,NTOF,C20	
		dc.b	2,NTON,F30,1,NTOF,F30	
		dc.b	2,NTON,D30,1,NTOF,D30	
		dc.b	3,NTON,B40,2,NTOF,B40	
		dc.b	1,NTOF,E30
		dc.b	2,NTON,E30,1,NTOF,E30	
		dc.b	1,NTON,A30,1,NTOF,A30	
		dc.b	2,NTON,E40,3,NTOF,E40	
		dc.b	2,NTON,D40,4,NTOF,D40	
		dc.b	20,META,EOTRK,0
;================================================ SFX 69 (ICEGND_A)
SFX_S69		dc.b	1-1
		dc.w	sfx69a-SFX_S69
sfx69a		dc.b	1,PRGM,34
		dc.b	1,CTRL,VOLM,105
		dc.b	1,NTON,C20,2,NTOF,C20	
		dc.b	2,NTON,F30,1,NTOF,F30	
		dc.b	2,NTON,D30,1,NTOF,D30	
		dc.b	4,NTON,B40,2,NTOF,B40	
		dc.b	20,META,EOTRK,0

;================================================ SFX 70 (ICEGND_B)
SFX_S70		dc.b	1-1
		dc.w	sfx70a-SFX_S70
sfx70a		dc.b	1,PRGM,33
		dc.b	1,CTRL,VOLM,105
		dc.b	2,NTON,F30,1,NTOF,F30	
		dc.b	4,NTON,D30,1,NTOF,D30	
		dc.b	20,META,EOTRK,0

;================================================ SFX 71 (ICEGND_C)
SFX_S71		dc.b	1-1
		dc.w	sfx71a-SFX_S71
sfx71a		dc.b	2,PRGM,34
		dc.b	1,CTRL,VOLM,115
		dc.b	2,META,SS,PBM,14
		dc.b	1,NTON,C20,2,NTOF,C20	
		dc.b	4,NTON,F30,1,NTOF,F30	
		dc.b	2,NTON,D30,1,NTOF,D30	
		dc.b	5,NTON,B40,2,NTOF,B40	
		dc.b	20,META,EOTRK,0
;================================================ SFX 72 (ICEGND_D)
SFX_S72		dc.b	1-1
		dc.w	sfx72a-SFX_S72
sfx72a		dc.b	4,PRGM,33
		dc.b	1,CTRL,VOLM,125
		dc.b	2,META,SS,PBM,15
		dc.b	1,NTON,C20,2,NTOF,C20	
		dc.b	2,NTON,F30,1,NTOF,F30	
		dc.b	2,NTON,D30,1,NTOF,D30	
		dc.b	3,NTON,B40,2,NTOF,B40	
		dc.b	2,NTON,E30,1,NTOF,E30	
		dc.b	1,NTON,A30,1,NTOF,A30	
		dc.b	4,NTON,E40,3,NTOF,E40	
		dc.b	3,NTON,D40,4,NTOF,D40	
		dc.b	20,META,EOTRK,0
;================================================ SFX 73 (ICEDROP_A)
SFX_S73		dc.b	1-1
		dc.w	sfx73a-SFX_S73
sfx73a		dc.b	0,PRGM,36
		dc.b	1,CTRL,VOLM,105
		dc.b	1,NTON,B10,1,NTOF,B10
		dc.b	1,CTRL,VOLM,115
		dc.b	1,NTON,D10,3,NTOF,D10
		dc.b	11,META,EOTRK,0
;================================================ SFX 74 (ICEBREAK_A)
SFX_S74		dc.b	1-1
		dc.w	sfx74a-SFX_S74
sfx74a		dc.b	0,PRGM,44
		dc.b	1,NTON,G30,2,NTOF,G30
		dc.b	1,NTON,C40,2,NTOF,C40
		dc.b	2,NTON,G40,3,NTOF,G40
		dc.b	1,PRGM,19
		dc.b	3,NTON,A30,4,NTOF,A30
		dc.b	2,NTON,E20,8,NTOF,E20
		dc.b	12,META,EOTRK,0
;================================================ SFX 75 (BASHPOLE_B)
SFX_S75		dc.b	1-1
		dc.w	sfx75a-SFX_S75
sfx75a		dc.b	0,PRGM,37
		dc.b	1,CTRL,VOLM,105
		dc.b	0,NTON,C10
		dc.b	0,META,SS,PBM,16
		dc.b	10,NTOF,C10
		dc.b	11,META,EOTRK,0
;================================================ SFX 76 (BATNOISE_A)
SFX_S76		dc.b	1-1
		dc.w	sfx76a-SFX_S76
sfx76a		dc.b	0,PRGM,38
		dc.b	1,CTRL,VOLM,70
		dc.b	0,META,SS,PBM,17
		dc.b	1,NTON,C40,3,NTOF,C40
		dc.b	6,CTRL,VOLM,100
		dc.b	0,NTON,G40,1,NTOF,G40
		dc.b	3,CTRL,VOLM,107
		dc.b	9,NTON,F30,3,NTOF,F30
		dc.b	5,CTRL,VOLM,105
		dc.b	0,META,SS,PBM,17
		dc.b	1,NTON,D50,6,NTOF,D50
		dc.b	2,CTRL,VOLM,95
		dc.b	0,NTON,G40,1,NTOF,G40
		dc.b	6,CTRL,VOLM,80
		dc.b	0,NTON,F30,8,NTOF,F30
		dc.b	22,CTRL,VOLM,55
		dc.b	1,NTON,E30,6,NTOF,E30
		dc.b	20,CTRL,VOLM,25
		dc.b	1,NTON,D30,5,NTOF,D30
		dc.b	20,CTRL,VOLM,5
		dc.b	1,NTON,C3S,5,NTOF,C3S
		dc.b	11,META,EOTRK,0
;================================================ SFX 77 (CANFIRE_A)
SFX_S77		dc.b	1-1
		dc.w	sfx77a-SFX_S77
sfx77a		dc.b	0,PRGM,15
		dc.b	1,NTON,G60
		dc.b	1,META,SS,PBM,22
		dc.b	90,NTOF,G60
		dc.b	11,META,EOTRK,0
;================================================ SFX 78 (MCANFIRE_A)
SFX_S78		dc.b	1-1
		dc.w	sfx78a-SFX_S78
sfx78a		dc.b	0,PRGM,39
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,C30,3,NTOF,C30
		dc.b	3,NTON,C30,3,NTOF,C30
		dc.b	4,NTON,G40
		dc.b	3,CTRL,PANM,0
		dc.b	4,CTRL,PANM,127
		dc.b	2,CTRL,PANM,64
		dc.b	16,NTOF,G40
		dc.b	12,META,EOTRK,0
;================================================ SFX 79 (POWERUP_A)
SFX_S79		dc.b	1-1
		dc.w	sfx79a-SFX_S79
sfx79a		dc.b	0,PRGM,40
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,A30,3,NTOF,A30
		dc.b	3,NTON,A30,3,NTOF,A30
		dc.b	3,NTON,G3S,3,NTOF,G3S
		dc.b	3,NTON,G3S,3,NTOF,G3S
		dc.b	3,NTON,G30,3,NTOF,G30
		dc.b	3,NTON,G30,3,NTOF,G30
		dc.b	3,NTON,G3S,3,NTOF,G3S
		dc.b	3,NTON,G3S,4,NTOF,G3S
		dc.b	3,NTON,A30,6,NTOF,A30
		dc.b	12,META,EOTRK,0
;================================================ SFX 80 (AAARG_A)
SFX_S80		dc.b	1-1
		dc.w	sfx80a-SFX_S80
sfx80a		dc.b	0,PRGM,41
		dc.b	1,CTRL,VOLM,110
		dc.b	0,NTON,B30
		dc.b	0,META,SS,PBM,18
		dc.b	26,NTOF,B30
		dc.b	12,META,EOTRK,0
;================================================ SFX 81 (GUYGND_A)
SFX_S81		dc.b	1-1
		dc.w	sfx81a-SFX_S81
sfx81a		dc.b	0,PRGM,9
		dc.b	1,CTRL,VOLM,115
		dc.b	0,NTON,C20
		dc.b	1,META,SS,PBM,19
		dc.b	10,NTOF,C20
		dc.b	12,META,EOTRK,0
;================================================ SFX 82 (BLOCKHIT_A)
SFX_S82		dc.b	1-1
		dc.w	sfx82a-SFX_S82
sfx82a		dc.b	0,PRGM,42
		dc.b	1,CTRL,VOLM,120
		dc.b	0,NTON,B20
		dc.b	1,META,SS,PBM,18
		dc.b	20,NTOF,B20
		dc.b	12,META,EOTRK,0
;================================================ SFX 83 (BLOCKGND_A)
SFX_S83		dc.b	1-1
		dc.w	sfx83a-SFX_S83
sfx83a		dc.b	0,PRGM,42
		dc.b	1,CTRL,VOLM,120
		dc.b	0,NTON,D30
		dc.b	1,META,SS,PBM,18
		dc.b	10,NTOF,D30
		dc.b	12,META,EOTRK,0
;================================================ SFX 84 (BLOCKGND_B)
SFX_S84		dc.b	1-1
		dc.w	sfx84a-SFX_S84
sfx84a		dc.b	0,PRGM,42
		dc.b	1,CTRL,VOLM,120
		dc.b	0,NTON,E20
		dc.b	1,META,SS,PBM,18
		dc.b	22,NTOF,E20
		dc.b	12,META,EOTRK,0
;================================================ SFX 85 (BLOCKGND_C)
SFX_S85		dc.b	1-1
		dc.w	sfx85a-SFX_S85
sfx85a		dc.b	0,PRGM,42
		dc.b	1,CTRL,VOLM,120
		dc.b	0,NTON,C20
		dc.b	1,META,SS,PBM,3
		dc.b	28,NTOF,C20
		dc.b	12,META,EOTRK,0
;================================================ SFX 86 (BLOCKGND_D)
SFX_S86		dc.b	1-1
		dc.w	sfx86a-SFX_S86
sfx86a		dc.b	0,PRGM,42
		dc.b	1,CTRL,VOLM,125
		dc.b	0,NTON,E10
		dc.b	1,META,SS,PBM,18
		dc.b	20,NTOF,E10
		dc.b	12,META,EOTRK,0
;================================================ SFX 87 (LIGHTHIT_A)
SFX_S87		dc.b	1-1
		dc.w	sfx87a-SFX_S87
sfx87a		dc.b	0,PRGM,6
		dc.b	1,CTRL,VOLM,125
		dc.b	0,NTON,A2S	;,2,NTOF,G10
		dc.b	5,PRGM,32
		dc.b	1,CTRL,VOLM,127
		dc.b	0,META,SS,PBM,12
		dc.b	0,NTON,C10,3,NTOF,C10	
		dc.b	2,NTON,F40,1,NTOF,F40	
		dc.b	2,NTON,D30,1,NTOF,D30	
		dc.b	0,NTON,B40,2,NTOF,B40	
		dc.b	2,NTON,E30,1,NTOF,E30	
		dc.b	1,NTON,A20,1,NTOF,A20	
		dc.b	2,NTON,E40,1,NTOF,E40	
		dc.b	2,NTOF,A2S
		dc.b	20,META,EOTRK,0
;================================================ SFX 88 (CIRCUS_A)
SFX_S88		dc.b	1-1
		dc.w	sfx88a-SFX_S88
sfx88a		dc.b	0,PRGM,43
		dc.b	1,CTRL,VOLM,20
		dc.b	0,NTON,A30,1,META,SS,PBM,20,24,NTOF,A30
		dc.b	6,NTON,A40,1,META,SS,PBM,20,24,NTOF,A40
		dc.b	6,NTON,G3S,1,META,SS,PBM,20,12,NTOF,G3S
		dc.b	6,NTON,G4S,1,META,SS,PBM,20,24,NTOF,G4S
		dc.b	6,NTON,G30,1,META,SS,PBM,20,24,NTOF,G30
		dc.b	6,NTON,G30,1,META,SS,PBM,20,24,NTOF,G30
		dc.b	6,NTON,G3S,1,META,SS,PBM,20,24,NTOF,G3S
		dc.b	6,NTON,G3S,1,META,SS,PBM,20,24,NTOF,G3S
		dc.b	6,NTON,A30,1,META,SS,PBM,20,24,NTOF,A30
		dc.b	10,META,EOTRK,0
;================================================ SFX 89 (BOUY_A)
SFX_S89		dc.b	1-1
		dc.w	sfx89a-SFX_S89
sfx89a		dc.b	0,PRGM,28
		dc.b	1,NTON,F50,1,NTOF,F50
		dc.b	10,NTON,F50,5,NTOF,F50
		dc.b	10,META,EOTRK,0
;================================================ SFX 90 (WATERPLOP_D)
SFX_S90		dc.b	1-1
		dc.w	sfx90a-SFX_S90
sfx90a		dc.b	0,PRGM,17
		dc.b	1,NTON,C20,4,NTOF,C20
		dc.b	31,META,EOTRK,0

		EVEN

;*****************************************************************************			

		ENDIF

;*****************************************************************************			

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
; PROGRAM PATCH BANK (Z80 FM+PSG first)
;
MOBIKE		equ	0
BENDSKID	equ	0

		IF	AUDIO_MAIN

	dc.b	$00,$01		; Offset to patch #0: 256
	dc.b	$27,$01		; Offset to patch #1: 295
	dc.b	$4E,$01		; Offset to patch #2: 334
	dc.b	$4F,$01		; Offset to patch #3: 335
	dc.b	$50,$01		; Offset to patch #4: 336
	dc.b	$57,$01		; Offset to patch #5: 343
	dc.b	$7E,$01		; Offset to patch #6: 382
	dc.b	$7F,$01		; Offset to patch #7: 383
	dc.b	$A6,$01		; Offset to patch #8: 422
	dc.b	$CD,$01		; Offset to patch #9: 461
	dc.b	$F4,$01		; Offset to patch #10: 500
	dc.b	$1B,$02		; Offset to patch #11: 539
	dc.b	$1C,$02		; Offset to patch #12: 540
	dc.b	$1D,$02		; Offset to patch #13: 541
	dc.b	$24,$02		; Offset to patch #14: 548
	dc.b	$25,$02		; Offset to patch #15: 549
	dc.b	$26,$02		; Offset to patch #16: 550
	dc.b	$4D,$02		; Offset to patch #17: 589
	dc.b	$74,$02		; Offset to patch #18: 628
	dc.b	$9B,$02		; Offset to patch #19: 667
	dc.b	$A2,$02		; Offset to patch #20: 674
	dc.b	$A3,$02		; Offset to patch #21: 675
	dc.b	$A4,$02		; Offset to patch #22: 676
	dc.b	$CB,$02		; Offset to patch #23: 715
	dc.b	$F2,$02		; Offset to patch #24: 754
	dc.b	$19,$03		; Offset to patch #25: 793
	dc.b	$40,$03		; Offset to patch #26: 832
	dc.b	$41,$03		; Offset to patch #27: 833
	dc.b	$42,$03		; Offset to patch #28: 834
	dc.b	$43,$03		; Offset to patch #29: 835
	dc.b	$44,$03		; Offset to patch #30: 836
	dc.b	$45,$03		; Offset to patch #31: 837
	dc.b	$46,$03		; Offset to patch #32: 838
	dc.b	$47,$03		; Offset to patch #33: 839
	dc.b	$6E,$03		; Offset to patch #34: 878
	dc.b	$95,$03		; Offset to patch #35: 917
	dc.b	$BC,$03		; Offset to patch #36: 956
	dc.b	$E3,$03		; Offset to patch #37: 995
	dc.b	$E4,$03		; Offset to patch #38: 996
	dc.b	$E5,$03		; Offset to patch #39: 997
	dc.b	$E6,$03		; Offset to patch #40: 998
	dc.b	$ED,$03		; Offset to patch #41: 1005
	dc.b	$F4,$03		; Offset to patch #42: 1012
	dc.b	$FB,$03		; Offset to patch #43: 1019
	dc.b	$02,$04		; Offset to patch #44: 1026
	dc.b	$03,$04		; Offset to patch #45: 1027
	dc.b	$0A,$04		; Offset to patch #46: 1034
	dc.b	$11,$04		; Offset to patch #47: 1041
	dc.b	$38,$04		; Offset to patch #48: 1080
	dc.b	$5F,$04		; Offset to patch #49: 1119
	dc.b	$66,$04		; Offset to patch #50: 1126
	dc.b	$8D,$04		; Offset to patch #51: 1165
	dc.b	$8E,$04		; Offset to patch #52: 1166
	dc.b	$8F,$04		; Offset to patch #53: 1167
	dc.b	$90,$04		; Offset to patch #54: 1168
	dc.b	$B7,$04		; Offset to patch #55: 1207
	dc.b	$B8,$04		; Offset to patch #56: 1208
	dc.b	$B9,$04		; Offset to patch #57: 1209
	dc.b	$E0,$04		; Offset to patch #58: 1248
	dc.b	$E1,$04		; Offset to patch #59: 1249
	dc.b	$E2,$04		; Offset to patch #60: 1250
	dc.b	$E3,$04		; Offset to patch #61: 1251
	dc.b	$E4,$04		; Offset to patch #62: 1252
	dc.b	$E5,$04		; Offset to patch #63: 1253
	dc.b	$E6,$04		; Offset to patch #64: 1254
	dc.b	$E7,$04		; Offset to patch #65: 1255
	dc.b	$0E,$05		; Offset to patch #66: 1294
	dc.b	$0F,$05		; Offset to patch #67: 1295
	dc.b	$10,$05		; Offset to patch #68: 1296
	dc.b	$11,$05		; Offset to patch #69: 1297
	dc.b	$12,$05		; Offset to patch #70: 1298
	dc.b	$13,$05		; Offset to patch #71: 1299
	dc.b	$14,$05		; Offset to patch #72: 1300
	dc.b	$15,$05		; Offset to patch #73: 1301
	dc.b	$16,$05		; Offset to patch #74: 1302
	dc.b	$17,$05		; Offset to patch #75: 1303
	dc.b	$18,$05		; Offset to patch #76: 1304
	dc.b	$19,$05		; Offset to patch #77: 1305
	dc.b	$1A,$05		; Offset to patch #78: 1306
	dc.b	$41,$05		; Offset to patch #79: 1345
	dc.b	$68,$05		; Offset to patch #80: 1384
	dc.b	$69,$05		; Offset to patch #81: 1385
	dc.b	$6A,$05		; Offset to patch #82: 1386
	dc.b	$6B,$05		; Offset to patch #83: 1387
	dc.b	$6C,$05		; Offset to patch #84: 1388
	dc.b	$6D,$05		; Offset to patch #85: 1389
	dc.b	$6E,$05		; Offset to patch #86: 1390
	dc.b	$6F,$05		; Offset to patch #87: 1391
	dc.b	$70,$05		; Offset to patch #88: 1392
	dc.b	$71,$05		; Offset to patch #89: 1393
	dc.b	$72,$05		; Offset to patch #90: 1394
	dc.b	$73,$05		; Offset to patch #91: 1395
	dc.b	$74,$05		; Offset to patch #92: 1396
	dc.b	$75,$05		; Offset to patch #93: 1397
	dc.b	$76,$05		; Offset to patch #94: 1398
	dc.b	$77,$05		; Offset to patch #95: 1399
	dc.b	$78,$05		; Offset to patch #96: 1400
	dc.b	$79,$05		; Offset to patch #97: 1401
	dc.b	$7A,$05		; Offset to patch #98: 1402
	dc.b	$7B,$05		; Offset to patch #99: 1403
	dc.b	$A2,$05		; Offset to patch #100: 1442
	dc.b	$C9,$05		; Offset to patch #101: 1481
	dc.b	$CA,$05		; Offset to patch #102: 1482
	dc.b	$F1,$05		; Offset to patch #103: 1521
	dc.b	$18,$06		; Offset to patch #104: 1560
	dc.b	$3F,$06		; Offset to patch #105: 1599
	dc.b	$40,$06		; Offset to patch #106: 1600
	dc.b	$67,$06		; Offset to patch #107: 1639
	dc.b	$6E,$06		; Offset to patch #108: 1646
	dc.b	$95,$06		; Offset to patch #109: 1685
	dc.b	$9C,$06		; Offset to patch #110: 1692
	dc.b	$C3,$06		; Offset to patch #111: 1731
	dc.b	$EA,$06		; Offset to patch #112: 1770
	dc.b	$11,$07		; Offset to patch #113: 1809
	dc.b	$38,$07		; Offset to patch #114: 1848
	dc.b	$3F,$07		; Offset to patch #115: 1855
	dc.b	$66,$07		; Offset to patch #116: 1894
	dc.b	$8D,$07		; Offset to patch #117: 1933
	dc.b	$B4,$07		; Offset to patch #118: 1972
	dc.b	$DB,$07		; Offset to patch #119: 2011
	dc.b	$02,$08		; Offset to patch #120: 2050
	dc.b	$29,$08		; Offset to patch #121: 2089
	dc.b	$50,$08		; Offset to patch #122: 2128
	dc.b	$57,$08		; Offset to patch #123: 2135
	dc.b	$7E,$08		; Offset to patch #124: 2174
	dc.b	$A5,$08		; Offset to patch #125: 2213
	dc.b	$CC,$08		; Offset to patch #126: 2252
	dc.b	$F3,$08		; Offset to patch #127: 2291
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
* Patch 2 "<Unused #2>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 3 "<Unused #3>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
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
* Patch 6 "<Unused #6>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
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
* Patch 11 "<Unused #11>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 12 "<Unused #12>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 13 "Metal crash long decay": PSG Noise
	dc.b	3
	dc.b	$04,$FF,$0F,$00,$08,$08
* Patch 14 "<Unused #14>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 15 "<Unused #15>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
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
* Patch 20 "<Unused #20>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 21 "<Unused #21>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
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
* Patch 26 "<Unused #26>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 27 "<Unused #27>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 28 "<Unused #28>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 29 "<Unused #29>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 30 "<Unused #30>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 31 "<Unused #31>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 32 "<Unused #32>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
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
* Patch 37 "<Unused #37>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 38 "<Unused #38>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 39 "<Unused #39>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 40 "FIRE BREATHER": PSG Noise
	dc.b	3
	dc.b	$04,$1F,$04,$05,$04,$12
* Patch 41 "KNIFE THROW": PSG Noise
	dc.b	3
	dc.b	$04,$1F,$0F,$00,$1B,$18
* Patch 42 "KNIFE SPIN": PSG Noise
	dc.b	3
	dc.b	$04,$1F,$0F,$00,$1C,$18
* Patch 43 "BOMBS": PSG Noise
	dc.b	3
	dc.b	$06,$FF,$0E,$00,$06,$0F
* Patch 44 "<Unused #44>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
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
	dc.b	$00,$00,$3A,$C0,$01,$0F,$1F,$1F
	dc.b	$00,$06,$03,$22,$1F,$1F,$00,$06
	dc.b	$03,$1C,$1F,$1F,$00,$06,$01,$00
	dc.b	$11,$1F,$05,$08,$00,$00,$00,$00
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
* Patch 51 "<Unused #51>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 52 "<Unused #52>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 53 "<Unused #53>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 54 "MINI MOOG ": FM
	dc.b	0
	dc.b	$0A,$00,$24,$D4,$00,$0A,$9F,$04
	dc.b	$0D,$78,$31,$0C,$DF,$07,$1F,$BF
	dc.b	$71,$1A,$5F,$02,$05,$48,$00,$1D
	dc.b	$5F,$09,$00,$1F,$3F,$FF,$3F,$FF
	dc.b	$3F,$FF,$00,$00,$0F,$00
* Patch 55 "<Unused #55>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 56 "<Unused #56>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 57 "FeedbackGuitarsus.": FM
	dc.b	0
	dc.b	$02,$00,$25,$D0,$03,$07,$9E,$86
	dc.b	$03,$38,$03,$0E,$1E,$08,$00,$28
	dc.b	$12,$0C,$DE,$89,$06,$09,$61,$0B
	dc.b	$1F,$83,$07,$08,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 58 "<Unused #58>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 59 "<Unused #59>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 60 "<Unused #60>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 61 "<Unused #61>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 62 "<Unused #62>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 63 "<Unused #63>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 64 "<Unused #64>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 65 "Gong/Tam Tam ": FM
	dc.b	0
	dc.b	$0F,$00,$04,$F7,$1F,$00,$45,$01
	dc.b	$00,$0F,$70,$05,$9B,$03,$00,$50
	dc.b	$0A,$10,$4F,$01,$07,$0F,$70,$00
	dc.b	$19,$8B,$1F,$FF,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 66 "<Unused #66>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 67 "<Unused #67>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 68 "<Unused #68>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 69 "<Unused #69>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 70 "<Unused #70>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 71 "<Unused #71>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 72 "<Unused #72>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 73 "<Unused #73>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 74 "<Unused #74>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 75 "<Unused #75>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 76 "<Unused #76>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 77 "<Unused #77>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 78 "Log Drum": FM
	dc.b	0
	dc.b	$0B,$00,$3A,$C5,$31,$09,$9F,$18
	dc.b	$11,$5B,$01,$10,$5F,$17,$05,$BB
	dc.b	$31,$1B,$5F,$13,$06,$AB,$00,$0F
	dc.b	$5F,$05,$07,$2B,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 79 "Sleazy Snare": FM
	dc.b	0
	dc.b	$06,$00,$3D,$C5,$33,$03,$DF,$03
	dc.b	$11,$F5,$03,$04,$DF,$14,$14,$D8
	dc.b	$00,$09,$9F,$0C,$1F,$F8,$00,$08
	dc.b	$9F,$05,$10,$68,$1F,$35,$3F,$B7
	dc.b	$3F,$B6,$3F,$70,$0F,$00
* Patch 80 "<Unused #80>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 81 "<Unused #81>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 82 "<Unused #82>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 83 "<Unused #83>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 84 "<Unused #84>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 85 "<Unused #85>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 86 "<Unused #86>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 87 "<Unused #87>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 88 "<Unused #88>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 89 "<Unused #89>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 90 "<Unused #90>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 91 "<Unused #91>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 92 "<Unused #92>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 93 "<Unused #93>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 94 "<Unused #94>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 95 "<Unused #95>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 96 "<Unused #96>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 97 "<Unused #97>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 98 "<Unused #98>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 99 "BODYSOCK.FM ": FM
	dc.b	0
	dc.b	$0B,$00,$28,$C5,$73,$08,$1F,$19
	dc.b	$1F,$CF,$00,$0A,$1E,$13,$1F,$BF
	dc.b	$63,$04,$1F,$19,$1F,$AF,$01,$02
	dc.b	$1F,$0D,$1F,$8F,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 100 "Heavy Metal": FM
	dc.b	0
	dc.b	$0F,$00,$3A,$C4,$2A,$15,$1F,$8E
	dc.b	$02,$0D,$21,$18,$1F,$87,$02,$0D
	dc.b	$20,$03,$1F,$86,$02,$3D,$00,$0A
	dc.b	$1F,$84,$02,$FD,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0F,$00
* Patch 101 "<Unused #101>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 102 "Big explosion (FM)": FM
	dc.b	0
	dc.b	$0F,$00,$3A,$C7,$2A,$15,$1F,$8E
	dc.b	$02,$07,$21,$18,$1F,$87,$02,$03
	dc.b	$20,$03,$1F,$86,$02,$35,$00,$0E
	dc.b	$1F,$84,$02,$F4,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0F,$00
* Patch 103 "Electric 0": FM
	dc.b	0
	dc.b	$00,$16,$32,$C0,$15,$23,$0E,$0D
	dc.b	$00,$0F,$0E,$00,$10,$0C,$00,$BF
	dc.b	$02,$10,$1F,$00,$00,$0F,$07,$08
	dc.b	$0E,$0C,$00,$CF,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0F,$00
* Patch 104 "Spinning blade": FM
	dc.b	0
	dc.b	$0B,$00,$1C,$D0,$1F,$00,$0C,$81
	dc.b	$00,$06,$0A,$05,$8C,$83,$00,$06
	dc.b	$35,$14,$0C,$90,$00,$06,$76,$02
	dc.b	$0C,$90,$00,$07,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 105 "<Unused #105>": Unknown Type!
	dc.b	99		; unknown/undefined patch type
* Patch 106 "Catty": FM
	dc.b	0
	dc.b	$08,$00,$23,$C7,$71,$27,$15,$0F
	dc.b	$00,$F8,$32,$00,$09,$0D,$00,$FB
	dc.b	$01,$00,$09,$1F,$00,$0C,$31,$00
	dc.b	$10,$0D,$00,$F9,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 107 "Fireball": PSG Noise
	dc.b	3
	dc.b	$07,$1F,$00,$00,$FF,$15
* Patch 108 "Water Cannon": FM
	dc.b	0
	dc.b	$03,$00,$3C,$F7,$31,$00,$15,$0C
	dc.b	$00,$0A,$00,$02,$16,$0D,$00,$0A
	dc.b	$30,$00,$15,$0C,$00,$0A,$00,$07
	dc.b	$0E,$0D,$00,$4A,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 109 "Psg Crash": PSG Noise
	dc.b	3
	dc.b	$07,$1F,$0F,$00,$08,$08
* Patch 110 "Bomb Bounce": FM
	dc.b	0
	dc.b	$00,$16,$02,$C7,$15,$23,$19,$10
	dc.b	$00,$03,$0E,$00,$19,$0F,$00,$03
	dc.b	$02,$10,$19,$0F,$00,$03,$07,$00
	dc.b	$19,$10,$00,$F8,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0F,$00
* Patch 111 "Drop Mine ": FM
	dc.b	0
	dc.b	$0D,$00,$32,$F6,$00,$00,$1F,$15
	dc.b	$00,$F5,$05,$23,$1F,$0D,$0C,$F6
	dc.b	$09,$1D,$1F,$0C,$10,$F6,$0B,$00
	dc.b	$1E,$10,$14,$FA,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 112 "Sliding Block": FM
	dc.b	0
	dc.b	$08,$00,$39,$E0,$0B,$29,$19,$1F
	dc.b	$00,$0B,$00,$1D,$15,$0B,$00,$0B
	dc.b	$00,$05,$14,$04,$00,$0B,$00,$0A
	dc.b	$0E,$1C,$00,$0B,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0F,$00
* Patch 113 "Copy of Sliding Block": FM
	dc.b	0
	dc.b	$08,$00,$39,$E0,$07,$29,$19,$1F
	dc.b	$00,$0B,$00,$1D,$15,$0B,$00,$0B
	dc.b	$00,$05,$14,$04,$00,$0B,$00,$00
	dc.b	$19,$0B,$00,$F8,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0F,$00
* Patch 114 "Crackle": PSG Noise
	dc.b	3
	dc.b	$07,$FF,$00,$00,$FF,$15
* Patch 115 "Menu FM": FM
	dc.b	0
	dc.b	$00,$00,$38,$D0,$70,$00,$5F,$1F
	dc.b	$1F,$98,$74,$0D,$18,$08,$14,$30
	dc.b	$60,$00,$57,$1A,$1F,$6F,$76,$06
	dc.b	$1F,$1A,$09,$19,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0C,$00
* Patch 116 "Mach Gun FM": FM
	dc.b	0
	dc.b	$0B,$00,$28,$C5,$73,$08,$1F,$19
	dc.b	$1F,$CF,$00,$0A,$1E,$13,$1F,$BF
	dc.b	$63,$04,$1F,$19,$1F,$AF,$01,$00
	dc.b	$1F,$0C,$1F,$FF,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 117 "Motor cycle": FM
	dc.b	0
	dc.b	$00,$00,$02,$C0,$03,$13,$1F,$1F
	dc.b	$00,$0D,$09,$06,$1F,$1F,$00,$0E
	dc.b	$00,$00,$1F,$1F,$00,$0D,$00,$00
	dc.b	$1A,$1F,$00,$0E,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0F,$00
* Patch 118 "Skid": FM
	dc.b	0
	dc.b	$0E,$00,$00,$F7,$32,$10,$CE,$00
	dc.b	$00,$08,$32,$14,$9F,$0C,$00,$08
	dc.b	$72,$16,$9F,$13,$00,$08,$12,$00
	dc.b	$CC,$0D,$00,$0F,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 119 "Cat wail": FM
	dc.b	0
	dc.b	$0A,$00,$22,$C5,$21,$14,$0E,$89
	dc.b	$0B,$07,$23,$28,$18,$89,$07,$0A
	dc.b	$31,$04,$1B,$88,$0B,$09,$14,$08
	dc.b	$14,$8B,$0A,$0A,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 120 "Pendulum swish patch": FM
	dc.b	0
	dc.b	$0F,$00,$3A,$C0,$03,$00,$0D,$8D
	dc.b	$02,$06,$0F,$26,$0B,$8D,$13,$F7
	dc.b	$0D,$28,$12,$8D,$02,$F7,$02,$00
	dc.b	$0B,$8F,$1F,$F8,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0F,$00
* Patch 121 "Spinning blade": FM
	dc.b	0
	dc.b	$0B,$00,$1C,$D0,$1F,$00,$0C,$81
	dc.b	$00,$08,$0A,$05,$8C,$83,$00,$08
	dc.b	$35,$14,$0C,$90,$00,$09,$76,$14
	dc.b	$0C,$90,$00,$09,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 122 "PSG Chiff 1": PSG Noise
	dc.b	3
	dc.b	$07,$FF,$0F,$00,$07,$FF
* Patch 123 "Buzzy Saw": FM
	dc.b	0
	dc.b	$08,$16,$32,$C6,$15,$23,$0E,$0D
	dc.b	$00,$0F,$0E,$00,$10,$1F,$00,$0F
	dc.b	$02,$10,$1F,$11,$00,$0F,$07,$00
	dc.b	$0E,$1F,$00,$0F,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0F,$00
* Patch 124 "Droplet": FM
	dc.b	0
	dc.b	$0B,$00,$39,$C0,$05,$14,$19,$98
	dc.b	$00,$F9,$30,$2B,$57,$8C,$0A,$F9
	dc.b	$55,$21,$5A,$8C,$04,$F9,$30,$00
	dc.b	$55,$93,$1F,$CA,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 125 "Penguin Voice": FM
	dc.b	0
	dc.b	$03,$00,$24,$C1,$70,$00,$0E,$9F
	dc.b	$05,$0F,$20,$00,$0E,$1F,$06,$0F
	dc.b	$74,$0A,$0E,$9F,$00,$0F,$12,$0A
	dc.b	$0E,$9F,$00,$0F,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 126 "Batmobile low end": FM
	dc.b	0
	dc.b	$08,$00,$3A,$E0,$59,$1E,$19,$1F
	dc.b	$00,$0B,$72,$1D,$15,$0B,$00,$0B
	dc.b	$20,$09,$14,$04,$00,$0B,$30,$00
	dc.b	$0E,$1C,$00,$0B,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0F,$00
* Patch 127 "Another Digital": DIG
	dc.b	1
	dc.b	$04

		ENDIF

; End of Z80 Patch data
;*****************************************************************************			

;*****************************************************************************			
; Start of 68K Patch + Sequence + Sample data

		IF	AUDIO_SUB

INIT_USER_VARS	rts
		
PCH_BANK	dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	0+Z80PATCH
		dc.b	0
		dc.b	127
;patch01
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	1+Z80PATCH	
		dc.b	0
		dc.b	0
;patch02
		dc.b	1		;bang0
		dc.b	0
		dc.w	0
		dc.w	WAVE_E01-WAVE_S01
		dc.w	WAVE_E01-WAVE_S01
		dc.b	eADSR02
		dc.b	64
		dc.b	120
		dc.b	17+Z80PATCH
    		dc.b	0	
		dc.b	110
;patch03
		dc.b	1		;bang0
		dc.b	0
		dc.w	0
		dc.w	WAVE_E01-WAVE_S01
		dc.w	WAVE_E01-WAVE_S01
		dc.b	eADSR00
		dc.b	64
		dc.b	127
		dc.b	0
		dc.b	0
		dc.b	0

;patch04
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	4+Z80PATCH
		dc.b	0
		dc.b	127
;patch05
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	5+Z80PATCH
		dc.b	0
		dc.b	127
;patch06
		dc.b	$80
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
;patch07
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	7+Z80PATCH
		dc.b	0
		dc.b	127
;patch08
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	8+Z80PATCH
		dc.b	0
		dc.b	127

;patch09
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	9+Z80PATCH
		dc.b	36
		dc.b	127

;Patch 10 (Explosion 0)
		dc.b	9
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E09-WAVE_S09
		dc.b	eADSR00
		dc.b	64
		dc.b	127
		dc.b	0
		dc.b	0
		dc.b	0
;patch11
		dc.b	$80
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

;patch12
		dc.b	$80
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

;patch13
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	13+Z80PATCH
		dc.b	0
		dc.b	127

;patch14
		dc.b	$80
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

;patch15
		dc.b	$80
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

;patch16
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	16+Z80PATCH
		dc.b	0
		dc.b	127

;patch17
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	17+Z80PATCH
		dc.b	0
		dc.b	127

;patch18
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	18+Z80PATCH
		dc.b	0
		dc.b	127

;patch19
		dc.b	4
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E04-WAVE_S04
		dc.b	eADSR07
		dc.b	64
		dc.b	117
		dc.b	0
		dc.b	0
		dc.b	0

;patch20
		dc.b	$80
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

;patch21
		dc.b	$80
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

;patch22
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	22+Z80PATCH
		dc.b	0
		dc.b	127

;patch23
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	23+Z80PATCH
		dc.b	0
		dc.b	127

;patch24
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	24+Z80PATCH
		dc.b	0
		dc.b	127

;patch25
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	25+Z80PATCH
		dc.b	0
		dc.b	127

;patch26
		dc.b	$80
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

;patch27
		dc.b	$80
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

;patch28
		dc.b	$80
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

;patch29
		dc.b	$80
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

;patch30
		dc.b	$80
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

;patch31
		dc.b	10
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E10-WAVE_S10
		dc.b	eADSR01
		dc.b	64
		dc.b	115
		dc.b	0
		dc.b	0
		dc.b	0
;patch32
		dc.b	$80
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
;patch33
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	33+Z80PATCH
		dc.b	0
		dc.b	127
;patch34
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	34+Z80PATCH
		dc.b	0
		dc.b	127
;patch35
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	35+Z80PATCH
		dc.b	0
		dc.b	127
;patch36
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	36+Z80PATCH
		dc.b	0
		dc.b	127

;patch37
		dc.b	$80
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
;patch38
		dc.b	$80
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

;patch39
		dc.b	$80
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

;patch40
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	40+Z80PATCH
		dc.b	0
		dc.b	127

;patch41
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	41+Z80PATCH
		dc.b	0
		dc.b	127

;patch42
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	42+Z80PATCH
		dc.b	0
		dc.b	127

;patch43
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	43+Z80PATCH
		dc.b	0
		dc.b	127

;patch44
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	44+Z80PATCH
		dc.b	0
		dc.b	127

;patch45
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	45+Z80PATCH
		dc.b	0
		dc.b	127

;patch46
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	46+Z80PATCH
		dc.b	0
		dc.b	127

;patch47
		dc.b	1		;bang0
		dc.b	0
		dc.w	0
		dc.w	WAVE_E01-WAVE_S01
		dc.w	WAVE_E01-WAVE_S01
		dc.b	eADSR00
		dc.b	64
		dc.b	127
		dc.b	47+Z80PATCH
		dc.b	24
		dc.b	112

;patch48
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	48+Z80PATCH
		dc.b	0
		dc.b	127

;patch49
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	49+Z80PATCH
		dc.b	0
		dc.b	120

;patch50
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	50+Z80PATCH
		dc.b	0
		dc.b	127

;patch51
		dc.b	$80
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

;patch52
		dc.b	$80
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

;patch53
		dc.b	$80
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

;patch54
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	54+Z80PATCH
		dc.b	0
		dc.b	127

;patch55
		dc.b	$80
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

;patch56
		dc.b	$80
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

;patch57
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	57+Z80PATCH
		dc.b	0
		dc.b	127

;patch58
		dc.b	$80
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

;patch59
		dc.b	$80
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

;patch60
		dc.b	$80
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

;patch61
		dc.b	$80
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

;patch62
		dc.b	$80
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

;patch63
		dc.b	$80
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

;patch64
		dc.b	$80
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

;patch65
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	65+Z80PATCH
		dc.b	0
		dc.b	127

;patch66
		dc.b	$80
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

;patch67
		dc.b	$80
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

;patch68
		dc.b	$80
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

;patch69
		dc.b	$80
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

;patch70
		dc.b	$80
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

;patch71
		dc.b	$80
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

;patch72
		dc.b	$80
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

;patch73
		dc.b	$80
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

;patch74
		dc.b	$80
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

;patch75
		dc.b	$80
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

;patch76
		dc.b	$80
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

;patch77
		dc.b	$80
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

;patch78
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	78+Z80PATCH
		dc.b	0
		dc.b	127

;patch79
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	79+Z80PATCH
		dc.b	0
		dc.b	127

;patch80 (Dig 0)
		dc.b	$80
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

;patch81 (Dig 1)
		dc.b	$80
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

;patch82 (Dig 2 BMHIT)
		dc.b	2
		dc.b	0
		dc.w	0
		dc.w	WAVE_E02-WAVE_S02
		dc.w	WAVE_E02-WAVE_S02
		dc.b	eADSR00
		dc.b	64
		dc.b	127
		dc.b	0
		dc.b	0
		dc.b	0

;patch83 (Dig 2)
		dc.b	2
		dc.b	0
		dc.w	0
		dc.w	WAVE_E02-WAVE_S02
		dc.w	WAVE_E02-WAVE_S02
		dc.b	eADSR00
		dc.b	64
		dc.b	127
		dc.b	50+Z80PATCH
		dc.b	20
		dc.b	110


;patch84 (Dig 4 - Punch)
		dc.b	0
		dc.b	0
		dc.w	0
		dc.w	WAVE_E00-WAVE_S00
		dc.w	WAVE_E00-WAVE_S00
		dc.b	eADSR00
		dc.b	64
		dc.b	123
		dc.b	0
		dc.b	0
		dc.b	0

;patch85 (Dig 5 - CWHIT0)
		dc.b	5
		dc.b	0
		dc.w	0
		dc.w	WAVE_E05-WAVE_S05
		dc.w	WAVE_E05-WAVE_S05
		dc.b	eADSR03
		dc.b	64
		dc.b	127
		dc.b	0
		dc.b	0
		dc.b	0

;patch86 (Dig 6 - THUD)
		dc.b	6
		dc.b	0
		dc.w	0
		dc.w	WAVE_E06-WAVE_S06
		dc.w	WAVE_E06-WAVE_S06
		dc.b	eADSR00
		dc.b	64
		dc.b	127
		dc.b	0
		dc.b	0
		dc.b	0

;patch87
		dc.b	3
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E03-WAVE_S03
		dc.b	eADSR00
		dc.b	64
		dc.b	127
		dc.b	0
		dc.b	0
		dc.b	0

;patch88 (Batmobile Turbine noise)
		dc.b	4
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E04-WAVE_S04
		dc.b	eADSR05
		dc.b	64
		dc.b	48
		dc.b	48+Z80PATCH
		dc.b	40
		dc.b	100


;patch89 (Batmobile Skid)
		dc.b	10
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E10-WAVE_S10
		dc.b	eADSR06
		dc.b	64
		dc.b	127
		dc.b	0
		dc.b	0
		dc.b	0

;patch90 (Motorcycle)
		dc.b	7
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E07-WAVE_S07
		dc.b	eADSR00
		dc.b	64
		dc.b	127
		dc.b	0
		dc.b	0
		dc.b	0

;patch91 (for SAW)
		dc.b	4
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E04-WAVE_S04
		dc.b	eADSR00
		dc.b	64
		dc.b	127
		dc.b	0
		dc.b	0
		dc.b	0

;patch92
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	9+Z80PATCH
		dc.b	0
		dc.b	127

;patch93
		dc.b	$80
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

;patch94
		dc.b	$80
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

;patch95
		dc.b	$80
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

;patch96
		dc.b	$80
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

;patch97
		dc.b	$80
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

;patch98
		dc.b	$80
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

;patch99
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	99+Z80PATCH
		dc.b	0
		dc.b	127

;patch100
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	100+Z80PATCH
		dc.b	0
		dc.b	127

;patch101
		dc.b	$80
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

;patch102
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	102+Z80PATCH
		dc.b	0
		dc.b	127

;patch103
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	103+Z80PATCH
		dc.b	0
		dc.b	127

;patch104
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	104+Z80PATCH
		dc.b	0
		dc.b	127

;patch105
		dc.b	$80
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

;patch106
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	106+Z80PATCH
		dc.b	0
		dc.b	127

;patch107
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	107+Z80PATCH
		dc.b	0
		dc.b	127

;patch108
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	108+Z80PATCH
		dc.b	0
		dc.b	127

;patch109
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	109+Z80PATCH
		dc.b	0
		dc.b	127

;patch110
		dc.b	6
		dc.b	0
		dc.w	0
		dc.w	WAVE_E06-WAVE_S06
		dc.w	WAVE_E06-WAVE_S06
		dc.b	eADSR00
		dc.b	64
		dc.b	120
		dc.b	110+Z80PATCH
		dc.b	0
		dc.b	127

;patch111
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	111+Z80PATCH
		dc.b	0
		dc.b	127

;patch112
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	112+Z80PATCH
		dc.b	0
		dc.b	127

;patch113
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	113+Z80PATCH
		dc.b	0
		dc.b	127

;patch114
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	114+Z80PATCH
		dc.b	0
		dc.b	127

;patch115
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	115+Z80PATCH
		dc.b	0
		dc.b	120

;patch116
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	116+Z80PATCH
		dc.b	0
		dc.b	127

;patch117
		dc.b	7	;Motorbike
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	WAVE_E07-WAVE_S07
		dc.b	eADSR00
		dc.b	64
		dc.b	110
		dc.b	0
		dc.b	0
		dc.b	0

;patch118
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	118+Z80PATCH
		dc.b	0
		dc.b	127

;patch119
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	119+Z80PATCH
		dc.b	0
		dc.b	127

;patch120
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	120+Z80PATCH
		dc.b	0
		dc.b	127

;patch121
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	121+Z80PATCH
		dc.b	0
		dc.b	127

;patch122
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	122+Z80PATCH
		dc.b	0
		dc.b	127

;patch123
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	123+Z80PATCH
		dc.b	0
		dc.b	127

;patch124
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	124+Z80PATCH
		dc.b	0
		dc.b	127

;patch125
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	125+Z80PATCH
		dc.b	0
		dc.b	127

;patch126
		dc.b	$80
		dc.b	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.b	eADSR00
		dc.b	0
		dc.b	0
		dc.b	126+Z80PATCH
		dc.b	0
		dc.b	127

;patch127
		dc.b	$80
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

;*********************************************************			
;
; ADSR ENVELOPE BANK 
;
;*********************************************************			

ADSR00		dc.b	255,0,255,0,255,255,0,10
ADSR01		dc.b	255,10,255,0,255,255,0,10
ADSR02		dc.b	255,8,255,0,255,255,0,12
ADSR03		dc.b	255,1,255,0,255,255,0,20
ADSR04		dc.b	255,0,255,0,255,255,0,10
ADSR05		dc.b	255,0,255,0,255,255,0,40
ADSR06		dc.b	255,20,255,0,255,255,0,20
ADSR07		dc.b	255,5,255,0,255,255,0,2

PBMacros	dc.w	PBM00-PBMacros
		dc.w	PBM01-PBMacros
		dc.w	PBM02-PBMacros
		dc.w	PBM03-PBMacros
		dc.w	PBM04-PBMacros
		dc.w	PBM05-PBMacros
		dc.w	PBM06-PBMacros
		dc.w	PBM07-PBMacros

PBM00		dc.w	$2000
		dc.w	0,8000
		dc.w	0,-8000
		dc.w	10,150
		dc.w	30,-80
		dc.w	-1

PBM01		dc.w	$2000
		dc.w	40,240
		dc.w	-1

PBM02		dc.w	$2000
		dc.w	40,-240
		dc.w	-1

PBM03		dc.w	$2000
		dc.w	3,400
		dc.w	10,-500
		dc.w	-1

		dc.w	4,200
		dc.w	4,-200
		dc.w	-1

PBM04		dc.w	$2000
		dc.w	3,140
		dc.w	100,-90
		dc.w	-1

PBM05		dc.w	$2000
		dc.w	100,-30
		dc.w	160,0
		dc.w	-1

PBM06		dc.w	$2000
		dc.w	300,30
		dc.w	-1

PBM07		dc.w	$2000
		dc.w	10,300
		dc.w	120,-90
		dc.w	-1



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



WAVE_S00	incbin	"..\cdad\PUNCH1.CD8"		;1
WAVE_E00
		EVEN
WAVE_S01	incbin	"..\cdad\BANG1.CD8"		;4
WAVE_E01
		EVEN
WAVE_S02	incbin	"..\cdad\BMHIT0.CD8"		;2
WAVE_E02
		EVEN
WAVE_S03	incbin	"..\cdad\GIGGLE0.CD8"		;2
WAVE_E03
		EVEN
WAVE_S04	incbin	"..\cdad\JET2.CD8"		;2
WAVE_E04
		EVEN
WAVE_S05	incbin	"..\cdad\CWHIT0.CD8"		;2
WAVE_E05
		EVEN
WAVE_S06	incbin	"..\cdad\THUD.CD8"		;1
WAVE_E06
		EVEN
WAVE_S07	incbin	"..\cdad\BATMOB3.CD8"		;2
WAVE_E07
		EVEN
WAVE_S08	incbin	"..\cdad\CLANG0.CD8"		;4
WAVE_E08
		EVEN
WAVE_S09	incbin	"..\cdad\EXPLOD2.CD8"		;4 BLK.
WAVE_E09
		EVEN
WAVE_S10	incbin	"..\cdad\SKID2.CD8"		;2 BLK
WAVE_E10
		EVEN
							;26

;*****************************************************************************			
;
;			SYSEX Lists
;
;*****************************************************************************			

		EVEN
SysExTAB	dc.l	SX00	;Each entry here represents
		dc.l	0	;a game level and points to
				;list of Source Wave #s to load

SX00		dc.b	0,1,2,3,4,5,6,7,8,9,10,-1
		EVEN	

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

		EVEN

SFX_INSTTAB	dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
		dc.b	1,2,1,2,2,2,2,2,2,2,2,2,2,2,2,2
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
		dc.w	SFX_S91-SFX_ADDR_TAB
		dc.w	SFX_S92-SFX_ADDR_TAB
		dc.w	SFX_S93-SFX_ADDR_TAB
		dc.w	SFX_S94-SFX_ADDR_TAB
		dc.w	SFX_S95-SFX_ADDR_TAB
		dc.w	SFX_S96-SFX_ADDR_TAB
		dc.w	SFX_S97-SFX_ADDR_TAB
		dc.w	SFX_S98-SFX_ADDR_TAB
		dc.w	SFX_S99-SFX_ADDR_TAB
		dc.w	SFX_S100-SFX_ADDR_TAB
		dc.w	SFX_S101-SFX_ADDR_TAB
		dc.w	SFX_S102-SFX_ADDR_TAB
		dc.w	SFX_S103-SFX_ADDR_TAB
		dc.w	SFX_S104-SFX_ADDR_TAB
		dc.w	SFX_S105-SFX_ADDR_TAB
		dc.w	SFX_S106-SFX_ADDR_TAB
		dc.w	SFX_S107-SFX_ADDR_TAB
		dc.w	SFX_S108-SFX_ADDR_TAB
		dc.w	SFX_S109-SFX_ADDR_TAB
		dc.w	SFX_S110-SFX_ADDR_TAB
		dc.w	SFX_S111-SFX_ADDR_TAB
		dc.w	SFX_S112-SFX_ADDR_TAB
		dc.w	SFX_S113-SFX_ADDR_TAB
		dc.w	SFX_S114-SFX_ADDR_TAB
		dc.w	SFX_S115-SFX_ADDR_TAB
		dc.w	SFX_S116-SFX_ADDR_TAB
		dc.w	SFX_S117-SFX_ADDR_TAB
		dc.w	SFX_S118-SFX_ADDR_TAB
		dc.w	SFX_S119-SFX_ADDR_TAB
		dc.w	SFX_S120-SFX_ADDR_TAB
		dc.w	SFX_S121-SFX_ADDR_TAB
		dc.w	SFX_S122-SFX_ADDR_TAB
		dc.w	SFX_S123-SFX_ADDR_TAB
		dc.w	SFX_S124-SFX_ADDR_TAB
		dc.w	SFX_S125-SFX_ADDR_TAB
		dc.w	SFX_S126-SFX_ADDR_TAB
		dc.w	SFX_S127-SFX_ADDR_TAB

SFX_S00		dc.b	1-1
		dc.w	sfx0a-SFX_S00
sfx0a		dc.b	0,META,EOTRK,0

SFX_S01		dc.b	1-1
		dc.w	sfx1a-SFX_S01
sfx1a		dc.b	0,META,EOTRK,0

SFX_S02		dc.b	1-1
		dc.w	sfx2a-SFX_S02
sfx2a		dc.b	0,META,EOTRK,0

SFX_S03		dc.b	1-1
		dc.w	sfx3a-SFX_S03
sfx3a		dc.b	0,META,EOTRK,0

SFX_S04		dc.b	1-1
		dc.w	sfx4a-SFX_S04
sfx4a		dc.b	0,META,EOTRK,0

SFX_S05		dc.b	1-1
		dc.w	sfx5a-SFX_S05
sfx5a		dc.b	0,META,EOTRK,0

SFX_S06		dc.b	1-1
		dc.w	sfx6a-SFX_S06
sfx6a		dc.b	0,META,EOTRK,0

SFX_S07		dc.b	1-1
		dc.w	sfx7a-SFX_S07
sfx7a		dc.b	0,META,EOTRK,0

SFX_S08		dc.b	1-1
		dc.w	sfx8a-SFX_S08
sfx8a		dc.b	0,META,EOTRK,0

SFX_S09		dc.b	1-1
		dc.w	sfx9a-SFX_S09
sfx9a		dc.b	0,META,EOTRK,0

SFX_S10		dc.b	1-1
		dc.w	sfx10a-SFX_S10
sfx10a		dc.b	0,META,EOTRK,0

SFX_S11		dc.b	1-1
		dc.w	sfx11a-SFX_S11
sfx11a		dc.b	0,META,EOTRK,0

SFX_S12		dc.b	1-1
		dc.w	sfx12a-SFX_S12
sfx12a		dc.b	0,META,EOTRK,0

SFX_S13		dc.b	1-1
		dc.w	sfx13a-SFX_S13
sfx13a		dc.b	0,META,EOTRK,0

SFX_S14		dc.b	1-1
		dc.w	sfx14a-SFX_S14
sfx14a		dc.b	0,META,EOTRK,0

SFX_S15		dc.b	1-1
		dc.w	sfx15a-SFX_S15
sfx15a		dc.b	0,META,EOTRK,0

SFX_S16		dc.b	1-1
		dc.w	sfx16a-SFX_S16
sfx16a		dc.b	0,META,EOTRK,0

SFX_S17		dc.b	1-1
		dc.w	sfx17a-SFX_S17
sfx17a		dc.b	0,META,EOTRK,0

SFX_S18		dc.b	1-1
		dc.w	sfx18a-SFX_S18
sfx18a		dc.b	0,META,EOTRK,0

SFX_S19		dc.b	1-1
		dc.w	sfx19a-SFX_S19
sfx19a		dc.b	0,PRGM,86
		dc.b	0,CTRL,VOLM,127
		dc.b	0,NTON,G10
		dc.b	24,NTOF,G10
		dc.b	0,META,EOTRK,0

SFX_S20		dc.b	1-1
		dc.w	sfx20a-SFX_S20
sfx20a		dc.b	0,PRGM,40
		dc.b	1,CTRL,VOLM,127
		dc.b	1,NTON,A30
		dc.b	50,NTOF,A30
		dc.b	2,META,EOTRK,0

SFX_S21		dc.b	1-1
		dc.w	sfx21a-SFX_S21
sfx21a		dc.b	0,PRGM,41
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,C40,24,NTOF,C40
		dc.b	11,META,EOTRK,0

SFX_S22		dc.b	1-1
		dc.w	sfx22a-SFX_S22
sfx22a		dc.b	0,PRGM,41
		dc.b	0,CTRL,VOLM,127
		dc.b	0,NTON,C40
		dc.b	24,NTOF,C40
		dc.b	0,META,EOTRK,0

SFX_S23		dc.b	1-1
		dc.w	sfx23a-SFX_S23
sfx23a		dc.b	0,PRGM,43
		dc.b	0,NTON,C40,6,NTOF,C40
		dc.b	0,PRGM,47
		dc.b	0,NTON,C40,10,NTOF,C40
		dc.b	0,META,EOTRK,0

SFX_S24		dc.b	1-1
		dc.w	sfx24a-SFX_S24
sfx24a		dc.b	0,PRGM,116
		dc.b	0,CTRL,VOLM,122
		dc.b	0,NTON,F20,2,NTOF,F20
		dc.b	0,NTON,B20,1,NTOF,B20
		dc.b	0,PRGM,122
		dc.b	0,NTON,E60,2,NTOF,E60
		dc.b	0,NTON,G60,2,NTOF,G60
		dc.b	1,NTON,F70,24,NTOF,F70
		dc.b	0,META,EOTRK,0

SFX_S25		dc.b	1-1
		dc.w	sfx25a-SFX_S25
sfx25a		dc.b	0,PRGM,45
		dc.b	0,NTON,C40,4,NTOF,C40
		dc.b	0,META,EOTRK,0

SFX_S26		dc.b	1-1
		dc.w	sfx26a-SFX_S26
sfx26a		dc.b	0,PRGM,117
		dc.b	0,NTON,A40
		dc.b	2,META,SS,PBM,0
		dc.b	50,NTOF,A40
		dc.b	11,META,EOTRK,0

SFX_S27		dc.b	1-1
		dc.w	sfx27a-SFX_S27
sfx27a		dc.b	0,PRGM,44
		dc.b	0,NTON,C40,72,NTOF,C40
		dc.b	2,META,EOTRK,0

SFX_S28		dc.b	1-1
		dc.w	sfx28a-SFX_S28
sfx28a		dc.b	0,PRGM,46
		dc.b	0,NTON,C40,24,NTOF,C40
		dc.b	0,META,EOTRK,0

SFX_S29		dc.b	1-1
		dc.w	sfx29a-SFX_S29
sfx29a		dc.b	0,PRGM,22
		dc.b	0,CTRL,VOLM,121
		dc.b	0,NTON,A6S,1,NTOF,A6S
		dc.b	2,NTON,F60,5,NTOF,F60
		dc.b	0,NTON,C70,3,NTOF,C70		
		dc.b	0,META,EOTRK,0

SFX_S30		dc.b	1-1
		dc.w	sfx30a-SFX_S30
sfx30a		dc.b	0,PRGM,49
		dc.b	0,NTON,C40,24,NTOF,C40
		dc.b	0,META,EOTRK,0

SFX_S31		dc.b	1-1
		dc.w	sfx31a-SFX_S31
sfx31a		dc.b	0,PRGM,47
		dc.b	0,NTON,C20
		dc.b	6,CTRL,PANM,0
		dc.b	6,CTRL,PANM,64
		dc.b	6,CTRL,PANM,127
		dc.b	6,CTRL,PANM,64
		dc.b	6,NTOF,C20
		dc.b	0,META,EOTRK,0

SFX_S32		dc.b	1-1
       		dc.w	sfx32a-SFX_S32
sfx32a		dc.b	0,PRGM,50
		dc.b	1,CTRL,VOLM,100
		dc.b	1,NTON,C40,9,NTOF,C40
		dc.b	1,PRGM,83
		dc.b	1,CTRL,VOLM,40
		dc.b	1,NTON,E10
		dc.b	1,META,SS,PBM,2
		dc.b	30,NTOF,E10
		dc.b	11,META,EOTRK,0

SFX_S33		dc.b	1-1
		dc.w	sfx33a-SFX_S33
sfx33a		dc.b	0,META,EOTRK,0

SFX_S34		dc.b	1-1
		dc.w	sfx34a-SFX_S34
sfx34a		dc.b	0,PRGM,111
		dc.b	1,CTRL,VOLM,118
		dc.b	0,NTON,C20,3,NTOF,C20
		dc.b	2,NTON,B30,2,NTOF,B30
		dc.b	1,NTON,F10,2,NTOF,F10
		dc.b	2,META,EOTRK,0

SFX_S35		dc.b	1-1
		dc.w	sfx35a-SFX_S35
sfx35a		dc.b	0,PRGM,111
		dc.b	0,NTON,B10,6,NTOF,B10
		dc.b	0,NTON,G10,2,NTOF,G10
		dc.b	0,PRGM,45
		dc.b	0,NTON,C40,4,NTOF,C40
		dc.b	0,META,EOTRK,0

SFX_S36		dc.b	1-1
		dc.w	sfx36a-SFX_S36
sfx36a		dc.b	0,PRGM,84		;PUNCH used as KICK
		dc.b	1,CTRL,VOLM,117
		dc.b	0,NTON,A00,10,NTOF,A00
		dc.b	11,META,EOTRK,0

SFX_S37		dc.b	1-1
		dc.w	sfx37a-SFX_S37
sfx37a		dc.b	0,PRGM,7
		dc.b	0,CTRL,VOLM,121
		dc.b	0,NTON,C50,0,NTON,D4S
		dc.b	2,NTOF,C50,3,NTOF,D4S
		dc.b	0,META,EOTRK,0

SFX_S38		dc.b	1-1
		dc.w	sfx38a-SFX_S38
sfx38a		dc.b	0,PRGM,18
		dc.b	0,NTON,G2S,1,NTOF,G2S
		dc.b	2,PRGM,16
		dc.b	0,NTON,D4S,2,NTOF,D4S
		dc.b	0,META,EOTRK,0

SFX_S39		dc.b	1-1
		dc.w	sfx39a-SFX_S39
sfx39a		dc.b	0,PRGM,4
		dc.b	0,NTON,C40,24,NTOF,C40
		dc.b	0,META,EOTRK,0

SFX_S40		dc.b	1-1
		dc.w	sfx40a-SFX_S40
sfx40a		dc.b	0,PRGM,116
		dc.b	0,NTON,G20,4,NTOF,G20
		dc.b	2,CTRL,VOLM,110
		dc.b	0,NTON,F20,4,NTOF,F20
		dc.b	0,META,EOTRK,0

SFX_S41		dc.b	1-1
		dc.w	sfx41a-SFX_S41
sfx41a		dc.b	0,PRGM,84		;PUNCH
		dc.b	0,CTRL,VOLM,127
		dc.b	0,NTON,C20,4,NTOF,C20
		dc.b	0,META,EOTRK,0

SFX_S42		dc.b	1-1
		dc.w	sfx42a-SFX_S42
sfx42a		dc.b	0,PRGM,89
		dc.b	1,CTRL,VOLM,115
		dc.b	1,NTON,G20
		dc.b	1,META,SS,PBM,6
		dc.b	14,NTOF,G20
		dc.b	11,META,EOTRK,0

SFX_S43		dc.b	1-1
		dc.w	sfx43a-SFX_S43
sfx43a		dc.b	0,PRGM,17
		dc.b	0,NTON,G2S,15,NTOF,G2S
		dc.b	0,META,EOTRK,0

SFX_S44		dc.b	2-1
		dc.w	sfx44a-SFX_S44
		dc.w	sfx44b-SFX_S44
sfx44a		dc.b	0,PRGM,9
		dc.b	0,NTON,A10,12,NTOF,A10
		dc.b	0,PRGM,13
		dc.b	0,NTON,C40,24,NTOF,C40
		dc.b	0,META,EOTRK,0
sfx44b		dc.b	0,PRGM,16
		dc.b	11,NTON,G20,1,NTOF,G20
		dc.b	1,NTON,C30,24,NTOF,C30
		dc.b	0,META,EOTRK,0

SFX_S45		dc.b	1-1
		dc.w	sfx45a-SFX_S45
sfx45a		dc.b	0,PRGM,9
		dc.b	0,CTRL,VOLM,127
		dc.b	0,NTON,E30,4,NTOF,E30
		dc.b	0,PRGM,18
		dc.b	0,NTON,A10,6,NTOF,A10
		dc.b	0,META,EOTRK,0

SFX_S46		dc.b	1-1
		dc.w	sfx46a-SFX_S46
sfx46a		dc.b	0,PRGM,19
		dc.b	1,CTRL,VOLM,127
		dc.b	1,NTON,F40
		dc.b	1,META,SS,PBM,3
		dc.b	10,NTOF,F40
		dc.b	5,META,EOTRK,0

SFX_S47		dc.b	1-1
		dc.w	sfx47a-SFX_S47
sfx47a		dc.b	0,META,EOTRK,0

SFX_S48		dc.b	1-1
		dc.w	sfx48a-SFX_S48
sfx48a		dc.b	0,PRGM,85
		dc.b	1,CTRL,VOLM,127
		dc.b	1,NTON,G2S,120,NTOF,G2S
		dc.b	13,META,EOTRK,0

SFX_S49		dc.b	1-1
		dc.w	sfx49a-SFX_S49
sfx49a		dc.b	0,META,EOTRK,0

SFX_S50		dc.b	1-1
		dc.w	sfx50a-SFX_S50
sfx50a		dc.b	0,PRGM,84
		dc.b	1,CTRL,VOLM,127
		dc.b	1,NTON,C10,1,NTOF,C10
		dc.b	2,PRGM,85
		dc.b	1,NTON,B20,120,NTOF,B20
		dc.b	13,META,EOTRK,0

SFX_S51		dc.b	1-1
		dc.w	sfx51a-SFX_S51
sfx51a		dc.b	0,META,EOTRK,0

SFX_S52		dc.b	1-1
		dc.w	sfx52a-SFX_S52
sfx52a		dc.b	0,META,EOTRK,0

SFX_S53		dc.b	1-1
		dc.w	sfx53a-SFX_S53
sfx53a		dc.b	0,PRGM,17
		dc.b	1,CTRL,VOLM,125
		dc.b	0,NTON,C40,2,NTOF,C40
		dc.b	2,PRGM,103
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,D30
		dc.b	1,META,SS,PBM,2
		dc.b	26,NTOF,D30
		dc.b	11,META,EOTRK,0

SFX_S54		dc.b	1-1
		dc.w	sfx54a-SFX_S54
sfx54a		dc.b	0,PRGM,3
		dc.b	1,CTRL,VOLM,100
		dc.b	0,NTON,A20,11,NTOF,A20
		dc.b	11,META,EOTRK,0

SFX_S55		dc.b	1-1
		dc.w	sfx55a-SFX_S55
sfx55a		dc.b	0,PRGM,107
		dc.b	0,NTON,G5S,4,NTOF,G5S
		dc.b	0,META,EOTRK,0

SFX_S56		dc.b	1-1
		dc.w	sfx56a-SFX_S56
sfx56a		dc.b	0,PRGM,108
		dc.b	0,CTRL,VOLM,112
		dc.b	0,NTON,C00,9,NTOF,C00
		dc.b	0,NTON,C2S,42,NTOF,C2S
		dc.b	0,META,EOTRK,0

SFX_S57		dc.b	1-1
		dc.w	sfx57a-SFX_S57
sfx57a		dc.b	0,META,EOTRK,0

SFX_S58		dc.b	1-1
		dc.w	sfx58a-SFX_S58
sfx58a		dc.b	0,PRGM,99
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,C3S,2,NTOF,C3S
		dc.b	0,PRGM,102
		dc.b	1,CTRL,VOLM,124
		dc.b	0,NTON,C10,5,NTOF,C10
		dc.b	1,PRGM,18
		dc.b	1,CTRL,VOLM,122
		dc.b	1,NTON,D1S,3,NTOF,D1S
		dc.b	0,NTON,C2S,7,NTOF,C2S
		dc.b	0,NTON,F0S,4,NTOF,F0S
		dc.b	0,PRGM,16
		dc.b	1,CTRL,VOLM,123
		dc.b	0,NTON,F00,2,NTOF,F00
		dc.b	1,NTON,C40,3,NTOF,C40
		dc.b	1,NTON,G1S,4,NTOF,G1S
		dc.b	0,NTON,D20,7,NTOF,D20
		dc.b	11,META,EOTRK,0

SFX_S59		dc.b	1-1
		dc.w	sfx59a-SFX_S59
sfx59a		dc.b	0,PRGM,108
		dc.b	0,CTRL,VOLM,115
		dc.b	0,NTON,G5S,6,NTOF,G5S
		dc.b	0,CTRL,VOLM,120
		dc.b	0,NTON,C80,9,NTOF,C80
		dc.b	0,META,EOTRK,0

SFX_S60		dc.b	1-1
		dc.w	sfx60a-SFX_S60
sfx60a		dc.b	0,PRGM,102
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,B00,6,NTOF,B00
		dc.b	1,PRGM,109
		dc.b	1,CTRL,VOLM,124
		dc.b	0,NTON,C3S,8,NTOF,C3S
		dc.b	1,PRGM,47
		dc.b	1,CTRL,VOLM,125
		dc.b	0,NTON,C40,6,NTOF,C40
		dc.b	1,PRGM,18
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,D20,3,NTOF,D20
		dc.b	1,NTON,E20,4,NTOF,E20
		dc.b	1,NTON,G1S,3,NTOF,G1S
		dc.b	11,META,EOTRK,0

SFX_S61		dc.b	1-1
		dc.w	sfx61a-SFX_S61
sfx61a		dc.b	0,PRGM,102
		dc.b	0,CTRL,VOLM,127
		dc.b	0,NTON,C40,3,NTOF,C40
		dc.b	0,NTON,D0S,6,NTOF,D0S
		dc.b	0,META,EOTRK,0

SFX_S62		dc.b	1-1
		dc.w	sfx62a-SFX_S62
sfx62a		dc.b	0,PRGM,16
		dc.b	0,CTRL,VOLM,127
		dc.b	0,NTON,D10,2,NTOF,D10
		dc.b	0,CTRL,VOLM,123
		dc.b	0,NTON,G2S,2,NTOF,G2S
		dc.b	0,CTRL,VOLM,120
		dc.b	0,NTON,B20,2,NTOF,B20
		dc.b	0,CTRL,VOLM,125
		dc.b	0,NTON,C3S,2,NTOF,C3S
		dc.b	0,NTON,B30,2,NTOF,B30
		dc.b	0,PRGM,18
		dc.b	0,NTON,C40,1,NTOF,C40
		dc.b	7,NTON,C40,1,NTOF,C40
		dc.b	5,NTON,A30,1,NTOF,A30
		dc.b	5,NTON,D3S,1,NTOF,D3S
		dc.b	5,NTON,A2S,2,NTOF,A2S
		dc.b	12,META,EOTRK,0

SFX_S63		dc.b	1-1
		dc.w	sfx63a-SFX_S63
sfx63a		dc.b	0,META,EOTRK,0

SFX_S64		dc.b	1-1
		dc.w	sfx64a-SFX_S64
sfx64a		dc.b	0,PRGM,103
		dc.b	0,NTON,C50,48,NTOF,C50
		dc.b	0,META,EOTRK,0

SFX_S65		dc.b	1-1
		dc.w	sfx65a-SFX_S65
sfx65a		dc.b	0,PRGM,1
		dc.b	0,CTRL,VOLM,127
		dc.b	0,NTON,F20,60,NTOF,F20
		dc.b	0,META,EOTRK,0

SFX_S66		dc.b	1-1
		dc.w	sfx66a-SFX_S66
sfx66a		dc.b	0,PRGM,9
		dc.b	1,CTRL,VOLM,120
		dc.b	0,NTON,E20,11,NTOF,E20
		dc.b	6,NTON,B20,4,NTOF,B20
		dc.b	11,META,EOTRK,0

SFX_S67		dc.b	1-1
		dc.w	sfx67a-SFX_S67
sfx67a		dc.b	0,PRGM,31
		dc.b	1,CTRL,VOLM,115
		dc.b	0,NTON,F00
		dc.b	1,META,SS,PBM,2
		dc.b	26,NTOF,F00
		dc.b	12,META,EOTRK,0

SFX_S68		dc.b	1-1
		dc.w	sfx68a-SFX_S68
sfx68a		dc.b	0,PRGM,18
		dc.b	0,CTRL,VOLM,127
		dc.b	0,NTON,C1S,3,NTOF,C1S
		dc.b	0,PRGM,24
		dc.b	0,NTON,G5S,2,NTOF,G5S
		dc.b	0,NTON,C60,2,NTOF,C60
		dc.b	0,NTON,F4S,1,NTOF,F4S
		dc.b	0,NTON,C40,2,NTOF,C40
		dc.b	0,NTON,E40,1,NTOF,E40
		dc.b	0,NTON,F5S,7,NTOF,F5S
		dc.b	0,META,EOTRK,0

SFX_S69		dc.b	1-1
		dc.w	sfx69a-SFX_S69
sfx69a		dc.b	0,PRGM,111
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,F10,4,NTOF,F10
		dc.b	1,PRGM,102
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,C00,14,NTOF,C00
		dc.b	11,META,EOTRK,0

SFX_S70		dc.b	1-1
		dc.w	sfx70a-SFX_S70
sfx70a		dc.b	0,PRGM,112
		dc.b	0,CTRL,VOLM,127
sfx70al		dc.b	0,NTON,C00,12,NTOF,C00
		dc.b	0,NTON,E00,12,NTOF,E00
		dc.b	0,META,SS,GTO
		dc.l	sfx70al-sfx70a

SFX_S71		dc.b	1-1
		dc.w	sfx71a-SFX_S71
sfx71a		dc.b	0,PRGM,79
		dc.b	0,CTRL,VOLM,109
		dc.b	0,NTON,A2S,2,NTOF,A2S
		dc.b	0,CTRL,VOLM,115
		dc.b	0,NTON,F4S,2,NTOF,F4S
		dc.b	0,PRGM,65
		dc.b	0,CTRL,VOLM,120
		dc.b	0,NTON,G7S,24,NTOF,G7S
		dc.b	0,META,EOTRK,0

SFX_S72		dc.b	1-1
		dc.w	sfx72a-SFX_S72
sfx72a		dc.b	0,PRGM,5
		dc.b	1,CTRL,VOLM,127
		dc.b	1,NTON,C40
		dc.b	1,META,SS,PBM,1
		dc.b	18,NTOF,C40
		dc.b	1,PRGM,25
		dc.b	1,CTRL,VOLM,127
		dc.b	1,NTON,A30
		dc.b	1,META,SS,PBM,2
		dc.b	22,NTOF,A30
		dc.b	11,META,EOTRK,0

SFX_S73		dc.b	1-1
		dc.w	sfx73a-SFX_S73
sfx73a		dc.b	0,META,EOTRK,0

SFX_S74		dc.b	1-1
		dc.w	sfx74a-SFX_S74
sfx74a		dc.b	0,PRGM,17
		dc.b	0,CTRL,VOLM,127
		dc.b	0,NTON,B10,6,NTOF,B10
		dc.b	0,PRGM,16
		dc.b	0,NTON,F1S,6,NTOF,F1S
		dc.b	0,META,EOTRK,0

SFX_S75		dc.b	1-1
		dc.w	sfx75a-SFX_S75
sfx75a		dc.b	0,PRGM,24
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,A3S,5,NTOF,A3S
		dc.b	1,NTON,A4S,3,NTOF,A4S
		dc.b	1,PRGM,16
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,C40,3,NTOF,C40
		dc.b	1,NTON,C3S,2,NTOF,C3S
		dc.b	1,NTON,C40,2,NTOF,C40
		dc.b	1,NTON,F6S,3,NTOF,F6S
		dc.b	1,CTRL,VOLM,115
		dc.b	0,NTON,C40,3,NTOF,C40
		dc.b	1,NTON,D4S,1,NTOF,D4S
		dc.b	2,NTON,G40,3,NTOF,G40
		dc.b	1,NTON,D5S,2,NTOF,D5S
		dc.b	3,NTON,D5S,2,NTOF,D5S
		dc.b	11,META,EOTRK,0

SFX_S76		dc.b	1-1
		dc.w	sfx76a-SFX_S76
sfx76a		dc.b	0,PRGM,18
		dc.b	0,CTRL,VOLM,127
		dc.b	0,NTON,B00,3,NTOF,B00
		dc.b	0,PRGM,110
		dc.b	0,NTON,A10,24,NTOF,A10
		dc.b	0,META,EOTRK,0

SFX_S77		dc.b	1-1
		dc.w	sfx77a-SFX_S77
sfx77a		dc.b	0,PRGM,110
		dc.b	1,CTRL,VOLM,118
		dc.b	0,NTON,C30,2,NTOF,C30
		dc.b	2,NTON,C20,12,NTOF,C20
		dc.b	11,META,EOTRK,0

SFX_S78		dc.b	1-1
		dc.w	sfx78a-SFX_S78
sfx78a		dc.b	0,PRGM,91
		dc.b	1,CTRL,VOLM,120
		dc.b	1,NTON,B50
		dc.b	1,META,SS,PBM,5
		dc.b	100,NTOF,B50		
		dc.b	11,META,EOTRK,0

SFX_S79		dc.b	1-1
		dc.w	sfx79a-SFX_S79
sfx79a		dc.b	0,PRGM,9
		dc.b	1,CTRL,VOLM,127
		dc.b	1,NTON,C1S,45,NTOF,C1S
		dc.b	2,META,EOTRK,0

SFX_S80		dc.b	1-1
		dc.w	sfx80a-SFX_S80
sfx80a		dc.b	0,PRGM,111
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,F1S,4,NTOF,F1S
		dc.b	1,PRGM,17
		dc.b	1,CTRL,VOLM,122
		dc.b	0,NTON,C00,36,NTOF,C00		
		dc.b	11,META,EOTRK,0

SFX_S81		dc.b	1-1
		dc.w	sfx81a-SFX_S81
sfx81a		dc.b	0,META,EOTRK,0

;============================================== 82 Swinging Pipes
SFX_S82		dc.b	1-1
		dc.w	sfx82a-SFX_S82
sfx82a		dc.b	0,PRGM,9 ;103
		dc.b	1,CTRL,VOLM,127
		dc.b	1,NTON,C1S,30,NTOF,C1S
		dc.b	11,META,EOTRK,0

;		dc.b	1,CTRL,VOLM,127
;		dc.b	0,NTON,D40
;		dc.b	1,META,SS,PBM,1
;		dc.b	8,NTOF,D40
;		dc.b	1,NTON,C40
;		dc.b	1,META,SS,PBM,2
;		dc.b	14,NTOF,C40		
;		dc.b	11,META,EOTRK,0
;============================================== 83 Clown Rocket
SFX_S83		dc.b	1-1
		dc.w	sfx83a-SFX_S83
sfx83a		dc.b	0,PRGM,31
		dc.b	0,CTRL,VOLM,127
		dc.b	0,NTON,C20
		dc.b	2,META,SS,PBM,4		
		dc.b	12,CTRL,PANM,90
		dc.b	12,CTRL,PANM,50
		dc.b	5,CTRL,PANM,64
		dc.b	40,NTOF,C20
		dc.b	11,META,EOTRK,0

SFX_S84		dc.b	1-1
		dc.w	sfx84a-SFX_S84
sfx84a		dc.b	0,PRGM,3
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,F10,6,NTOF,F10
		dc.b	3,NTON,A10,12,NTOF,A10
		dc.b	11,META,EOTRK,0

SFX_S85		dc.b	1-1
		dc.w	sfx85a-SFX_S85
sfx85a		dc.b	0,PRGM,22
		dc.b	1,CTRL,VOLM,123
		dc.b	1,NTON,C60,2,NTOF,C60
		dc.b	1,PRGM,16
		dc.b	0,CTRL,VOLM,127
		dc.b	0,NTON,A1S,24,NTOF,A1S
		dc.b	1,META,EOTRK,0

SFX_S86		dc.b	1-1
		dc.w	sfx86a-SFX_S86
sfx86a		dc.b	0,PRGM,103
		dc.b	1,CTRL,VOLM,124
		dc.b	1,NTON,A20,6,NTOF,A20
		dc.b	1,PRGM,16
		dc.b	1,NTON,C40,3,NTOF,C40
		dc.b	1,PRGM,103
		dc.b	1,NTON,A2S,24,NTOF,A2S
		dc.b	1,NTON,A2S,48,NTOF,A2S
		dc.b	11,META,EOTRK,0

SFX_S87		dc.b	1-1
		dc.w	sfx87a-SFX_S87
sfx87a		dc.b	0,PRGM,103
		dc.b	1,CTRL,VOLM,119
		dc.b	1,NTON,A1S
		dc.b	23,NTOF,A1S
		dc.b	1,NTON,G2S,24,NTOF,G2S
		dc.b	11,META,EOTRK,0

SFX_S88		dc.b	1-1
		dc.w	sfx88a-SFX_S88
sfx88a		dc.b	0,PRGM,17
		dc.b	0,NTON,G30,48,NTOF,G30
		dc.b	0,META,EOTRK,0

SFX_S89		dc.b	1-1
		dc.w	sfx89a-SFX_S89
sfx89a		dc.b	0,PRGM,120
		dc.b	0,NTON,A1S,24,NTOF,A1S
		dc.b	0,PRGM,17
		dc.b	0,NTON,B10,3,NTOF,B10
		dc.b	0,NTON,G10,3,NTOF,G10
		dc.b	0,NTON,C10,9,NTOF,C10
		dc.b	0,NTON,G1S,24,NTOF,G1S
		dc.b	0,META,EOTRK,0

SFX_S90		dc.b	1-1
		dc.w	sfx90a-SFX_S90
sfx90a		dc.b	0,PRGM,120
		dc.b	1,NTON,G70,12,NTOF,G70
		dc.b	12,META,EOTRK,0
;============================================== 91 - BM gets Hit
SFX_S91		dc.b	1-1
		dc.w	sfx91a-SFX_S91
sfx91a		dc.b	0,PRGM,18
		dc.b	1,NTON,C1S,6,NTOF,C1S
		dc.b	0,PRGM,82
		dc.b	1,CTRL,VOLM,30
		dc.b	0,NTON,F20,12,NTOF,F20
		dc.b	11,META,EOTRK,0

SFX_S92		dc.b	1-1
		dc.w	sfx92a-SFX_S92
sfx92a		dc.b	0,PRGM,115
		dc.b	0,NTON,G2S,3,NTOF,G2S
		dc.b	0,NTON,C40,2,NTOF,C40
		dc.b	1,NTON,G40,1,NTOF,G40
		dc.b	0,NTON,D40,6,NTOF,D40
		dc.b	0,META,EOTRK,0

SFX_S93		dc.b	1-1
		dc.w	sfx93a-SFX_S93
sfx93a		dc.b	0,PRGM,103
		dc.b	0,CTRL,VOLM,127
		dc.b	0,NTON,C40,5,NTOF,C40
		dc.b	0,PRGM,115
		dc.b	0,NTON,A2S,6,NTOF,A2S
		dc.b	0,META,EOTRK,0

SFX_S94		dc.b	1-1
		dc.w	sfx94a-SFX_S94
sfx94a		dc.b	0,PRGM,115
		dc.b	0,CTRL,VOLM,125
		dc.b	0,NTON,C40,2,NTOF,C40
		dc.b	0,NTON,D40,4,NTOF,D40
		dc.b	0,META,EOTRK,0

SFX_S95		dc.b	1-1
		dc.w	sfx95a-SFX_S95
sfx95a		dc.b	0,PRGM,115
		dc.b	0,CTRL,VOLM,127
		dc.b	0,NTON,G40,2,NTOF,G40
		dc.b	0,NTON,A40,4,NTOF,A40

SFX_S96		dc.b	1-1
		dc.w	sfx96a-SFX_S96
sfx96a		dc.b	0,PRGM,115
		dc.b	0,NTON,G30,2,NTOF,G30
		dc.b	0,NTON,C40,3,NTOF,C40
		dc.b	0,NTON,A40,2,NTOF,A40
		dc.b	1,NTON,A40,2,NTOF,A40
		dc.b	1,NTON,C50,3,NTOF,C50
		dc.b	0,META,EOTRK,0

;=============================================== 97 - Boss Explosion
SFX_S97		dc.b	1-1
		dc.w	sfx97a-SFX_S97
sfx97a		dc.b	0,PRGM,10
		dc.b	1,CTRL,VOLM,127
		dc.b	0,NTON,B20,16,NTOF,B20
		dc.b	0,NTON,D20,12,NTOF,D20
		dc.b	2,NTON,C10,3,NTOF,C10
		dc.b	1,NTON,A10,30,NTOF,A10
		dc.b	22,META,EOTRK,0

SFX_S98		dc.b	1-1
		dc.w	sfx98a-SFX_S98
sfx98a		dc.b	0,META,EOTRK,0

SFX_S99		dc.b	1-1
		dc.w	sfx99a-SFX_S99
sfx99a		dc.b	0,PRGM,90
		dc.b	1,CTRL,VOLM,80
		dc.b	1,NTON,C50
		dc.b 	1,META,SS,PBM,7
		dc.b	100,NTOF,C50
		dc.b	11,META,EOTRK,0

SFX_S100	dc.b	1-1
		dc.w	sfx100a-SFX_S100
sfx100a		dc.b	0,META,EOTRK,0

SFX_S101	dc.b	1-1
		dc.w	sfx101a-SFX_S101
sfx101a		dc.b	0,META,EOTRK,0

SFX_S102	dc.b	1-1
		dc.w	sfx102a-SFX_S102
sfx102a		dc.b	0,META,EOTRK,0

;=============================================== 103 - Clown Laugh 0
SFX_S103	dc.b	1-1
		dc.w	sfx103a-SFX_S103
sfx103a		dc.b	0,PRGM,87
		dc.b	1,CTRL,VOLM,120
		dc.b	1,NTON,G20,28,NTOF,G20
		dc.b	11,META,EOTRK,0
;=============================================== 104 - Clown Laugh 1
SFX_S104	dc.b	1-1
		dc.w	sfx104a-SFX_S104
sfx104a		dc.b	0,PRGM,87
		dc.b	1,CTRL,VOLM,115
		dc.b	1,NTON,A10,20,NTOF,A10
		dc.b	1,NTON,C20,20,NTOF,C20
		dc.b	1,NTON,E20,18,NTOF,E20
		dc.b	11,META,EOTRK,0
;=============================================== 105 - Clown Laugh 2
SFX_S105	dc.b	1-1
		dc.w	sfx105a-SFX_S105
sfx105a		dc.b	0,PRGM,87		
		dc.b	1,CTRL,VOLM,120
		dc.b	1,NTON,E20,26,NTOF,E20
		dc.b	11,META,EOTRK,0
;=============================================== 106 - Clown Laugh 3
SFX_S106	dc.b	1-1
		dc.w	sfx106a-SFX_S106
sfx106a		dc.b	0,PRGM,87
		dc.b	1,CTRL,VOLM,120
		dc.b	1,NTON,E20,16,NTOF,E20
		dc.b	1,NTON,G20,26,NTOF,G20
		dc.b	10,NTON,F20,16,NTOF,F20
		dc.b	11,META,EOTRK,0
;============================================== 107 - Batmobile Arrive
SFX_S107	dc.b	1-1
		dc.w	sfx107a-SFX_S107
sfx107a		dc.b	1,PRGM,88
		dc.b	1,CTRL,VOLM,122
		dc.b	1,CTRL,PANM,100
		dc.b	0,NTON,C20
		dc.b	1,META,SS,PBM,5
		dc.b	40,CTRL,PANM,64
		dc.b	40,CTRL,PANM,32
		dc.b	120,NTOF,C20
		dc.b	41,META,EOTRK,0
;============================================== 108 - Batmobile Depart
SFX_S108	dc.b	1-1
		dc.w	sfx108a-SFX_S108
sfx108a		dc.b	0,PRGM,88
		dc.b	1,CTRL,VOLM,120
		dc.b	0,CTRL,PANM,80
		dc.b	0,NTON,A10
		dc.b	1,META,SS,PBM,6
		dc.b	40,CTRL,PANM,34
		dc.b	40,CTRL,PANM,12
		dc.b	120,NTOF,A10
		dc.b	41,META,EOTRK,0
;============================================== 109 - Generic Kick
SFX_S109	dc.b	1-1
		dc.w	sfx109a-SFX_S109
sfx109a		dc.b	0,PRGM,3
		dc.b	1,CTRL,VOLM,60
		dc.b	0,NTON,A20,1,NTOF,A20
		dc.b	1,PRGM,86
		dc.b	1,CTRL,VOLM,100
		dc.b	1,NTON,G10,3,NTOF,G10
		dc.b	11,META,EOTRK,0

;============================================== 110 - Generic Punch
SFX_S110	dc.b	1-1
		dc.w	sfx110a-SFX_S110
sfx110a		dc.b	0,PRGM,3		
		dc.b	1,CTRL,VOLM,60
		dc.b	0,NTON,A20,2,NTOF,A20
		dc.b	1,CTRL,VOLM,110
		dc.b	1,NTON,F30,1,NTOF,F30
		dc.b	5,META,EOTRK,0
;============================================== 110 - BM Punchswing
SFX_S111	dc.b	1-1
		dc.w	sfx111a-SFX_S111
sfx111a		dc.b	0,PRGM,9
		dc.b	0,NTON,C40
		dc.b	0,NTON,C1S
		dc.b	48,NTOF,C40
		dc.b	0,NTOF,C1S
		dc.b	0,META,EOTRK,0
			
SFX_S112	dc.b	1-1
		dc.w	sfx112a-SFX_S112
sfx112a		dc.b	0,META,EOTRK,0

SFX_S113	dc.b	1-1
		dc.w	sfx113a-SFX_S113
sfx113a		dc.b	0,PRGM,8
		dc.b	1,CTRL,VOLM,120
		dc.b	1,NTON,D00,1,NTOF,D00
		dc.b	2,NTON,G10,1,NTOF,G10
		dc.b	1,NTON,C2S,1,NTOF,C2S
		dc.b	1,NTON,C30,1,NTOF,C30
		dc.b	0,NTON,C40,1,NTOF,C40
		dc.b	0,CTRL,VOLM,114
		dc.b	0,NTON,D50,1,NTOF,D50
		dc.b	1,NTON,A50,2,NTOF,A50
		DC.B	0,NTON,D6S,2,NTOF,D6S
		dc.b	1,NTON,C6S,1,NTOF,C6S
		dc.b	2,NTON,G6S,1,NTOF,G6S
		dc.b	0,NTON,D7S,2,NTOF,D7S
		dc.b	1,META,EOTRK,0

SFX_S114	dc.b	1-1
		dc.w	sfx114a-SFX_S114
sfx114a		dc.b	0,PRGM,89
		dc.b	1,CTRL,VOLM,100
		dc.b	1,NTON,E20
		dc.b	1,META,SS,PBM,6
		dc.b	22,NTOF,E20
		dc.b	11,META,EOTRK,0

SFX_S115	dc.b	1-1
		dc.w	sfx115a-SFX_S115
sfx115a		dc.b	0,META,EOTRK,0

SFX_S116	dc.b	1-1
		dc.w	sfx116a-SFX_S116
sfx116a		dc.b	0,PRGM,92
		dc.b	1,CTRL,VOLM,127
		dc.b	1,NTON,A10,36,NTOF,A10
		dc.b	11,META,EOTRK,0

SFX_S117	dc.b	1-1
		dc.w	sfx117a-SFX_S117
sfx117a		dc.b	0,META,EOTRK,0

SFX_S118	dc.b	1-1
		dc.w	sfx118a-SFX_S118
sfx118a		dc.b	0,META,EOTRK,0

SFX_S119	dc.b	1-1
		dc.w	sfx119a-SFX_S119
sfx119a		dc.b	0,META,EOTRK,0

SFX_S120	dc.b	1-1
		dc.w	sfx120a-SFX_S120
sfx120a		dc.b	0,META,EOTRK,0

SFX_S121	dc.b	1-1
		dc.w	sfx121a-SFX_S121
sfx121a		dc.b	0,META,EOTRK,0

SFX_S122	dc.b	1-1
		dc.w	sfx122a-SFX_S122
sfx122a		dc.b	0,META,EOTRK,0

SFX_S123	dc.b	1-1
		dc.w	sfx123a-SFX_S123
sfx123a		dc.b	0,META,EOTRK,0

SFX_S124	dc.b	1-1
		dc.w	sfx124a-SFX_S124
sfx124a		dc.b	0,META,EOTRK,0

SFX_S125	dc.b	1-1
		dc.w	sfx125a-SFX_S125
sfx125a		dc.b	0,META,EOTRK,0

SFX_S126	dc.b	1-1
		dc.w	sfx126a-SFX_S126
sfx126a		dc.b	0,META,EOTRK,0

SFX_S127	dc.b	1-1
		dc.w	sfx127a-SFX_S127
sfx127a		dc.b	0,META,EOTRK,0

		EVEN

		ENDIF

;*********************************************************			

	processor 6502
	include "vcs.h"
	include "macro.h"

	SEG
	ORG $F000

Reset

	ldx #0
	lda #0

Clear
	sta 0,x
	inx
	bne Clear

StartOfFrame
	lda #0
	sta VBLANK
	lda #2
	sta VSYNC
	sta WSYNC
	sta WSYNC
	sta WSYNC

	lda #0
	sta VSYNC

	ldx #0

VerticalBlank
	sta WSYNC
	inx
	cpx #37
	bne VerticalBlank

	ldx #$0E
	ldy #0

PictureWhite
	stx COLUBK
	sta WSYNC
	iny
	cpy #64
	bne PictureWhite
	
	ldx #$88
        ldy #0

PictureBlue
	stx COLUBK
	sta WSYNC
	iny
	cpy #64
	bne PictureBlue

	ldx #$42
	ldy #0

PictureRed
	stx COLUBK
        sta WSYNC
        iny
        cpy #64
        bne PictureRed
	
	lda #%01000010
	sta VBLANK
	
	ldx #0

Overscan
	sta WSYNC
	inx
	cpx #30
	bne Overscan

	jmp StartOfFrame
	
	ORG $FFFA

InterruptVectors

        .word Reset          ; NMI
        .word Reset          ; RESET
        .word Reset          ; IRQ

END

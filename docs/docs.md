# OS����

## Day1
�قƂ�ǃT���v���̂��̂��R�s�[����.
�ŏ��̓o�C�i���G�f�B�^�̓��e���ʂ����Ǝv���������ʂ��Ǝv���Ă�߂�.

### helloos0
����Ȋ�����qemu���N���ł����B
![qemu](image.png)

### helloos1
asm��img�t�@�C�����쐬�ł���悤�ɂȂ���

### helloos2
�ȉ��̂悤�ȃA�Z���u���̃R�[�h���^����ꂽ.  
�厖�ȂƂ����**���b�Z�[�W����** �̂Ƃ���

DB���� : DataByte�̗�,�t�@�C����1�o�C�g�����߂𒼐ڏ�����  
DW���� : DataWord�̗�,word = 16bit = 2byte�����߂�������  
DD���� : DataDouble-word�̗�,2word = 26bit = 4byte�����߂�������  
RESB���� : ReserveByte�̗�,"RESB {int}"��{int}byte���\����s��,0x00�Ŗ��߂Ă����(0x�����Ă���̂�16�i��)  
& : �擪���牽byte�ڂ����i�[����Ă���ϐ�  

```m68k
; hello-os
; TAB=4

; �ȉ��͕W���I��FAT12�t�H�[�}�b�g�t���b�s�[�f�B�X�N�̂��߂̋L�q

		DB		0xeb, 0x4e, 0x90
		DB		"HELLOIPL"		; �u�[�g�Z�N�^�̖��O�����R�ɏ����Ă悢�i8�o�C�g�j
		DW		512				; 1�Z�N�^�̑傫���i512�ɂ��Ȃ���΂����Ȃ��j
		DB		1				; �N���X�^�̑傫���i1�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DW		1				; FAT���ǂ�����n�܂邩�i���ʂ�1�Z�N�^�ڂ���ɂ���j
		DB		2				; FAT�̌��i2�ɂ��Ȃ���΂����Ȃ��j
		DW		224				; ���[�g�f�B���N�g���̈�̑傫���i���ʂ�224�G���g���ɂ���j
		DW		2880			; ���̃h���C�u�̑傫���i2880�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DB		0xf0			; ���f�B�A�̃^�C�v�i0xf0�ɂ��Ȃ���΂����Ȃ��j
		DW		9				; FAT�̈�̒����i9�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DW		18				; 1�g���b�N�ɂ����̃Z�N�^�����邩�i18�ɂ��Ȃ���΂����Ȃ��j
		DW		2				; �w�b�h�̐��i2�ɂ��Ȃ���΂����Ȃ��j
		DD		0				; �p�[�e�B�V�������g���ĂȂ��̂ł����͕K��0
		DD		2880			; ���̃h���C�u�傫����������x����
		DB		0,0,0x29		; �悭�킩��Ȃ����ǂ��̒l�ɂ��Ă����Ƃ����炵��
		DD		0xffffffff		; ���Ԃ�{�����[���V���A���ԍ�
		DB		"HELLO-OS   "	; �f�B�X�N�̖��O�i11�o�C�g�j
		DB		"FAT12   "		; �t�H�[�}�b�g�̖��O�i8�o�C�g�j
		RESB	18				; �Ƃ肠����18�o�C�g�����Ă���

; �v���O�����{��

		DB		0xb8, 0x00, 0x00, 0x8e, 0xd0, 0xbc, 0x00, 0x7c
		DB		0x8e, 0xd8, 0x8e, 0xc0, 0xbe, 0x74, 0x7c, 0x8a
		DB		0x04, 0x83, 0xc6, 0x01, 0x3c, 0x00, 0x74, 0x09
		DB		0xb4, 0x0e, 0xbb, 0x0f, 0x00, 0xcd, 0x10, 0xeb
		DB		0xee, 0xf4, 0xeb, 0xfd

; ���b�Z�[�W����

		DB		0x0a, 0x0a		; ���s��2��
		DB		"This is ArgOS......"
		DB		0x0a			; ���s
		DB		0

		RESB	0x1fe-$			; 0x001fe�܂ł�0x00�Ŗ��߂閽��

		DB		0x55, 0xaa

; �ȉ��̓u�[�g�Z�N�^�ȊO�̕����̋L�q

		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
		RESB	4600
		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
		RESB	1469432
```
FAT12�t�H�[�}�b�g : WS��MS-dos�̕W���t�H�[�}�b�g�`��
�u�[�g�Z�N�^ : FD�̍ŏ��̃Z�N�^,1�Z�N�^ = 512byte.1FD = 1,440kb�Ȃ̂�1FD = 2,800�Z�N�^  
PC�͋N�����ŏ��̃Z�N�^�ƍŌ��2byte��ǂ�ł��ꂪ"55 AA"�ł��邩�ǂ����ŋN���̉ۂ𔻒f����炵����,���̃R�[�h�̓��b�Z�[�W�����̍Ō��"55 AA"�����݂���̂Ō����Ă��邱�ƂƈႤ�C������......�Ǝv�������A������������"55 AA"��T�����遨�����遨����𖖔����Ƃ��Ă��̃Z�N�^�̓�������s����.�Ƃ����`�ɂȂ��Ă���̂���??  
IPL : InitialProgramLoader�̗�,OS�̃u�[�g�Z�N�^�͕���1�Z�N�^�Ŏ��܂�Ȃ����ߊO���̃v���O������ǂݍ��ޓs����u�[�g�Z�N�^��IPL���ēǂ񂾂肷��,���i�K�ł͂���Ȃ��Ƃ��Ȃ��̂ŕ��ʂɉR,OS5����IPL���̗p  
�u�[�g : bootstrap,�ق�ӂ��j�݂̖`��  
����Ȋ����Ő������\�����ꂽ   
![Alt text](image-1.png)

## Day2
### helloos3
- ORG���� : origin����,PC�̃������̂ǂ��ɓǂݍ��܂�邩���A�Z���u��(�����nask)�ɋ����閽��  
- JUMP���� : goto���Ɠ���  
- MOV���� :�������
- msg : ���x���̂���
- [] : []�̓������̔Ԓn��\��,"�f�[�^�̑傫�� [�Ԓn]"�̌`��,�܂� 'MOV AL,[SI]'��'MOV AL, BYTE [SI]����,MOV���߂�bit���������Ȃ��Ƃ͖񑩂Ȃ̂�'MOV AL,[SI](��������SI�Ԓn��1�o�C�g�̓��e��AL�ɓǂݍ���)
- ADD���� : �����Z����,"ADD SI, 1" = "SI = SI + 1"
- CMP���� : ��r����,"CMP AL,0" = "if (CMP == 0)"
- JE���� : Jump if Equal,�O�q��CMP��true�̎���jump����
- INT���� : Interrupt����,���荞�ݏ���
  - BIOS(Basic Input Output System) : ROM(Read Only System)�ɏ������܂ꂽOS�J���҂̂��߂̊֐��W�܂�,INT���߂ł��̊֐����Ăяo��.INT {����}�ŔC�ӂ̐����̊֐����Ă�
- HLT���� : ���͂�����܂�cpu���A�C�h����Ԃɂ��閽��,�������Ȃ��Ȃ�HLT����K��������,�ꌹ��halt(��~������)
#### CPU�̑�\�I�ȃ��W�X�^(16bit���W�X�^)
- AX : �A�L���[�����[�^(Accumulator : �ݐω��Z��)  
- CX : �J�E���^(counter)
- DX : �f�[�^(data)
- BX : �x�[�X(base)
- BP : �x�[�X�|�C���^(Base Pointer : �x�[�X�p�|�C���^)  
- SP : �X�^�b�N�|�C���^(Stack Pointer : �X�^�b�N�p�|�C���^)
- SI : �\�[�X�C���f�b�N�X(Source Index : �ǂݍ��݃C���f�b�N�X)
- DI : �f�X�e�B�l�[�V�����C���f�b�N�X(Destination Index : �������݃C���f�b�N�X)
x�͊g��(extend)�̈�  
AX�̉���bit��AL(low)�ƌĂ�,���bit��AH(high)�ƌĂ�
#### �Z�O�����g���W�X�^(16bit���W�X�^)
- ES : �G�N�X�g���Z�O�����g(extra segment : ���܂��Z�O�����g)
- CS : �R�[�h�Z�O�����g(Code Segment)
- SS : �X�^�b�N�Z�O�����g(Stack Segment)
- DS : �f�[�^�Z�O�����g(Data Segment)
- FS,GS : �{���Ȃ�(���܂��Z�O�����g2,3)



```
; hello-os
; TAB=4

		ORG		0x7c00			; ���̃v���O�������ǂ��ɓǂݍ��܂��̂�

; �ȉ��͕W���I��FAT12�t�H�[�}�b�g�t���b�s�[�f�B�X�N�̂��߂̋L�q

		JMP		entry
		DB		0x90
		DB		"HELLOIPL"		; �u�[�g�Z�N�^�̖��O�����R�ɏ����Ă悢�i8�o�C�g�j
		DW		512				; 1�Z�N�^�̑傫���i512�ɂ��Ȃ���΂����Ȃ��j
		DB		1				; �N���X�^�̑傫���i1�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DW		1				; FAT���ǂ�����n�܂邩�i���ʂ�1�Z�N�^�ڂ���ɂ���j
		DB		2				; FAT�̌��i2�ɂ��Ȃ���΂����Ȃ��j
		DW		224				; ���[�g�f�B���N�g���̈�̑傫���i���ʂ�224�G���g���ɂ���j
		DW		2880			; ���̃h���C�u�̑傫���i2880�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DB		0xf0			; ���f�B�A�̃^�C�v�i0xf0�ɂ��Ȃ���΂����Ȃ��j
		DW		9				; FAT�̈�̒����i9�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DW		18				; 1�g���b�N�ɂ����̃Z�N�^�����邩�i18�ɂ��Ȃ���΂����Ȃ��j
		DW		2				; �w�b�h�̐��i2�ɂ��Ȃ���΂����Ȃ��j
		DD		0				; �p�[�e�B�V�������g���ĂȂ��̂ł����͕K��0
		DD		2880			; ���̃h���C�u�傫����������x����
		DB		0,0,0x29		; �悭�킩��Ȃ����ǂ��̒l�ɂ��Ă����Ƃ����炵��
		DD		0xffffffff		; ���Ԃ�{�����[���V���A���ԍ�
		DB		"HELLO-OS   "	; �f�B�X�N�̖��O�i11�o�C�g�j
		DB		"FAT12   "		; �t�H�[�}�b�g�̖��O�i8�o�C�g�j
		RESB	18				; �Ƃ肠����18�o�C�g�����Ă���

; �v���O�����{��

entry:
		MOV		AX,0			; ���W�X�^������
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX
		MOV		ES,AX

		MOV		SI,msg          ; msg�̓W�����v��̃��x��
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; SI��1�𑫂�
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; �ꕶ���\���t�@���N�V����
		MOV		BX,15			; �J���[�R�[�h
		INT		0x10			; �r�f�IBIOS�Ăяo��
		JMP		putloop
fin:
		HLT						; ��������܂�CPU���~������
		JMP		fin				; �������[�v

msg:
		DB		0x0a, 0x0a		; ���s��2��
		DB		"hello, world"
		DB		0x0a			; ���s
		DB		0

		RESB	0x7dfe-$		; 0x7dfe�܂ł�0x00�Ŗ��߂閽��

		DB		0x55, 0xaa

; �ȉ��̓u�[�g�Z�N�^�ȊO�̕����̋L�q

		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
		RESB	4600
		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
		RESB	1469432

```

����̃R�[�h��,msg�̒��g���ꕶ�����\������,�f�[�^����ɂȂ�����hlt������R�[�h  
BIOS�̖��߃R�[�h�̃��t�@�����X�͈ȉ��̒ʂ�  
#### �ꕶ���\��
- AH = 0x0e;
- AL = �L�����N�^�[�R�[�h;
- BH = 0;
- BL = �J���[�R�[�h;
- return None
- �� : �r�[�v,�o�b�N�X�y�[�X,CR,LF�͐���R�[�h�Ƃ��ĔF��

#### ORG    0x7c00�̈Ӗ�
0x7c00�̓��������Ŗ񑩂���Ă���u�[�g�Z�N�^���ǂݍ��܂��A�h���X�̐擪

### helloos4
nask�Ƀf�B�X�N�C���[�W�S�̂���点����,�Ƃ��512�o�C�g�̃u�[�g�Z�N�^�����S�����Ă��炤�悤�ɂ���.  
�����,�u�[�g�Z�N�^�ȊO�̋L�q���J�b�g��,helloos.nas����ipl.nas�ɕύX  
```; hello-os
; TAB=4

		ORG		0x7c00			; ���̃v���O�������ǂ��ɓǂݍ��܂��̂�

; �ȉ��͕W���I��FAT12�t�H�[�}�b�g�t���b�s�[�f�B�X�N�̂��߂̋L�q

		JMP		entry
		DB		0x90
		DB		"HELLOIPL"		; �u�[�g�Z�N�^�̖��O�����R�ɏ����Ă悢�i8�o�C�g�j
		DW		512				; 1�Z�N�^�̑傫���i512�ɂ��Ȃ���΂����Ȃ��j
		DB		1				; �N���X�^�̑傫���i1�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DW		1				; FAT���ǂ�����n�܂邩�i���ʂ�1�Z�N�^�ڂ���ɂ���j
		DB		2				; FAT�̌��i2�ɂ��Ȃ���΂����Ȃ��j
		DW		224				; ���[�g�f�B���N�g���̈�̑傫���i���ʂ�224�G���g���ɂ���j
		DW		2880			; ���̃h���C�u�̑傫���i2880�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DB		0xf0			; ���f�B�A�̃^�C�v�i0xf0�ɂ��Ȃ���΂����Ȃ��j
		DW		9				; FAT�̈�̒����i9�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DW		18				; 1�g���b�N�ɂ����̃Z�N�^�����邩�i18�ɂ��Ȃ���΂����Ȃ��j
		DW		2				; �w�b�h�̐��i2�ɂ��Ȃ���΂����Ȃ��j
		DD		0				; �p�[�e�B�V�������g���ĂȂ��̂ł����͕K��0
		DD		2880			; ���̃h���C�u�傫����������x����
		DB		0,0,0x29		; �悭�킩��Ȃ����ǂ��̒l�ɂ��Ă����Ƃ����炵��
		DD		0xffffffff		; ���Ԃ�{�����[���V���A���ԍ�
		DB		"HELLO-OS   "	; �f�B�X�N�̖��O�i11�o�C�g�j
		DB		"FAT12   "		; �t�H�[�}�b�g�̖��O�i8�o�C�g�j
		RESB	18				; �Ƃ肠����18�o�C�g�����Ă���

; �v���O�����{��

entry:
		MOV		AX,0			; ���W�X�^������
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX
		MOV		ES,AX

		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; SI��1�𑫂�
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; �ꕶ���\���t�@���N�V����
		MOV		BX,15			; �J���[�R�[�h
		INT		0x10			; �r�f�IBIOS�Ăяo��
		JMP		putloop
fin:
		HLT						; ��������܂�CPU���~������
		JMP		fin				; �������[�v

msg:
		DB		0x0a, 0x0a		; ���s��2��
		DB		"hello, world"
		DB		0x0a			; ���s
		DB		0

		RESB	0x7dfe-$		; 0x7dfe�܂ł�0x00�Ŗ��߂閽��

		DB		0x55, 0xaa
```
�܂��Aasm.bat��ipl.bin�ɕύX��,ipl.lst���o�͂���悤�ɕύX,
#### ipl.lst
�ǂ̖��߂��ǂ̋@�B��ƑΉ����Ă��邩���m�F�ł���e�L�X�g�t�@�C��  
#### making.bat
ipl.bin�����Ƃ�helloos.img���쐬����o�b�`�t�@�C��.edimg.exe�ŋ�̃C���[�W�t�@�C����ipl.bin��ǂݍ��܂���helloos.img�Ƃ��ďo��
#### ����̗���
!con -> asm -> makeing -> run

### MakeFile�̍쐬
```# �t�@�C�������K��

ipl.bin : ipl.nas Makefile
	../z_tools/nask.exe ipl.nas ipl.bin ipl.lst

helloos.img : ipl.bin Makefile
	../z_tools/edimg.exe   imgin:../z_tools/fdimg0at.tek \
		wbinimg src:ipl.bin len:512 from:0 to:0   imgout:helloos.img
```

## Day3
### harib00a
#### �T�v
FD�̎w�肳�ꂽ�Z�N�^��ǂ�  
[INT 0x13](http://oswiki.osask.jp/?(AT)BIOS)
```
AH = 0x02; �i�ǂݍ��ݎ��j
AH = 0x03; �i�������ݎ��j
AH = 0x04; �i�x���t�@�C���j
AH = 0x0c; �i�V�[�N���j
AL = ��������Z�N�^��; �i�A�������Z�N�^�������ł���j
CH = �V�����_�ԍ� & 0xff;
CL = �Z�N�^�ԍ�(bit0-5) | (�V�����_�ԍ� & 0x300) >> 2;
DH = �w�b�h�ԍ�;
DL = �h���C�u�ԍ�;
ES:BX = �o�b�t�@�A�h���X; �i�x���t�@�C���A�V�[�N���ɂ͂���͎Q�Ƃ��Ȃ��j
�߂�l�F
FLAGS.CF == 0 �F �G���[�Ȃ��AAH == 0
FLAGS.CF == 1 �F �G���[����AAH�ɃG���[�R�[�h�i���Z�b�g�t�@���N�V�����Ɠ����j
```
- FLAGS.CF : �L�����[�t���O : �G���[������ꍇ��1��Ԃ�  
- CH,CL,DH : �t���b�s�[�̈ʒu������,�w�b�h���\��,�V�����_���O����0�Ƃ����ւ̈ʒu,�Z�N�^������𕪊���������  
- ES:BX : �������̃A�h���X�w��,�Ԓn�@= ES x 16 + BX

```
; �f�B�X�N��ǂ�

		MOV		AX,0x0820
		MOV		ES,AX
		MOV		CH,0			; �V�����_0
		MOV		DH,0			; �w�b�h0
		MOV		CL,2			; �Z�N�^2

		MOV		AH,0x02			; AH=0x02 : �f�B�X�N�ǂݍ���
		MOV		AL,1			; 1�Z�N�^
		MOV		BX,0
		MOV		DL,0x00			; A�h���C�u
		INT		0x13			; �f�B�X�NBIOS�Ăяo��
		JC		error
```

### harib00b
#### �T�v
5��ȏ�FD��ǂݍ���ł��߂Ȃ�G���[����  
#### �V�o����
- JNC���� : Jump if Not Carry: �L�����[�t���O��0�̏ꍇ���
- JAE���� : Jum if above or equal : �ȏ�Ȃ���
#### �G���[���̏���
�ǂݒ����O��
- AH = 0x00
- DL = 0x00
- INT = 0x13
���s��
```
; �f�B�X�N��ǂ�

		MOV		AX,0x0820
		MOV		ES,AX
		MOV		CH,0			; �V�����_0
		MOV		DH,0			; �w�b�h0
		MOV		CL,2			; �Z�N�^2

		MOV		SI,0			; ���s�񐔂𐔂��郌�W�X�^
retry:
		MOV		AH,0x02			; AH=0x02 : �f�B�X�N�ǂݍ���
		MOV		AL,1			; 1�Z�N�^
		MOV		BX,0
		MOV		DL,0x00			; A�h���C�u
		INT		0x13			; �f�B�X�NBIOS�Ăяo��
		JNC		fin				; �G���[�������Ȃ����fin��
		ADD		SI,1			; SI��1�𑫂�
		CMP		SI,5			; SI��5���r
		JAE		error			; SI >= 5 ��������error��
		MOV		AH,0x00
		MOV		DL,0x00			; A�h���C�u
		INT		0x13			; �h���C�u�̃��Z�b�g
		JMP		retry
```

### haribo00c
#### �T�v
�G���[�łȂ��Ƃ�,next���x���Ŏ��̃Z�N�^��ǂݍ���
#### ���̃Z�N�^��ǂޕ��@
CL++����,ES��0x20�������₷(512��16�i���Ŋ������l)  
'ADD AX,512 / 16'�ł�'ADD BX 512'�ł����l

#### �V�o����
- JBR���� : Jump if Below or equal : �ȉ��Ȃ���

## AL = 17�̓���
��x��17�Z�N�^�ǂݍ���ł����̃v���O�����͖��Ȃ���,BIOS�̓ǂݍ��݃t�@���N�V������  
> ��������Z�N�^����0x01 ~ 0xff�͈̔͂Ŏw��  
�Ƃ̋L�q�����邽��,����̃v���O�����̂��߂Ƀ��[�v�őΉ�


```
; �f�B�X�N��ǂ�

		MOV		AX,0x0820
		MOV		ES,AX
		MOV		CH,0			; �V�����_0
		MOV		DH,0			; �w�b�h0
		MOV		CL,2			; �Z�N�^2
readloop:
		MOV		SI,0			; ���s�񐔂𐔂��郌�W�X�^
retry:
		MOV		AH,0x02			; AH=0x02 : �f�B�X�N�ǂݍ���
		MOV		AL,1			; 1�Z�N�^
		MOV		BX,0
		MOV		DL,0x00			; A�h���C�u
		INT		0x13			; �f�B�X�NBIOS�Ăяo��
		JNC		next			; �G���[�������Ȃ����next��
		ADD		SI,1			; SI��1�𑫂�
		CMP		SI,5			; SI��5���r
		JAE		error			; SI >= 5 ��������error��
		MOV		AH,0x00
		MOV		DL,0x00			; A�h���C�u
		INT		0x13			; �h���C�u�̃��Z�b�g
		JMP		retry
next:
		MOV		AX,ES			; �A�h���X��0x200�i�߂�
		ADD		AX,0x0020
		MOV		ES,AX			; ADD ES,0x020 �Ƃ������߂��Ȃ��̂ł������Ă���
		ADD		CL,1			; CL��1�𑫂�
		CMP		CL,18			; CL��18���r
		JBE		readloop		; CL <= 18 ��������readloop��

```

### harib00d
#### �T�v
C0-H0-S18�̎��ł���f�B�X�N�̗�(�w�b�_1)C0-H1-S1��0xa400����ǂݍ���,���̌�C0-H1-S18 -> C1-H1-S1 -> C9-H1-S18�܂œǂݍ��܂���
#### �V�o����
- JB���� : Jump if Below:��������΃W�����v���Ȃ���
- EQU���� : EQUal : #define�̗p�Ƀ}�N����ݒ肷��
```
; �f�B�X�N��ǂ�

		MOV		AX,0x0820
		MOV		ES,AX
		MOV		CH,0			; �V�����_0
		MOV		DH,0			; �w�b�h0
		MOV		CL,2			; �Z�N�^2
readloop:
		MOV		SI,0			; ���s�񐔂𐔂��郌�W�X�^
retry:
		MOV		AH,0x02			; AH=0x02 : �f�B�X�N�ǂݍ���
		MOV		AL,1			; 1�Z�N�^
		MOV		BX,0
		MOV		DL,0x00			; A�h���C�u
		INT		0x13			; �f�B�X�NBIOS�Ăяo��
		JNC		next			; �G���[�������Ȃ����next��
		ADD		SI,1			; SI��1�𑫂�
		CMP		SI,5			; SI��5���r
		JAE		error			; SI >= 5 ��������error��
		MOV		AH,0x00
		MOV		DL,0x00			; A�h���C�u
		INT		0x13			; �h���C�u�̃��Z�b�g
		JMP		retry
next:
		MOV		AX,ES			; �A�h���X��0x200�i�߂�
		ADD		AX,0x0020
		MOV		ES,AX			; ADD ES,0x020 �Ƃ������߂��Ȃ��̂ł������Ă���
		ADD		CL,1			; CL��1�𑫂�
		CMP		CL,18			; CL��18���r
		JBE		readloop		; CL <= 18 ��������readloop��
		MOV		CL,1            ;��������w�b�_1(����)
		ADD		DH,1
		CMP		DH,2
		JB		readloop		; DH < 2 ��������readloop��
		MOV		DH,0
		ADD		CH,1
		CMP		CH,CYLS         ;CYLS�͂ǂ��܂œǂݍ��ނ��̒l,�����10,�܂�Z�N�^0 ~ 9��10��
		JB		readloop		; CH < CYLS ��������readloop��

```

#### make install�����Ƃ��ɃG���[����

##### �G���[���̃��O
```
.\tolset\harib00d>..\z_tools\make.exe install
../z_tools/make.exe -r img
make.exe[1]: Entering directory `C:/Users/nezum/Documents/Projents/tolset/harib00d'
../z_tools/make.exe -r haribote.img
make.exe[2]: Entering directory `C:/Users/nezum/Documents/Projents/tolset/harib00d'
make.exe[2]: `haribote.img' is up to date.
make.exe[2]: Leaving directory `C:/Users/nezum/Documents/Projents/tolset/harib00d'
make.exe[1]: Leaving directory `C:/Users/nezum/Documents/Projents/tolset/harib00d'
../z_tools/imgtol.com w a: haribote.img
process_begin: CreateProcess(.\tolset\z_tools\imgtol.com, ../z_tools/imgtol.com w a: haribote.img, ...) failed.
make (e=216): Error 216..\z_tools\make.exe: *** [install] Error 216
```
##### ���
�ǂ����,makefile�Ŏw�肳��Ă���,```imgtol.com```��64bit��PC�ƌ݊������Ȃ��炵��
```TOOLPATH = ../z_tools/
MAKE     = $(TOOLPATH)make.exe -r
NASK     = $(TOOLPATH)nask.exe
EDIMG    = $(TOOLPATH)edimg.exe
IMGTOL   = $(TOOLPATH)imgtol.com
COPY     = copy
DEL      = del
```
##### �������@1(����͉����@2���̗p)
VM��32bit��Win�����\�z��,�����ō���i�߂Ă��� 
[32bit��Win����iso�t�@�C��](https://www.microsoft.com/ja-jp/software-download/windows10)
(�ŏ�,��w��Azure�A�J�E���g��OS�������ĂȂ����T������64bit�����Ȃ��������ߌ������Z�b�g�A�b�v)  
[Oracle VM](https://www.virtualbox.org/wiki/Downloads) 
###### **����**
��Win32bit�̃v���_�N�g�L�[���K�v,�Ȃ��ł��N���ł��邪����܂��肽���Ȃ��̂ŉ����@2��
![Alt text](image-3.png)

##### �����@2(����)
VM�ō쐬����img����OS�𗧂��グ��@
->����̓t�@�C���̏㏑�����K�v->git�ŊǗ�
[ArgOS](https://github.com/arugo11/ArgOS)
![helloos1.img�𗧂��グ������](image-4.png)

### harib00e
#### �T�v
�u�[�g�Z�N�^��haribote.sys���N��������Ηǂ����Ƃ𗝉�����
```
fin:
	HLT
	JMP fin
```

### harib00f
#### �T�v
�u�[�g�Z�N�^����OS�{�̂̎��s
#### �Ԓn�̎w��
�u�[�g�Z�N�^��0x8000�Ԓn�ɂ���悤�ɓǂ�ł���̂�0x4200�̈ʒu�̃v���O������
0x8000 + 0x4200 = 0xc200�ɓǂݍ��܂Ă���͂��A
�Ȃ̂�ORG 0xc200,
```
; haribote-os
; TAB=4

		ORG		0xc200			;
```

### harib00g
#### �T�v
OS�̓���m�F�̂��߉�ʃ��[�h�o��
#### ��ʃ��[�h�؂�ւ�
```
�r�f�I���[�h�ݒ�
AH = 0x00;
AL = ���[�h�F (�}�C�i�[�ȉ�ʃ��[�h�͏ȗ����Ă��܂�)
0x03�F16�F�e�L�X�g�A80x25
0x12�FVGA�O���t�B�b�N�X�A640x480x4bit�J���[�A�Ǝ��v���[���A�N�Z�X
0x13�FVGA�O���t�B�b�N�X�A320x200x8bit�J���[�A�p�b�N�h�s�N�Z��
0x6a�F�g��VGA�O���t�B�b�N�X�A800x600x4bit�J���[�A�Ǝ��v���[���A�N�Z�X�i�r�f�I�J�[�h�ɂ���Ă̓T�|�[�g����Ȃ��j
�߂�l�F�Ȃ�
```
#### ipl10.nas
10�V�����_�������ǂݍ���ł��Ȃ����Ƃ𖾎��I�ɕ\��
�܂��A0x0ff0�Ԓn�ɉ��V�����_�܂œǂݍ��񂾂�����������

ipl10.nas
```
; �ǂݏI������̂�haribote.sys�����s���I

		MOV		[0x0ff0],CH		; IPL���ǂ��܂œǂ񂾂̂�������
		JMP		0xc200
```
#### haribote.nas

haribote.nas
```
; haribote-os
; TAB=4

		ORG		0xc200			; ���̃v���O�������ǂ��ɓǂݍ��܂��̂�

		MOV		AL,0x13			; VGA�O���t�B�b�N�X�A320x200x8bit�J���[
		MOV		AH,0x00
		INT		0x10
fin:
		HLT
		JMP		fin

```

#### run���̃G���[
##### �G���[���O
```
C:\Users\[username]\[path]\harib>..\z_tools\make.exe run
../z_tools/make.exe -r img
make.exe[1]: Entering directory `C:/Users/[username]/[path]/harib'
../z_tools/make.exe -r haribote.img
make.exe[2]: Entering directory `C:/Users/[username]/[path]/harib'
../z_tools/nask.exe ipl10.nas ipl10.bin ipl10.lst
../z_tools/nask.exe haribote.nas haribote.sys haribote.lst
../z_tools/edimg.exe   imgin:../z_tools/fdimg0at.tek \
        wbinimg src:ipl10.bin len:512 from:0 to:0 \
        copy from:haribote.sys to:@: \
        imgout:haribote.img
opt-imgout store error. : haribote.img
make.exe[2]: *** [haribote.img] Error 24
make.exe[2]: Leaving directory `C:/Users/[username]/[path]/harib'
make.exe[1]: *** [img] Error 2
make.exe[1]: Leaving directory `C:/Users/[username]/[path]/harib'
..\z_tools\make.exe: *** [run] Error 2
```
##### �����@
VM��haribote.img���J�����ςȂ��Ȃ̂��ǂ��Ȃ�����.VM���~��,haribote.img���폜���ēxrun�����琳��Ɏ��s�ł���

![haribote00g�̉�ʃ��[�h](image-2.png)

### haribote00h
#### �T�v
�����l�X�ȉ�ʃ��[�h�ɑΉ����邽�߂ɉ�ʂ̏����������Ƀ������Ă���,  
VRAM�͉�ʃ��[�h�ɂ���ĉ�f�����قȂ邽�߃������}�b�v��ɕ�������.  
���s���̉�ʏ�̕ω��͂Ȃ�(�������Ƀ������������ł��邽��)  
haribote00h
```
haribote-os
; TAB=4

; BOOT_INFO�֌W
CYLS	EQU		0x0ff0			; �u�[�g�Z�N�^���ݒ肷��
LEDS	EQU		0x0ff1
VMODE	EQU		0x0ff2			; �F���Ɋւ�����B���r�b�g�J���[���H
SCRNX	EQU		0x0ff4			; �𑜓x��X
SCRNY	EQU		0x0ff6			; �𑜓x��Y
VRAM	EQU		0x0ff8			; �O���t�B�b�N�o�b�t�@�̊J�n�Ԓn

		ORG		0xc200			; ���̃v���O�������ǂ��ɓǂݍ��܂��̂�

		MOV		AL,0x13			; VGA�O���t�B�b�N�X�A320x200x8bit�J���[
		MOV		AH,0x00
		INT		0x10
		MOV		BYTE [VMODE],8	; ��ʃ��[�h����������
		MOV		WORD [SCRNX],320
		MOV		WORD [SCRNY],200
		MOV		DWORD [VRAM],0x000a0000

; �L�[�{�[�h��LED��Ԃ�BIOS�ɋ����Ă��炤

		MOV		AH,0x02
		INT		0x16 			; keyboard BIOS
		MOV		[LEDS],AL

fin:
		HLT
		JMP		fin

```
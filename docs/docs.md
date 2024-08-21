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

### harib00i
#### �T�v
c����𓱓�����  
����ɂ�������,c������A�Z���u���ƍ������Ȃ��Ă͂Ȃ�Ȃ��B���̂��߈ȉ��̎菇�ō�������.
#### .c���@�B��ɕϊ�����菇
1. cc1.exe(����gcc)��.c(c����\�[�X�R�[�h)��.gas(�A�Z���u��)�ɕϊ�
2. gas2nask��.gas��.nas(�Ǝ��A�Z���u��nask)�ɕϊ�
3. nask.exe��.nas��.obj(�I�u�W�F�N�g�t�@�C��)�ɕϊ�
4. obj2bim��.obj��.bim(BInary Image:2�i���C���[�W�t�@�C��)�ɕϊ�
5. bim2hrb��.bim��.hrb(�@�B��)�ɕϊ�
6. .hrb��asmhead.bin����������haribote.sys�Ƃ���

#### bootpack.c
���i�K��c����t�@�C���ɈӖ��͂Ȃ�
```c
void HariMain(void)
{

fin:
	/* ������HLT����ꂽ���̂����AC����ł�HLT���g���Ȃ��I */
	goto fin;

}

```

#### ���O���m�F���Ă݂�
```batch
C:\Users\[username]\[path]\harib>make run

C:\Users\[username]\[path]\harib>..\z_tools\make.exe run
../z_tools/make.exe -r img
make.exe[1]: Entering directory `C:/Users/[username]/[path]/harib'
../z_tools/make.exe -r haribote.img
make.exe[2]: Entering directory `C:/Users/[username]/[path]/harib'
../z_tools/nask.exe asmhead.nas asmhead.bin asmhead.lst
../z_tools/cc1.exe -I../z_tools/haribote/ -Os -Wall -quiet -o bootpack.gas bootpack.c
../z_tools/gas2nask.exe -a bootpack.gas bootpack.nas
../z_tools/nask.exe bootpack.nas bootpack.obj bootpack.lst
../z_tools/obj2bim.exe @../z_tools/haribote/haribote.rul out:bootpack.bim stack:3136k map:bootpack.map \
        bootpack.obj
../z_tools/bim2hrb.exe bootpack.bim bootpack.hrb 0
copy /B asmhead.bin+bootpack.hrb haribote.sys
asmhead.bin
bootpack.hrb
        1 �̃t�@�C�����R�s�[���܂����B
../z_tools/edimg.exe   imgin:../z_tools/fdimg0at.tek \
        wbinimg src:ipl10.bin len:512 from:0 to:0 \
        copy from:haribote.sys to:@: \
        imgout:haribote.img
make.exe[2]: Leaving directory `C:/Users/[username]/[path]/harib'
make.exe[1]: Leaving directory `C:/Users/[username]/[path]/harib'
copy haribote.img ..\z_tools\qemu\fdimage0.bin
        1 �̃t�@�C�����R�s�[���܂����B
../z_tools/make.exe -r -C ../z_tools/qemu
make.exe[1]: Entering directory `C:/Users/[username]/[path]/z_tools/qemu'
qemu-win.bat

C:\Users\[username]\[path]\z_tools\qemu>qemu.exe -L . -m 32 -localtime -std-vga -fda fdimage0.bin
make.exe[1]: Leaving directory `C:/Users/[username]/[path]/z_tools/qemu'
```

### haribote00j
#### �T�v
hlt�̎���

#### naskfunc.nas
�A�Z���u���Ŋ֐�������,c�\�[�X�R�[�h�����ǂ�obj�t�@�C���ɂȂ�̂Ŗ��Ȃ�  
WCOFF�ɂ��邱�ƂŃI�u�W�F�N�g�t�@�C������郂�[�h�ɂȂ�.
�\�[�X�t�@�C�����𖾎����Ȃ��Ă͂Ȃ�Ȃ��̂�"[FILE "naskfunc.nas"]"�Ƃ���.  
�v���O�������ɂǂ̂悤�Ȋ֐���������������������,���̎�"_{�֐���}"�Ƃ��Ȃ���C����̊֐��ƘA�g�ł��Ȃ�  
#### �V�o����
- RET���� : return����,c����Ŋ֐����������Ɠ����p�Ɋ֐��̏I���𖾎�����.  
```
; naskfunc
; TAB=4

[FORMAT "WCOFF"]				; �I�u�W�F�N�g�t�@�C������郂�[�h	
[BITS 32]						; 32�r�b�g���[�h�p�̋@�B�����点��


; �I�u�W�F�N�g�t�@�C���̂��߂̏��

[FILE "naskfunc.nas"]			; �\�[�X�t�@�C�������

		GLOBAL	_io_hlt			; ���̃v���O�����Ɋ܂܂��֐���


; �ȉ��͎��ۂ̊֐�

[SECTION .text]		; �I�u�W�F�N�g�t�@�C���ł͂���������Ă���v���O����������

_io_hlt:	; void io_hlt(void);
		HLT
		RET
```

#### bootpack.c
```
/* ���̃t�@�C���ō�����֐�������܂���C�R���p�C���ɋ����� */

void io_hlt(void);

/* �֐��錾�Ȃ̂ɁA{}���Ȃ��Ă����Ȃ�;�������ƁA
	���̃t�@�C���ɂ��邩���낵���ˁA�Ƃ����Ӗ��ɂȂ�̂ł��B */

void HariMain(void)
{

fin:
	io_hlt(); /* �����naskfunc.nas��_io_hlt�����s����܂� */
	goto fin;

}

```

### harib01a
#### �T�v
��ʂɂȂɂ��\�����邽�߂�VRAM�������ɏ������ޕK�v�����邪c���ꂩ�烁�����ɏ������ޕ��@���Ȃ��̂�naskfunc.nas�ɃA�Z���u���Ŋ֐�����������

#### naskfunc.nas
##### C���ꂪ�g�p���ėǂ�32bit���W�X�^
- EAX
- ECX
- EDX
##### �\�[�X�R�[�h�ɂ���
- [INSTRSET "i486p"] : 486�A�[�L�e�N�`�����g����Ƃ����Ӗ�,�f�t�H���g����8086�A�[�L�e�N�`���ƌĂ΂��Â��d�l���Q�Ƃ��Ă��܂�,���̂܂܂���ECX�����x�����������͂����̒萔�Ƃ��ĎQ�Ƃ��Ă��܂����ߎw�肪�K�v�B
##### ESP�̋����ɂ���
```
���ʃA�h���X
+------------+
| 0x00AB     | ESP+11
|            | ESP+10
|            | ESP+9
|            | ESP+8
+------------+
| 0x1234     | ESP+7
|            | ESP+6
|            | ESP+5
|            | ESP+4
+------------+
| ret����     | ESP+3
|            | ESP+2
|            | ESP+1
|            | ESP+0 (ESP ���w���ʒu)
+------------+
��ʃA�h���X
```
ESP�͈ȏ�̂悤�ɃX�^�b�N�̃g�b�v��\���Ă��܂�.
##### �֐��̈�����ESP
�֐��̈����͉E���獶(�����data->addr�̏�)�ɃX�^�b�N�����̂ň������v�b�V�����ꂽ�i�K�ł͈ȉ��̂悤�ȃX�^�b�N�ɂȂ��Ă���  
[ESP,addr,data]�Ȃ̂�ESP+4��addr���w��ESP+8��data���w��
write_mem8(�^�[�Q�b�g�A�h���X,�������ރf�[�^)
##### �֐��̗���
1. ECX��addr��ǂݍ���
2. AL�ɏ������݂���data��ǂݍ���(�����15:��)
3. ECX�Ɋi�[����Ă�addr��AL�̒l��������
naskfunc.nas
```
[FORMAT "WCOFF"]				; �I�u�W�F�N�g�t�@�C������郂�[�h	
[INSTRSET "i486p"]				; 486�̖��߂܂Ŏg�������Ƃ����L�q
[BITS 32]						; 32�r�b�g���[�h�p�̋@�B�����点��
[FILE "naskfunc.nas"]			; �\�[�X�t�@�C�������

		GLOBAL	_io_hlt,_write_mem8

[SECTION .text]

_io_hlt:	; void io_hlt(void);
		HLT
		RET

_write_mem8:	; void write_mem8(int addr, int data);
		MOV		ECX,[ESP+4]		; [ESP+4]��addr�������Ă���̂ł����ECX�ɓǂݍ���
		MOV		AL,[ESP+8]		; [ESP+8]��data�������Ă���̂ł����AL�ɓǂݍ���
		MOV		[ECX],AL
		RET

```
#### bootpack.c
�O�q�̒ʂ�,���ԂɃ�������15�Ƃ����l����͂��Ă���.
bootpack.c
```c

void io_hlt(void);
void write_mem8(int addr, int data);

void HariMain(void)
{
	int i; /* �ϐ��錾�Bi�Ƃ����ϐ��́A32�r�b�g�̐����^ */

	for (i = 0xa0000; i <= 0xaffff; i++) {
		write_mem8(i, 15); /* MOV BYTE [i],15 */
	}

	for (;;) {
		io_hlt();
	}
}
```

#### ����
##### data == 15�̂Ƃ�
![data == 15�̂Ƃ�](image-5.png)
##### data == 10�̂Ƃ�
![data == 10�̂Ƃ�](image-6.png)

### harib01b
#### �T�v
���܂��ܖ͗l�̍쐬
#### 0x0f��AND���Z
0x0f��15(10)�Ȃ̂�00001111(2),�܂艺��4bit�݂̂����o��.  
�܂�,�F�w��̍�0 ~ 15�̒l���J��Ԃ��l�ɂȂ�.
```
void io_hlt(void);
void write_mem8(int addr, int data);


void HariMain(void)
{
	int i; /* �ϐ��錾�Bi�Ƃ����ϐ��́A32�r�b�g�̐����^ */

	for (i = 0xa0000; i <= 0xaffff; i++) {
		write_mem8(i, i & 0x0f);
	}

	for (;;) {
		io_hlt();
	}
}

```
![���܂���](image-7.png)

#### i�̒l�����̂܂ܐF�w��
���Ă݂�,����0 ~ 255�̐F�̒l���X���C�h���Ă�����.
```
void io_hlt(void);
void write_mem8(int addr, int data);


void HariMain(void)
{
	int i; /* �ϐ��錾�Bi�Ƃ����ϐ��́A32�r�b�g�̐����^ */

	for (i = 0xa0000; i <= 0xaffff; i++) {
		write_mem8(i, i);
	}

	for (;;) {
		io_hlt();
	}
}

```
![Alt text](image-8.png)

### harib01c
#### �|�C���^�̓���
write_mem8��p�~���đ���Ƀ|�C���^��p����

#### �|�C���^�𓱓������̂ŉ��߂ă|�C���^�Ƃ͂Ȃɂ���������
���܂�,write_mem8(addr,data)�����Ă���.
����̈Ӗ���  
'MOV [addr] data'���s���Ă���.(���m�ɂ͈ȉ��̒ʂ�)  
```
_write_mem8:	; void write_mem8(int addr, int data);
		MOV		ECX,[ESP+4]		; [ESP+4]��addr�������Ă���̂ł����ECX�ɓǂݍ���
		MOV		AL,[ESP+8]		; [ESP+8]��data�������Ă���̂ł����AL�ɓǂݍ���
		MOV		[ECX],AL
		RET
```    
������|�C���^��p���邱�ƂŃA�Z���u���R�[�h��p�����ɓ������Ƃ�������.  
�����ŗp������T�O��**�|�C���^**  
```c
int addr, data;
char *p;

p = addr; // p��addr(�A�h���X�Ԓn��n��)
*p = data; //addr�Ԓn�̂Ƃ���ɂȂɂ��̏������s��
```
�Ƃ����`�ŏ������s�����Ƃ��ł���.    
�������A���̂܂܂���addr�Ƃ�������c�̃R���p�C���I�ɃA�h���X�Ԓn��\�������ł͂Ȃ�,�����̐����Ƃ����@���ł��邽��,�����I�Ɏ����Ă����� -> �L���X�g  
```c
int addr, data;
char *p;

p = (char *) addr; // p��addr(�A�h���X�Ԓn��n��)
*p = data; //addr�Ԓn�̂Ƃ���ɂȂɂ��̏������s��
```
c�R���p�C���I�ɉ��o�C�g�������ނ��ɂ���Đ錾���ς��  
```c
char *p //BYTE�p�Ԓn�̏ꍇ
char *p //WORD�p�Ԓn�̏ꍇ
char *p //DWORD�p�Ԓn�̏ꍇ
```
�������,p��p�����Ɏ������邱�Ƃ��ł���  
'(char *) addr'��addr�͂����̐����ł͂Ȃ�,�������Ԓn�����������ł��邱�Ƃ��R���p�C���ɋ���,����ɃA�N�Z�X��data�̒l��^���邱�Ƃ��ł���.  
```c
int addr, data
*((char *) addr) = data
```


#### �|�C���^�̊T�O�𓥂܂���,���݂���Ă��邱�Ƃ𐮗�����.
���i�K��c�\�[�X�R�[�h�͂���  
```c
void io_hlt(void);
void write_mem8(int addr, int data);


void HariMain(void)
{
	int i; /* �ϐ��錾�Bi�Ƃ����ϐ��́A32�r�b�g�̐����^ */
	char *p;
	for (i = 0xa0000; i <= 0xaffff; i++) {
		p = (char * )i;
		*p = i & 0x0f;
	}

	for (;;) {
		io_hlt();
	}
}

```
�����VRAM��'i'�̒l����������ł���,
##### �ł�,�Ȃ�VRAM��0xa0000����n�܂邱�Ƃ�������?
asmhead.nas��BOOT_INFO�֌W�Ɖ�ʃ��[�h�ݒ���Q�Ƃ��邱�Ƃŕ�����  
'VRAM EQU 0x0ff8'��VRAM�̊J�n�Ԓn���i�[����Ă���Ԓn�����������,'MOV DWORD [VRAM],0x000a0000'��,VRAM�̊J�n�Ԓn��0xa0000�ł��邱�Ƃ����܂�Ƃ����`�ł���  
asmhead.nas
```

; BOOT_INFO�֌W
CYLS	EQU		0x0ff0			; �u�[�g�Z�N�^���ݒ肷��
LEDS	EQU		0x0ff1
VMODE	EQU		0x0ff2			; �F���Ɋւ�����B���r�b�g�J���[���H
SCRNX	EQU		0x0ff4			; �𑜓x��X
SCRNY	EQU		0x0ff6			; �𑜓x��Y
VRAM	EQU		0x0ff8			; �O���t�B�b�N�o�b�t�@�̊J�n�Ԓn

		ORG		0xc200			; ���̃v���O�������ǂ��ɓǂݍ��܂��̂�

; ��ʃ��[�h��ݒ�

		MOV		AL,0x13			; VGA�O���t�B�b�N�X�A320x200x8bit�J���[
		MOV		AH,0x00
		INT		0x10
		MOV		BYTE [VMODE],8	; ��ʃ��[�h����������iC���ꂪ�Q�Ƃ���j
		MOV		WORD [SCRNX],320
		MOV		WORD [SCRNY],200
		MOV		DWORD [VRAM],0x000a0000
```

### harib01d ~ e
#### �T�v
�|�C���^�̕��K�Ȃ̂Ŋ���
```c
p = (char *) 0xa;
for (int i = 0; i < 0xffff; i++) *(p + i) = i & 0xf;
```
```c
p = (char *) 0xa;
for (int i = 0; i < 0xffff; i++) p[i] = i & 0xf;
```

### harib01f
#### �T�v
�F�̃p���b�g��ݒ肷��.
#### �ݒ���@
[�r�f�IDA�R���o�[�^�̃p���b�g�̃A�N�Z�X�菇���Q�Ƃ���](http://oswiki.osask.jp/?VGA#:~:text=0%E3%81%A8%E8%A6%8B%E3%81%AA%E3%81%99-,%E3%83%91%E3%83%AC%E3%83%83%E3%83%88%E3%81%AE%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E3%81%AE%E6%89%8B%E9%A0%86,-%E3%81%BE%E3%81%9A%E4%B8%80%E9%80%A3%E3%81%AE)
�ȉ����s��
##### �p���b�g�̃A�N�Z�X�̎菇
- �܂���A�̃A�N�Z�X���Ɋ��荞�݂Ȃǂ�����Ȃ��悤�ɂ���i���Ƃ���CLI�j�B
- 0x03c8�ɐݒ肵�����p���b�g�ԍ����������݁A�����āAR�AG�AB�̏���0x03c9�ɏ������ށB�������̃p���b�g�������Đݒ肵�����̂Ȃ�A�p���b�g�ԍ��̐ݒ���ȗ����āA�����RGB�̏���0x03c9�ɏ�������ł悢�B
- ���݂̃p���b�g��Ԃ�ǂݏo���Ƃ��́A�܂�0x03c7�Ƀp���b�g�ԍ�����������ŁA0x03c9��3��ǂݏo���B���ꂪ����R�AG�AB�ɂȂ��Ă���B������������̃p���b�g���ǂݏo�������Ƃ��́A�p���b�g�ԍ��̐ݒ���ȗ�����RGB�̏��ɓǂݏo���Ă悢�B
- �ŏ���CLI�����ꍇ�́A�Ō��STI����B

#### CLI,STI����
- CLI : CLear Interrupt flag : ���荞�݃t���O(interrupt flag)��0�ɂ��閽��
- STI : STe Interrupt flag : ���荞�݃t���O(interrupt flag)��1�ɂ��閽��
CPU���犄�荞�ݗv���M���������Ƃ��ɖ������邩�ǂ����̃t���O,������0  
#### EFLAGS,FLAGS
EFLAGS : FLAGS��32bit�Ɋg���������
##### FLAGS  
|0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|
|-|-|-|-|-|-|-|-|-|-|--|--|--|--|--|--|
|CF||PF||AF||ZF|SF|TF|IF|DF|OF|IOPL|IOPL|NT||  

**�����IF(Interrpt Flag)�A�܂��9bit�ڂ�0��1�Ŕ��f**
#### io_loat_eflags
##### PUSHFD����
- PUSHFD : PUSH Flags Double-word : �t���O���_�u�����[�h��(�X�^�b�N��)��������
```
_io_load_eflags:	; int io_load_eflags(void);
		PUSHFD		; PUSH EFLAGS �Ƃ����Ӗ�
		POP		EAX
		RET
```

##### DX,AL�ɂ���
- DX : �f�[�^
- AL : AX��LOW
- AX : �ݐω��Z��
#### io_out8
- 'MOV EDX, [ESP+4]'��port�̏���EDX�ɓn���A���̎��ŏI�I��DX�ŉ���16bit�݂̂ɂȂ邪32bit���Ŏ��s���Ă��邽�߃R�[�h�̈�ѐ���ۂ��߂ɂ�EDX�Ŏ󂯎��  
- 'MOV AL,[ESP+8]'
- 'OUT DX,AL' : 
- 'RET'

##### OUT����
- OUT���� : ���u�ɓd�C�M���𑗂�M��
```
_io_out8:	; void io_out8(int port, int data);
		MOV		EDX,[ESP+4]		; port
		MOV		AL,[ESP+8]		; data
		OUT		DX,AL
		RET
```
#### set_palette
```c
void set_palette(int start, int end, unsigned char *rgb)
{
	int i, eflags;
	eflags = io_load_eflags();	/* ���荞�݋��t���O�̒l���L�^���� */
	io_cli(); 					/* ���t���O��0�ɂ��Ċ��荞�݋֎~�ɂ��� */
	io_out8(0x03c8, start); //0x03c8�ɐݒ肵�����p���b�g�ԍ�����������
	for (i = start; i <= end; i++) { //�����āAR�AG�AB�̏���0x03c9�ɏ�������,
		io_out8(0x03c9, rgb[0] / 4);
		io_out8(0x03c9, rgb[1] / 4);
		io_out8(0x03c9, rgb[2] / 4);
		rgb += 3;
	}//�������̃p���b�g�������Đݒ肵�����̂Ȃ�A�p���b�g�ԍ��̐ݒ���ȗ����āA�����RGB�̏���0x03c9�ɏ�������ł悢�B
	io_store_eflags(eflags);	/* ���荞�݋��t���O�����ɖ߂� */
	return;
}

```


#### init_palette(void)
����,rgb�̕\���쐬���邾��
init_palette(void)
```c
void init_palette(void)
{
	static unsigned char table_rgb[16 * 3] = {
		0x00, 0x00, 0x00,	/*  0:�� */
		0xff, 0x00, 0x00,	/*  1:���邢�� */
		0x00, 0xff, 0x00,	/*  2:���邢�� */
		0xff, 0xff, 0x00,	/*  3:���邢���F */
		0x00, 0x00, 0xff,	/*  4:���邢�� */
		0xff, 0x00, 0xff,	/*  5:���邢�� */
		0x00, 0xff, 0xff,	/*  6:���邢���F */
		0xff, 0xff, 0xff,	/*  7:�� */
		0xc6, 0xc6, 0xc6,	/*  8:���邢�D�F */
		0x84, 0x00, 0x00,	/*  9:�Â��� */
		0x00, 0x84, 0x00,	/* 10:�Â��� */
		0x84, 0x84, 0x00,	/* 11:�Â����F */
		0x00, 0x00, 0x84,	/* 12:�Â��� */
		0x84, 0x00, 0x84,	/* 13:�Â��� */
		0x00, 0x84, 0x84,	/* 14:�Â����F */
		0x84, 0x84, 0x84	/* 15:�Â��D�F */
	};
	set_palette(0, 15, table_rgb);
	return;

	/* static char ���߂́A�f�[�^�ɂ����g���Ȃ�����DB���ߑ��� */
}
```
![Alt text](image-9.png)

### harib01g,f
#### �T�v
�l�p�`��`�悵��OS���ۂ���ʂ��邾��
![Alt text](image-10.png)

## Day5
### harib02a
#### �T�v
���̉�ʃ��[�h�ɂ����Ƃ���VRAM�̊J�n�Ԓn��x,y�̃T�C�Y���ς��̂œ��I�Ɏ擾�ł���悤�ɂ���  

#### harimain()
�|�C���^�ł�邾��  
- binfo : bootinfo�̈�  
```c
void HariMain(void)
{
	char *vram;
	int xsize, ysize;
	short *binfo_scrnx, *binfo_scrny;
	int *binfo_vram;

	init_palette();
	binfo_scrnx = (short *) 0x0ff4;
	binfo_scrny = (short *) 0x0ff6;
	binfo_vram = (int *) 0x0ff8;
	xsize = *binfo_scrnx;
	ysize = *binfo_scrny;
	vram = (char *) *binfo_vram;

	init_screen(vram, xsize, ysize);

	for (;;) {
		io_hlt();
	}
}
```

#### �Q�l : asmhead.nas
```
; BOOT_INFO�֌W
CYLS	EQU		0x0ff0			; �u�[�g�Z�N�^���ݒ肷��
LEDS	EQU		0x0ff1
VMODE	EQU		0x0ff2			; �F���Ɋւ�����B���r�b�g�J���[���H
SCRNX	EQU		0x0ff4			; �𑜓x��X
SCRNY	EQU		0x0ff6			; �𑜓x��Y
VRAM	EQU		0x0ff8			; �O���t�B�b�N�o�b�t�@�̊J�n�Ԓn

		ORG		0xc200			; ���̃v���O�������ǂ��ɓǂݍ��܂��̂�

; ��ʃ��[�h��ݒ�

		MOV		AL,0x13			; VGA�O���t�B�b�N�X�A320x200x8bit�J���[
		MOV		AH,0x00
		INT		0x10
		MOV		BYTE [VMODE],8	; ��ʃ��[�h����������iC���ꂪ�Q�Ƃ���j
		MOV		WORD [SCRNX],320
		MOV		WORD [SCRNY],200
		MOV		DWORD [VRAM],0x000a0000
```
#### harib01b
### �T�v
�\���̂�p���ăV���v����BOOTINFO��\��

### �\���̂ƃ|�C���^(�������낢)
|0x0ff0|0x0ff1|0x0ff2|0x0ff3|0x0ff4|0x0ff5|0x0ff6|0x0ff7|0x0ff8|0x0ff9|0x0ffa|0x0ffb|
|------|------|------|------|------|------|------|------|------|------|------|------|
| cyls | leds | vmode| reserve | SCRNX (2 bytes) | SCRNX (2 bytes) | SCRNY (2 bytes) |SCRNY (2 bytes) |    VRAM (4 bytes)   |   VRAM (4 bytes)   |   VRAM (4 bytes)   |   VRAM (4 bytes)   |  

����Ő擪�������Ă�
```
binfo = (struct BOOTINFO *) 0x0ff0;
```

```
struct BOOTINFO {
	char cyls, leds, vmode, reserve;
	short scrnx, scrny;
	char *vram;
};

void HariMain(void)
{
	char *vram;
	int xsize, ysize;
	struct BOOTINFO *binfo;

	init_palette();
	binfo = (struct BOOTINFO *) 0x0ff0;
	xsize = (*binfo).scrnx;
	ysize = (*binfo).scrny;
	vram = (*binfo).vram;

	init_screen(vram, xsize, ysize);

	for (;;) {
		io_hlt();
	}
}
```

#### harib02c
##### �T�v
�A���[���Z�q�ɂ���

#### harib02d


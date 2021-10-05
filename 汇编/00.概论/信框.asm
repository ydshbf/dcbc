; 改自 fasm\EXAMPLES\PEDEMO
; 32-位裸PE程序
; 源档编码 utf-8

format PE GUI
entry 始

section '.text' code readable executable

  始:

	push	0
	push	标题
	push	信
	push	0
	call	[信框]

	push	0
	call	[退出]

include "encoding\utf8.inc"
section '.data' data readable writeable

  标题 du '🦅Win32汇编编程😄️',0
  信 du '平直汇编！',0

section '.idata' import data readable writeable

  dd 0,0,0,RVA 核库,RVA 核库函表
  dd 0,0,0,RVA 用户库,RVA 户库函表
  dd 0,0,0,0,0

  核库函表:
    退出 dd RVA _退出
    dd 0
  户库函表:
    信框 dd RVA _信框
    dd 0

  核库 db 'KERNEL32.DLL',0
  用户库 db 'USER32.DLL',0

  _退出 dw 0
    db 'ExitProcess',0
  _信框 dw 0
    db 'MessageBoxW',0

section '.reloc' fixups data readable discardable	; win32重定位

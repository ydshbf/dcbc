; ----------------------------------------------------------------------------------------
; nasm 不支持万国码标词命名
; 64-bit Linux 汇编，编译运行:
; 编译：    nasm -felf64 开始.asm 
; 链接：    ld 开始.o -o 开始 # 也可用gold,ld.lld
; 运行：   ./开始
; 参考：
; 1. https://cs.lmu.edu/~ray/notes/nasmtutorial/
; 2. https://filippo.io/linux-syscall-table/
; ----------------------------------------------------------------------------------------

          global    _start

          section   .text
_start:   mov       rax, 1                  ; write调号为1
          mov       rdi, 1                  ; 标出档号为1
          mov       rsi, message            ; 串地址
          mov       rdx, 27                 ; 串字节数
          syscall                           ; 叫系统调write
          mov       rax, 60                 ; exit调号为60
          xor       rdi, rdi                ; 退码取0
          syscall                           ; 叫系统调exit

          section   .data
message:  db        "nasm不支持万国码！",10, 0      ; 10换行，0串尾
; 用Python3求出utf-8串字节数：s2 = "nasm不支持万国码！"
; len(s2.encode("utf-8"))

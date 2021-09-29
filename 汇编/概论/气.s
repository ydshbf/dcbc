# ----------------------------------------------------------------------------------------
# gas 支持万国码命名标词, clang-as却不支持
# 64-bit Linux 汇编，编译运行:
# 编译：    gcc -c 气.s 
# 链接：    ld 气.o -o 气 # 也可用gold,ld.lld
# 链接结果：ld、ld.lld有警告，但可以跑；gold无警告但不可跑
# 运行：   ./气
# 参考：
# 1. https://cs.lmu.edu/~ray/notes/nasmtutorial/
# 2. https://filippo.io/linux-syscall-table/
# 3. https://stackoverflow.com/questions/42301831/change-entry-point-with-gnu-linker
# ----------------------------------------------------------------------------------------

        .global _始

        .text
_始:
        # write(1, 消息, 13)
        mov     $1, %rax                # write调号为1
        mov     $1, %rdi                # 标出档号为1
        mov     $消息, %rsi          	# 串地址
        mov     $26, %rdx               # 串字节数
        syscall                         # 叫系统调write

        # exit(0)
        mov     $60, %rax               # exit调号为60
        xor     %rdi, %rdi              # 退码取0
        syscall                         # 叫系统调exit
消息:
        .ascii  "gas比nasm稍微好点。\n"

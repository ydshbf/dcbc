/*OUTPUT_FORMAT("elf32-i386");*/
/*
ld.lld -T布局.ld 程口.o 先.o -o 改程口；对万国码支持不彻底
ld, gold不支持万国码
参考：
* 1. https://stackoverflow.com/questions/42301831/change-entry-point-with-gnu-linker
* 2. https://lore.kernel.org/lkml/CAKwvOdnJR3vbHd6Z0eLK9CppABWFL4E0Rjh6SzDN6U6mShS2qQ@mail.gmail.com/T/
*/
OUTPUT_FORMAT("elf64-x86-64");

/* ENTRY(_始);  ld.lld不认_始*/
ENTRY(_rukou); 


SECTIONS
{
    /* 载代码及数据的内存块地址(VMA) 
     * Linux中默认为0x400000, 多启动器默认为 0x100000  
     */
    . = 0x400000;

    /* 代码区内放 .先 区于首位 */
    .text : {
        *(.先);
        *(.text*);
    }

    /* 数据区 */
    .data : {
        *(.data*);
    }

    .rodata : {
        *(.rodata*);
    }

    /* 存未赋值变量的BSS区 */
    .bss : {
        __bss_start = .;
        *(COMMON);
        *(.bss);
        . = ALIGN(4);
        __bss_end = .;
    }

    /* 可能用到BSS区大小 */
    __bss_size = ((__bss_end)-(__bss_start));

    /* 丢冗区 */
    /DISCARD/ : {
        *(.note.gnu.build-id);
        *(.eh_frame);
        *(.note*);
        *(.comment*);
    }
}


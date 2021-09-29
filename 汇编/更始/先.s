# gcc -O2 -c 先.s; gas支持万国码
# clang -O2 -c 先.s; 出错：clang-as不支持万国码
# 用.global导出入口标识
# .global  _始
.global  _rukou

# 造特区名之曰.先
# 设成可分配可运行, allocatable executable
.section .先, "ax"

#_始: gas认_始，但ld.lld 不认
_rukou:

jmp 主

.text
# 其余代码置于 .text 区


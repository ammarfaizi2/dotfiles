set auto-load safe-path /
define my_bt
    set $_i=0
    set $_frame_ptr=$rbp
    set $_pc=$pc
    set listsize 1

    printf "#%u %p\n", $_i, $_pc
    list *$_pc-8,*$_pc
    printf "---------------------------------------\n"

    while (*(void **)$_frame_ptr)
        set $_ret_addr=*(void **)($_frame_ptr+8)
        set $_i=$_i+1
        printf "#%u %p\n", $_i, $_ret_addr
        list *$_ret_addr-8,*$_ret_addr
        printf "---------------------------------------\n"
        set $_frame_ptr=*(void **)$_frame_ptr
    end
end
set history save on
set history size 512
source /home/ammarfaizi2/project/now/gef/gef.py
set disassembly-flavor att
gef config gef.debug False
#add-symbol-file kernelfull.o 0x100000


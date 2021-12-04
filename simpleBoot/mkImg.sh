dd if=/dev/zero of=flp.img bs=512 count=2880
losetup /dev/loop0 flp.img
objdump -h boot
dd if=boot ibs=512 skip=8 of=/dev/loop0 obs=512 seek=0 count=1

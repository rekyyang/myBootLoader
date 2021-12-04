ALL:
	cpp boot.S > bboot.S
	as -gstabs -o boot.o bboot.S --32
	ld -o boot boot.o -Tboot.ld
	
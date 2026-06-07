run:
	nasm -f bin main.asm -o boot.bin

build : 
	qemu-system-x86_64 -drive format=raw,file=boot.bin -nographic 

compile:
	gcc main.o -o main -no-pie


clean:
	rm -f main.o main

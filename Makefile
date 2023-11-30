CONFIG_MODULE_SIG=n

KSRC ?= /lib/modules/$(shell uname -r)/build
#KSRC ?= /home/ubuntu/workspace/debug_linux5.0_x86

obj-m += ivpci.o
all:
	make -C $(KSRC) M=$(PWD) modules
	gcc -g -O0 ioctl.c -o ioctl
clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
	rm -rf ioctl
This is a repo for ivshmem

## 1. ivshmem
plain memory share between several VMs


## 2.ivshmem-doorbell
add interrupt and doorbell mechanism for several VMs


## 3.How to Test
test for interrupt injection

### (0) preset
On Host machine run follow commands, make sure qemu is installed :

ivshmem-server -l 4M -M fg-doorbell -n 8 -F -v


### (1) Compile

make

### (2) load VM
if using qemu raw cmd to load VM, add following command

-chardev socket,path=/tmp/ivshmem_socket,id=fg-doorbell
-device ivshmem-doorbell,chardev=fg-doorbell,vectors=8

### (3) load driver

insmod ivpci.ko

### (4) Test 

#### In VM0

./ioctl /dev/ivpci0 wait

VM0 shall wait till interrupt hits

#### In VM1
assume VM0 peerid is 1, to trigger VM0 ivshmem 0 interrupt, run as follow

./ioctl /dev/ivpci0 ring 1 0

username = $(shell whoami)
files = fsmain.c fsoperations.c fstree.c bitmap.c fsdisk.c
opflag = -o fs
flags = `pkg-config fuse --cflags --libs` -DFUSE_USE_VERSION=25 -lm -g

all: run

run: compile
	./fs -f /home/$(username)/Desktop/mountpoint1

debugrun: dcompile
	valgrind --track-origins=yes ./fs -d -f -s /home/$(username)/Desktop/mountpoint1

compile: checkdir
	gcc -Wall $(files) $(opflag) $(flags)

dcompile: checkdir	
	gcc -Wall -g $(files) $(opflag) $(flags)

checkdir:
	if [ -d "/home/$(username)/Desktop/mountpoint1" ]; then echo "mountpoint1 exists"; else mkdir /home/$(username)/Desktop/mountpoint1; fi

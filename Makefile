# TODO: to run it directly on computer, make so that "make th" (like in prt/ repo) will
#       use clang instead of th-gcc in two places below

# current gcc version on openwrt (5.3.0) gives warnings which it must not give
# (clang-4.0.1 and gcc-7.2.0 on my computer do not give them), so disable sign-conversion warnings
CC=th-gcc -Wno-sign-conversion

THD_COMPS := thd keystate trigger eventnames devices cmdsocket obey ignore uinput triggerparser

MAKEDEPEND = th-gcc -M -MG $(CFLAGS) -o $*.d $<

all: thd

thd: $(THD_COMPS:%=%.o)

clean:
	rm -f *.d
	rm -f *.o
	rm -f thd

ifeq ($(shell whereami),home)
VENDORID=13ba
PRODUCTID=0001
else ifeq ($(shell whereami),notebook)
VENDORID=1c4f
PRODUCTID=0002
else
VENDORID=04d9
PRODUCTID=1702
endif

boot: all
	@! test -e lock-image || ( echo ALREADY RUNNING; false )
	@touch lock-image
	@cd /var/local/x86/ && qemu-system-x86_64 -enable-kvm -drive format=raw,file=x86.img -nographic -usb -device usb-host,bus=usb-bus.0,vendorid=0x${VENDORID},productid=0x${PRODUCTID}
	@rm lock-image

%.d : %.c
	$(MAKEDEPEND)

-include $(THD_COMPS:%=%.d)

prog: prog.c
	th-gcc -o $@ $<


#if you want to transport a file with scp from host to guest, start the guest with
# "-device e1000,netdev=user.0 -netdev user,id=user.0,hostfwd=tcp::5555-:22"
# Now you are forwarding the host port 5555 to the guest port 22. After starting up the guest,
# you can transport a file with e.g. "scp -P 5555 file.txt root@localhost:/tmp" from host to guest

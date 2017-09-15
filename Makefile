# TODO: try to run it directly on computer - without openwrt and virtual machine
# TODO: use clang if we run "make th" (like in prt/ repo) - because clang hase #line patch

DESTDIR:=/var/local/x86-builder/files
BINDIR:=$(DESTDIR)/usr/sbin
MANDIR:=$(DESTDIR)/usr/share/man/man1

# current gcc version on openwrt (5.3.0) gives warnings which it must not give
# (clang-4.0.1 and gcc-7.2.0 on my computer do not give them), so disable sign-conversion warnings
CC=th-gcc -Wno-sign-conversion

THD_COMPS := thd keystate trigger eventnames devices cmdsocket obey ignore uinput triggerparser
THCMD_COMPS := th-cmd cmdsocket

MAKEDEPEND = th-gcc -M -MG $(CFLAGS) -o $*.d $<

all: thd th-cmd

thd: $(THD_COMPS:%=%.o)

th-cmd: $(THCMD_COMPS:%=%.o)

clean:
	rm -f *.d
	rm -f *.o
	rm -f thd th-cmd
	rm -f thd.1 th-cmd.1

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

-include $(THD_COMPS:%=%.d) $(THCMD_COMPS:%=%.d)

prog: prog.c
	th-gcc -o $@ $<

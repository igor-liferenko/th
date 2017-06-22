CC:=STAGING_DIR=/var/local/x86-sdk /var/local/x86-sdk/bin/x86_64-openwrt-linux-gcc

DESTDIR:=/var/local/x86-builder/files
BINDIR:=$(DESTDIR)/usr/sbin
MANDIR:=$(DESTDIR)/usr/share/man/man1

VERSION:=$(shell cat version.inc)

THD_COMPS := thd keystate trigger eventnames devices cmdsocket obey ignore uinput triggerparser
THCMD_COMPS := th-cmd cmdsocket

MAKEDEPEND = $(CC) -M -MG $(CFLAGS) -o $*.d $<

all: thd th-cmd man prog

prog:
	ctangle prog.w
	$(CC) prog.c -o prog

man: thd.1 th-cmd.1

thd: $(THD_COMPS:%=%.o)

th-cmd: $(THCMD_COMPS:%=%.o)

%.1: %.pod
	pod2man \
		--center="Triggerhappy daemon" \
		--section=1 \
		--release="$(VERSION)" \
		$< > $@

linux_input_defs_gen.inc:
	echo "#include <linux/input.h>" | STAGING_DIR=/var/local/x86-sdk /var/local/x86-sdk/bin/x86_64-openwrt-linux-gcc $(CFLAGS) -dM -E - > $@

evtable_%.inc: linux_input_defs_gen.inc
	awk '/^#define $*_/ && $$2 !~ /_(MAX|CNT|VERSION)$$/ {print "EV_MAP("$$2"),"}' $< > $@

version.h: version.inc
	sed -r 's!(.*)!#define TH_VERSION "\1"!' $< > $@

clean:
	rm -f *.d
	rm -f *.o
	rm -f linux_input_defs_gen.inc
	rm -f evtable_*.inc
	rm -f version.h
	rm -f thd th-cmd
	rm -f thd.1 th-cmd.1

VENDORID=$(shell if [ "`whereami 2>/dev/null`" = home ]; then echo 13ba; else echo 04d9; fi)
PRODUCTID=$(shell if [ "`whereami 2>/dev/null`" = home ]; then echo 0001; else echo 1702; fi)

boot: all
	@! test -e lock-image || ( echo ALREADY RUNNING; false )
	@touch lock-image
	@cd /var/local/x86/ && qemu-system-x86_64 -enable-kvm -drive format=raw,file=x86.img -nographic -usb -device usb-host,bus=usb-bus.0,vendorid=0x${VENDORID},productid=0x${PRODUCTID}
	@rm lock-image

%.d : %.c
	$(MAKEDEPEND)

-include $(THD_COMPS:%=%.d) $(THCMD_COMPS:%=%.d)

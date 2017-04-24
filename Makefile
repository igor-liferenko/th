PREFIX:=/usr/
DESTDIR:=/var/local/x86-builder/files
BINDIR:=$(DESTDIR)/$(PREFIX)/sbin
MANDIR:=$(DESTDIR)/$(PREFIX)/share/man/man1

VERSION:=$(shell cat version.inc)

THD_COMPS := thd keystate trigger eventnames devices cmdsocket obey ignore uinput triggerparser
THCMD_COMPS := th-cmd cmdsocket

MAKEDEPEND = STAGING_DIR=/var/local/x86-sdk /var/local/x86-sdk/bin/x86_64-openwrt-linux-gcc -M -MG $(CPPFLAGS) -o $*.d $<

all: thd th-cmd man

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
	echo "#include <linux/input.h>" | STAGING_DIR=/var/local/x86-sdk /var/local/x86-sdk/bin/x86_64-openwrt-linux-gcc $(CPPFLAGS) -dM -E - > $@

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

install: all
	#NOTE: add triggerhappy to PACKAGES and comment "install" commands and in openwrt run
	#"opkg files triggerhappy" and check that it is equal to current setup
	rm -f /var/local/x86-builder
	rm -fr /var/local/x86/OpenWrt-ImageBuilder-*
	tar -C /var/local/x86 -jxf /usr/local/SUPER_DEBIAN/x86-builder.tar.bz2
	ln -s `ls -d /var/local/x86/OpenWrt-ImageBuilder-*` /var/local/x86-builder
	mkdir -p /var/local/x86-builder/files/etc/
	cp -r conf/ /var/local/x86-builder/files/etc/triggerhappy/
	install -D thd $(BINDIR)/thd
	install -D th-cmd $(BINDIR)/th-cmd
	install -D thd.1 $(MANDIR)/thd.1
	install -D th-cmd.1 $(MANDIR)/th-cmd.1
	make -C /var/local/x86-builder image PACKAGES="kmod-usb-hid kmod-hid-generic kmod-usb-ohci" FILES=files/

%.d : %.c
	$(MAKEDEPEND)

-include $(THD_COMPS:%=%.d) $(THCMD_COMPS:%=%.d)

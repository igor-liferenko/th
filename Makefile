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
VENDORID=0403
PRODUCTID=6001
else
VENDORID=04d9
PRODUCTID=1702
endif

boot: all
	@! ps -ef | grep -q [q]emu-system-x86_64 || ( echo ALREADY RUNNING; false )
	@cd /var/local/x86/ && qemu-system-x86_64 -m 64 `if [ $$(whereami) != notebook ]; then echo -enable-kvm; fi` -drive format=raw,file=x86.img -daemonize -serial null -parallel null -monitor none -display none -vga none -usb -device usb-host,bus=usb-bus.0,vendorid=0x${VENDORID},productid=0x${PRODUCTID} -net user,hostfwd=tcp::5555-:22 -net nic # the "whereami" test is necessary because -enable-kvm option does not work on notebook

%.d : %.c
	$(MAKEDEPEND)

-include $(THD_COMPS:%=%.d)

prog: prog.c
	th-gcc -o $@ $<

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

# TODO: vendorid/productid check is too general - other devices may fall into it, so better change "-device usb-host,bus=usb-bus.0,vendorid=0x${VENDORID},productid=0x${PRODUCTID}" to "-device usb-host,hostbus=X,hostaddr=Y"
# Use this command to get X and Y values for above command (the first line of output is X, the second - Y):
# udevadm info --name=/dev/ttyUSB0 --attribute-walk | sed -n 's/\s*ATTRS{\(\(devnum\)\|\(busnum\)\)}==\"\([^\"]\+\)\"/\4/p' | head -n 2
# Finally, use udev rule which sets SYMLINK+="unique_name" for a specific device and use /dev/unique_name instead of /dev/ttyUSB0 in above command.
# NOTE: for some devices /dev/xxx is not created (e.g., usb keyboard) - for such devices find another way to automatically determine devnum and busnum ANSWER: use SUBSYSTEM=="usb" ... SYMLINK+=... - then /dev/unique_name will be created, pointing to bus/<busnum>/<devnum>
boot: all
	@! ps h -fC qemu-system-x86_64 | grep -v newcd-qemu | grep -q . || ( echo ALREADY RUNNING; false )
	@cd /var/local/x86/ && qemu-system-x86_64 -m 64 `if [ $$(whereami) != notebook ]; then echo -enable-kvm; fi` -drive format=raw,file=x86.img -daemonize -serial null -parallel null -monitor none -display none -vga none -usb -device usb-host,bus=usb-bus.0,vendorid=0x${VENDORID},productid=0x${PRODUCTID} -net user,hostfwd=tcp::5555-:22 -net nic # the "whereami" test is necessary because -enable-kvm option does not work on notebook
	@echo connect with ssh -p 5555 root@localhost

%.d : %.c
	$(MAKEDEPEND)

-include $(THD_COMPS:%=%.d)

prog: prog.c
	th-gcc -o $@ $<

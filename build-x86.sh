#!/bin/bash -x
# https://wiki.openwrt.org/doc/howto/obtain.firmware.generate

# FIXME: is vsyscall=emulate needed here?

IMG=OpenWrt-ImageBuilder-x86-64.Linux-x86_64
SDK=OpenWrt-SDK-x86-64_gcc-5.3.0_musl-1.1.16.Linux-x86_64
mkdir -p ~/openwrt
cd ~/openwrt
[ -e $IMG.tar.bz2 ] || wget https://downloads.openwrt.org/snapshots/trunk/x86/64/$IMG.tar.bz2 || exit
[ -e $SDK.tar.bz2 ] || wget https://downloads.openwrt.org/snapshots/trunk/x86/64/$SDK.tar.bz2 || exit
rm -fr x86/
mkdir x86/
cd x86/
tar -jxf ../$IMG.tar.bz2
cd $IMG/
mkdir -p files/etc/
mkdir -p files/usr/sbin/
ln -s /mnt/conf/ files/etc/triggerhappy
ln -s /mnt/thd files/usr/sbin/thd
ln -s /mnt/th-cmd files/usr/sbin/th-cmd
mkdir -p files/etc/
cat << EOF > files/etc/rc.local
while ! mount|grep -q ^10.0.2.2; do
  mount.nfs 10.0.2.2:/home/user/th/ /mnt/ -o nolock,vers=3
done
exit 0
EOF
mkdir -p files/etc/uci-defaults/
cat << EOF > files/etc/uci-defaults/my
uci set network.lan.proto=dhcp
uci commit network
EOF
make info; exit # make image PROFILE=???? PACKAGES="nfs-utils kmod-usb-hid kmod-hid-generic kmod-usb-ohci" FILES=files/
gunzip bin/x86/openwrt-x86-64-combined-ext4.img.gz
rm -fr /var/local/x86/
mkdir /var/local/x86/
# copy sdk:
tar -C /var/local/x86 -jxf bin/x86/OpenWrt-SDK-*.tar.bz2
rm -f /var/local/x86-sdk
ln -s /var/local/x86/*/staging_dir/toolchain* /var/local/x86-sdk
rm -f /usr/local/SUPER_DEBIAN/x86-sdk.tar.bz2
cp bin/x86/OpenWrt-SDK-*.tar.bz2 /usr/local/SUPER_DEBIAN/x86-sdk.tar.bz2
# copy img:
cp bin/x86/openwrt-x86-64-combined-ext4.img /var/local/x86/x86.img
rm -f /usr/local/SUPER_DEBIAN/x86.img
cp bin/x86/openwrt-x86-64-combined-ext4.img /usr/local/SUPER_DEBIAN/x86.img

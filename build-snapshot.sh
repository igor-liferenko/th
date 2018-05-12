#!/bin/bash -x

IMG=openwrt-imagebuilder-x86-64.Linux-x86_64
SDK=openwrt-sdk-x86-64_gcc-7.3.0_musl.Linux-x86_64
mkdir -p ~/openwrt
cd ~/openwrt
[ -e $IMG.tar.xz ] || wget https://downloads.openwrt.org/snapshots/targets/x86/64/$IMG.tar.xz || exit
[ -e $SDK.tar.xz ] || wget https://downloads.openwrt.org/snapshots/targets/x86/64/$SDK.tar.xz || exit
rm -fr x86/
mkdir x86/
cd x86/
tar -Jxf ../$IMG.tar.xz
cd $IMG/
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
uci set system.@system[0].timezone=GMT-7
uci commit system
EOF
make image PROFILE=Generic PACKAGES="nfs-utils kmod-fs-nfs kmod-usb-uhci kmod-usb-acm" FILES=files/
gunzip bin/targets/x86/64/openwrt-x86-64-combined-ext4.img.gz
rm -fr /var/local/x86/
mkdir /var/local/x86/
# copy sdk:
tar -C /var/local/x86 -Jxf ../../$SDK.tar.xz
rm -f /var/local/x86-sdk
ln -s /var/local/x86/*/staging_dir/toolchain* /var/local/x86-sdk
# copy img:
cp bin/targets/x86/64/openwrt-x86-64-combined-ext4.img /var/local/x86/x86.img

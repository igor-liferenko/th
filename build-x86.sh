#!/bin/bash -x

IMG=lede-imagebuilder-17.01.4-x86-64.Linux-x86_64
SDK=lede-sdk-17.01.4-x86-64_gcc-5.4.0_musl-1.1.16.Linux-x86_64
mkdir -p ~/lede
cd ~/lede
[ -e $IMG.tar.xz ] || wget https://downloads.lede-project.org/releases/17.01.4/targets/x86/64/$IMG.tar.xz || exit
[ -e $SDK.tar.xz ] || wget https://downloads.lede-project.org/releases/17.01.4/targets/x86/64/$SDK.tar.xz || exit
rm -fr x86/
mkdir x86/
cd x86/
tar -Jxf ../$IMG.tar.xz
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
uci set system.@system[0].timezone=GMT-7
uci commit system
EOF
make image PROFILE=Generic PACKAGES="nfs-utils kmod-fs-nfs kmod-usb-uhci kmod-usb-acm mpc" FILES=files/
gunzip bin/targets/x86/64/lede-17.01.4-x86-64-combined-ext4.img.gz
rm -fr /var/local/x86/
mkdir /var/local/x86/
# copy sdk:
tar -C /var/local/x86 -Jxf ../../$SDK.tar.xz
rm -f /var/local/x86-sdk
ln -s /var/local/x86/*/staging_dir/toolchain* /var/local/x86-sdk
rm -f /usr/local/SUPER_DEBIAN/x86-sdk.tar.xz
cp ../../$SDK.tar.xz /usr/local/SUPER_DEBIAN/x86-sdk.tar.xz
# copy img:
cp bin/targets/x86/64/lede-17.01.4-x86-64-combined-ext4.img /var/local/x86/x86.img
rm -f /usr/local/SUPER_DEBIAN/x86.img
cp bin/targets/x86/64/lede-17.01.4-x86-64-combined-ext4.img /usr/local/SUPER_DEBIAN/x86.img

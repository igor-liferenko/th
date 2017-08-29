#!/bin/bash -x

# https://wiki.openwrt.org/doc/howto/build

export PATH=$PATH:~/openwrt/x86/staging_dir/host/bin

mkdir -p ~/openwrt
cd ~/openwrt
[ -d x86 ] && exit
git clone git://github.com/openwrt/openwrt.git x86
cd x86/
./scripts/feeds update packages
./scripts/feeds install nfs-utils
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
cat << EOF > .config
CONFIG_TARGET_x86=y
CONFIG_TARGET_x86_64=y
CONFIG_TARGET_x86_64_Generic=y
CONFIG_DEVEL=y
CONFIG_BUILD_NLS=y
CONFIG_SDK=y
CONFIG_PACKAGE_iconv=y
CONFIG_PACKAGE_libcharset=y
CONFIG_PACKAGE_libiconv-full=y
CONFIG_PACKAGE_libintl-full=y
CONFIG_BUSYBOX_CUSTOM=y
CONFIG_BUSYBOX_CONFIG_LAST_SUPPORTED_WCHAR=0
CONFIG_BUSYBOX_CONFIG_LOCALE_SUPPORT=y
CONFIG_BUSYBOX_CONFIG_SUBST_WCHAR=65533
CONFIG_BUSYBOX_CONFIG_UNICODE_PRESERVE_BROKEN=y
CONFIG_BUSYBOX_CONFIG_UNICODE_SUPPORT=y
CONFIG_BUSYBOX_CONFIG_UNICODE_USING_LOCALE=y
CONFIG_PACKAGE_kmod-nls-utf8=y
CONFIG_PACKAGE_kmod-fs-nfs=y
CONFIG_PACKAGE_nfs-utils=y
CONFIG_PACKAGE_kmod-usb-hid=y
CONFIG_PACKAGE_kmod-hid-generic=y
CONFIG_PACKAGE_kmod-usb-ohci=y
CONFIG_ALL_KMODS=y
EOF
make defconfig
make
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

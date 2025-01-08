if ! [ -e /tmp/amsfonts.zip ]; then
  echo Download to /tmp https://www.ams.org/arc/tex/amsfonts.zip
  exit
fi
rm -fr /tmp/cm/; mkdir /tmp/cm/
unzip -j -d /tmp/cm /tmp/amsfonts.zip fonts/type1/public/amsfonts/cm/\*.pfb >/dev/null
t1disasm /tmp/cm/cmb10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmb10.pfb
t1disasm /tmp/cm/cmbx10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmbx10.pfb
t1disasm /tmp/cm/cmbx12.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmbx12.pfb
t1disasm /tmp/cm/cmbx5.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmbx5.pfb
t1disasm /tmp/cm/cmbx6.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmbx6.pfb
t1disasm /tmp/cm/cmbx7.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmbx7.pfb
t1disasm /tmp/cm/cmbx8.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmbx8.pfb
t1disasm /tmp/cm/cmbx9.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmbx9.pfb
t1disasm /tmp/cm/cmbxsl10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmbxsl10.pfb
t1disasm /tmp/cm/cmbxti10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmbxti10.pfb
t1disasm /tmp/cm/cmcsc10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmcsc10.pfb
t1disasm /tmp/cm/cmdunh10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmdunh10.pfb
t1disasm /tmp/cm/cmff10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmff10.pfb
t1disasm /tmp/cm/cmfi10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmfi10.pfb
t1disasm /tmp/cm/cmfib8.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmfib8.pfb
t1disasm /tmp/cm/cmitt10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmitt10.pfb
t1disasm /tmp/cm/cmr10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmr10.pfb
t1disasm /tmp/cm/cmr12.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmr12.pfb
t1disasm /tmp/cm/cmr17.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmr17.pfb
t1disasm /tmp/cm/cmr5.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmr5.pfb
t1disasm /tmp/cm/cmr6.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmr6.pfb
t1disasm /tmp/cm/cmr7.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmr7.pfb
t1disasm /tmp/cm/cmr8.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmr8.pfb
t1disasm /tmp/cm/cmr9.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmr9.pfb
t1disasm /tmp/cm/cmsl10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmsl10.pfb
t1disasm /tmp/cm/cmsl12.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmsl12.pfb
t1disasm /tmp/cm/cmsl8.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmsl8.pfb
t1disasm /tmp/cm/cmsl9.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmsl9.pfb
t1disasm /tmp/cm/cmsltt10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmsltt10.pfb
t1disasm /tmp/cm/cmss10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmss10.pfb
t1disasm /tmp/cm/cmss12.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmss12.pfb
t1disasm /tmp/cm/cmss17.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmss17.pfb
t1disasm /tmp/cm/cmss8.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmss8.pfb
t1disasm /tmp/cm/cmss9.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmss9.pfb
t1disasm /tmp/cm/cmssbx10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmssbx10.pfb
t1disasm /tmp/cm/cmssdc10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmssdc10.pfb
t1disasm /tmp/cm/cmssi10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmssi10.pfb
t1disasm /tmp/cm/cmssi12.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmssi12.pfb
t1disasm /tmp/cm/cmssi17.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmssi17.pfb
t1disasm /tmp/cm/cmssi8.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmssi8.pfb
t1disasm /tmp/cm/cmssi9.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmssi9.pfb
t1disasm /tmp/cm/cmssq8.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmssq8.pfb
t1disasm /tmp/cm/cmssqi8.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmssqi8.pfb
t1disasm /tmp/cm/cmtcsc10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmtcsc10.pfb
t1disasm /tmp/cm/cmtex10.pfb | sed s^/minus^/uni002D^ | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmtex10.pfb
t1disasm /tmp/cm/cmtex8.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmtex8.pfb
t1disasm /tmp/cm/cmtex9.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmtex9.pfb
t1disasm /tmp/cm/cmti10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmti10.pfb
t1disasm /tmp/cm/cmti12.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmti12.pfb
t1disasm /tmp/cm/cmti7.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmti7.pfb
t1disasm /tmp/cm/cmti8.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmti8.pfb
t1disasm /tmp/cm/cmti9.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmti9.pfb
t1disasm /tmp/cm/cmtt10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmtt10.pfb
t1disasm /tmp/cm/cmtt12.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmtt12.pfb
t1disasm /tmp/cm/cmtt8.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmtt8.pfb
t1disasm /tmp/cm/cmtt9.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmtt9.pfb
t1disasm /tmp/cm/cmu10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmu10.pfb
t1disasm /tmp/cm/cmvtt10.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | t1asm -o pfb/cmvtt10.pfb

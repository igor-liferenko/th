if ! [ -e /tmp/amsfonts.zip ]; then
  echo Download to /tmp https://www.ams.org/arc/tex/amsfonts.zip
  exit
fi
rm -fr /tmp/cm/; mkdir /tmp/cm/
unzip -j -d /tmp/cm /tmp/amsfonts.zip fonts/type1/public/amsfonts/cm/\*.pfb >/dev/null
for i in \
  cmb10 \
  cmbx10 \
  cmbx12 \
  cmbx5 \
  cmbx6 \
  cmbx7 \
  cmbx8 \
  cmbx9 \
  cmbxsl10 \
  cmbxti10 \
  cmcsc10 \
  cmdunh10 \
  cmff10 \
  cmfi10 \
  cmfib8 \
  cmitt10 \
  cmr10 \
  cmr12 \
  cmr17 \
  cmr5 \
  cmr6 \
  cmr7 \
  cmr8 \
  cmr9 \
  cmsl10 \
  cmsl12 \
  cmsl8 \
  cmsl9 \
  cmsltt10 \
  cmss10 \
  cmss12 \
  cmss17 \
  cmss8 \
  cmss9 \
  cmssbx10 \
  cmssdc10 \
  cmssi10 \
  cmssi12 \
  cmssi17 \
  cmssi8 \
  cmssi9 \
  cmssq8 \
  cmssqi8 \
  cmtcsc10 \
  cmti10 \
  cmti12 \
  cmti7 \
  cmti8 \
  cmti9 \
  cmtt10 \
  cmtt12 \
  cmtt8 \
  cmtt9 \
  cmu10 \
  cmvtt10
do \
  t1disasm /tmp/cm/$i.pfb | sed s^/quoteleft^/uni0060^ | sed s^/quoteright^/uni0027^ | \
    t1asm -o pfb/$i.pfb
done
for i in \
  cmtex10 \
  cmtex8 \
  cmtex9
do \
  t1disasm /tmp/cm/$i.pfb | sed s^/minus^/uni002D^ | sed s^/quoteleft^/uni0060^ | \
    sed s^/quoteright^/uni0027^ | t1asm -o pfb/$i.pfb
done

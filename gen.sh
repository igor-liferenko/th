#!/bin/bash

rm -f pfb/om* pfb/OM*
function gen() {
  for i in "${@:2:$#}"; do
    mftrace --formats=pfb --encoding=enc/$1 $i || { echo "*********** $i FAILED ************"; exit; }
    mv $i.pfb pfb/
  done
}
gen roman0csc0 \
  omsltt10 \
  OMSLTT10 \
  omtcsc10 \
  OMTCSC10 \
  omtt10 \
  OMTT10 \
  omtt12 \
  OMTT12 \
  omtt14 \
  OMTT14 \
  omtt17 \
  OMTT17 \
  omtt8 \
  OMTT8 \
  omtt9 \
  OMTT9
gen roman1csc1 \
  omr5 \
  OMR5 \
  omcsc10 \
  OMCSC10
gen roman2 \
  omb10 \
  OMB10 \
  ombx10 \
  OMBX10 \
  ombx12 \
  OMBX12 \
  ombx14 \
  OMBX14 \
  ombx17 \
  OMBX17 \
  ombx5 \
  OMBX5 \
  ombx6 \
  OMBX6 \
  ombx7 \
  OMBX7 \
  ombx8 \
  OMBX8 \
  ombx9 \
  OMBX9 \
  ombxsl10 \
  OMBXSL10 \
  omdunh10 \
  OMDUNH10 \
  omff10 \
  OMFF10 \
  omfib8 \
  OMFIB8 \
  omr10 \
  OMR10 \
  omr12 \
  OMR12 \
  omr14 \
  OMR14 \
  omr17 \
  OMR17 \
  omr6 \
  OMR6 \
  omr7 \
  OMR7 \
  omr8 \
  OMR8 \
  omr9 \
  OMR9 \
  omsl10 \
  OMSL10 \
  omsl12 \
  OMSL12 \
  omsl14 \
  OMSL14 \
  omsl17 \
  OMSL17 \
  omsl8 \
  OMSL8 \
  omsl9 \
  OMSL9 \
  omss10 \
  OMSS10 \
  omss12 \
  OMSS12 \
  omss17 \
  OMSS17 \
  omss8 \
  OMSS8 \
  omss9 \
  OMSS9 \
  omssbx10 \
  OMSSBX10 \
  omssdc10 \
  OMSSDC10 \
  omssi17 \
  OMSSI17 \
  omssi10 \
  OMSSI10 \
  omssi12 \
  OMSSI12 \
  omssi8 \
  OMSSI8 \
  omssi9 \
  OMSSI9 \
  omssq8 \
  OMSSQ8 \
  omssqi8 \
  OMSSQI8 \
  omvtt10 \
  OMVTT10
gen textit0 \
  omitt10 \
  OMITT10
gen textit2 \
  ombxti10 \
  OMBXTI10 \
  omfi10 \
  OMFI10 \
  omti10 \
  OMTI10 \
  omti12 \
  OMTI12 \
  omti14 \
  OMTI14 \
  omti17 \
  OMTI17 \
  omti7 \
  OMTI7 \
  omti8 \
  OMTI8 \
  omti9 \
  OMTI9 \
  omu10 \
  OMU10
gen texset \
  omtex8 \
  OMTEX8 \
  omtex9 \
  OMTEX9 \
  omtex10 \
  OMTEX10

#!/bin/bash
# script that performs a gzip compression on a said directory

###################
# INPUT ARGUMENTS #
###################
for i in "$@"; do
  case $i in
    --dir=*|-d=*) DIR_PATH="${i#*=}" ;;
    --scale=*|-s=*) SCALE="${i#*=}" ;;
    --) shift; break ;;
    -*) echo "Unrecognized option $i."; break;;
    *) break;;
  esac
  shift # skip parsed options
done

##########################################
# ENSURE REQUIRED PARAMETERS WERE PASSED #
##########################################
if [ -z "$DIR_PATH" ]; then printf "--dir / -d) input directory was not specified.\n"; exit -1 ; fi
if [ -z "$SCALE" ]; then printf "(--scale / -s) compression level was not specified.\n"; exit -1 ; fi

cd $DIR_PATH

##################
# GZIP ALL FILES #
##################
for d in `find ./* -type d -d 0`; do
  FILE=${d:2}
  tar -cvf $FILE.tar $FILE;
  gzip '-'$SCALE ${FILE}.tar;
done

exit

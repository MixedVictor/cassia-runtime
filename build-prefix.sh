#!/usr/bin/env sh
#
# Do not use, this is only for testing.

PREFIX_FOLDER=$(pwd)/00000000-0000-0000-0000-000000000000

WINEPREFIX=$PREFIX_FOLDER/pfx

DRIVE_C=$WINEPREFIX/drive_c
WINDIR=$DRIVE_C/windows
DLLSDIR=build/prefix/lib/wine
UTILS_DLLSDIR=build/prefix/dlls

PREFIX_ARCHIVE_NAME="baseprefix.tar.gz"

clear

[[ -d $PREFIX_FOLDER ]] && rm -rf $PREFIX_FOLDER
[[ -f $PREFIX_ARCHIVE_NAME ]] && rm -rf $PREFIX_ARCHIVE_NAME

mkdir -p $PREFIX_FOLDER/home
mkdir -p $WINDIR/system32
mkdir -p $WINDIR/syswow64

cp $DLLSDIR/aarch64-windows/* $WINDIR/system32
cp $DLLSDIR/i386-windows/* $WINDIR/syswow64

cp $UTILS_DLLSDIR/aarch64-w64-mingw32/bin/* $WINDIR/system32
cp $UTILS_DLLSDIR/i686-w64-mingw32/bin/* $WINDIR/syswow64

cp metadata.prefix.json $PREFIX_FOLDER/metadata.json
cp runtime.reg $WINEPREFIX

tar --no-xattrs -czf $PREFIX_ARCHIVE_NAME 00000000-0000-0000-0000-000000000000
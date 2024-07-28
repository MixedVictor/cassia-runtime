#!/usr/bin/env sh

PATH=/nix/store/4kkbq8p8p5cczlxzwgldwx9cvgddj73p-llvm-mingw/bin:$PATH

SDK_PATH=/opt/android-sdk
NDK_VER=26.3.11579264
NDK_PATH=$SDK_PATH/ndk/$NDK_VER

WINETOOLS_PATH=winetools
CASSIAEXT_BUILD_PATH=cassiaext

RUNTIME_ARCHIVE_NAME=cassiaruntime.tar.gz

if [[ ! -d $WINETOOLS_PATH ]]; then
    mkdir $WINETOOLS_PATH && cd $WINETOOLS_PATH
    clear;../wine/configure --enable-win64&&clear;make -j$(nproc) || {
        cd ..
        rm -rf $WINETOOLS_PATH
        exit 1
    }
    cd ..
fi

# [[ -d "build" ]] && rm -rf build
# If the above is commented, it'll do a dirty build instead to save compilation time
# The below deletes wine-prefix build folder for a full compilation
[[ -d "build/wine-prefix" ]] && rm -rf build/wine-prefix
[[ -f $RUNTIME_ARCHIVE_NAME ]] && rm -rf $RUNTIME_ARCHIVE_NAME

clear;cmake -GNinja -Bbuild -H.                                                             \
            -DCMAKE_CXX_FLAGS="-Wno-error=incompatible-function-pointer-types"              \
            -DCMAKE_TOOLCHAIN_FILE=$NDK_PATH/build/cmake/android.toolchain.cmake            \
            -DANDROID=ON                                                                    \
            -DANDROID_PLATFORM=android-29                                                   \
            -DANDROID_ABI=arm64-v8a                                                         \
            -DANDROID_SDK=$SDK_PATH                                                         \
            -DANDROID_NDK=$NDK_PATH                                                         \
            -DWINETOOLS_PATH=$WINETOOLS_PATH                                                \
            -DCASSIAEXT_BUILD_PATH=$CASSIAEXT_BUILD_PATH                                    \
            -DMINGW_SYSROOT_PATH=/nix/store/4kkbq8p8p5cczlxzwgldwx9cvgddj73p-llvm-mingw/    \
            -DDLL_BUILD_ARCHITECTURES=i386,aarch64 &&                                       \
            cd build    || exit 1
clear;cmake --build .   || exit 1

tar --no-xattrs -czf $RUNTIME_ARCHIVE_NAME prefix
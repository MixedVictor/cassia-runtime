#!/usr/bin/env sh

SDK_PATH=/opt/android-sdk
NDK_VER=26.3.11579264
NDK_PATH=$SDK_PATH/ndk/$NDK_VER

if [[ ! -d "winetools" ]]; then
    mkdir winetools && cd winetools
    ../wine/configure --enable-win64&&make -j$(nproc) || exit 1
    cd ..
fi

[[ -d "build" ]] && rm -rf build
clear;cmake -GNinja -Bbuild -H.                                                             \
            -DCMAKE_TOOLCHAIN_FILE=$NDK_PATH/build/cmake/android.toolchain.cmake            \
            -DANDROID_PLATFORM=android-29                                                   \
            -DANDROID_ABI=arm64-v8a                                                         \
            -DANDROID_SDK=$SDK_PATH                                                         \
            -DANDROID_NDK=$NDK_PATH                                                         \
            -DANDROID=ON                                                                    \
            -DWINETOOLS_PATH=winetools                                                      \
            -DCASSIAEXT_BUILD_PATH=cassiaext                                                \
            -DMINGW_SYSROOT_PATH=/nix/store/4kkbq8p8p5cczlxzwgldwx9cvgddj73p-llvm-mingw/    \
            -DDLL_BUILD_ARCHITECTURES=aarch64 &&                                            \
            cd build    || exit 1
clear;cmake --build .   || exit 1
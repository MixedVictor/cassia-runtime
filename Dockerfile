# Credits to https://github.com/xtruder/nix-devcontainer :D
FROM ghcr.io/xtruder/nix-devcontainer:latest

RUN sudo apt-get install sdkmanager -y

ARG NDK_VER=26.3.11579264
ARG BUILD_TOOLS_VER=34.0.0

RUN sudo sdkmanager "ndk;$NDK_VER" "build-tools;$BUILD_TOOLS_VER"
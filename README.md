# Cassiapp Runtime

## Cloning
* You can clone this repository using `git clone --recursive` or cloning normally and then updating the submodules with `git submodule update --init --recursive`

### But there is too many modules to clone and my internet can't handle it!

Try running this repeatedly:
```
clear;git submodule deinit --force --all && git submodule update --init --recursive
```

## Building
* Run `build.sh` to build Cassia's runtime
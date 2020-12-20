# GKISS Linux 🐂

## Installation

Follow the steps mentioned on the [KISS Linux](https://k1ss.org/install) website, making a few changes:

* Download the latest GKISS tarball from https://github.com/gkisslinux/grepo/releases instead of the KISS tarball.
* Generate locales by running `locale-gen` as root after modifying the `/etc/locale.gen` file with the appropriate locales (Such as `en_US.UTF8 UTF-8`). Refer to the [Arch Wiki](https://wiki.archlinux.org/index.php/Locale).
* In order to rebuild `glibc`, the KISS [Community repository](https://github.com/kisslinux/community) needs to be enabled.
* Additionally, enable the GKISS [Community repository](https://github.com/gkisslinux/gcommunity) along with the KISS one.

## Binary Packages

**NOTE:** This assumes that the user trusts the source of the binary packages. All binary packages are built in a GKISS chroot obtained from the releases page dedicated to building packages only.

Regularly updated binaries are provided for the following packages:
* Firefox
* Firefox ESR
* LLVM
* Rust

Binaries for KISS (musl) -> [here](https://github.com/git-bruh/kiss-bins)

### Installing binaries

* Modify `KISS_PATH` such that the `bin` repository takes priority over other repositories:
```sh
export KISS_PATH=/path/to/grepo/bin:$KISS_PATH
```
* The packages can now be installed by a simple `kiss b $PKG && kiss i $PKG` command.

## NVIDIA

* Install the nvidia drivers by building the `nvidia` package.
* For kernel configuration, refer to the [Gentoo Wiki](https://wiki.gentoo.org/wiki/NVIDIA/nvidia-drivers#Kernel_compatibility). The `nouveau` kernel module must either be blacklisted from being loaded or disabled in the kernel configuration.

### Screen Tearing
* Enable `Force Composition Pipeline` in the `nvidia-settings` GUI and save the changes to `xorg.conf` by using the `Save to X Configuration File` option.
* Enable `layers.acceleration.force-enabled` or switch to **WebRender** by setting `gfx.webrender.all` to `True` in Firefox's `about:config`.

## Reporting Issues

Any build failures/segfaults encountered with packages from the official KISS repositories (main/community) should be reported in the form of an issue on this repository.

# GKISS Linux

## Installation

Follow the steps mentioned on the [KISS Linux](https://k1ss.org/install) website, making a few changes:

* Download the latest GKISS tarball from https://github.com/gkisslinux/grepo/releases instead of the KISS tarball.
* Generate locales by running `locale-gen` as root after modifying the `/etc/locale.gen` file with the appropriate locales (Such as `en_US.UTF8 UTF-8`). Refer to the [Arch Wiki](https://wiki.archlinux.org/index.php/Locale).
* In order to rebuild `glibc`, the KISS [Community repository](https://github.com/kisslinux/community) needs to be enabled.
* Additionally, enable the GKISS [Community repository](https://github.com/gkisslinux/gcommunity) along with the KISS one.

## NVIDIA

* Install the nvidia drivers by building the `nvidia` package.
* For kernel configuration, refer to the [Gentoo Wiki](https://wiki.gentoo.org/wiki/NVIDIA/nvidia-drivers#Kernel_compatibility). The `nouveau` kernel module must either be blacklisted or disabled in the kernel configuration.

### Screen Tearing
* Enable `Force Composition Pipeline` in the `nvidia-settings` GUI and save the changes to `xorg.conf` by using the `Save to X Configuration File` option.
* Enable `layers.acceleration.force-enabled` or switch to **WebRender** by setting `gfx.webrender.all` to `True` in Firefox's `about:config`.

## Reporting Issues

If you run into any issues with GKISS, create an issue on this repository.

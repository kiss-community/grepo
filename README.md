# GKISS Linux

## Installation

Follow the steps mentioned on the [KISS Linux](https://k1ss.org/install) website, making a few changes:

* Download the latest GKISS tarball from https://github.com/gkisslinux/grepo/releases instead of the KISS tarball.
* Generate locales by running `locale-gen` as root after modifying the `/etc/locale.gen` file with the appropriate locales (Such as `en_US.UTF8 UTF-8`). Refer to the [Arch Wiki](https://wiki.archlinux.org/index.php/Locale).
* In order to rebuild `glibc`, the KISS [community repository](https://github.com/kisslinux/community) needs to be enabled.

## NVIDIA

* Install the nvidia drivers by building the `nvidia` package.
* For kernel configuration, refer to the [Gentoo Wiki](https://wiki.gentoo.org/wiki/NVIDIA/nvidia-drivers#Kernel_compatibility). The `nouveau` driver __MUST__ be disabled in the kernel configuration.

### Screen Tearing
* Enable 'Force Composition Pipeline' in `nvidia-settings`.
* Set `layers.acceleration.force-enabled` and optionally `gfx.webrender.all` to `True` in Firefox's `about:config`.



## Reporting Issues

If you run into any issues with GKISS, create an issue on this repository.

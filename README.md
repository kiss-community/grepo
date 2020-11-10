# Installation

Follow the steps mentioned on the [KISS Linux](https://k1ss.org/install) website, making a few changes:

* Download the latest `gkisslinux` tarball from https://github.com/gkisslinux/grepo/releases
* Generate locales by running `locale-gen` as root after modifying the `/etc/locale.gen` file with the appropriate locales (Such as `en_US.UTF8 UTF-8`). Refer to the [Arch Wiki](https://wiki.archlinux.org/index.php/Locale).
* In order to rebuild `glibc`, the KISS [community repository](https://github.com/kisslinux/community) needs to be enabled.

# Reporting Issues

If you run into any issues with GKISS, create an issue on this repository.

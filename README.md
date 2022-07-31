# GKISS Linux 🐂

![Downloads](https://img.shields.io/github/downloads/gkisslinux/grepo/total.svg)

## Installation

Follow the steps mentioned on the [KISS Linux](https://kisslinux.org/install) website, making a few changes:

* Download the latest GKISS tarball from https://github.com/gkisslinux/grepo/releases instead of the KISS tarball.
* In order to rebuild `glibc`, the KISS [Community repository](https://github.com/kiss-community/repo-community) needs to be enabled.
* Generate locales by running `locale-gen` as root after modifying the `/etc/locale.gen` file with the appropriate locales separated by newlines (`en_US.UTF8 UTF-8` for most users) and add `export LANG=en_US.UTF-8` to `/etc/profile`.
* Optionally, enable the GKISS [Community repository](https://github.com/gkisslinux/gcommunity) for software like `dbus` and `pulseaudio`.

## Binary Packages

**NOTE:** This assumes that the user trusts the source of the binary packages. The packages are built on the author's personal system with [these](https://github.com/git-bruh/dotfiles/blob/master/.profile#L3) build flags.

Regularly updated binaries are provided for the following packages:

* Clang
* CMake
* Firefox
* LLVM
* Rust

Binaries for KISS (musl) -> [here](https://github.com/kiss-community/repo-bin)

### Installing binaries

* Modify `KISS_PATH` such that the `bin` repository takes priority over other repositories:
```sh
export KISS_PATH=/path/to/grepo/bin:$KISS_PATH
```

* The packages can now be installed by a simple `kiss b $PKG` command.

## NVIDIA

**TIP:** `mesa` can be built without `llvm` on NVIDIA systems, look [here](https://github.com/git-bruh/kiss-repo/blob/master/overrides/mesa/build) for an example.

**TIP:** X11 Packages can be found in the [kiss-xorg](https://github.com/ehawkvu/kiss-xorg) repo if Wayland is not for you.

* Modify `KISS_PATH` such that the `nvidia` repository takes priority over other repositories since some Wayland packages like `wlroots` are forked here to add NVIDIA support:
```sh
export KISS_PATH=/path/to/grepo/nvidia:$KISS_PATH
```

* Build `libglvnd`, and then `mesa` since NVIDIA drivers require libglvnd.

* Install the nvidia drivers by building the `nvidia` package.

* For kernel configuration, refer to the [Gentoo Wiki](https://wiki.gentoo.org/wiki/NVIDIA/nvidia-drivers#Kernel_compatibility). The `nouveau` kernel module must either be blacklisted from being loaded or disabled in the kernel configuration.

* The kernel modules can also be built for a specific kernel by exporting the `KERNEL_UNAME` variable:

```sh
export KERNEL_UNAME=5.10.2 # Example
kiss b nvidia
# Environment variables can't be used in `post-install`.
depmod "$KERNEL_UNAME"
```

* For Wayland compositors to work properly, the NVIDIA kernel module _MUST_ be loaded with the GSP firmware (To avoid flickering) and the `modeset` parameter enabled:

```sh
# tee /etc/rc.d/nvidia.boot <<EOF
/bin/modprobe nvidia NVreg_OpenRmEnableUnsupportedGpus=1 NVreg_EnableGpuFirmware=1 NVreg_EnableGpuFirmwareLogs=1
/bin/modprobe nvidia-drm modeset=1
EOF
```

If the firmware was loaded correctly, the following command should output the driver version instead of `N/A`:

```sh
$ nvidia-smi -q | grep GSP
    GSP Firmware Version                  : 515.48.07
```

## Reporting Issues

Any build failures/segfaults encountered with packages from GKISS/KISS repositories should be reported in the form of an issue on this repository.

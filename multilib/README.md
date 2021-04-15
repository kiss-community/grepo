# GKISS Linux 🐂

This is the experimental multilib repository for GKISS.

# Usage

* Add the repository to `KISS_PATH`:
```sh
KISS_PATH="/path/to/grepo/multilib/bin:$KISS_PATH" # Optional, if binary packages are preferred.
KISS_PATH="/path/to/grepo/multilib/core:$KISS_PATH" # The 'core' repository must take precedence in `KISS_PATH` as it overrides the `binutils` and `gcc` packages.
KISS_PATH="$KISS_PATH:/path/to/grepo/multilib/extra"
KISS_PATH="$KISS_PATH:/path/to/grepo/multilib/xorg"
```

* Install the `binutils`, `gcc` and `lib32-glibc` packages:
```sh
cd /path/to/grepo/multilib/bin

for pkg in binutils gcc lib32-glibc; do
  (cd "$pkg"; kiss b && kiss i)
done
```

**NOTE:** The `bin` repository must be used for the first time since a multilib toolchain cannot be built from a pure 64-bit toolchain. If desired, the toolchain can be built by first replacing the KISS toolchain with Arch's multilib toolchain, and then rebuilding the KISS toolchain.

* In order to run graphical applications, one of either `lib32-nvidia` or `lib32-mesa` must be installed, depending upon the graphics card present in the system.

**NOTE:** The `lib32-llvm` package is enough to build `lib32-mesa`, but _CANNOT_ be used to build a `clang` that generates 32-bit binaries.

# Software

#### Steam

* Build the `steam` package:

```sh
kiss b steam && kiss i steam
```

...

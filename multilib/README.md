# GKISS Linux 🐂

This is the experimental multilib repository for GKISS.

# Usage

* Install the `binutils`, `gcc` and `lib32-glibc` packages from the `bin` repository:
```sh
KISS_PATH="/path/to/grepo/multilib/bin:$KISS_PATH"
kiss b binutils gcc lib32-glibc
```

* Add the repository to `KISS_PATH`:
```sh
KISS_PATH="/path/to/grepo/multilib/bin:$KISS_PATH" # Required after initial installation only if binary packages are preferred.
KISS_PATH="/path/to/grepo/multilib/core:$KISS_PATH" # The `core` repository must take precedence in `KISS_PATH` as it overrides the `binutils` and `gcc` packages.
KISS_PATH="$KISS_PATH:/path/to/grepo/multilib/extra"
KISS_PATH="$KISS_PATH:/path/to/grepo/multilib/xorg"
```

* Create a few symlinks to use the existing sources for 32-bit packages:
```sh
cd "${XDG_CACHE_HOME:-"${HOME:?HOME is null}/.cache"}/kiss"

for pkg in $(kiss search "lib32-*" | grep multilib); do
    pkg="$(basename "$pkg")"
    ln -sf "${pkg#lib32-}" "$pkg"
done
```

* Set a `KISS_HOOK` to remove unwanted stuff from 32-bit packages:

`export KISS_HOOK=/path/to/grepo/multilib/kiss-hook`

* In order to run graphical applications, one of either `lib32-nvidia` or `lib32-mesa` must be installed, depending upon the graphics card present in the system.

**NOTE:** The `bin` repository must be used for the first time since a multilib toolchain cannot be built from a pure 64-bit toolchain. If desired, the toolchain can be built by first replacing the KISS toolchain with Arch's multilib toolchain (Lazy method), and then rebuilding the KISS toolchain.

**NOTE:** The `lib32-llvm` package is enough to build `lib32-mesa`, but _CANNOT_ be used to build a `clang` that generates 32-bit binaries.

# Software

#### Steam

* Build the `steam` package:

```sh
kiss b steam && kiss i steam
```

* Create a symlink to allow networking to work properly in `steam`:

```sh
cd /etc/ssl/certs
ln -sf ../cert.pem ca-certificates.crt
```

* Since `steam` uses a _LOT_ of non-standard `tar` options, `/usr/bin/tar` must be switched to `gtar` during the initial setup and during future updates:

```sh
kiss b gtar && kiss i gtar
kiss a gtar /usr/bin/tar
```

* Some games require `pulseaudio`:

`kiss b pulseaudio && kiss i pulseaudio # From 'gcommunity'`

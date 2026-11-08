+++                                                                                                                          
title = 'Watercraft Linux Kernel Descaled'                                                                                           
date = 2026-11-04T22:30:04-20:00                                                                                             
draft = false                                                                                                                
type = "post"                                                                                                                
tags = ["Releases", "Downloads", "Watercraft"]                                                                               
+++   

This is the first release of Watercraft's in house 100% rust-free Linux build.

Linux 6.12.115 compiled with extra checks to ensure absolutely no rust was used in the build.

The build script is available in the [GitHub repository](https://github.com/watercraft-devs/watercraft-linux-kernel-descaled) and [here](https://phosphene.xyz/releases/kernel/6.12.115-2wc1/) as `build.sh`. 

You can use it to build your own descaled kernel locally, if you build locally please contribute back anything you think might be useful.

Kernel Version: `6.12.115-2wc1`

## Requirements 

- Linux computer running Watercraft 0.1.x or Devuan Excalibur
- Disabled secure boot (Enroll your own MOK and sign if you need to )

## Notes

This keeps your original kernel installed if you need to revert back to it.

The original kernel shipped with Devuan at the moment at least is not built with rust as far as I can tell.

Many other distros are shipping default rust kernels.

# Installing the descaled kernel manually:

## 1. Add Watercraft's archive key:

```ssh
sudo curl -fsSLo /usr/share/keyrings/watercraft-archive-keyring.gpg \
    https://phosphene.xyz/repo/watercraft-archive-keyring.gpg
```

Make sure the fingerprint matches ours:

```
2D77 384D 04C6 968E 1FBF  E957 6066 E450 9E00 ED74
```

Don't install anything from Watercraft without verifying the gpg signature matches our fingerprint. 
Signatures are provided with all software releases.

## 2. Add the Watercraft apt repo


```sh
sudo tee /etc/apt/sources.list.d/watercraft.sources >/dev/null <<'EOF'
Types: deb
URIs: https://phosphene.xyz/repo
Suites: ketch
Components: main
Signed-By: /usr/share/keyrings/watercraft-archive-keyring.gpg
EOF
sudo apt update
```

## 3. Install the descaled kernel, headers, and watercraft-archive-keyring

```sh
sudo apt install linux-image-wc-descaled-amd64 linux-headers-wc-descaled-amd64 watercraft-archive-keyring
```

These two packages will always point at the latest descaled kernel image and headers.
Nvidia users:
The headers let DKMS build Nvidia drivers and anything similar for the new kernel installation.
You can check with this command that it built your Nvidia driver properly after installation with this command:

```sh
dkms status
```
Nvidia users:
it should come back with `nvidia-current/550.163.01, 6.12.115-wc-descaled-amd64, x86_64: installed` as the last line.
If not, don't reboot into the new kernel yet, either stay on your old kernel or get the headers properly installed.
Otherwise you will likely boot into failing graphics drivers ie blackscreen or something.

## 4. Reboot and check that you're on the new kernel

```sh
sudo reboot
```

check the kernel:
```sh
uname -r
```

It should print `6.12.115-wc-descaled-amd64`


If something doesn't work, restart, open **Advanced options** in the GRUB menu,
and pick your previous kernel.

## Updating the descaled kernel

New kernels arive with normal updates now that you added the repo in step 2

```sh
sudo apt update && sudo apt full-upgrade
```
then reboot to use the updated kernel build.

Watercraft will build and ship updates in a timely manner once we hear that new kernel versions are released.

The repo is only hosted here on phosphene.xyz for now but we may have mirrors in the future.


## Removing the descaled kernel.

If for whatever reason you need to.

Boot into your other kernel first (GRUB → **Advanced options**), then:

```sh
sudo apt purge linux-image-wc-descaled-amd64 linux-headers-wc-descaled-amd64 \
    'linux-image-*-wc-descaled-amd64' 'linux-headers-*-wc-descaled-amd64' watercraft-archive-keyring
sudo rm /etc/apt/sources.list.d/watercraft.sources \
    /usr/share/keyrings/watercraft-archive-keyring.gpg
sudo apt update
```













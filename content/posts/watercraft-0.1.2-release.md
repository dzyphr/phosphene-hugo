+++
title = 'Watercraft 0.1.2 Release'
date = 2026-11-14T21:04:12-06:00
draft = false
type = "post"
tags = ["Releases", "Downloads", "Watercraft"]
+++
# Watercraft 0.1.2 Release Notes

This release includes major security fixes and overall upgrades to the system.


### Download It Here: 

- ISO [watercraft-0.1.2-ketch-amd64.iso](https://phosphene.xyz/releases/watercraft/ketch-0.1.2/watercraft-0.1.2-ketch-amd64.iso)
-  [SHA256SUMS](https://phosphene.xyz/releases/watercraft/ketch-0.1.2/SHA256SUMS) 
-  [SHA256SUMS.asc](https://phosphene.xyz/releases/watercraft/ketch-0.1.2/SHA256SUMS.asc) 
- GPG PubKey [watercraft-public.asc](https://phosphene.xyz/releases/watercraft/ketch-0.1.2/watercraft-public.asc)

### Verify

- Verification steps: [docs/VERIFY_ISO.md](../../blob/main/docs/VERIFY_ISO.md)

### GPG Fingerprint

```
2D77 384D 04C6 968E 1FBF  E957 6066 E450 9E00 ED74
```
---

**NEW IN 0.1.2:**


## Watercraft 0.1.2 ships with the latest descaled (rust-free) kernel and a custom patched xorg-server.

**Anyone on older versions** 
You can reference: [phosphene.xyz 0.1.1 release post](https://phosphene.xyz/posts/watercraft-0.1.1-release/)
or [0.1.1 Github Release](https://github.com/watercraft-devs/watercraft/releases#release-v0.1.1)
in order to fix your kernel vulnerabilities manually. 

Alternatively, you can read [Watercraft descaled kernel post](https://phosphene.xyz/posts/watercraft-descaled-linux-kernel/) to get setup with Watercraft's descaled kernel manually which is on the latest version as well.

You can also check out [Watercraft xorg-server patch post](https://phosphene.xyz/posts/watercraft-xorg-server-patch/) to patch your `xorg-server` manually.

## Brave Origin is now the default browser

Brave Origin is a lightweight version of the regular Brave browser.

It is only free on Linux, which is a unique offering that Watercraft would like to take advantage of.

Firefox was the previous default that comes with the base Devuan desktop installation.

We have entirely removed Firefox from Watercraft `0.1.2`, users who want it can still download it through `apt`.

NOTE:

**Brave comes from Brave’s own apt repository, so installing it places trust in Brave’s signing key for that repository. Brave updates arrive via `apt upgrade`.**


## Microcode

Microcode is low level instructions from a CPU that control how machine code is carried out.

Every CPU leaves a manufacturer with a version of this, but it needs to be updated from time to time.

You can get microcode updates via motherboard firmware upgrades, and you can also load it with the Linux kernel during boot.

`0.1.2` will include the latest AMD and Intel microcode out of the box.

If you want to add it to your system manually:

```sh
dpkg -l '*microcode*' | grep '^ii'
# this will print microcode packages if you have them already
grep -m1 'vendor_id' /proc/cpuinfo
# this prints your CPU vendor if you are unsure
```
AMD
```sh
sudo apt install amd64-microcode      # AMD
```
Intel
```sh
sudo apt install intel-microcode      # Intel
```



## `Chrony`

Chrony is a very convenient modern tool that synchronizes your clocks automatically via network connection.

It was previously delivered through `provisions.sh` but is now in `gabbard_rigging.sh` meaning it ships in `0.1.2` and in future builds.

Configuring time manually is a pain so we don't want that to be the default. However it is still an option for anyone without a network connection. Our manual script `fix_date_time.sh` works but is not ideal and it will be improved in the future for offline Watercraft installations.

## Watercraft `apt` repo at [phosphene.xyz](https://phosphene.xyz/repo/)

`0.1.2` installations will include our own `apt` repo configured so that you will get updates anytime we fix something critical. Currently we ship the descaled kernel, xorg-server, and our own keyring. 

This allows us to ship patches for the latest vulnerabilities ASAP, and anyone with our repo configured on their systems can upgrade immediately no matter what version they're on from here on out.

Guides for adding Watercraft `apt` repo and software:

- [xorg-server patch](https://phosphene.xyz/posts/watercraft-xorg-server-patch/)
- [descaled kernel](https://phosphene.xyz/posts/watercraft-descaled-linux-kernel/)

## Watercraft descaled (rust-free) Linux kernel

Watercraft descaled kernel [6.12.117-1wc1](https://github.com/watercraft-devs/watercraft-linux-kernel-descaled/releases/tag/v6.12.117-1wc1) ships alongside the latest kernel shipped by Devuan in `0.1.2`.

[Watercraft Descaled Github Repo](https://github.com/watercraft-devs/watercraft-linux-kernel-descaled)

This is a replica of the latest Linux kernel built with verifiably no rust in the process.
In the repo you can find `build.sh` which is the script for building locally.
It will updated in a timely manner and upgrades are shipped through our apt repo.

Manual install guide is in the post on phosphene.xyz: [Watercraft descaled kernel post](https://phosphene.xyz/posts/watercraft-descaled-linux-kernel/)



##  Watercraft Dark Lantern DNS Toggle

[Github Repo | click for more info](https://github.com/watercraft-devs/dark-lantern)

A DNS toggle that does not depend on systemd or any init system.

It routes all your lookups through an `Unbound resolver` on localhost.

It uses Quad9 as the default provider as of right now.

It is shipped at `/rigging/dark-lantern-dns.sh` in `0.1.2`

## Watercraft Remote Audio

A command line tool for simple, high fidelity, remote audio via ssh to any other similar Linux system.

[GitHub Repo | click for more info](https://github.com/watercraft-devs/watercraft-remote-audio/tree/main)

This is an early version so the UX is not ideal, it will be improved and likely given an optional GUI in the future.

It is shipped at `/rigging/watercraft-remote-audio.sh` in `0.1.2`

## Script Upgrades

- `amusements.sh`
    - Minecraft Java client: `prismlauncher`

- `up.sh`
    - `--full` flag added for full upgrades

## Small Fixes

- rootless containers (e.g. podman) are no longer failing for the installed user. Previously they would fail because the ID ranges were still assigned to liveuser.
- leftover LightDM autologin artifacts removed




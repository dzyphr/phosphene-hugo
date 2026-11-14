+++
title = 'Xorg-server Vulnerability Patch now shipped through Watercraft Apt'
date = 2026-11-13T21:57:29-06:00
draft = false
type = "post"
tags = ["Releases", "Downloads", "Watercraft", "Updates", "Upgrades"]
+++

# Patched Xorg for Watercraft 0.1.2

X.Org published two sets of security fixes for the X server in October and November 2026.

Devuan's Xorg doesn't include them yet, so Watercraft ships a patched build through our own signed apt repository. 

Watercraft 0.1.2 includes the repository already out of the box and all future releases will also include it.

- [X.Org Security Advisory, 7 October 2026 (xorg-server 21.1.25)](https://www.openwall.com/lists/oss-security/2026/10/07/23)
- [X.Org Security Advisory, 10 November 2026 (xorg-server 21.1.26)](https://www.openwall.com/lists/oss-security/2026/11/10/13)

> **Note:** Don't run X programs against an X server you don't trust,
> for example by setting `DISPLAY` to someone else's machine. A separate set of
> X.Org fixes for the X client libraries (October 2026) isn't in Devuan yet,
> and those flaws are triggered by a malicious X server.

##  0.1.0 or 0.1.1 users: 

Add the Watercraft `apt` repo and the patched Xorg with the steps below. You don't need to reinstall the OS.

Adding the repo will also give you future upgrades with `sudo apt update && sudo apt upgrade`.

The patched packages are Devuan's own Xorg with the upstream fixes added, versioned `…devuan1+wc1`. 

If Devuan publishes its own Xorg update, apt switches you back to Devuan's package with `sudo apt update && sudo apt upgrade`.

## 1. Update your system first

```sh
sudo apt update && sudo apt full-upgrade
```

**IMPORTANT** This brings in the current Devuan security updates, even some for `apt` itself.

## 2. Add the signing key

```sh
sudo curl -fsSLo /usr/share/keyrings/watercraft-archive-keyring.gpg \
    https://phosphene.xyz/repo/watercraft-archive-keyring.gpg
gpg --show-keys /usr/share/keyrings/watercraft-archive-keyring.gpg
```

The fingerprint must match:

```
2D77 384D 04C6 968E 1FBF  E957 6066 E450 9E00 ED74
```

If it doesn't match, delete the file and report your findings as a bug report here: [Watercraft Issues](https://github.com/watercraft-devs/watercraft/issues).

## 3. Add the repository and the keyring

```sh
sudo tee /etc/apt/sources.list.d/watercraft.sources >/dev/null <<'EOF'
Types: deb
URIs: https://phosphene.xyz/repo
Suites: ketch
Components: main
Signed-By: /usr/share/keyrings/watercraft-archive-keyring.gpg
EOF
sudo apt update # after the above command, this must be ran before installing anything from the repo
sudo apt install watercraft-archive-keyring
```
The first command is a heredoc that writes the repository information into your `/etc/apt/sources.list.d/` directory.

In order to fulfil the `Signed-By` field and properly get updates through `apt`, you must run the last line that installs the `watercraft-archive-keyring`.

## 4. Upgrade to the patched Xorg

```sh
sudo apt upgrade
```

`apt` will replace the vulnerable X server packages on your system with the `+wc1` versions.

Reboot afterwards so the patched X server is the one running: `sudo reboot`

## 5. Check

```sh
dpkg -l xserver-xorg-core | tail -1
```

The version should end in `+wc1`.

## If something goes wrong

If the desktop doesn't start after rebooting, switch to a console with Ctrl+Alt+F1,
log in, and go back to Devuan's version:

```sh
sudo apt install xserver-xorg-core=2:21.1.16-1.3+deb13u4devuan1 \
    xserver-common=2:21.1.16-1.3+deb13u4devuan1 \
    xserver-xorg-legacy=2:21.1.16-1.3+deb13u4devuan1
```

Then reboot.

## Optional Additional Software

**Watercraft descaled (rust-free) Linux kernel**

Once you added our repo in the steps above, all you need to do to get the descaled kernel is: 
```sh
sudo apt update && sudo apt full-upgrade
```

For more info: [Watercraft descaled kernel post](/posts/watercraft-descaled-linux-kernel/)

[Watercraft descaled kernel GitHub](https://github.com/watercraft-devs/watercraft-linux-kernel-descaled)


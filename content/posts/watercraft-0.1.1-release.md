+++
title = 'Watercraft 0.1.1 Release'
date = 2026-10-15T21:54:08-05:00
draft = false
type = "post"
tags = ["Releases", "Downloads", "Watercraft"]
+++



# Watercraft 0.1.1 (Ketch) 

[GitHub Repo](https://github.com/watercraft-devs/watercraft/tree/main)


*released on GitHub as of 2026-10-15*

This release contains important bug-fixes. 

The only things that have been updated are build scripts and provision scripts, everything else is unchanged.

### Bug Fixes

- Removed build time and install time artifacts that persisted onto the installed sytstem unexpectedly.
    - `liveuser` and `boatswain` account sudoers.d rules
    - autologin from the `liveuser` account
    
- Branding is no longer being overwritten.
    - `/etc/os-release` is no longer a symlink and should always report Watercraft on installed systems now.

- New monitors default to Watercraft desktop background wallpaper instead of defaulting to Devuan wallpapers.

- Stopped the builder hostname from persisting onto the live session's hostname which could have also persisted to the installed system if unchanged.
    - Default hostname is now `watercraft`.

## Script Upgrades

- Brave origin is now installed by default instead of regular Brave browser.

- `gifview` added to QOL packages.

- `-y` flag added to `up.sh` for completely non-interactive upgrades.

- 2 games added to `amusements.sh`.
    - Doom (crispy-doom)
    - Runescape (runelite)

### Download Here 


- Base folder: [phosphene.xyz -> watercraft-0.1.1](https://phosphene.xyz/releases/watercraft/ketch-0.1.1/)
- ISO [watercraft-0.1.1-ketch-amd64.iso](https://phosphene.xyz/releases/watercraft/ketch-0.1.1/watercraft-0.1.1-ketch-amd64.iso)
-  [SHA256SUMS](https://phosphene.xyz/releases/watercraft/ketch-0.1.1/SHA256SUMS) 
-  [SHA256SUMS.asc](https://phosphene.xyz/releases/watercraft/ketch-0.1.1/SHA256SUMS.asc) 
- GPG PubKey [watercraft-public.asc](https://phosphene.xyz/releases/watercraft/ketch-0.1.1/watercraft-public.asc)

### Verify

- Verification steps: [docs/VERIFY_ISO.md](../../blob/main/docs/VERIFY_ISO.md)

### GPG Fingerprint

```
2D77 384D 04C6 968E 1FBF  E957 6066 E450 9E00 ED74
```



**ATTENTION 0.1.0 USERS: version 0.1.0 has been officially superseded by 0.1.1 due build-time sudo rules persisting onto the installed system**

If you left the default name and your account is named `liveuser` will have passwordless root which is not secure for an actual installation.

The builder account persisting is also insecure as it does not have a secure password.

If you are on `0.1.0` follow this mitigation:
```sh
# 0.1.0 left two sudo rules for the Live Install account 'liveuser' and builder account 'boatswain'
# If you built from scratch you have to change boatswain to your build account name
# this script grep matches the files by content and then removes them from sudoers.d
sudo grep -lE '^(boatswain|liveuser)[[:space:]]' /etc/sudoers.d/* | xargs -r sudo rm
sudo visudo -c
```

There's no upgrade helpers for the branding, new monitor wallpaper defaults, or hostname fixes yet.

You may be able to get help with that on Discord or IRC if you want to do it manually and need assistance.

If you want to grab the script upgrades, you can just pull them from the github release, all scripts are in the `rigging/` folder.



---

## Communication Channels

- IRC
        - `/join #watercraft` on Libera

- Discord
        - [https://discord.gg/U3dbc6vFtF](https://discord.gg/U3dbc6vFtF)



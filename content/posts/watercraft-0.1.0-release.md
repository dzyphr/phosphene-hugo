+++
title = 'Watercraft 0.1.0 Release'
date = 2026-09-11T03:48:59.254Z
draft = true
type = "post"
tags = ["Releases", "Downloads", "Watercraft"]
+++

# Watercraft 0.1.0 (Ketch) 

*released on GitHub as of 2026-09-11*

[GitHub Repo](https://github.com/watercraft-devs/watercraft/tree/main)

**ATTENTION: version 0.1.0 has been officially superseded by 0.1.1 due build-time sudo rules persisting onto the installed system**

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

---

- This is the first official release, there is plenty more planned for the future.

- Watercraft is built to meet the needs of modern development and entertainment systems on Linux.

---

## Communication Channels

- IRC
	- `/join #watercraft` on Libera 

- Discord
	- [https://discord.gg/U3dbc6vFtF](https://discord.gg/U3dbc6vFtF)

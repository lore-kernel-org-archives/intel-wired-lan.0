From: Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Mon, 28 Mar 2022 16:58:26 +0200
Subject: [Intel-wired-lan] [PATCH net-next 0/2] ice: improve port
 representor naming scheme
Message-ID: <20220328145828.10097-1-marcin.szycik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patchset adds support for systemd defined naming scheme for port
representors, as well as re-enables displaying PCI bus-info in ethtool.

bus-info information has previously been removed from ethtool for port
representors, as a workaround for a bug in lshw tool, where the tool would
sometimes display wrong descriptions for port representors/PF. Now the bug
has been fixed in lshw tool [1].

Removing the workaround can be considered a regression (user might be
running an older, unpatched version of lshw) (see [2] for discussion).
However, calling SET_NETDEV_DEV also produces the same effect as removing
the workaround, i.e. lshw is able to access PCI bus-info (this time not
via ethtool, but in some other way) and the bug can occur.

Adding SET_NETDEV_DEV is important, as it greatly improves netdev naming -
- port representors are named based on PF name. Currently port representors
are named "ethX", which might be confusing, especially when spawning VFs on
multiple PFs. Furthermore, it's currently harder to determine to which PF
does a particular port representor belong, as bus-info is not shown in
ethtool.

Consider the following three cases:


Case 1: current code - driver workaround in place, no SET_NETDEV_DEV,
lshw with or without fix. Port representors are not displayed because they
don't have bus-info (the workaround), PFs are labelled correctly:

$ sudo ./lshw -c net -businfo
Bus info          Device      Class          Description
========================================================
pci at 0000:02:00.0  ens6f0      network        Ethernet Controller E810-XXV for SFP <-- PF
pci at 0000:02:00.1  ens6f1      network        Ethernet Controller E810-XXV for SFP
pci at 0000:02:01.0  ens6f0v0    network        Ethernet Adaptive Virtual Function <-- VF
pci at 0000:02:01.1  ens6f0v1    network        Ethernet Adaptive Virtual Function
...


Case 2: driver workaround in place, SET_NETDEV_DEV, no lshw fix. Port
representors have predictable names. lshw is able to get bus-info because
of SET_NETDEV_DEV and netdevs CAN be mislabelled:

$ sudo ./lshw -c net -businfo
Bus info          Device           Class          Description
=============================================================
pci at 0000:02:00.0  ens6f0npf0vf60   network        Ethernet Controller E810-XXV for SFP <-- mislabelled port representor
pci at 0000:02:00.1  ens6f1           network        Ethernet Controller E810-XXV for SFP
pci at 0000:02:01.0  ens6f0v0         network        Ethernet Adaptive Virtual Function
pci at 0000:02:01.1  ens6f0v1         network        Ethernet Adaptive Virtual Function
...
pci at 0000:02:00.0  ens6f0npf0vf26   network        Ethernet interface
pci at 0000:02:00.0  ens6f0           network        Ethernet interface <-- mislabelled PF
pci at 0000:02:00.0  ens6f0npf0vf81   network        Ethernet interface
...
$ sudo ethtool -i ens6f0npf0vf60
driver: ice
...
bus-info:
...

Output of lshw would be the same with workaround removed; it does not
change the fact that lshw labels netdevs incorrectly, while at the same
time it prevents ethtool from displaying potentially useful data
(bus-info).


Case 3: workaround removed, SET_NETDEV_DEV, lshw fix:

$ sudo ./lshw -c net -businfo
Bus info          Device           Class          Description
=============================================================
pci at 0000:02:00.0  ens6f0npf0vf73   network        Ethernet Controller E810-XXV for SFP
pci at 0000:02:00.1  ens6f1           network        Ethernet Controller E810-XXV for SFP
pci at 0000:02:01.0  ens6f0v0         network        Ethernet Adaptive Virtual Function
pci at 0000:02:01.1  ens6f0v1         network        Ethernet Adaptive Virtual Function
...
pci at 0000:02:00.0  ens6f0npf0vf5    network        Ethernet Controller E810-XXV for SFP
pci at 0000:02:00.0  ens6f0           network        Ethernet Controller E810-XXV for SFP
pci at 0000:02:00.0  ens6f0npf0vf60   network        Ethernet Controller E810-XXV for SFP
...
$ sudo ethtool -i ens6f0npf0vf73
driver: ice
...
bus-info: 0000:02:00.0
...

In this case poort representors have predictable names, netdevs are not
mislabelled in lshw, and bus-info is shown in ethtool.

[1] https://ezix.org/src/pkg/lshw/commit/9bf4e4c9c1
[2] https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20220321144731.3935-1-marcin.szycik@linux.intel.com

Marcin Szycik (1):
  Revert "ice: Hide bus-info in ethtool for PRs in switchdev mode"

Michal Swiatkowski (1):
  ice: link representors to PCI device

 drivers/net/ethernet/intel/ice/ice_ethtool.c | 8 +++-----
 drivers/net/ethernet/intel/ice/ice_repr.c    | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.35.1


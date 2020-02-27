From: Maciej =?unknown-8bit?q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Thu, 27 Feb 2020 14:54:15 -0800
Subject: [Intel-wired-lan] ixgbe 2.5 / 5 gbit support works but is not
 reported as supported/advertised
Message-ID: <CAHo-OozeA2Dp_4pRZr84A+nH8pLbM3L26_50enHgPV4HpevpCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://www.startech.com/Networking-IO/Adapter-Cards/dual-port-network-card~ST10GPEXNDPI

84:00.0 Ethernet controller [0200]: Intel Corporation Ethernet
Controller 10G X550T [8086:1563] (rev 01)
84:00.1 Ethernet controller [0200]: Intel Corporation Ethernet
Controller 10G X550T [8086:1563] (rev 01)

This card will negotiate 2.5g or 5g if plugged in to a 2.5/5g port on
the other end of a 7ft cat 5e cable.
But it doesn't *claim* to support it.

# ethtool eix1
Settings for eix1:
        Supported ports: [ TP ]
        Supported link modes:   100baseT/Full
                                1000baseT/Full
                                10000baseT/Full
        Supported pause frame use: Symmetric
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  100baseT/Full
                                1000baseT/Full
                                10000baseT/Full
        Advertised pause frame use: Symmetric
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Speed: 2500Mb/s     <-- or 5000Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        MDI-X: Unknown
        Supports Wake-on: d
        Wake-on: d
        Current message level: 0x00000007 (7)
                               drv probe link
        Link detected: yes

(note the lack of
                                2500baseT/Full
                                5000baseT/Full
under supported/advertised)

5.2.17-1rodete3-amd64 #1 SMP Debian
[240677.031802] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
- version 5.1.0-k
[240677.031806] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[240677.717538] ixgbe 0000:84:00.0: Multiqueue Enabled: Rx Queue count
= 56, Tx Queue count = 56 XDP Queue count = 0
[240677.816262] ixgbe 0000:84:00.0: 31.504 Gb/s available PCIe
bandwidth (8 GT/s x4 link)
[240677.844663] ixgbe 0000:84:00.0: MAC: 4, PHY: 0, PBA No: 000500-000
[240677.844668] ixgbe 0000:84:00.0: 00:0a:...
[240677.994928] ixgbe 0000:84:00.0 eix1: renamed from eth1
[240678.005278] ixgbe 0000:84:00.0: Intel(R) 10 Gigabit Network Connection
[240678.005360] libphy: ixgbe-mdio: probed
[240678.694408] ixgbe 0000:84:00.1: Multiqueue Enabled: Rx Queue count
= 56, Tx Queue count = 56 XDP Queue count = 0
[240678.792505] ixgbe 0000:84:00.1: 31.504 Gb/s available PCIe
bandwidth (8 GT/s x4 link)
[240678.820671] ixgbe 0000:84:00.1: MAC: 4, PHY: 0, PBA No: 000500-000
[240678.820677] ixgbe 0000:84:00.1: 00:0a:...
[240678.970174] ixgbe 0000:84:00.1 eix2: renamed from eth1
[240678.980665] ixgbe 0000:84:00.1: Intel(R) 10 Gigabit Network Connection
[240678.980747] libphy: ixgbe-mdio: probed
[242612.969243] ixgbe 0000:84:00.0: registered PHC device on eix1
[242615.246740] ixgbe 0000:84:00.1: registered PHC device on eix2
[242620.138766] ixgbe 0000:84:00.0 eix1: NIC Link is Up 10 Gbps, Flow
Control: RX/TX
[242620.162687] ixgbe 0000:84:00.1 eix2: NIC Link is Up 10 Gbps, Flow
Control: RX/TX
[242712.081620] ixgbe 0000:84:00.0 eix1: NIC Link is Down
[242712.280592] ixgbe 0000:84:00.1 eix2: NIC Link is Down
[242867.346797] ixgbe 0000:84:00.0 eix1: NIC Link is Up 5 Gbps, Flow
Control: RX/TX
[243018.281569] ixgbe 0000:84:00.0 eix1: NIC Link is Down
[243028.975451] ixgbe 0000:84:00.0 eix1: NIC Link is Up 2.5 Gbps, Flow
Control: RX/TX
[243405.309056] ixgbe 0000:84:00.0 eix1: NIC Link is Down

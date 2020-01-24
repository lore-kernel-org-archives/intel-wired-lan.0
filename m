From: Ben Greear <greearb@candelatech.com>
Date: Fri, 24 Jan 2020 11:31:05 -0800
Subject: [Intel-wired-lan] ixgbe: "Warning firmware error detected FWSM:
 0xFFFFFFFF"
Message-ID: <9c5158a4-8c45-f45c-636e-7ea75d40eabf@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

Anyone know what this problem means?

# dmesg|grep ixg
[    3.840480] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.1.0-k
[    3.840481] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    4.535677] ixgbe 0000:01:00.0: Multiqueue Enabled: Rx Queue count = 8, Tx Queue count = 8 XDP Queue count = 0
[    4.633347] ixgbe 0000:01:00.0: 31.504 Gb/s available PCIe bandwidth (8 GT/s x4 link)
[    4.745337] ixgbe 0000:01:00.0: MAC: 4, PHY: 0, PBA No: H86377-005
[    4.745338] ixgbe 0000:01:00.0: 9c:69:b4:60:e4:a6
[    4.904379] ixgbe 0000:01:00.0: Intel(R) 10 Gigabit Network Connection
[    4.904413] libphy: ixgbe-mdio: probed
[    5.610158] ixgbe 0000:01:00.1: Multiqueue Enabled: Rx Queue count = 8, Tx Queue count = 8 XDP Queue count = 0
[    5.709523] ixgbe 0000:01:00.1: 31.504 Gb/s available PCIe bandwidth (8 GT/s x4 link)
[    5.823067] ixgbe 0000:01:00.1: MAC: 4, PHY: 0, PBA No: H86377-005
[    5.823071] ixgbe 0000:01:00.1: 9c:69:b4:60:e4:a7
[    5.986413] ixgbe 0000:01:00.1: Intel(R) 10 Gigabit Network Connection
[    5.986444] libphy: ixgbe-mdio: probed
[    5.987671] ixgbe 0000:01:00.0 enp1s0f0: renamed from eth0
[    5.995744] ixgbe 0000:01:00.1 enp1s0f1: renamed from eth1
[   10.086982] ixgbe 0000:01:00.0 eth2: renamed from enp1s0f0
[   10.098434] ixgbe 0000:01:00.1 eth3: renamed from enp1s0f1
[   30.868089] ixgbe 0000:01:00.0: registered PHC device on eth2
[   31.327796] ixgbe 0000:01:00.1: registered PHC device on eth3
[   47.567801] ixgbe 0000:01:00.0: Adapter removed
[   47.571172] ixgbe 0000:01:00.0: Warning firmware error detected FWSM: 0xFFFFFFFF
[   47.571188] ixgbe 0000:01:00.0: Firmware recovery mode detected. Limiting functionality. Refer to the Intel(R) Ethernet Adapters and Devices User Guide for 
details on firmware recovery mode.
[   47.588245] ixgbe 0000:01:00.0: removed PHC on eth2
[   48.056546] ixgbe 0000:01:00.1: Adapter removed
[   48.059916] ixgbe 0000:01:00.1: Warning firmware error detected FWSM: 0xFFFFFFFF
[   48.059932] ixgbe 0000:01:00.1: Firmware recovery mode detected. Limiting functionality. Refer to the Intel(R) Ethernet Adapters and Devices User Guide for 
details on firmware recovery mode.
[   48.076589] ixgbe 0000:01:00.1: removed PHC on eth3

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


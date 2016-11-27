From: Anders K. Pedersen | Cohaesio <akp@cohaesio.com>
Date: Sun, 27 Nov 2016 14:14:32 +0000
Subject: [Intel-wired-lan] i40e TX problems
Message-ID: <1480256071.19477.2.camel@cohaesio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

I have a Dell PowerEdge R730 server with some XL710 (40G) and X710
(10G) NICs that is used as a router. It's running Debian GNU/Linux 8
and stock Linux 4.8.6.

The NICs are setup for LACP using the teaming driver as follows:

team0: eth9 (40G), eth3 (10G), eth7 (10G)
team1: eth0 (10G), eth1 (10G), eth4 (10G), eth5 (10G)

On top of team0 there are several VLAN interfaces. Initially it ran
fine, but a few hours after we began sending traffic through it, the
following issue occurred on the 40G XL710 NIC (eth9):

[87879.812815] i40e 0000:03:00.1: TX driver issue detected, PF reset issued
[87881.069392] i40e 0000:03:00.1: Error I40E_AQ_RC_EINVAL adding RX filters on PF, promiscuous mode forced on
[87881.073463] i40e 0000:03:00.1: TX driver issue detected, PF reset issued
[87882.027869] i40e 0000:03:00.1: Error I40E_AQ_RC_EINVAL adding RX filters on PF, promiscuous mode forced on
[87882.074125] i40e 0000:03:00.1: TX driver issue detected, PF reset issued
[87883.068052] i40e 0000:03:00.1: Error I40E_AQ_RC_EINVAL adding RX filters on PF, promiscuous mode forced on

A few minutes after that, all the active 10G X710 NICs began frequently
logging messages similar to (more samples further down)

[88274.436656] i40e 0000:01:00.0: TX driver issue detected, PF reset issued
[88435.583223] i40e 0000:01:00.1: TX driver issue detected, PF reset issued
[88436.673482] i40e 0000:01:00.1: TX driver issue detected, PF reset issued
[88675.918479] i40e 0000:01:00.3: TX driver issue detected, PF reset issued
[88677.049922] i40e 0000:01:00.3: TX driver issue detected, PF reset issued
[88678.089589] i40e 0000:01:00.3: TX driver issue detected, PF reset issued

The system continued to function, but we noticed traffic interruptions
on team0 (where eth9 was selected by LACP) for about 7 seconds every 1-
2 minutes. No further messages were logged for the 40G XL710, but after
about an hour we ran 'ifconfig eth9 down' to switch team0 over to the
two 10G backup interfaces (eth3 and eth7), and since then we haven't
seen any further traffic interruptions. The "TX driver issue detected,
PF reset issued" messages continue to happen frequently on the 10G X710
NICs, though.

A few days later the following warning was logged:

[260940.998966] ------------[ cut here ]------------
[260940.998973] WARNING: CPU: 1 PID: 0 at net/sched/sch_generic.c:316 dev_watchdog+0x1f4/0x200
[260940.998974] NETDEV WATCHDOG: eth1 (i40e): transmit queue 10 timed out
[260940.998974] Modules linked in:
[260940.998977] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.8.6 #1
[260940.998978] Hardware name: Dell Inc. PowerEdge R730/0H21J3, BIOS 2.2.5 09/06/2016
[260940.998979]??0000000000000000 ffffffff8129e059 ffff88085f243e20 0000000000000000
[260940.998981]??ffffffff81072a24 000000000000000a ffff88085f243e70 0000000000000040
[260940.998983]??0000000000000001 ffff88085b156000 0000000000000001 ffffffff81072a8f
[260940.998985] Call Trace:
[260940.998985]??<IRQ>??[<ffffffff8129e059>] ? dump_stack+0x46/0x5d
[260940.998992]??[<ffffffff81072a24>] ? __warn+0xc4/0xe0
[260940.998993]??[<ffffffff81072a8f>] ? warn_slowpath_fmt+0x4f/0x60
[260940.998995]??[<ffffffff81490154>] ? dev_watchdog+0x1f4/0x200
[260940.998997]??[<ffffffff8148ff60>] ? netif_carrier_off+0x20/0x20
[260940.999000]??[<ffffffff810c5b60>] ? call_timer_fn+0x30/0x130
[260940.999002]??[<ffffffff810c686f>] ? run_timer_softirq+0x1bf/0x3f0
[260940.999003]??[<ffffffff810c7948>] ? enqueue_hrtimer+0x38/0x80
[260940.999006]??[<ffffffff8154bd40>] ? __do_softirq+0x100/0x28a
[260940.999008]??[<ffffffff81076810>] ? irq_exit+0x80/0x90
[260940.999009]??[<ffffffff8154bb4e>] ? smp_apic_timer_interrupt+0x3e/0x50
[260940.999010]??[<ffffffff8154af7c>] ? apic_timer_interrupt+0x7c/0x90
[260940.999011]??<EOI>??[<ffffffff814327a5>] ? cpuidle_enter_state+0x145/0x2b0
[260940.999016]??[<ffffffff81432781>] ? cpuidle_enter_state+0x121/0x2b0
[260940.999018]??[<ffffffff810ab845>] ? cpu_startup_entry+0x2f5/0x330
[260940.999021]??[<ffffffff81032358>] ? start_secondary+0x128/0x130
[260940.999022] ---[ end trace 8e0f488215350c10 ]---
[260940.999026] i40e 0000:01:00.1 eth1: tx_timeout: VSI_seid: 406, Q 10, NTC: 0x3ba, HWB: 0x3ba, NTU: 0x3f5, TAIL: 0x3f5, INT: 0x1
[260940.999027] i40e 0000:01:00.1 eth1: tx_timeout recovery level 1, hung_queue 10

and since then messages similar to the last two lines have been logged
from time to time (details below), but they do not appear to cause any
significant traffic outages.

From reading the archives, I understand that at least some of this is
due to "Malicious Driver Detection" events and that there is a (non
public?) way to debug those, but I couldn't find any details.

I also found https://patchwork.ozlabs.org/patch/692499/ , but the
referenced commit 53cb6e9e8949 ("i40e: Removal of workaround for simple
MAC address filter deletion") is only in net-next for 4.10, and the
code related to i40e_rm_default_mac_filter() is present in the driver
in Linux 4.8.6, so that patch will not help.

Are there any known fixes for these issues or can you help us with
debugging them?

Regards,
Anders K. Pedersen

Detailed information:

ethtool -i output
-----------------
eth0: 
driver: i40e
version: 1.6.11-k
firmware-version: 5.04 0x800024d4 16.5.20
bus-info: 0000:01:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

eth1: 
driver: i40e
version: 1.6.11-k
firmware-version: 5.04 0x800024d4 16.5.20
bus-info: 0000:01:00.1
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

eth2: 
driver: i40e
version: 1.6.11-k
firmware-version: 5.04 0x800024d4 16.5.20
bus-info: 0000:01:00.2
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

eth3: 
driver: i40e
version: 1.6.11-k
firmware-version: 5.04 0x800024d4 16.5.20
bus-info: 0000:01:00.3
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

eth4: 
driver: i40e
version: 1.6.11-k
firmware-version: 5.04 0x800024ce 16.5.20
bus-info: 0000:05:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

eth5:
driver: i40e
version: 1.6.11-k
firmware-version: 5.04 0x800024ce 16.5.20
bus-info: 0000:05:00.1
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

eth6:
driver: i40e
version: 1.6.11-k
firmware-version: 5.04 0x800024ce 16.5.20
bus-info: 0000:05:00.2
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

eth7:
driver: i40e
version: 1.6.11-k
firmware-version: 5.04 0x800024ce 16.5.20
bus-info: 0000:05:00.3
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

eth8:
driver: i40e
version: 1.6.11-k
firmware-version: 5.04 0x800024d8 0.0.0
bus-info: 0000:03:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

eth9:
driver: i40e
version: 1.6.11-k
firmware-version: 5.04 0x800024d8 0.0.0
bus-info: 0000:03:00.1
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes


i40e kernel messages
--------------------
[    5.224932] i40e: Intel(R) Ethernet Connection XL710 Network Driver - version 1.6.11-k
[    5.224932] i40e: Copyright (c) 2013 - 2014 Intel Corporation.
[    5.240059] i40e 0000:01:00.0: fw 5.0.40043 api 1.5 nvm 5.04 0x800024d4 16.5.20
[    5.482712] i40e 0000:01:00.0: MAC address: f8:bc:12:06:22:e8
[    5.690860] i40e 0000:01:00.0: Added LAN device PF0 bus=0x00 func=0x00
[    5.690863] i40e 0000:01:00.0: PCI-Express: Speed 8.0GT/s Width x8
[    5.721294] i40e 0000:01:00.0: Features: PF-id[0] VSIs: 2 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    5.756790] i40e 0000:01:00.1: fw 5.0.40043 api 1.5 nvm 5.04 0x800024d4 16.5.20
[    5.998151] i40e 0000:01:00.1: MAC address: f8:bc:12:06:22:ea
[    6.207506] i40e 0000:01:00.1: Added LAN device PF1 bus=0x00 func=0x01
[    6.207509] i40e 0000:01:00.1: PCI-Express: Speed 8.0GT/s Width x8
[    6.238329] i40e 0000:01:00.1: Features: PF-id[1] VSIs: 2 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    6.274199] i40e 0000:01:00.2: fw 5.0.40043 api 1.5 nvm 5.04 0x800024d4 16.5.20
[    6.514847] i40e 0000:01:00.2: MAC address: f8:bc:12:06:22:ec
[    6.620152] i40e 0000:01:00.2: Added LAN device PF2 bus=0x00 func=0x02
[    6.620155] i40e 0000:01:00.2: PCI-Express: Speed 8.0GT/s Width x8
[    6.626299] i40e 0000:01:00.2: Features: PF-id[2] VSIs: 2 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    6.641823] i40e 0000:01:00.3: fw 5.0.40043 api 1.5 nvm 5.04 0x800024d4 16.5.20
[    6.884297] i40e 0000:01:00.3: MAC address: f8:bc:12:06:22:ee
[    7.143220] i40e 0000:01:00.3: Added LAN device PF3 bus=0x00 func=0x03
[    7.143226] i40e 0000:01:00.3: PCI-Express: Speed 8.0GT/s Width x8
[    7.174105] i40e 0000:01:00.3: Features: PF-id[3] VSIs: 2 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    7.189788] i40e 0000:03:00.0: fw 5.0.40043 api 1.5 nvm 5.04 0x800024d8 0.0.0
[    7.435008] i40e 0000:03:00.0: MAC address: 3c:fd:fe:16:42:28
[    7.542963] i40e 0000:03:00.0: Added LAN device PF0 bus=0x00 func=0x00
[    7.542969] i40e 0000:03:00.0: PCI-Express: Speed 8.0GT/s Width x8
[    7.549151] i40e 0000:03:00.0: Features: PF-id[0] VSIs: 66 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    7.564879] i40e 0000:03:00.1: fw 5.0.40043 api 1.5 nvm 5.04 0x800024d8 0.0.0
[    7.807261] i40e 0000:03:00.1: MAC address: 3c:fd:fe:16:42:2a
[    8.016225] i40e 0000:03:00.1: Added LAN device PF1 bus=0x00 func=0x01
[    8.016232] i40e 0000:03:00.1: PCI-Express: Speed 8.0GT/s Width x8
[    8.047069] i40e 0000:03:00.1: Features: PF-id[1] VSIs: 66 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    8.062659] i40e 0000:05:00.0: fw 5.0.40043 api 1.5 nvm 5.04 0x800024ce 16.5.20
[    8.305246] i40e 0000:05:00.0: MAC address: 3c:fd:fe:01:2c:60
[    8.519115] i40e 0000:05:00.0: Added LAN device PF0 bus=0x00 func=0x00
[    8.519121] i40e 0000:05:00.0: PCI-Express: Speed 8.0GT/s Width x8
[    8.549869] i40e 0000:05:00.0: Features: PF-id[0] VSIs: 34 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    8.585326] i40e 0000:05:00.1: fw 5.0.40043 api 1.5 nvm 5.04 0x800024ce 16.5.20
[    8.826002] i40e 0000:05:00.1: MAC address: 3c:fd:fe:01:2c:62
[    9.038562] i40e 0000:05:00.1: Added LAN device PF1 bus=0x00 func=0x01
[    9.038565] i40e 0000:05:00.1: PCI-Express: Speed 8.0GT/s Width x8
[    9.069296] i40e 0000:05:00.1: Features: PF-id[1] VSIs: 34 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    9.105599] i40e 0000:05:00.2: fw 5.0.40043 api 1.5 nvm 5.04 0x800024ce 16.5.20
[    9.348370] i40e 0000:05:00.2: MAC address: 3c:fd:fe:01:2c:64
[    9.499361] i40e 0000:05:00.2: Added LAN device PF2 bus=0x00 func=0x02
[    9.499367] i40e 0000:05:00.2: PCI-Express: Speed 8.0GT/s Width x8
[    9.505534] i40e 0000:05:00.2: Features: PF-id[2] VSIs: 34 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[    9.521117] i40e 0000:05:00.3: fw 5.0.40043 api 1.5 nvm 5.04 0x800024ce 16.5.20
[    9.764590] i40e 0000:05:00.3: MAC address: 3c:fd:fe:01:2c:66
[   10.024572] i40e 0000:05:00.3: Added LAN device PF3 bus=0x00 func=0x03
[   10.024579] i40e 0000:05:00.3: PCI-Express: Speed 8.0GT/s Width x8
[   10.055420] i40e 0000:05:00.3: Features: PF-id[3] VSIs: 34 QP: 16 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[   11.869443] i40e 0000:03:00.1 rename8: renamed from eth5
[   11.937324] i40e 0000:05:00.1 eth5: renamed from eth7
[   12.007234] i40e 0000:05:00.3 eth7: renamed from eth9
[   12.117255] i40e 0000:05:00.0 rename9: renamed from eth6
[   12.247225] i40e 0000:03:00.1 eth9: renamed from rename8
[   12.317369] i40e 0000:05:00.2 rename11: renamed from eth8
[   12.377250] i40e 0000:03:00.0 rename7: renamed from eth4
[   12.447231] i40e 0000:05:00.0 eth4: renamed from rename9
[   12.507287] i40e 0000:05:00.2 eth6: renamed from rename11
[   12.587197] i40e 0000:03:00.0 eth8: renamed from rename7
[   15.000589] i40e 0000:03:00.1 eth9: NIC Link is Up 40 Gbps Full Duplex, Flow Control: None
[   15.009827] i40e 0000:01:00.3 eth3: NIC Link is Up 10 Gbps Full Duplex, Flow Control: None
[   15.015783] i40e 0000:05:00.3 eth7: NIC Link is Up 10 Gbps Full Duplex, Flow Control: None
[   15.052200] i40e 0000:03:00.1 eth9: already using mac address 3c:fd:fe:16:42:2a
[   15.053933] i40e 0000:01:00.3 eth3: set new mac address 3c:fd:fe:16:42:2a
[   15.058831] i40e 0000:05:00.3 eth7: set new mac address 3c:fd:fe:16:42:2a
[   16.925231] i40e 0000:01:00.0 eth0: NIC Link is Up 10 Gbps Full Duplex, Flow Control: None
[   16.932689] i40e 0000:01:00.1 eth1: NIC Link is Up 10 Gbps Full Duplex, Flow Control: None
[   16.938184] i40e 0000:05:00.0 eth4: NIC Link is Up 10 Gbps Full Duplex, Flow Control: None
[   16.943638] i40e 0000:05:00.1 eth5: NIC Link is Up 10 Gbps Full Duplex, Flow Control: None
[   16.969866] i40e 0000:01:00.0 eth0: already using mac address f8:bc:12:06:22:e8
[   16.971091] i40e 0000:01:00.1 eth1: set new mac address f8:bc:12:06:22:e8
[   16.973763] i40e 0000:05:00.0 eth4: set new mac address f8:bc:12:06:22:e8
[   16.976127] i40e 0000:05:00.1 eth5: set new mac address f8:bc:12:06:22:e8


[87879.812815] i40e 0000:03:00.1: TX driver issue detected, PF reset issued
[87881.069392] i40e 0000:03:00.1: Error I40E_AQ_RC_EINVAL adding RX filters on PF, promiscuous mode forced on
[87881.073463] i40e 0000:03:00.1: TX driver issue detected, PF reset issued
[87882.027869] i40e 0000:03:00.1: Error I40E_AQ_RC_EINVAL adding RX filters on PF, promiscuous mode forced on
[87882.074125] i40e 0000:03:00.1: TX driver issue detected, PF reset issued
[87883.068052] i40e 0000:03:00.1: Error I40E_AQ_RC_EINVAL adding RX filters on PF, promiscuous mode forced on

[88274.436656] i40e 0000:01:00.0: TX driver issue detected, PF reset issued
[88435.583223] i40e 0000:01:00.1: TX driver issue detected, PF reset issued
[88436.673482] i40e 0000:01:00.1: TX driver issue detected, PF reset issued
[88675.918479] i40e 0000:01:00.3: TX driver issue detected, PF reset issued
[88677.049922] i40e 0000:01:00.3: TX driver issue detected, PF reset issued
[88678.089589] i40e 0000:01:00.3: TX driver issue detected, PF reset issued
[88915.015473] i40e 0000:01:00.3: TX driver issue detected, PF reset issued
[89035.477454] i40e 0000:01:00.3: TX driver issue detected, PF reset issued
[89036.125680] i40e 0000:01:00.3: TX driver issue detected, PF reset issued
[89095.334931] i40e 0000:05:00.0: TX driver issue detected, PF reset issued
[89096.173949] i40e 0000:01:00.1: TX driver issue detected, PF reset issued
[89096.458028] i40e 0000:05:00.0: TX driver issue detected, PF reset issued
[89096.484844] i40e 0000:01:00.1: TX driver issue detected, PF reset issued
[89097.310606] i40e 0000:01:00.1: TX driver issue detected, PF reset issued
[89244.689724] i40e 0000:01:00.0: TX driver issue detected, PF reset issued
[89244.955428] i40e 0000:01:00.0: TX driver issue detected, PF reset issued
[89275.125696] i40e 0000:01:00.0: TX driver issue detected, PF reset issued
[89395.372474] i40e 0000:01:00.3: TX driver issue detected, PF reset issued
[89396.158302] i40e 0000:01:00.3: TX driver issue detected, PF reset issued
[89397.161519] i40e 0000:01:00.3: TX driver issue detected, PF reset issued
[89424.535836] i40e 0000:05:00.1: TX driver issue detected, PF reset issued
[89474.149939] i40e 0000:01:00.3: TX driver issue detected, PF reset issued
[89498.867423] i40e 0000:05:00.3: TX driver issue detected, PF reset issued
[89499.108545] i40e 0000:05:00.3: TX driver issue detected, PF reset issued
[89499.960217] i40e 0000:05:00.3: TX driver issue detected, PF reset issued
[89501.167518] i40e 0000:05:00.3: TX driver issue detected, PF reset issued
[89502.193901] i40e 0000:05:00.3: TX driver issue detected, PF reset issued
[89503.273983] i40e 0000:05:00.3: TX driver issue detected, PF reset issued
[89504.380489] i40e 0000:05:00.3: TX driver issue detected, PF reset issued
[89561.787517] i40e 0000:01:00.1: TX driver issue detected, PF reset issued
[89575.234461] i40e 0000:05:00.3: TX driver issue detected, PF reset issued
[89641.567486] i40e 0000:01:00.0: TX driver issue detected, PF reset issued
[89641.850406] i40e 0000:01:00.0: TX driver issue detected, PF reset issued
[89716.382471] i40e 0000:05:00.3: TX driver issue detected, PF reset issued
[89717.467425] i40e 0000:05:00.3: TX driver issue detected, PF reset issued
[89755.222463] i40e 0000:01:00.3: TX driver issue detected, PF reset issued
[89756.442003] i40e 0000:01:00.3: TX driver issue detected, PF reset issued
[89758.555753] i40e 0000:01:00.1: TX driver issue detected, PF reset issued
[89905.256395] i40e 0000:05:00.3: TX driver issue detected, PF reset issued
[90256.298515] i40e 0000:01:00.1: TX driver issue detected, PF reset issued
[90282.286229] i40e 0000:05:00.1: TX driver issue detected, PF reset issued
[90283.320319] i40e 0000:05:00.1: TX driver issue detected, PF reset issued
... these continue to happen frequently, but I've filtered the rest ...


[260940.998966] ------------[ cut here ]------------
[260940.998973] WARNING: CPU: 1 PID: 0 at net/sched/sch_generic.c:316 dev_watchdog+0x1f4/0x200
[260940.998974] NETDEV WATCHDOG: eth1 (i40e): transmit queue 10 timed out
[260940.998974] Modules linked in:
[260940.998977] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.8.6 #1
[260940.998978] Hardware name: Dell Inc. PowerEdge R730/0H21J3, BIOS 2.2.5 09/06/2016
[260940.998979]  0000000000000000 ffffffff8129e059 ffff88085f243e20 0000000000000000
[260940.998981]  ffffffff81072a24 000000000000000a ffff88085f243e70 0000000000000040
[260940.998983]  0000000000000001 ffff88085b156000 0000000000000001 ffffffff81072a8f
[260940.998985] Call Trace:
[260940.998985]  <IRQ>  [<ffffffff8129e059>] ? dump_stack+0x46/0x5d
[260940.998992]  [<ffffffff81072a24>] ? __warn+0xc4/0xe0
[260940.998993]  [<ffffffff81072a8f>] ? warn_slowpath_fmt+0x4f/0x60
[260940.998995]  [<ffffffff81490154>] ? dev_watchdog+0x1f4/0x200
[260940.998997]  [<ffffffff8148ff60>] ? netif_carrier_off+0x20/0x20
[260940.999000]  [<ffffffff810c5b60>] ? call_timer_fn+0x30/0x130
[260940.999002]  [<ffffffff810c686f>] ? run_timer_softirq+0x1bf/0x3f0
[260940.999003]  [<ffffffff810c7948>] ? enqueue_hrtimer+0x38/0x80
[260940.999006]  [<ffffffff8154bd40>] ? __do_softirq+0x100/0x28a
[260940.999008]  [<ffffffff81076810>] ? irq_exit+0x80/0x90
[260940.999009]  [<ffffffff8154bb4e>] ? smp_apic_timer_interrupt+0x3e/0x50
[260940.999010]  [<ffffffff8154af7c>] ? apic_timer_interrupt+0x7c/0x90
[260940.999011]  <EOI>  [<ffffffff814327a5>] ? cpuidle_enter_state+0x145/0x2b0
[260940.999016]  [<ffffffff81432781>] ? cpuidle_enter_state+0x121/0x2b0
[260940.999018]  [<ffffffff810ab845>] ? cpu_startup_entry+0x2f5/0x330
[260940.999021]  [<ffffffff81032358>] ? start_secondary+0x128/0x130
[260940.999022] ---[ end trace 8e0f488215350c10 ]---
[260940.999026] i40e 0000:01:00.1 eth1: tx_timeout: VSI_seid: 406, Q 10, NTC: 0x3ba, HWB: 0x3ba, NTU: 0x3f5, TAIL: 0x3f5, INT: 0x1
[260940.999027] i40e 0000:01:00.1 eth1: tx_timeout recovery level 1, hung_queue 10

[323262.952164] i40e 0000:01:00.3 eth3: tx_timeout: VSI_seid: 408, Q 11, NTC: 0x200, HWB: 0x200, NTU: 0x2a8, TAIL: 0x2a8, INT: 0x1
[323262.952171] i40e 0000:01:00.3 eth3: tx_timeout recovery level 1, hung_queue 11
[330320.772933] i40e 0000:05:00.0 eth4: tx_timeout: VSI_seid: 395, Q 4, NTC: 0x1, HWB: 0x1, NTU: 0x3e9, TAIL: 0x1, INT: 0x1
[330320.772938] i40e 0000:05:00.0 eth4: tx_timeout recovery level 1, hung_queue 4
[337834.797070] i40e 0000:01:00.0 eth0: tx_timeout: VSI_seid: 404, Q 2, NTC: 0x1da, HWB: 0x1da, NTU: 0x23b, TAIL: 0x23b, INT: 0x1
[337834.797072] i40e 0000:01:00.0 eth0: tx_timeout recovery level 1, hung_queue 2
[339651.405235] i40e 0000:01:00.1 eth1: tx_timeout: VSI_seid: 406, Q 1, NTC: 0xc, HWB: 0xc, NTU: 0x1a9, TAIL: 0x1a9, INT: 0x1
[339651.405237] i40e 0000:01:00.1 eth1: tx_timeout recovery level 1, hung_queue 1
[340489.228935] i40e 0000:01:00.0 eth0: tx_timeout: VSI_seid: 404, Q 8, NTC: 0xbc, HWB: 0xbc, NTU: 0x194, TAIL: 0x194, INT: 0x1
[340489.228941] i40e 0000:01:00.0 eth0: tx_timeout recovery level 1, hung_queue 8
[341386.097133] i40e 0000:05:00.0 eth4: tx_timeout: VSI_seid: 395, Q 1, NTC: 0x115, HWB: 0x115, NTU: 0x13c, TAIL: 0x13c, INT: 0x1
[341386.097138] i40e 0000:05:00.0 eth4: tx_timeout recovery level 1, hung_queue 1
[425771.893680] i40e 0000:01:00.1 eth1: tx_timeout: VSI_seid: 406, Q 0, NTC: 0x232, HWB: 0x232, NTU: 0x2c7, TAIL: 0x2c7, INT: 0x1
[425771.893681] i40e 0000:01:00.1 eth1: tx_timeout recovery level 1, hung_queue 0
[502047.396291] i40e 0000:05:00.0 eth4: tx_timeout: VSI_seid: 395, Q 6, NTC: 0x2d9, HWB: 0x2d9, NTU: 0xc2, TAIL: 0xc2, INT: 0x1
[502047.396299] i40e 0000:05:00.0 eth4: tx_timeout recovery level 1, hung_queue 6
[513887.338367] i40e 0000:05:00.0 eth4: tx_timeout: VSI_seid: 395, Q 5, NTC: 0x1f5, HWB: 0x1f5, NTU: 0x261, TAIL: 0x261, INT: 0x1
[513887.338372] i40e 0000:05:00.0 eth4: tx_timeout recovery level 1, hung_queue 5
[848835.232702] i40e 0000:05:00.0 eth4: tx_timeout: VSI_seid: 395, Q 1, NTC: 0x2d7, HWB: 0x2d7, NTU: 0x32c, TAIL: 0x32c, INT: 0x1
[848835.232703] i40e 0000:05:00.0 eth4: tx_timeout recovery level 1, hung_queue 1
[933270.464650] i40e 0000:01:00.1 eth1: tx_timeout: VSI_seid: 406, Q 6, NTC: 0x245, HWB: 0x245, NTU: 0x283, TAIL: 0x283, INT: 0x1
[933270.464651] i40e 0000:01:00.1 eth1: tx_timeout recovery level 1, hung_queue 6
[933288.386019] i40e 0000:01:00.1 eth1: tx_timeout: VSI_seid: 406, Q 15, NTC: 0x175, HWB: 0x175, NTU: 0x277, TAIL: 0x277, INT: 0x1
[933288.386025] i40e 0000:01:00.1 eth1: tx_timeout recovery level 2, hung_queue 15
[1016965.638477] i40e 0000:01:00.1 eth1: tx_timeout: VSI_seid: 396, Q 9, NTC: 0x0, HWB: 0x0, NTU: 0x3ec, TAIL: 0x3ec, INT: 0x0
[1016965.638483] i40e 0000:01:00.1 eth1: tx_timeout recovery level 1, hung_queue 9
[1026363.634655] i40e 0000:01:00.0 eth0: tx_timeout: VSI_seid: 397, Q 5, NTC: 0x56, HWB: 0x56, NTU: 0x110, TAIL: 0x110, INT: 0x1
[1026363.634657] i40e 0000:01:00.0 eth0: tx_timeout recovery level 1, hung_queue 5
[1032529.863716] i40e 0000:01:00.3 eth3: tx_timeout: VSI_seid: 399, Q 10, NTC: 0x31a, HWB: 0x31a, NTU: 0x367, TAIL: 0x367, INT: 0x1
[1032529.863718] i40e 0000:01:00.3 eth3: tx_timeout recovery level 1, hung_queue 10
[1041301.091698] i40e 0000:05:00.1 eth5: tx_timeout: VSI_seid: 394, Q 4, NTC: 0x107, HWB: 0x107, NTU: 0x134, TAIL: 0x134, INT: 0x1
[1041301.091703] i40e 0000:05:00.1 eth5: tx_timeout recovery level 1, hung_queue 4
[1357700.633037] i40e 0000:01:00.3 eth3: tx_timeout: VSI_seid: 399, Q 5, NTC: 0x397, HWB: 0x397, NTU: 0x123, TAIL: 0x123, INT: 0x1
[1357700.633043] i40e 0000:01:00.3 eth3: tx_timeout recovery level 1, hung_queue 5
[1363806.057881] i40e 0000:01:00.3 eth3: tx_timeout: VSI_seid: 399, Q 10, NTC: 0x3f, HWB: 0x3f, NTU: 0x34d, TAIL: 0x34d, INT: 0x1
[1363806.057886] i40e 0000:01:00.3 eth3: tx_timeout recovery level 1, hung_queue 10
[1386477.784130] i40e 0000:01:00.3 eth3: tx_timeout: VSI_seid: 399, Q 11, NTC: 0x34d, HWB: 0x34d, NTU: 0x3b5, TAIL: 0x3b5, INT: 0x1
[1386477.784135] i40e 0000:01:00.3 eth3: tx_timeout recovery level 1, hung_queue 11
[1386478.824208] i40e 0000:01:00.0 eth0: tx_timeout: VSI_seid: 397, Q 9, NTC: 0x288, HWB: 0x288, NTU: 0x2b8, TAIL: 0x2b8, INT: 0x1
[1386478.824212] i40e 0000:01:00.0 eth0: tx_timeout recovery level 1, hung_queue 9
[1458714.642924] i40e 0000:01:00.3 eth3: tx_timeout: VSI_seid: 399, Q 0, NTC: 0x7d, HWB: 0x7d, NTU: 0xe8, TAIL: 0xe8, INT: 0x1
[1458714.642932] i40e 0000:01:00.3 eth3: tx_timeout recovery level 1, hung_queue 0
[1468213.605519] i40e 0000:05:00.3 eth7: tx_timeout: VSI_seid: 393, Q 0, NTC: 0x3f8, HWB: 0x3f8, NTU: 0x1d, TAIL: 0x1d, INT: 0x1
[1468213.605524] i40e 0000:05:00.3 eth7: tx_timeout recovery level 1, hung_queue 0
[1468679.080893] i40e 0000:05:00.1 eth5: tx_timeout: VSI_seid: 394, Q 14, NTC: 0x2f6, HWB: 0x2f6, NTU: 0x378, TAIL: 0x378, INT: 0x1
[1468679.080895] i40e 0000:05:00.1 eth5: tx_timeout recovery level 1, hung_queue 14
[1531685.877625] i40e 0000:05:00.3 eth7: tx_timeout: VSI_seid: 393, Q 0, NTC: 0x20c, HWB: 0x20c, NTU: 0x245, TAIL: 0x245, INT: 0x1
[1531685.877632] i40e 0000:05:00.3 eth7: tx_timeout recovery level 1, hung_queue 0
[1547213.537740] i40e 0000:05:00.1 eth5: tx_timeout: VSI_seid: 394, Q 5, NTC: 0xc8, HWB: 0xc8, NTU: 0x124, TAIL: 0x124, INT: 0x1
[1547213.537741] i40e 0000:05:00.1 eth5: tx_timeout recovery level 1, hung_queue 5
[1547991.196926] i40e 0000:05:00.1 eth5: tx_timeout: VSI_seid: 394, Q 10, NTC: 0x2b2, HWB: 0x2b2, NTU: 0x306, TAIL: 0x306, INT: 0x1
[1547991.196932] i40e 0000:05:00.1 eth5: tx_timeout recovery level 1, hung_queue 10
[1552302.484878] i40e 0000:05:00.1 eth5: tx_timeout: VSI_seid: 394, Q 8, NTC: 0x3fe, HWB: 0x3fe, NTU: 0x46, TAIL: 0x46, INT: 0x1
[1552302.484883] i40e 0000:05:00.1 eth5: tx_timeout recovery level 1, hung_queue 8
[1552595.467171] i40e 0000:05:00.3 eth7: tx_timeout: VSI_seid: 393, Q 15, NTC: 0x3e2, HWB: 0x3e2, NTU: 0x91, TAIL: 0x91, INT: 0x1
[1552595.467173] i40e 0000:05:00.3 eth7: tx_timeout recovery level 1, hung_queue 15
[1555248.709098] i40e 0000:01:00.1 eth1: tx_timeout: VSI_seid: 396, Q 0, NTC: 0xa9, HWB: 0xa9, NTU: 0xef, TAIL: 0xef, INT: 0x1
[1555248.709100] i40e 0000:01:00.1 eth1: tx_timeout recovery level 1, hung_queue 0
[1557380.071370] i40e 0000:05:00.1 eth5: tx_timeout: VSI_seid: 394, Q 2, NTC: 0xf9, HWB: 0xf9, NTU: 0x12a, TAIL: 0x12a, INT: 0x1
[1557380.071376] i40e 0000:05:00.1 eth5: tx_timeout recovery level 1, hung_queue 2
[1623483.824998] i40e 0000:05:00.0 eth4: tx_timeout: VSI_seid: 395, Q 10, NTC: 0x117, HWB: 0x117, NTU: 0x1e7, TAIL: 0x1e7, INT: 0x1
[1623483.825003] i40e 0000:05:00.0 eth4: tx_timeout recovery level 1, hung_queue 10
[1626089.302953] i40e 0000:05:00.0 eth4: tx_timeout: VSI_seid: 395, Q 4, NTC: 0xbc, HWB: 0xbc, NTU: 0xf6, TAIL: 0xf6, INT: 0x1
[1626089.302955] i40e 0000:05:00.0 eth4: tx_timeout recovery level 1, hung_queue 4
[1632532.673535] i40e 0000:05:00.3 eth7: tx_timeout: VSI_seid: 393, Q 14, NTC: 0x79, HWB: 0x79, NTU: 0x19a, TAIL: 0x19a, INT: 0x1
[1632532.673536] i40e 0000:05:00.3 eth7: tx_timeout recovery level 1, hung_queue 14

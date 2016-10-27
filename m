From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 27 Oct 2016 20:36:45 +0200
Subject: [Intel-wired-lan] =?utf-8?q?=5Bixgbe=5D_Problem_with_Linux_4=2E8?=
 =?utf-8?q?=2E4=2C_link_doesn=E2=80=99t_receive_packets?=
Message-ID: <0e726f89-130a-2602-4aee-554d2b622764@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Linux developers,


Booting Linux 4.8.4, we have the following behavior on a TYAN S8812 with 
the devices below.

[I mark it up as citation, as otherwise Mozilla Thunderbird autowraps it.]

> 04:00.0 Ethernet controller [0200]: Intel Corporation 82574L Gigabit Network Connection [8086:10d3]
> 05:00.0 Ethernet controller [0200]: Intel Corporation 82576 Gigabit Network Connection [8086:10c9] (rev 01)
> 05:00.1 Ethernet controller [0200]: Intel Corporation 82576 Gigabit Network Connection [8086:10c9] (rev 01)
> 06:00.0 RAID bus controller [0104]: 3ware Inc 9750 SAS2/SATA-II RAID PCIe [13c1:1010] (rev 05)
> 07:00.0 Ethernet controller [0200]: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection [8086:10fb] (rev 01)
> 07:00.1 Ethernet controller [0200]: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection [8086:10fb] (rev 01)

The problem is, the link is up, but doesn?t receive any packets. Both 
LEDs are on, the switch doesn?t show a connection though.

### Linux 4.4.14 ###

Here is the working boot with Linux 4.4.14.

> [   14.407431] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.2.1-k
> [   14.407878] ixgbe: Copyright (c) 1999-2015 Intel Corporation.
> [   15.509390] ixgbe 0000:07:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
> [   15.509960] ixgbe 0000:07:00.0: PCI Express bandwidth of 32GT/s available
> [   15.510194] ixgbe 0000:07:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
> [   15.510516] ixgbe 0000:07:00.0: MAC: 2, PHY: 1, PBA No: E68793-004
> [   15.510794] ixgbe 0000:07:00.0: 00:1b:21:d6:ca:bc
> [   15.513170] ixgbe 0000:07:00.0: Intel(R) 10 Gigabit Network Connection
> [   15.682545] ixgbe 0000:07:00.1: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
> [   15.683115] ixgbe 0000:07:00.1: PCI Express bandwidth of 32GT/s available
> [   15.683352] ixgbe 0000:07:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
> [   15.683672] ixgbe 0000:07:00.1: MAC: 2, PHY: 18, SFP+: 6, PBA No: E68793-004
> [   15.683949] ixgbe 0000:07:00.1: 00:1b:21:d6:ca:bd
> [   15.686311] ixgbe 0000:07:00.1: Intel(R) 10 Gigabit Network Connection
> [   18.493786] ixgbe 0000:07:00.0 net03: renamed from eth3
> [   18.507056] ixgbe 0000:07:00.1 net04: renamed from eth4
> [   18.839122] ixgbe 0000:07:00.1: registered PHC device on net04
> [   19.010366] ixgbe 0000:07:00.1 net04: detected SFP+: 6
> [   19.253458] ixgbe 0000:07:00.1 net04: NIC Link is Up 10 Gbps, Flow Control: RX/TX

### Linux 4.8.4 ###

> [   22.136906] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.4.0-k
> [   22.137360] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> [   23.272410] ixgbe 0000:07:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
> [   23.272931] ixgbe 0000:07:00.0: PCI Express bandwidth of 32GT/s available
> [   23.273217] ixgbe 0000:07:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
> [   23.273532] ixgbe 0000:07:00.0: MAC: 2, PHY: 1, PBA No: E68793-004
> [   23.273765] ixgbe 0000:07:00.0: 00:1b:21:d6:ca:bc
> [   23.276469] ixgbe 0000:07:00.0: Intel(R) 10 Gigabit Network Connection
> [   23.438461] ixgbe 0000:07:00.1: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
> [   23.438981] ixgbe 0000:07:00.1: PCI Express bandwidth of 32GT/s available
> [   23.439266] ixgbe 0000:07:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
> [   23.439580] ixgbe 0000:07:00.1: MAC: 2, PHY: 18, SFP+: 6, PBA No: E68793-004
> [   23.439817] ixgbe 0000:07:00.1: 00:1b:21:d6:ca:bd
> [   23.442483] ixgbe 0000:07:00.1: Intel(R) 10 Gigabit Network Connection
> [   26.911415] ixgbe 0000:07:00.0 net03: renamed from eth3
> [   26.927234] ixgbe 0000:07:00.1 net04: renamed from eth4
> [   27.277634] ixgbe 0000:07:00.1: registered PHC device on net04
> [   27.457916] ixgbe 0000:07:00.1 net04: detected SFP+: 6
> [   27.713989] ixgbe 0000:07:00.1 net04: NIC Link is Up 10 Gbps, Flow Control: RX/TX

No packets are received on the interface. After unplugging the network 
cable, and plugging it back in, it works.

> [ 2009.455327] ixgbe 0000:07:00.1 net04: NIC Link is Down
> [ 2012.354168] ixgbe 0000:07:00.1 net04: NIC Link is Up 10 Gbps, Flow Control: RX/TX


After a reboot, there is the *same* result.

> [   21.427370] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.4.0-k
> [   21.431447] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> [   22.568344] ixgbe 0000:07:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
> [   22.568506] ixgbe 0000:07:00.0: PCI Express bandwidth of 32GT/s available
> [   22.568508] ixgbe 0000:07:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
> [   22.568588] ixgbe 0000:07:00.0: MAC: 2, PHY: 1, PBA No: E68793-004
> [   22.568589] ixgbe 0000:07:00.0: 00:1b:21:d6:ca:bc
> [   22.571967] ixgbe 0000:07:00.0: Intel(R) 10 Gigabit Network Connection
> [   22.734311] ixgbe 0000:07:00.1: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
> [   22.734833] ixgbe 0000:07:00.1: PCI Express bandwidth of 32GT/s available
> [   22.735126] ixgbe 0000:07:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
> [   22.735441] ixgbe 0000:07:00.1: MAC: 2, PHY: 18, SFP+: 6, PBA No: E68793-004
> [   22.735675] ixgbe 0000:07:00.1: 00:1b:21:d6:ca:bd
> [   22.738115] ixgbe 0000:07:00.1: Intel(R) 10 Gigabit Network Connection
> [   25.980145] ixgbe 0000:07:00.0 net03: renamed from eth3
> [   26.005989] ixgbe 0000:07:00.1 net04: renamed from eth4
> [   26.379269] ixgbe 0000:07:00.1: registered PHC device on net04
> [   26.551580] ixgbe 0000:07:00.1 net04: detected SFP+: 6
> [   26.802655] ixgbe 0000:07:00.1 net04: NIC Link is Up 10 Gbps, Flow Control: RX/TX


After doing `ip link set dev net04 down`, and `ip link set dev net04 
up`, the link works as expected.

> [  151.437972] ixgbe 0000:07:00.1: removed PHC on net04
> [  162.174209] ixgbe 0000:07:00.1: registered PHC device on net04
> [  162.350749] ixgbe 0000:07:00.1 net04: detected SFP+: 6
> [  162.599821] ixgbe 0000:07:00.1 net04: NIC Link is Up 10 Gbps, Flow Control: RX/TX

So I have some questions.

1. Have you heard of such problems in Linux kernels after 4.4?
2. Can you explain the behavior, that there is no message *NIC Link is 
Down* from Linux after `ip link set dev net04 down`?
3. If it is a bug, what can I do to get it fixed? Is this mailing list 
the right forum, or should I create a ticket at the Linux Kernel 
Bugtracker [1]? What other information than above do you need?


Kind regards,

Paul


[1] https://bugzilla.kernel.org/

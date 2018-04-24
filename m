From: Holger Schurig <holgerschurig@gmail.com>
Date: Tue, 24 Apr 2018 17:14:58 +0200
Subject: [Intel-wired-lan] [BUG] igb: reconnecting of cable not always
 detected
Message-ID: <87h8o0ocul.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

I'm on kernel 4.16.4 and have an issue with eth0, driver is igb. When I
remove the ethernet cable, this is always detected:

[    2.772360] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    2.772363] igb: Copyright (c) 2007-2014 Intel Corporation.
[    3.023707] igb 0000:02:00.0: added PHC on eth0
[    3.023710] igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
[    3.023713] igb 0000:02:00.0: eth0: (PCIe:2.5Gb/s:Width x1) 00:13:95:1a:54:33
[    3.023758] igb 0000:02:00.0: eth0: PBA No: 000300-000
[    3.023762] igb 0000:02:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
[    7.984921] igb 0000:02:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   11.184593] igb 0000:02:00.0 eth0: igb: eth0 NIC Link is Down

Sometimes, plugging the cable back in is detected ...

[   43.736922] igb 0000:02:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX

... but sometimes this is *NOT* detected. I can put the cable in and
even after two minutes nothing has been detected.

But when I run "rmmod igb" followed by "modpobe igb", the link is
detected again:

[  100.528609] igb 0000:02:00.0 eth0: igb: eth0 NIC Link is Down
[ 2336.583244] igb 0000:02:00.0: removed PHC on eth0
[ 2339.693521] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[ 2339.693524] igb: Copyright (c) 2007-2014 Intel Corporation.
[ 2339.990553] pps pps0: new PPS source ptp0
[ 2339.990561] igb 0000:02:00.0: added PHC on eth0
[ 2339.990565] igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
[ 2339.990569] igb 0000:02:00.0: eth0: (PCIe:2.5Gb/s:Width x1) 00:13:95:1a:54:33
[ 2339.990611] igb 0000:02:00.0: eth0: PBA No: 000300-000
[ 2339.990615] igb 0000:02:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
[ 2343.001114] igb 0000:02:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX

(In above dmesg snippet the ethernet cable was the whole time inserted).


Any tips on how I can debug this further?

PS: I already tried a different switch and also a direct connection from
device-to-device, without a switch.

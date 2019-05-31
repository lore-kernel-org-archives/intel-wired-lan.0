From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Fri, 31 May 2019 15:19:20 +0200
Subject: [Intel-wired-lan] Decreasing time to get link up to below 3 s
Message-ID: <87cb341b-1c32-04be-9309-489354ef8065@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Linux folks,


On several systems with different network devices and drivers (e1000e, r8169, tg3)
it looks like getting the link up takes over three seconds.

### e1000e ###

[    1.999678] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    2.000374] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.001206] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    2.412096] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
[    2.495295] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 64:00:6a:2c:10:c1
[    2.496204] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[    2.497024] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
[   15.614031] e1000e 0000:00:1f.6 net00: renamed from eth0
[   18.679325] e1000e: net00 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None

### r8169 ###

[   33.433103] r8169 0000:18:00.0: enabling device (0000 -> 0003)
[   33.453834] libphy: r8169: probed
[   33.456629] r8169 0000:18:00.0 eth0: RTL8168h/8111h, 30:9c:23:04:d6:98, XID 541, IRQ 52
[   33.456631] r8169 0000:18:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[   33.607384] r8169 0000:18:00.0 enp24s0: renamed from eth0
[   34.134035] Generic Realtek PHY r8169-1800:00: attached PHY driver [Generic Realtek PHY] (mii_bus:phy_addr=r8169-1800:00, irq=IGNORE)
[   34.215244] r8169 0000:18:00.0 enp24s0: Link is Down
[   37.822536] r8169 0000:18:00.0 enp24s0: Link is Up - 1Gbps/Full - flow control rx/tx

### tg3 ###

[    2.015604] tg3.c:v3.137 (May 11, 2014)
[    2.025613] tg3 0000:04:00.0 eth0: Tigon3 [partno(BCM95762) rev 5762100] (PCI Express) MAC address 54:bf:64:70:a5:f9
[    2.026955] tg3 0000:04:00.0 eth0: attached PHY is 5762C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    2.028252] tg3 0000:04:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    2.029462] tg3 0000:04:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    6.376904] tg3 0000:04:00.0 net00: renamed from eth0
[   10.240411] tg3 0000:04:00.0 net00: Link is up at 1000 Mbps, full duplex
[   10.240412] tg3 0000:04:00.0 net00: Flow control is on for TX and on for RX
[   10.240413] tg3 0000:04:00.0 net00: EEE is disabled


Can you verify, that it takes that long on your systems too?

Can this be improved? According to the thread *Ethernet auto-negotiate time* [1]
it should take not more that half a second.

If the time cannot be decreased, are there alternative strategies to get a link
up as fast as possible? For fast boot systems, it?d be interesting if first
a slower speed could be negotiated and later it would be changed.


Kind regards,

Paul


[1]: https://forums.tomshardware.com/threads/ethernet-auto-negotiate-time.954333/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190531/79d2ad7f/attachment.p7s>

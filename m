From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Fri, 31 May 2019 18:29:00 +0200
Subject: [Intel-wired-lan] Decreasing time to get link up to below 3 s
In-Reply-To: <20190531141411.GA23821@lunn.ch>
References: <87cb341b-1c32-04be-9309-489354ef8065@molgen.mpg.de>
 <20190531141411.GA23821@lunn.ch>
Message-ID: <f2b13ac8-e1ca-80c1-01b5-8f8c0da82323@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 31.05.2019 16:14, Andrew Lunn wrote:
> On Fri, May 31, 2019 at 03:19:20PM +0200, Paul Menzel wrote:
>> Dear Linux folks,
>>
>>
>> On several systems with different network devices and drivers (e1000e, r8169, tg3)
>> it looks like getting the link up takes over three seconds.
>>
>> ### e1000e ###
>>
>> [    1.999678] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
>> [    2.000374] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
>> [    2.001206] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
>> [    2.412096] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
>> [    2.495295] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 64:00:6a:2c:10:c1
>> [    2.496204] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
>> [    2.497024] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
>> [   15.614031] e1000e 0000:00:1f.6 net00: renamed from eth0
>> [   18.679325] e1000e: net00 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
> 
> Hi Paul
> 
> All the Intel drivers do there own PHY handling, so i cannot speak for them.
> 
>>
>> ### r8169 ###
>>
>> [   33.433103] r8169 0000:18:00.0: enabling device (0000 -> 0003)
>> [   33.453834] libphy: r8169: probed
>> [   33.456629] r8169 0000:18:00.0 eth0: RTL8168h/8111h, 30:9c:23:04:d6:98, XID 541, IRQ 52
>> [   33.456631] r8169 0000:18:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
>> [   33.607384] r8169 0000:18:00.0 enp24s0: renamed from eth0
>> [   34.134035] Generic Realtek PHY r8169-1800:00: attached PHY driver [Generic Realtek PHY] (mii_bus:phy_addr=r8169-1800:00, irq=IGNORE)
>> [   34.215244] r8169 0000:18:00.0 enp24s0: Link is Down
>> [   37.822536] r8169 0000:18:00.0 enp24s0: Link is Up - 1Gbps/Full - flow control rx/tx
> 
> This is using the generic PHY framework and drivers.
> 
> You can see here irq=IGNORE. This implies interrupts are not being
> used. So it will poll the PHY once per second. If you can get
> interrupts working, you can save 1/2 second on average.
> 
irq=IGNORE means the MAC interrupt is used (using phy_mac_interrupt).

> 
>> ### tg3 ###
>>
>> [    2.015604] tg3.c:v3.137 (May 11, 2014)
>> [    2.025613] tg3 0000:04:00.0 eth0: Tigon3 [partno(BCM95762) rev 5762100] (PCI Express) MAC address 54:bf:64:70:a5:f9
>> [    2.026955] tg3 0000:04:00.0 eth0: attached PHY is 5762C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
>> [    2.028252] tg3 0000:04:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
>> [    2.029462] tg3 0000:04:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
>> [    6.376904] tg3 0000:04:00.0 net00: renamed from eth0
>> [   10.240411] tg3 0000:04:00.0 net00: Link is up at 1000 Mbps, full duplex
>> [   10.240412] tg3 0000:04:00.0 net00: Flow control is on for TX and on for RX
>> [   10.240413] tg3 0000:04:00.0 net00: EEE is disabled
>>
> 
> Another MAC driver which does not use the generic framework.
> 
>> If the time cannot be decreased, are there alternative strategies to get a link
>> up as fast as possible? For fast boot systems, it?d be interesting if first
>> a slower speed could be negotiated and later it would be changed.
> 
The following presentation should help to understand which factors
contribute to the >3s for auto-negotiation.
http://www.ieee802.org/3/af/public/jan02/brown_1_0102.pdf

> You can use ethtool to set the modes it will offer for auto-neg. So
> you could offer 10/half and see if that comes up faster.
> 
> ethtool -s eth0 advertise 0x001
> 
> But you are still going to have to wait the longer time when you
> decide it is time to swap to the full bandwidth.
> 
>        Andrew
> 
Heiner

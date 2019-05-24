From: L Ait <lhoussain.aitassou@gmail.com>
Date: Fri, 24 May 2019 17:04:29 +0200
Subject: [Intel-wired-lan] Kernel Linux and i*gb* drivers
In-Reply-To: <CAJdzkC3p0QEVxHikmGzq8d85bryrJ+iqWPnC2qYCn_=U0DDv5Q@mail.gmail.com>
References: <CAJdzkC0Ji0ZnCPhCDdhN_PUr5-qNs_OM5cvn=r+t8wYhJR3R0g@mail.gmail.com>
 <7fa75c5fd75b326e7825524481aca1365dfdaa9a.camel@intel.com>
 <CAJdzkC3p0QEVxHikmGzq8d85bryrJ+iqWPnC2qYCn_=U0DDv5Q@mail.gmail.com>
Message-ID: <CAJdzkC1uEYD77gcfiXTUWf-DSKAaYvNZXVeaDpJcb6m8qYYhyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,
To continue on debugging the out of order of udp datagrams arrival.
I upgraded to recent kernel version 4.14.110 and tested with recent [igb
,and ixgbe] drivers but i have got same errors.
One question what it the effect of having transceir internal instead of
external here :
ethtool eth0 :
Transceiver: internal

Because I can't change any parameter with ethtool : ethtool -s eth0 xcvr
external returns [operation not supported]

Thank you



Le mar. 9 avr. 2019 ? 10:52, L Ait <lhoussain.aitassou@gmail.com> a ?crit :

> Hi,
>
> Please find in attached file the details of hardware ( lspci -vvv) command.
> I have noticed one difference between kernel versions 4.4.27 and 4.14.20:
> For  4.14.20, I get with ethtool eth1 :
> Settings for eth1:
>     Supported ports: [ FIBRE ]
>     Supported link modes:   Not reported
>     Supported pause frame use: Symmetric
>     Supports auto-negotiation: Yes
>     Advertised link modes:  Not reported
>     Advertised pause frame use: Symmetric
>     Advertised auto-negotiation: Yes
>     Speed: 1000Mb/s
>     Duplex: Full
>     Port: FIBRE
>     PHYAD: 0
>     Transceiver: internal
>     Auto-negotiation: on
>     Supports Wake-on: pumbg
>     Wake-on: g
>     Current message level: 0x00000007 (7)
>                    drv probe link
>     Link detected: yes
>
>
> But for 4.4.27:
> Settings for eth1:
>     Supported ports: [ FIBRE ]
>     Supported link modes:   1000baseT/Full
>     Supported pause frame use: No
>     Supports auto-negotiation: Yes
>     Advertised link modes:  1000baseT/Full
>     Advertised pause frame use: No
>     Advertised auto-negotiation: Yes
>     Speed: 1000Mb/s
>     Duplex: Full
>     Port: Other
>     PHYAD: 0
>     Transceiver: external
>     Auto-negotiation: on
>     Supports Wake-on: umbg
>     Wake-on: g
>     Current message level: 0x00000007 (7)
>                    drv probe link
>
> I think the problem is related to transceiver type and I can't change this
> conf for 4.14.20 kernel.
> For information I could upgrade kernel but I would know which version and
> measure the gap
>
> Thank you in advance
>
>
> Le lun. 8 avr. 2019 ? 16:57, Jeff Kirsher <jeffrey.t.kirsher@intel.com> a
> ?crit :
>
>> On Mon, 2019-04-08 at 13:15 +0200, L Ait wrote:
>> > Hi ,
>> >
>> > I have a linux applidation that uses udp for data transferer between
>> > processes (on the same machine or same vlan). This application runs
>> > fine on linux 4.4.27. But when upgrading to linux 4.14.20 kernel I
>> > was facing out of order udp packets. This espcially happens when
>> > small datagramms occurs as they arrive before big ones.
>> > I know that udp packets aren't guaranteed to arrive in order but I
>> > would know what kernel changes affects this udp behavior.
>> > After troublshooting the application I didn't find waht could cause
>> > the problem. Here some parameters I changed either wtih ethtool or
>> > sysctl: -RX fifo length -irq interrupts vs cpus - RSS mode activation
>> > /deactivation
>> > for ibg and ixgbe drivers here are the versions I used in both cases
>> > :
>> > Kernel 4.4.27
>> > modinfo igb :
>> > filename:       /lib/modules/4.4.27-
>> > HRN06/kernel/drivers/net/ethernet/intel/igb/igb.ko
>> > version:        5.3.0-k
>> > license:        GPL
>> > description:    Intel(R) Gigabit Ethernet Network Driver
>> > modinfo ixgbe:
>> > filename:       /lib/modules/4.4.27-
>> > HRN06/kernel/drivers/net/ethernet/intel/ixgbe/ixgbe.ko
>> > version:        4.2.1-k
>> > license:        GPL
>> > description:    Intel(R) 10 Gigabit PCI Express Network Driver
>> >
>> > Kernel 4.14.20
>> > modinfo igb:
>> > filename:       /lib/modules/4.14.20-
>> > HRN09/kernel/drivers/net/ethernet/intel/igb/igb.ko
>> > version:        5.4.0-k
>> > license:        GPL
>> > description:    Intel(R) Gigabit Ethernet Network Driver
>> > author:         Intel Corporation, <e1000-devel@lists.sourceforge.net
>> > >
>> > modinfo ixgbe
>> > filename:       /lib/modules/4.14.20-
>> > HRN09/kernel/drivers/net/ethernet/intel/ixgbe/ixgbe.ko
>> > version:        5.1.0-k
>> > license:        GPL
>> > description:    Intel(R) 10 Gigabit PCI Express Network Driver
>> > author:         Intel Corporation, <linux.nics@intel.com>
>> >
>> > I also modified RX buffers but no good results
>> >
>>
>> First thing, please send requests like this to our public mailing list
>> so that all of the Intel Ethernet developers can review and help
>> respond to your questions.  I have gone ahead and added our public
>> mailing list.
>>
>> The kernel versions you are using are older and do not contain all the
>> bug fixes and changes.  Is there any chance that you can use the latest
>> kernel from David Miller or Linus kernel git tree?
>>
>> Also can you provide the hardware you are using for both the igb and
>> ixgbe drivers?  Specifically the NICs you are using.  This can be
>> obtained by running lspci -vvv.
>>
>>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190524/d44e2495/attachment.html>

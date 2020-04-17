From: Yi Yang =?unknown-8bit?b?5p2o54eaLeS6keacjeWKoembhuWbog==?= <yangyi01@inspur.com>
Date: Fri, 17 Apr 2020 01:32:05 +0000
Subject: [Intel-wired-lan] =?utf-8?b?562U5aSNOiAgQW55Ym9keSBrbm93cyB3aHkg?=
 =?utf-8?q?Intel_82599ES_10Gb_NIC_has_low_small_UDP_packets_forwarding_per?=
 =?utf-8?q?formance=3F?=
In-Reply-To: <CAKgT0UeaeQo1b1+yfiOZQG_GrGWGy5EX0QD+r4NxYJcmf-EjOA@mail.gmail.com>
References: <e640c125696a0a5395089846266c9146@sslemail.net>
 <CAKgT0UeKxrJr_GrcRR8igxNLAPoh9b=pYajozsL+b3==abhdBQ@mail.gmail.com>
 <d418667033b84bcdb23e57e4ea8ecd61@inspur.com>
 <CAKgT0UeaeQo1b1+yfiOZQG_GrGWGy5EX0QD+r4NxYJcmf-EjOA@mail.gmail.com>
Message-ID: <bb3a9253b3a94592b319b2fa245c6124@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks Alexander, I checked IOMMU, here is info.

$ sudo cat /proc/cmdline
BOOT_IMAGE=/boot/vmlinuz-4.15.0-46-generic root=/dev/mapper/vg1-lvroot ro default_hugepagesz=1G hugepagesz=1G hugepages=16
$ dmesg | grep -i iommu
[    0.000000] DMAR-IR: IOAPIC id 3 under DRHD base  0xfbffc000 IOMMU 0
[    0.000000] DMAR-IR: IOAPIC id 1 under DRHD base  0xc7ffc000 IOMMU 1
[    0.000000] DMAR-IR: IOAPIC id 2 under DRHD base  0xc7ffc000 IOMMU 1
$

It looks like IOMMU isn't enabled.

-----????-----
???: Alexander Duyck [mailto:alexander.duyck at gmail.com] 
????: 2020?4?17? 2:36
???: Yi Yang (??)-????? <yangyi01@inspur.com>
??: intel-wired-lan at lists.osuosl.org
??: Re: [Intel-wired-lan] Anybody knows why Intel 82599ES 10Gb NIC has low small UDP packets forwarding performance?

When you say 16 byte UDP packets I assume you mean 16B of payload. So with 14B ethernet header, 20B of IP header, 8B UDP header, and I am assuming 2B of padding you are carrying a 60 byte packet when everything is said and done. From personal experience I can tell you that the adapter should be able to handle about 10Mpps or so per port with packets that size. I have done routing tests in the past with those sort of packets without any issue. However the overhead for those packets is significantly higher than standard packets as you end up having to perform operations per-packet where as with TCP you have the advantage of TSO so you have one large frame that the adapter will break up into smaller pieces.

With that said, have you tried running "perf top" on a system under test to see what hot spots there are? That might help to identify any issues.

I know one common one that can cause significant small packet performance regressions is having an IOMMU enabled on the system without using the kernel parameter "iommu=pt". What can happen is that the DMA mapping will become a bottle-neck as each mapping will require using a resource lock on a table that is shared between all of the queues. You can probably run "dmesg | grep -i iommu" to see if anything pops up in your logs related to an IOMMU being enabled.

Other than that you might double check your interrupt moderation settings. You might start trying assigning manual delays via "ethtool -C" instead of allowing for dynamic rates to see if that has any effect.

Hope that helps.

- Alex

On Wed, Apr 15, 2020 at 7:25 PM Yi Yang (??)-????? <yangyi01@inspur.com> wrote:
>
> Thanks Alexander, but unfortunately, this NIC is integrated into motherboard, so we can't unplug it.
>
> I'm very sure it isn't PCIe bandwidth issue, because TCP and UDP performance are ok, only small UDP pps performance is bad. 16 bytes UDP packets won't consume too much bandwidth, 200Mbps is enough.
>
> -----????-----
> ???: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> ????: 2020?4?15? 23:15
> ???: Yi Yang (??)-????? <yangyi01@inspur.com>
> ??: intel-wired-lan at lists.osuosl.org
> ??: Re: [Intel-wired-lan] Anybody knows why Intel 82599ES 10Gb NIC has low small UDP packets forwarding performance?
>
> On Wed, Apr 15, 2020 at 1:03 AM Yi Yang (??)-????? <yangyi01@inspur.com> wrote:
> >
> > Hi, guys
> >
> > We find Intel 82599ES 10Gb NIC has low small UDP packets forwarding 
> > performance, this also impacts on 16 bytes UDP pps(packet per 
> > second) performance of VMs in Openstack environment, my NIC information is below:
> >
> > $ ethtool -i ten1
> > driver: ixgbe
> > version: 5.6.5
> > firmware-version: 0x800003df
> > expansion-rom-version:
> > bus-info: 0000:06:00.0
> > supports-statistics: yes
> > supports-test: yes
> > supports-eeprom-access: yes
> > supports-register-dump: yes
> > supports-priv-flags: yes
> > $
> >
> > On VMs,for 16 bytes UDP packets, maximum pps is about 180000 (I have 
> > tuned irq affinity, VM is pinned to fixed CPU, it is scheduled on 
> > the same numa node as NIC, so this has been a maximum possible 
> > value), we also tried physical port to physical port pps performance 
> > in two physical machines, that only can reach maximum pps 300000 (I have tried all the tuning ways).
> >
> > But on my other servers which have Intel X710 10Gb NIC, the driver 
> > is i40e, not ixgbe, it can reach 350000 pps for physical port to 
> > physical port case without any extra tuning. In VxLAN case, for 32 
> > bytes UDP packets, pps can reach 200000 very easily, it doesn?t need any extra tuning.
> >
> > https://docs.openstack.org/developer/performance-docs/test_plans/ten
> > an
> > t_netw
> > orking/plan.html and
> > https://docs.openstack.org/developer/performance-docs/test_results/t
> > en ant_ne tworking/neutron_vxlan_dvr_378/perl_l2/index.html#tcp show 
> > ixgbe driver also can reach 200000 pps for 32 bytes UDP packet for 
> > VMs and VxLAN cases. It doesn't mention which Intel Ethernet 
> > Controller is used.
> >
> > Metric
> >                Min    Avg     Max
> > loss, %                4.09
> > jitter, ms              0.01
> > packets, pps 190320     199583  213660
> >
> >
> > My issue is anybody knows if 82599ES can reach 350000 pps for 16 
> > bytes UDP packets for physical port to physical port case (note: I 
> > mean
> > iperf3 performance, I know DPDK can reach this).
> >
> > BTW, I find 82599ES can support VxLAN TSO offload, the performance 
> > data is good in case that VM MTU is configured to 8950 (our underlay 
> > MTU is 9000), both TCP and UDP performance can reach line speed.
>
> There could be a number of things going on. You might want to check your interrupt moderation settings, you might want to make sure you do not have an IOMMU enabled, you will want to make certain you have sufficient PCIe bandwidth as the X710 is a PCIe gen 3 part and 82599 is only gen2. You may want to double check to make sure the memory layout between the two systems is the same as memory can cause delays in packet throughput.
>
> My advice would be to see if you can swap the X710 and 82599 between two of your systems and see if the performance issues follow the card or the server. If it follows the server then you likely have something misconfigured on the server, if it follows the card then we could follow up with additional debugging.
>
> Thanks.
>
> - Alex
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 3600 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200417/e9df7f4c/attachment.p7s>

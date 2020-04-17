From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 17 Apr 2020 12:48:05 -0700
Subject: [Intel-wired-lan] Anybody knows why Intel 82599ES 10Gb NIC has
 low small UDP packets forwarding performance?
In-Reply-To: <d44d3db8140f4fe2a105b9d6e6cdc6ae@inspur.com>
References: <e640c125696a0a5395089846266c9146@sslemail.net>
 <CAKgT0UeKxrJr_GrcRR8igxNLAPoh9b=pYajozsL+b3==abhdBQ@mail.gmail.com>
 <d418667033b84bcdb23e57e4ea8ecd61@inspur.com>
 <CAKgT0UeaeQo1b1+yfiOZQG_GrGWGy5EX0QD+r4NxYJcmf-EjOA@mail.gmail.com>
 <d44d3db8140f4fe2a105b9d6e6cdc6ae@inspur.com>
Message-ID: <CAKgT0UcRsiRDheB1+c6WZU9bcfLW8uHcokaM5TbRe7enWt2H1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

To change the interrupt moderation settings you will need to use the
rx-usecs command. The others don't change anything as I recall. The
default is 1 which is adaptive interrupt moderation. If I recall the
value has to be 8 or more to be accepted as the delay value between
interrupts.

So try something like this:
sudo ethtool -C ten1 rx-usecs 24

That should lock it in at ~40K interrupts per second if I am not mistaken.

Thanks.

- ALex

On Fri, Apr 17, 2020 at 1:37 AM Yi Yang (??)-????? <yangyi01@inspur.com> wrote:
>
> Alexander, I tried to change some coalesce parameters, but it seems it can't work for my NIC. What's wrong?
>
> $ sudo ethtool -i ten1
> driver: ixgbe
> version: 5.6.5
> firmware-version: 0x800003df
> expansion-rom-version:
> bus-info: 0000:06:00.0
> supports-statistics: yes
> supports-test: yes
> supports-eeprom-access: yes
> supports-register-dump: yes
> supports-priv-flags: yes
> $ sudo ethtool -c ten1
> Coalesce parameters for ten1:
> Adaptive RX: off  TX: off
> stats-block-usecs: 0
> sample-interval: 0
> pkt-rate-low: 0
> pkt-rate-high: 0
>
> rx-usecs: 50
> rx-frames: 0
> rx-usecs-irq: 0
> rx-frames-irq: 0
>
> tx-usecs: 0
> tx-frames: 0
> tx-usecs-irq: 0
> tx-frames-irq: 256
>
> rx-usecs-low: 0
> rx-frame-low: 0
> tx-usecs-low: 0
> tx-frame-low: 0
>
> rx-usecs-high: 0
> rx-frame-high: 0
> tx-usecs-high: 0
> tx-frame-high: 0
>
> $ sudo ethtool -C ten1 adaptive-rx on adaptive-tx on
> $ sudo ethtool -c ten1
> Coalesce parameters for ten1:
> Adaptive RX: off  TX: off
> stats-block-usecs: 0
> sample-interval: 0
> pkt-rate-low: 0
> pkt-rate-high: 0
>
> rx-usecs: 50
> rx-frames: 0
> rx-usecs-irq: 0
> rx-frames-irq: 0
>
> tx-usecs: 0
> tx-frames: 0
> tx-usecs-irq: 0
> tx-frames-irq: 256
>
> rx-usecs-low: 0
> rx-frame-low: 0
> tx-usecs-low: 0
> tx-frame-low: 0
>
> rx-usecs-high: 0
> rx-frame-high: 0
> tx-usecs-high: 0
> tx-frame-high: 0
>
> $ sudo ethtool -C ten1 rx-usecs 1
> $ sudo ethtool -C ten1 tx-usecs 1
> Cannot set device coalesce parameters: Invalid argument
> $ sudo ethtool -C ten1 rx-frames-irq 256
> $ sudo ethtool -c ten1
> Coalesce parameters for ten1:
> Adaptive RX: off  TX: off
> stats-block-usecs: 0
> sample-interval: 0
> pkt-rate-low: 0
> pkt-rate-high: 0
>
> rx-usecs: 1
> rx-frames: 0
> rx-usecs-irq: 0
> rx-frames-irq: 0
>
> tx-usecs: 0
> tx-frames: 0
> tx-usecs-irq: 0
> tx-frames-irq: 256
>
> rx-usecs-low: 0
> rx-frame-low: 0
> tx-usecs-low: 0
> tx-frame-low: 0
>
> rx-usecs-high: 0
> rx-frame-high: 0
> tx-usecs-high: 0
> tx-frame-high: 0
>
> $
>
> -----????-----
> ???: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> ????: 2020?4?17? 2:36
> ???: Yi Yang (??)-????? <yangyi01@inspur.com>
> ??: intel-wired-lan at lists.osuosl.org
> ??: Re: [Intel-wired-lan] Anybody knows why Intel 82599ES 10Gb NIC has low small UDP packets forwarding performance?
>
> When you say 16 byte UDP packets I assume you mean 16B of payload. So with 14B ethernet header, 20B of IP header, 8B UDP header, and I am assuming 2B of padding you are carrying a 60 byte packet when everything is said and done. From personal experience I can tell you that the adapter should be able to handle about 10Mpps or so per port with packets that size. I have done routing tests in the past with those sort of packets without any issue. However the overhead for those packets is significantly higher than standard packets as you end up having to perform operations per-packet where as with TCP you have the advantage of TSO so you have one large frame that the adapter will break up into smaller pieces.
>
> With that said, have you tried running "perf top" on a system under test to see what hot spots there are? That might help to identify any issues.
>
> I know one common one that can cause significant small packet performance regressions is having an IOMMU enabled on the system without using the kernel parameter "iommu=pt". What can happen is that the DMA mapping will become a bottle-neck as each mapping will require using a resource lock on a table that is shared between all of the queues. You can probably run "dmesg | grep -i iommu" to see if anything pops up in your logs related to an IOMMU being enabled.
>
> Other than that you might double check your interrupt moderation settings. You might start trying assigning manual delays via "ethtool -C" instead of allowing for dynamic rates to see if that has any effect.
>
> Hope that helps.
>
> - Alex
>
> On Wed, Apr 15, 2020 at 7:25 PM Yi Yang (??)-????? <yangyi01@inspur.com> wrote:
> >
> > Thanks Alexander, but unfortunately, this NIC is integrated into motherboard, so we can't unplug it.
> >
> > I'm very sure it isn't PCIe bandwidth issue, because TCP and UDP performance are ok, only small UDP pps performance is bad. 16 bytes UDP packets won't consume too much bandwidth, 200Mbps is enough.
> >
> > -----????-----
> > ???: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> > ????: 2020?4?15? 23:15
> > ???: Yi Yang (??)-????? <yangyi01@inspur.com>
> > ??: intel-wired-lan at lists.osuosl.org
> > ??: Re: [Intel-wired-lan] Anybody knows why Intel 82599ES 10Gb NIC has low small UDP packets forwarding performance?
> >
> > On Wed, Apr 15, 2020 at 1:03 AM Yi Yang (??)-????? <yangyi01@inspur.com> wrote:
> > >
> > > Hi, guys
> > >
> > > We find Intel 82599ES 10Gb NIC has low small UDP packets forwarding
> > > performance, this also impacts on 16 bytes UDP pps(packet per
> > > second) performance of VMs in Openstack environment, my NIC information is below:
> > >
> > > $ ethtool -i ten1
> > > driver: ixgbe
> > > version: 5.6.5
> > > firmware-version: 0x800003df
> > > expansion-rom-version:
> > > bus-info: 0000:06:00.0
> > > supports-statistics: yes
> > > supports-test: yes
> > > supports-eeprom-access: yes
> > > supports-register-dump: yes
> > > supports-priv-flags: yes
> > > $
> > >
> > > On VMs,for 16 bytes UDP packets, maximum pps is about 180000 (I have
> > > tuned irq affinity, VM is pinned to fixed CPU, it is scheduled on
> > > the same numa node as NIC, so this has been a maximum possible
> > > value), we also tried physical port to physical port pps performance
> > > in two physical machines, that only can reach maximum pps 300000 (I have tried all the tuning ways).
> > >
> > > But on my other servers which have Intel X710 10Gb NIC, the driver
> > > is i40e, not ixgbe, it can reach 350000 pps for physical port to
> > > physical port case without any extra tuning. In VxLAN case, for 32
> > > bytes UDP packets, pps can reach 200000 very easily, it doesn?t need any extra tuning.
> > >
> > > https://docs.openstack.org/developer/performance-docs/test_plans/ten
> > > an
> > > t_netw
> > > orking/plan.html and
> > > https://docs.openstack.org/developer/performance-docs/test_results/t
> > > en ant_ne tworking/neutron_vxlan_dvr_378/perl_l2/index.html#tcp show
> > > ixgbe driver also can reach 200000 pps for 32 bytes UDP packet for
> > > VMs and VxLAN cases. It doesn't mention which Intel Ethernet
> > > Controller is used.
> > >
> > > Metric
> > >                Min    Avg     Max
> > > loss, %                4.09
> > > jitter, ms              0.01
> > > packets, pps 190320     199583  213660
> > >
> > >
> > > My issue is anybody knows if 82599ES can reach 350000 pps for 16
> > > bytes UDP packets for physical port to physical port case (note: I
> > > mean
> > > iperf3 performance, I know DPDK can reach this).
> > >
> > > BTW, I find 82599ES can support VxLAN TSO offload, the performance
> > > data is good in case that VM MTU is configured to 8950 (our underlay
> > > MTU is 9000), both TCP and UDP performance can reach line speed.
> >
> > There could be a number of things going on. You might want to check your interrupt moderation settings, you might want to make sure you do not have an IOMMU enabled, you will want to make certain you have sufficient PCIe bandwidth as the X710 is a PCIe gen 3 part and 82599 is only gen2. You may want to double check to make sure the memory layout between the two systems is the same as memory can cause delays in packet throughput.
> >
> > My advice would be to see if you can swap the X710 and 82599 between two of your systems and see if the performance issues follow the card or the server. If it follows the server then you likely have something misconfigured on the server, if it follows the card then we could follow up with additional debugging.
> >
> > Thanks.
> >
> > - Alex

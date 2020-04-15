From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 15 Apr 2020 08:15:22 -0700
Subject: [Intel-wired-lan] Anybody knows why Intel 82599ES 10Gb NIC has
 low small UDP packets forwarding performance?
In-Reply-To: <f015337518734947a767c736a5dd3b03@inspur.com>
References: <f015337518734947a767c736a5dd3b03@inspur.com>
Message-ID: <CAKgT0UeKxrJr_GrcRR8igxNLAPoh9b=pYajozsL+b3==abhdBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Apr 15, 2020 at 1:03 AM Yi Yang (??)-????? <yangyi01@inspur.com> wrote:
>
> Hi, guys
>
> We find Intel 82599ES 10Gb NIC has low small UDP packets forwarding
> performance, this also impacts on 16 bytes UDP pps(packet per second)
> performance of VMs in Openstack environment, my NIC information is below:
>
> $ ethtool -i ten1
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
> $
>
> On VMs,for 16 bytes UDP packets, maximum pps is about 180000 (I have tuned
> irq affinity, VM is pinned to fixed CPU, it is scheduled on the same numa
> node as NIC, so this has been a maximum possible value), we also tried
> physical port to physical port pps performance in two physical machines,
> that only can reach maximum pps 300000 (I have tried all the tuning ways).
>
> But on my other servers which have Intel X710 10Gb NIC, the driver is i40e,
> not ixgbe, it can reach 350000 pps for physical port to physical port case
> without any extra tuning. In VxLAN case, for 32 bytes UDP packets, pps can
> reach 200000 very easily, it doesn?t need any extra tuning.
>
> https://docs.openstack.org/developer/performance-docs/test_plans/tenant_netw
> orking/plan.html and
> https://docs.openstack.org/developer/performance-docs/test_results/tenant_ne
> tworking/neutron_vxlan_dvr_378/perl_l2/index.html#tcp show ixgbe driver also
> can reach 200000 pps for 32 bytes UDP packet for VMs and VxLAN cases. It
> doesn't mention which Intel Ethernet Controller is used.
>
> Metric
>                Min    Avg     Max
> loss, %                4.09
> jitter, ms              0.01
> packets, pps 190320     199583  213660
>
>
> My issue is anybody knows if 82599ES can reach 350000 pps for 16 bytes UDP
> packets for physical port to physical port case (note: I mean iperf3
> performance, I know DPDK can reach this).
>
> BTW, I find 82599ES can support VxLAN TSO offload, the performance data is
> good in case that VM MTU is configured to 8950 (our underlay MTU is 9000),
> both TCP and UDP performance can reach line speed.

There could be a number of things going on. You might want to check
your interrupt moderation settings, you might want to make sure you do
not have an IOMMU enabled, you will want to make certain you have
sufficient PCIe bandwidth as the X710 is a PCIe gen 3 part and 82599
is only gen2. You may want to double check to make sure the memory
layout between the two systems is the same as memory can cause delays
in packet throughput.

My advice would be to see if you can swap the X710 and 82599 between
two of your systems and see if the performance issues follow the card
or the server. If it follows the server then you likely have something
misconfigured on the server, if it follows the card then we could
follow up with additional debugging.

Thanks.

- Alex

From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 20 Nov 2015 04:30:56 +0000
Subject: [Intel-wired-lan] [Next PATCH] [v2] igb: don't unmap NULL
 hw_addr
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81D3DA4F@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jarod Wilson <jarod@redhat.com>

> I've got a startech thunderbolt dock someone loaned me, which among other
> things, has the following device in it:

> 08:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connection (rev 03)
>
> This hotplugs just fine (kernel 4.2.0 plus a patch or two here):
>
> [  863.020315] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.2.18-k
> [  863.020316] igb: Copyright (c) 2007-2014 Intel Corporation.
> [  863.028657] igb 0000:08:00.0: enabling device (0000 -> 0002)
> [  863.062089] igb 0000:08:00.0: added PHC on eth0
> [  863.062090] igb 0000:08:00.0: Intel(R) Gigabit Ethernet Network Connection
> [  863.062091] igb 0000:08:00.0: eth0: (PCIe:2.5Gb/s:Width x1) e8:ea:6a:00:1b:2a
> [  863.062194] igb 0000:08:00.0: eth0: PBA No: 000200-000
> [  863.062196] igb 0000:08:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
> [  863.064889] igb 0000:08:00.0 enp8s0: renamed from eth0
>
> But disconnecting it is another story:
>
> [ 1002.807932] igb 0000:08:00.0: removed PHC on enp8s0
> [ 1002.807944] igb 0000:08:00.0 enp8s0: PCIe link lost, device now detached
> [ 1003.341141] ------------[ cut here ]------------
> [ 1003.341148] WARNING: CPU: 0 PID: 199 at lib/iomap.c:43 bad_io_access+0x38/0x40()
> [ 1003.341149] Bad IO access at port 0x0 ()

< snipping out most of trace >

> [ 1003.342893]  [<ffffffff8164e29f>] ret_from_fork+0x3f/0x70
> [ 1003.342894]  [<ffffffff8108dd10>] ? kthread_create_on_node+0x180/0x180
> [ 1003.342895] ---[ end trace 65a77e06d5aa9358 ]---
>
> Upon looking at the igb driver, I see that igb_rd32() attempted to read from
> hw_addr and failed, so it set hw->hw_addr to NULL and spit out the message
> in the log output above, "PCIe link lost, device now detached".
>
> Well, now that hw_addr is NULL, the attempt to call pci_iounmap is obviously
> not going to go well. As suggested by Mark Rustad, do something similar to
> what ixgbe does, and save a copy of hw_addr as adapter->io_addr, so we can
> still call pci_iounmap on it on teardown. Additionally, for consistency,
> make the pci_iomap call assignment directly to io_addr, so map and unmap
> match.

> CC: Mark Rustad <mark.d.rustad@intel.com>
> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> CC: intel-wired-lan at lists.osuosl.org
> CC: netdev at vger.kernel.org
> Signed-off-by: Jarod Wilson <jarod@redhat.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |  2 ++
>  drivers/net/ethernet/intel/igb/igb_main.c | 10 ++++++----
>  2 files changed, 8 insertions(+), 4 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

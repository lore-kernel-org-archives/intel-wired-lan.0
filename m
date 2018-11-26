From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 26 Nov 2018 09:56:28 -0800
Subject: [Intel-wired-lan] [PATCH V2] mm: Replace all open encodings for
 NUMA_NO_NODE
In-Reply-To: <1543235202-9075-1-git-send-email-anshuman.khandual@arm.com>
References: <1543235202-9075-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <c1b8de1a8e9d4d215b56498e2d5b83a02083483a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2018-11-26 at 17:56 +0530, Anshuman Khandual wrote:
> At present there are multiple places where invalid node number is
> encoded
> as -1. Even though implicitly understood it is always better to have
> macros
> in there. Replace these open encodings for an invalid node number
> with the
> global macro NUMA_NO_NODE. This helps remove NUMA related assumptions
> like
> 'invalid node' from various places redirecting them to a common
> definition.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

For the 'ixgbe' driver changes.

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>


> ---
> Changes in V2:
> 
> - Added inclusion of 'numa.h' header at various places per Andrew
> - Updated 'dev_to_node' to use NUMA_NO_NODE instead per Vinod
> 
> Changes in V1: (https://lkml.org/lkml/2018/11/23/485)
> 
> - Dropped OCFS2 changes per Joseph
> - Dropped media/video drivers changes per Hans
> 
> RFC - https://patchwork.kernel.org/patch/10678035/
> 
> Build tested this with multiple cross compiler options like alpha,
> sparc,
> arm64, x86, powerpc, powerpc64le etc with their default config which
> might
> not have compiled tested all driver related changes. I will
> appreciate
> folks giving this a test in their respective build environment.
> 
> All these places for replacement were found by running the following
> grep
> patterns on the entire kernel code. Please let me know if this might
> have
> missed some instances. This might also have replaced some false
> positives.
> I will appreciate suggestions, inputs and review.
> 
> 1. git grep "nid == -1"
> 2. git grep "node == -1"
> 3. git grep "nid = -1"
> 4. git grep "node = -1"
> 
>  arch/alpha/include/asm/topology.h             |  3 ++-
>  arch/ia64/kernel/numa.c                       |  2 +-
>  arch/ia64/mm/discontig.c                      |  6 +++---
>  arch/ia64/sn/kernel/io_common.c               |  3 ++-
>  arch/powerpc/include/asm/pci-bridge.h         |  3 ++-
>  arch/powerpc/kernel/paca.c                    |  3 ++-
>  arch/powerpc/kernel/pci-common.c              |  3 ++-
>  arch/powerpc/mm/numa.c                        | 14 +++++++-------
>  arch/powerpc/platforms/powernv/memtrace.c     |  5 +++--
>  arch/sparc/kernel/auxio_32.c                  |  3 ++-
>  arch/sparc/kernel/pci_fire.c                  |  3 ++-
>  arch/sparc/kernel/pci_schizo.c                |  3 ++-
>  arch/sparc/kernel/pcic.c                      |  7 ++++---
>  arch/sparc/kernel/psycho_common.c             |  3 ++-
>  arch/sparc/kernel/sbus.c                      |  3 ++-
>  arch/sparc/mm/init_64.c                       |  6 +++---
>  arch/sparc/prom/init_32.c                     |  3 ++-
>  arch/sparc/prom/init_64.c                     |  5 +++--
>  arch/sparc/prom/tree_32.c                     | 13 +++++++------
>  arch/sparc/prom/tree_64.c                     | 19 ++++++++++-------
> --
>  arch/x86/include/asm/pci.h                    |  3 ++-
>  arch/x86/kernel/apic/x2apic_uv_x.c            |  7 ++++---
>  arch/x86/kernel/smpboot.c                     |  3 ++-
>  arch/x86/platform/olpc/olpc_dt.c              | 17 +++++++++--------
>  drivers/block/mtip32xx/mtip32xx.c             |  5 +++--
>  drivers/dma/dmaengine.c                       |  4 +++-
>  drivers/infiniband/hw/hfi1/affinity.c         |  3 ++-
>  drivers/infiniband/hw/hfi1/init.c             |  3 ++-
>  drivers/iommu/dmar.c                          |  5 +++--
>  drivers/iommu/intel-iommu.c                   |  3 ++-
>  drivers/misc/sgi-xp/xpc_uv.c                  |  3 ++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  5 +++--
>  include/linux/device.h                        |  2 +-
>  init/init_task.c                              |  3 ++-
>  kernel/kthread.c                              |  3 ++-
>  kernel/sched/fair.c                           | 15 ++++++++-------
>  lib/cpumask.c                                 |  3 ++-
>  mm/huge_memory.c                              | 13 +++++++------
>  mm/hugetlb.c                                  |  3 ++-
>  mm/ksm.c                                      |  2 +-
>  mm/memory.c                                   |  7 ++++---
>  mm/memory_hotplug.c                           | 12 ++++++------
>  mm/mempolicy.c                                |  2 +-
>  mm/page_alloc.c                               |  4 ++--
>  mm/page_ext.c                                 |  2 +-
>  net/core/pktgen.c                             |  3 ++-
>  net/qrtr/qrtr.c                               |  3 ++-
>  tools/perf/bench/numa.c                       |  6 +++---
>  48 files changed, 146 insertions(+), 108 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181126/bfa2b061/attachment.asc>

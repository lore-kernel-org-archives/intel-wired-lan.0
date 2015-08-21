From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Aug 2015 16:41:34 +0000
Subject: [Intel-wired-lan] [Patch V3 6/9] i40evf: Use numa_mem_id()
	to	better support memoryless node
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016CEE87@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jiang Liu
> Sent: Sunday, August 16, 2015 8:19 PM
> To: Andrew Morton; Mel Gorman; David Rientjes; Mike Galbraith; Peter
> Zijlstra; Wysocki, Rafael J; Tang Chen; Tejun Heo; Kirsher, Jeffrey T;
> Brandeburg, Jesse; Nelson, Shannon; Wyborny, Carolyn; Skidmore, Donald C;
> Vick, Matthew; Ronciak, John; Williams, Mitch A
> Cc: Luck, Tony; netdev at vger.kernel.org; x86 at kernel.org; linux-
> hotplug at vger.kernel.org; linux-kernel at vger.kernel.org; linux-
> mm at kvack.org; intel-wired-lan at lists.osuosl.org; Jiang Liu
> Subject: [Intel-wired-lan] [Patch V3 6/9] i40evf: Use numa_mem_id() to
> better support memoryless node
> 
> Function i40e_clean_rx_irq() tries to reuse memory pages allocated from the
> nearest node. To better support memoryless node, use
> numa_mem_id() instead of numa_node_id() to get the nearest node with
> memory.
> 
> This change should only affect performance.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Present in git log, code changes present in tree, does not break base driver.

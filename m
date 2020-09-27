From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:49:04 +0200
Subject: [Intel-wired-lan] [patch 18/35] net: vxge: Remove in_interrupt()
 conditionals
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194921.639274921@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

vxge_os_dma_malloc() and vxge_os_dma_malloc_async() are both called from
callchains which use GFP_KERNEL allocations unconditionally or have other
requirements to be called from fully preemptible task context..

vxge_os_dma_malloc():
  1)  __vxge_hw_blockpool_create() <- GFP_KERNEL
	
  2)  __vxge_hw_mempool_grow() <- vzalloc()
        __vxge_hw_blockpool_malloc()

vxge_os_dma_malloc_async():
  1  __vxge_hw_mempool_grow() <- vzalloc()
      __vxge_hw_blockpool_malloc()
	__vxge_hw_blockpool_blocks_add()

  2)  vxge_hw_vpath_open()	<- vzalloc()
	__vxge_hw_blockpool_block_allocate()

That means neither of these functions needs a conditional allocation mode.

Remove the in_interrupt() conditional and use GFP_KERNEL.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev at vger.kernel.org

---
 drivers/net/ethernet/neterion/vxge/vxge-config.c |    9 +--------
 drivers/net/ethernet/neterion/vxge/vxge-config.h |    7 +------
 2 files changed, 2 insertions(+), 14 deletions(-)

--- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
@@ -2303,16 +2303,9 @@ static void vxge_hw_blockpool_block_add(
 static inline void
 vxge_os_dma_malloc_async(struct pci_dev *pdev, void *devh, unsigned long size)
 {
-	gfp_t flags;
 	void *vaddr;
 
-	if (in_interrupt())
-		flags = GFP_ATOMIC | GFP_DMA;
-	else
-		flags = GFP_KERNEL | GFP_DMA;
-
-	vaddr = kmalloc((size), flags);
-
+	vaddr = kmalloc(size, GFP_KERNEL | GFP_DMA);
 	vxge_hw_blockpool_block_add(devh, vaddr, size, pdev, pdev);
 }
 
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.h
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.h
@@ -1899,18 +1899,13 @@ static inline void *vxge_os_dma_malloc(s
 			struct pci_dev **p_dmah,
 			struct pci_dev **p_dma_acch)
 {
-	gfp_t flags;
 	void *vaddr;
 	unsigned long misaligned = 0;
 	int realloc_flag = 0;
 	*p_dma_acch = *p_dmah = NULL;
 
-	if (in_interrupt())
-		flags = GFP_ATOMIC | GFP_DMA;
-	else
-		flags = GFP_KERNEL | GFP_DMA;
 realloc:
-	vaddr = kmalloc((size), flags);
+	vaddr = kmalloc(size, GFP_KERNEL | GFP_DMA);
 	if (vaddr == NULL)
 		return vaddr;
 	misaligned = (unsigned long)VXGE_ALIGN((unsigned long)vaddr,


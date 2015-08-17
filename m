From: Patil, Kiran <kiran.patil@intel.com>
Date: Mon, 17 Aug 2015 19:03:44 +0000
Subject: [Intel-wired-lan] [Patch V3 6/9] i40evf: Use numa_mem_id()
	to	better support memoryless node
In-Reply-To: <1439781546-7217-7-git-send-email-jiang.liu@linux.intel.com>
References: <1439781546-7217-1-git-send-email-jiang.liu@linux.intel.com>
 <1439781546-7217-7-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <4197C471DCF8714FBA1FE32565271C148FFF786A@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK.

Thanks,
-- Kiran P.

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jiang Liu
Sent: Sunday, August 16, 2015 8:19 PM
To: Andrew Morton; Mel Gorman; David Rientjes; Mike Galbraith; Peter Zijlstra; Wysocki, Rafael J; Tang Chen; Tejun Heo; Kirsher, Jeffrey T; Brandeburg, Jesse; Nelson, Shannon; Wyborny, Carolyn; Skidmore, Donald C; Vick, Matthew; Ronciak, John; Williams, Mitch A
Cc: Luck, Tony; netdev at vger.kernel.org; x86 at kernel.org; linux-hotplug at vger.kernel.org; linux-kernel at vger.kernel.org; linux-mm at kvack.org; intel-wired-lan at lists.osuosl.org; Jiang Liu
Subject: [Intel-wired-lan] [Patch V3 6/9] i40evf: Use numa_mem_id() to better support memoryless node

Function i40e_clean_rx_irq() tries to reuse memory pages allocated from the nearest node. To better support memoryless node, use
numa_mem_id() instead of numa_node_id() to get the nearest node with memory.

This change should only affect performance.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 395f32f226c0..19ca96d8bd97 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1003,7 +1003,7 @@ static int i40e_clean_rx_irq_ps(struct i40e_ring *rx_ring, int budget)
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	u16 rx_packet_len, rx_header_len, rx_sph, rx_hbo;
 	u16 cleaned_count = I40E_DESC_UNUSED(rx_ring);
-	const int current_node = numa_node_id();
+	const int current_node = numa_mem_id();
 	struct i40e_vsi *vsi = rx_ring->vsi;
 	u16 i = rx_ring->next_to_clean;
 	union i40e_rx_desc *rx_desc;
--
1.7.10.4

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

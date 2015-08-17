From: Jiang Liu <jiang.liu@linux.intel.com>
Date: Mon, 17 Aug 2015 11:19:02 +0800
Subject: [Intel-wired-lan] [Patch V3 5/9] i40e: Use numa_mem_id() to better
	support memoryless node
In-Reply-To: <1439781546-7217-1-git-send-email-jiang.liu@linux.intel.com>
References: <1439781546-7217-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1439781546-7217-6-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Function i40e_clean_rx_irq() tries to reuse memory pages allocated
from the nearest node. To better support memoryless node, use
numa_mem_id() instead of numa_node_id() to get the nearest node with
memory.

This change should only affect performance.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 9a4f2bc70cd2..a8f618cb8eb0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1516,7 +1516,7 @@ static int i40e_clean_rx_irq_ps(struct i40e_ring *rx_ring, int budget)
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


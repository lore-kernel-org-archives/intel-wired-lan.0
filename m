From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed,  4 Nov 2020 15:08:57 +0100
Subject: [Intel-wired-lan] [PATCH bpf-next 1/6] i40e: introduce lazy Tx
 completions for AF_XDP zero-copy
In-Reply-To: <1604498942-24274-1-git-send-email-magnus.karlsson@gmail.com>
References: <1604498942-24274-1-git-send-email-magnus.karlsson@gmail.com>
Message-ID: <1604498942-24274-2-git-send-email-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

Introduce lazy Tx completions when a queue is used for AF_XDP
zero-copy. In the current design, each time we get into the NAPI poll
loop we try to complete as many Tx packets as possible from the
NIC. This is performed by reading the head pointer register in the NIC
that tells us how many packets have been completed. Reading this
register is expensive as it is across PCIe, so let us try to limit the
number of times it is read by only completing Tx packets to user-space
when the number of available descriptors in the Tx HW ring is below
some threshold. This will decrease the number of reads issued to the
NIC and improves performance with 1.5% - 2% for the l2fwd xdpsock
microbenchmark.

The threshold is set to the minimum possible size that the HW ring can
have. This so that we do not run into a scenario where the threshold
is higher than the configured number of descriptors in the HW ring.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 6acede0..f8815b3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -9,6 +9,8 @@
 #include "i40e_txrx_common.h"
 #include "i40e_xsk.h"
 
+#define I40E_TX_COMPLETION_THRESHOLD I40E_MIN_NUM_DESCRIPTORS
+
 int i40e_alloc_rx_bi_zc(struct i40e_ring *rx_ring)
 {
 	unsigned long sz = sizeof(*rx_ring->rx_bi_zc) * rx_ring->count;
@@ -460,12 +462,15 @@ static void i40e_clean_xdp_tx_buffer(struct i40e_ring *tx_ring,
  **/
 bool i40e_clean_xdp_tx_irq(struct i40e_vsi *vsi, struct i40e_ring *tx_ring)
 {
+	u32 i, completed_frames, xsk_frames = 0, head_idx;
 	struct xsk_buff_pool *bp = tx_ring->xsk_pool;
-	u32 i, completed_frames, xsk_frames = 0;
-	u32 head_idx = i40e_get_head(tx_ring);
 	struct i40e_tx_buffer *tx_bi;
 	unsigned int ntc;
 
+	if (I40E_DESC_UNUSED(tx_ring) >= I40E_TX_COMPLETION_THRESHOLD)
+		goto out_xmit;
+
+	head_idx = i40e_get_head(tx_ring);
 	if (head_idx < tx_ring->next_to_clean)
 		head_idx += tx_ring->count;
 	completed_frames = head_idx - tx_ring->next_to_clean;
-- 
2.7.4


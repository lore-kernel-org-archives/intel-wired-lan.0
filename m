From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed,  4 Nov 2020 15:08:59 +0100
Subject: [Intel-wired-lan] [PATCH bpf-next 3/6] i40e: remove unnecessary
 sw_ring access from xsk Tx
In-Reply-To: <1604498942-24274-1-git-send-email-magnus.karlsson@gmail.com>
References: <1604498942-24274-1-git-send-email-magnus.karlsson@gmail.com>
Message-ID: <1604498942-24274-4-git-send-email-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

Remove the unnecessary access to the software ring for the AF_XDP
zero-copy driver. This was used to record the length of the packet so
that the driver Tx completion code could sum this up to produce the
total bytes sent. This is now performed during the transmission of the
packet, so no need to record this in the software ring.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index f8815b3..eabe1a3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -394,7 +394,6 @@ static bool i40e_xmit_zc(struct i40e_ring *xdp_ring, unsigned int budget)
 {
 	unsigned int sent_frames = 0, total_bytes = 0;
 	struct i40e_tx_desc *tx_desc = NULL;
-	struct i40e_tx_buffer *tx_bi;
 	struct xdp_desc desc;
 	dma_addr_t dma;
 
@@ -406,9 +405,6 @@ static bool i40e_xmit_zc(struct i40e_ring *xdp_ring, unsigned int budget)
 		xsk_buff_raw_dma_sync_for_device(xdp_ring->xsk_pool, dma,
 						 desc.len);
 
-		tx_bi = &xdp_ring->tx_bi[xdp_ring->next_to_use];
-		tx_bi->bytecount = desc.len;
-
 		tx_desc = I40E_TX_DESC(xdp_ring, xdp_ring->next_to_use);
 		tx_desc->buffer_addr = cpu_to_le64(dma);
 		tx_desc->cmd_type_offset_bsz =
@@ -417,7 +413,7 @@ static bool i40e_xmit_zc(struct i40e_ring *xdp_ring, unsigned int budget)
 				   0, desc.len, 0);
 
 		sent_frames++;
-		total_bytes += tx_bi->bytecount;
+		total_bytes += desc.len;
 
 		xdp_ring->next_to_use++;
 		if (xdp_ring->next_to_use == xdp_ring->count)
-- 
2.7.4


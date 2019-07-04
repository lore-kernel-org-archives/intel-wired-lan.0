From: Magnus Karlsson <magnus.karlsson@intel.com>
Date: Thu,  4 Jul 2019 14:42:11 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next v3 3/6] i40e: add support for
 AF_XDP need_wakup feature
In-Reply-To: <1562244134-19069-1-git-send-email-magnus.karlsson@intel.com>
References: <1562244134-19069-1-git-send-email-magnus.karlsson@intel.com>
Message-ID: <1562244134-19069-4-git-send-email-magnus.karlsson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds support for the need_wakeup feature of AF_XDP. If the
application has told the kernel that it might sleep using the new bind
flag XDP_USE_NEED_WAKEUP, the driver will then set this flag if it has
no more buffers on the NIC Rx ring and yield to the application. For
Tx, it will set the flag if it has no outstanding Tx completion
interrupts and return to the application.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index d0ff5d8..18de7b6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -626,6 +626,15 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 
 	i40e_finalize_xdp_rx(rx_ring, xdp_xmit);
 	i40e_update_rx_stats(rx_ring, total_rx_bytes, total_rx_packets);
+
+	if (xsk_umem_uses_might_sleep(rx_ring->xsk_umem)) {
+		if (failure || rx_ring->next_to_clean == rx_ring->next_to_use)
+			xsk_set_rx_need_wakeup(rx_ring->xsk_umem);
+		else
+			xsk_clear_rx_need_wakeup(rx_ring->xsk_umem);
+
+		return (int)total_rx_packets;
+	}
 	return failure ? budget : (int)total_rx_packets;
 }
 
@@ -761,6 +770,13 @@ bool i40e_clean_xdp_tx_irq(struct i40e_vsi *vsi,
 out_xmit:
 	xmit_done = i40e_xmit_zc(tx_ring, budget);
 
+	if (xsk_umem_uses_might_sleep(tx_ring->xsk_umem)) {
+		if (tx_ring->next_to_clean == tx_ring->next_to_use)
+			xsk_set_tx_need_wakeup(tx_ring->xsk_umem);
+		else
+			xsk_clear_tx_need_wakeup(tx_ring->xsk_umem);
+	}
+
 	return work_done && xmit_done;
 }
 
-- 
2.7.4


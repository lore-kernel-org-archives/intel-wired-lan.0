From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu,  4 Apr 2019 09:36:55 -0700
Subject: [Intel-wired-lan] [2/2] ixgbe: fix AF_XDP tx packet count.
In-Reply-To: <20190404163655.27662-1-jeffrey.t.kirsher@intel.com>
References: <20190404163655.27662-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20190404163655.27662-2-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: William Tu <u9012063@gmail.com>

The total_packets count at ixgbe_clean_xdp_tx_irq is
always zero when testing with xdpsock -t -N. Set the gso_segs
to 1 to make the tx packet count correct.

Signed-off-by: William Tu <u9012063@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 71b8474a9b4c..1a60764fb39b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -640,6 +640,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 		tx_bi = &xdp_ring->tx_buffer_info[xdp_ring->next_to_use];
 		tx_bi->bytecount = len;
 		tx_bi->xdpf = NULL;
+		tx_bi->gso_segs = 1;
 
 		tx_desc = IXGBE_TX_DESC(xdp_ring, xdp_ring->next_to_use);
 		tx_desc->read.buffer_addr = cpu_to_le64(dma);

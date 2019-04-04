From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu,  4 Apr 2019 09:36:54 -0700
Subject: [Intel-wired-lan] [1/2] ixgbe: fix AF_XDP tx byte count
Message-ID: <20190404163655.27662-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: William Tu <u9012063@gmail.com>

The tx bytecount is done twice.  When running
'./xdpsock -t -N -i eth3' and 'ip -s link show dev eth3'
The avg packet size is 120 instead of 60. So remove the
extra one.

Signed-off-by: William Tu <u9012063@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index bfe95ce0bd7f..71b8474a9b4c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -704,7 +704,6 @@ bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
 			xsk_frames++;
 
 		tx_bi->xdpf = NULL;
-		total_bytes += tx_bi->bytecount;
 
 		tx_bi++;
 		tx_desc++;

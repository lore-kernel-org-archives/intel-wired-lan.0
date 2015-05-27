From: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Date: Wed, 27 May 2015 16:19:50 +0300
Subject: [Intel-wired-lan] [PATCH 1/5] e1000e: fix flush_desc_ring
	implementation
Message-ID: <f063947281680c84305a9376b0ea73fa1698eeb1.1432732734.git.yanirx.lubetkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The indication that a descriptor ring flush is required was read from
FEXTNVM7 by mistake. it should be read from the pci config space.

Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h   |  2 ++
 drivers/net/ethernet/intel/e1000e/ich8lan.h |  1 -
 drivers/net/ethernet/intel/e1000e/netdev.c  | 12 +++++++-----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 0abc942..e78487a 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -98,6 +98,8 @@ struct e1000_info;
 #define DEFAULT_RADV			8
 #define BURST_RDTR			0x20
 #define BURST_RADV			0x20
+#define PCICFG_DESC_RING_STATUS		0xe4
+#define FLUSH_DESC_REQUIRED		0x100
 
 /* in the case of WTHRESH, it appears at least the 82571/2 hardware
  * writes back 4 descriptors when WTHRESH=5, and 3 descriptors when
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
index 6b5d116..da0454c 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
@@ -100,7 +100,6 @@
 #define E1000_FEXTNVM7_DISABLE_PB_READ	0x00040000
 
 #define E1000_FEXTNVM7_DISABLE_SMB_PERST	0x00000020
-#define E1000_FEXTNVM7_NEED_DESCRING_FLUSH	0x00000100
 #define E1000_FEXTNVM11_DISABLE_MULR_FIX	0x00002000
 
 /* bit24: RXDCTL thresholds granularity: 0 - cache lines, 1 - descriptors */
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index b2d77a5..4f029b6 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3867,7 +3867,7 @@ static void e1000_flush_rx_ring(struct e1000_adapter *adapter)
 
 static void e1000_flush_desc_rings(struct e1000_adapter *adapter)
 {
-	u32 hang_state;
+	u16 hang_state;
 	u32 fext_nvm11, tdlen;
 	struct e1000_hw *hw = &adapter->hw;
 
@@ -3877,13 +3877,15 @@ static void e1000_flush_desc_rings(struct e1000_adapter *adapter)
 	ew32(FEXTNVM11, fext_nvm11);
 	/* do nothing if we're not in faulty state, or if the queue is empty */
 	tdlen = er32(TDLEN(0));
-	hang_state = er32(FEXTNVM7);
-	if (!(hang_state & E1000_FEXTNVM7_NEED_DESCRING_FLUSH) || !tdlen)
+	pci_read_config_word(adapter->pdev, PCICFG_DESC_RING_STATUS,
+			     &hang_state);
+	if (!(hang_state & FLUSH_DESC_REQUIRED) || !tdlen)
 		return;
 	e1000_flush_tx_ring(adapter);
 	/* recheck, maybe the fault is caused by the rx ring */
-	hang_state = er32(FEXTNVM7);
-	if (hang_state & E1000_FEXTNVM7_NEED_DESCRING_FLUSH)
+	pci_read_config_word(adapter->pdev, PCICFG_DESC_RING_STATUS,
+			     &hang_state);
+	if (hang_state & FLUSH_DESC_REQUIRED)
 		e1000_flush_rx_ring(adapter);
 }
 
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


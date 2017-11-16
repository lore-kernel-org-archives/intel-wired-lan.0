From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 16 Nov 2017 11:54:42 -0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher/next-queue 4/9] ixgbe: add
 ipsec data to driver struct
In-Reply-To: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
References: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1510862087-1924-5-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add the ipsec table definitions to the driver's adapter struct and
add the new code into the Makefile.  This sets the stage for
actually using the new code.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/Makefile |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h  | 43 +++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/Makefile b/drivers/net/ethernet/intel/ixgbe/Makefile
index 35e6fa6..8319465 100644
--- a/drivers/net/ethernet/intel/ixgbe/Makefile
+++ b/drivers/net/ethernet/intel/ixgbe/Makefile
@@ -42,3 +42,4 @@ ixgbe-$(CONFIG_IXGBE_DCB) +=  ixgbe_dcb.o ixgbe_dcb_82598.o \
 ixgbe-$(CONFIG_IXGBE_HWMON) += ixgbe_sysfs.o
 ixgbe-$(CONFIG_DEBUG_FS) += ixgbe_debugfs.o
 ixgbe-$(CONFIG_FCOE:m=y) += ixgbe_fcoe.o
+ixgbe-$(CONFIG_XFRM_OFFLOAD) += ixgbe_ipsec.o
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 468c355..f324271 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -52,6 +52,9 @@
 #ifdef CONFIG_IXGBE_DCA
 #include <linux/dca.h>
 #endif
+#ifdef CONFIG_XFRM_OFFLOAD
+#include "ixgbe_ipsec.h"
+#endif /* CONFIG_XFRM_OFFLOAD */
 
 #include <net/busy_poll.h>
 
@@ -170,10 +173,11 @@ enum ixgbe_tx_flags {
 	IXGBE_TX_FLAGS_CC	= 0x08,
 	IXGBE_TX_FLAGS_IPV4	= 0x10,
 	IXGBE_TX_FLAGS_CSUM	= 0x20,
+	IXGBE_TX_FLAGS_IPSEC    = 0x40,
 
 	/* software defined flags */
-	IXGBE_TX_FLAGS_SW_VLAN	= 0x40,
-	IXGBE_TX_FLAGS_FCOE	= 0x80,
+	IXGBE_TX_FLAGS_SW_VLAN	= 0x80,
+	IXGBE_TX_FLAGS_FCOE	= 0x100,
 };
 
 /* VLAN info */
@@ -279,6 +283,10 @@ struct ixgbe_rx_queue_stats {
 	u64 alloc_rx_page_failed;
 	u64 alloc_rx_buff_failed;
 	u64 csum_err;
+#if CONFIG_XFRM_OFFLOAD
+	u64 ipsec_offloads;
+	u64 ipsec_offload_faileds;
+#endif /* CONFIG_XFRM_OFFLOAD */
 };
 
 #define IXGBE_TS_HDR_LEN 8
@@ -629,6 +637,8 @@ struct ixgbe_adapter {
 #define IXGBE_FLAG2_EEE_CAPABLE			BIT(14)
 #define IXGBE_FLAG2_EEE_ENABLED			BIT(15)
 #define IXGBE_FLAG2_RX_LEGACY			BIT(16)
+#define IXGBE_FLAG2_IPSEC_CAPABLE		BIT(17)
+#define IXGBE_FLAG2_IPSEC_ENABLED		BIT(18)
 
 	/* Tx fast path data */
 	int num_tx_queues;
@@ -780,6 +790,14 @@ struct ixgbe_adapter {
 
 #define IXGBE_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
 	u32 *rss_key;
+
+#ifdef CONFIG_XFRM
+	u16 num_rx_sa;
+	u16 num_tx_sa;
+	struct rx_ip_sa *rx_ip_sa_tbl;
+	struct rx_sa *rx_sa_tbl;
+	struct tx_sa *tx_sa_tbl;
+#endif /* CONFIG_XFRM */
 };
 
 static inline u8 ixgbe_max_rss_indices(struct ixgbe_adapter *adapter)
@@ -1010,4 +1028,25 @@ void ixgbe_store_key(struct ixgbe_adapter *adapter);
 void ixgbe_store_reta(struct ixgbe_adapter *adapter);
 s32 ixgbe_negotiate_fc(struct ixgbe_hw *hw, u32 adv_reg, u32 lp_reg,
 		       u32 adv_sym, u32 adv_asm, u32 lp_sym, u32 lp_asm);
+
+#ifdef CONFIG_XFRM_OFFLOAD
+void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter);
+void ixgbe_ipsec_process_rx_offload(struct ixgbe_ring *rx_ring,
+				    union ixgbe_adv_rx_desc *rx_desc,
+				    struct sk_buff *skb);
+int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring, struct sk_buff *skb,
+		   struct ixgbe_ipsec_tx_data *itd);
+void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter);
+void ixgbe_ipsec_dump_info(struct ixgbe_adapter *adapter);
+void ixgbe_ipsec_dump_hw(struct ixgbe_adapter *adapter);
+void ixgbe_ipsec_clear_hw_tables(struct ixgbe_adapter *adapter);
+#else
+inline void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter) { };
+inline void ixgbe_ipsec_process_rx_offload(struct ixgbe_ring *rx_ring,
+				    union ixgbe_adv_rx_desc *rx_desc,
+				    struct sk_buff *skb) { };
+inline int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring, struct sk_buff *skb,
+		   struct ixgbe_ipsec_tx_data *itd) { return 0; };
+inline void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter) { };
+#endif /* CONFIG_XFRM_OFFLOAD */
 #endif /* _IXGBE_H_ */
-- 
2.7.4


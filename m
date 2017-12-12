From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 12 Dec 2017 15:36:57 -0800
Subject: [Intel-wired-lan] [PATCH v2 next-queue 04/10] ixgbe: add ipsec data
 structures
In-Reply-To: <1513121823-27944-1-git-send-email-shannon.nelson@oracle.com>
References: <1513121823-27944-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1513121823-27944-5-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Set up the data structures to be used by the ipsec offload.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
v2: ipaddr[] becomes __be32
    increase the hash table size

 drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  5 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h | 40 ++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 1e11462..9487750 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -622,6 +622,7 @@ struct ixgbe_adapter {
 #define IXGBE_FLAG2_EEE_CAPABLE			BIT(14)
 #define IXGBE_FLAG2_EEE_ENABLED			BIT(15)
 #define IXGBE_FLAG2_RX_LEGACY			BIT(16)
+#define IXGBE_FLAG2_IPSEC_ENABLED		BIT(17)
 
 	/* Tx fast path data */
 	int num_tx_queues;
@@ -772,6 +773,10 @@ struct ixgbe_adapter {
 
 #define IXGBE_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
 	u32 *rss_key;
+
+#ifdef CONFIG_XFRM
+	struct ixgbe_ipsec *ipsec;
+#endif /* CONFIG_XFRM */
 };
 
 static inline u8 ixgbe_max_rss_indices(struct ixgbe_adapter *adapter)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
index 341d3f0..ba1c82e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
@@ -49,4 +49,44 @@ enum ixgbe_ipsec_tbl_sel {
 #define IXGBE_RXMOD_DECRYPT		0x00000008
 #define IXGBE_RXMOD_IPV6		0x00000010
 
+struct rx_sa {
+	struct hlist_node hlist;
+	struct xfrm_state *xs;
+	__be32 ipaddr[4];
+	u32 key[4];
+	u32 salt;
+	u32 mode;
+	u8  iptbl_ind;
+	bool used;
+	bool decrypt;
+};
+
+struct rx_ip_sa {
+	__be32 ipaddr[4];
+	u32 ref_cnt;
+	bool used;
+};
+
+struct tx_sa {
+	struct xfrm_state *xs;
+	u32 key[4];
+	u32 salt;
+	bool encrypt;
+	bool used;
+};
+
+struct ixgbe_ipsec_tx_data {
+	u32 flags;
+	u16 trailer_len;
+	u16 sa_idx;
+};
+
+struct ixgbe_ipsec {
+	u16 num_rx_sa;
+	u16 num_tx_sa;
+	struct rx_ip_sa *ip_tbl;
+	struct rx_sa *rx_tbl;
+	struct tx_sa *tx_tbl;
+	DECLARE_HASHTABLE(rx_sa_list, 10);
+};
 #endif /* _IXGBE_IPSEC_H_ */
-- 
2.7.4


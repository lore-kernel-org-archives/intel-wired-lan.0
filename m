From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 19 Dec 2017 15:59:58 -0800
Subject: [Intel-wired-lan] [PATCH v3 next-queue 06/10] ixgbe: restore
 offloaded SAs after a reset
In-Reply-To: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1513728002-7643-7-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On a chip reset most of the table contents are lost, so must be
restored.  This scans the driver's ipsec tables and restores both
the filled and empty table slots to their pre-reset values.

v2: during restore, clean the tables before restarting

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 41 ++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  1 +
 3 files changed, 44 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 8f41508..af690c2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -1010,8 +1010,10 @@ s32 ixgbe_negotiate_fc(struct ixgbe_hw *hw, u32 adv_reg, u32 lp_reg,
 #ifdef CONFIG_XFRM_OFFLOAD
 void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter);
 void ixgbe_stop_ipsec_offload(struct ixgbe_adapter *adapter);
+void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter);
 #else
 static inline void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter) { };
 static inline void ixgbe_stop_ipsec_offload(struct ixgbe_adapter *adapter) { };
+static inline void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter) { };
 #endif /* CONFIG_XFRM_OFFLOAD */
 #endif /* _IXGBE_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 96971ce..9cf120d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -299,6 +299,47 @@ static void ixgbe_ipsec_start_engine(struct ixgbe_adapter *adapter)
 }
 
 /**
+ * ixgbe_ipsec_restore - restore the ipsec HW settings after a reset
+ * @adapter: board private structure
+ **/
+void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_ipsec *ipsec = adapter->ipsec;
+	struct ixgbe_hw *hw = &adapter->hw;
+	int i;
+
+	if (!(adapter->flags2 & IXGBE_FLAG2_IPSEC_ENABLED))
+		return;
+
+	/* clean up and restart the engine */
+	ixgbe_ipsec_stop_engine(adapter);
+	ixgbe_ipsec_clear_hw_tables(adapter);
+	ixgbe_ipsec_start_engine(adapter);
+
+	/* reload the IP addrs */
+	for (i = 0; i < IXGBE_IPSEC_MAX_RX_IP_COUNT; i++) {
+		struct rx_ip_sa *ipsa = &ipsec->ip_tbl[i];
+
+		if (ipsa->used)
+			ixgbe_ipsec_set_rx_ip(hw, i, ipsa->ipaddr);
+	}
+
+	/* reload the Rx and Tx keys */
+	for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT; i++) {
+		struct rx_sa *rsa = &ipsec->rx_tbl[i];
+		struct tx_sa *tsa = &ipsec->tx_tbl[i];
+
+		if (rsa->used)
+			ixgbe_ipsec_set_rx_sa(hw, i, rsa->xs->id.spi,
+					      rsa->key, rsa->salt,
+					      rsa->mode, rsa->iptbl_ind);
+
+		if (tsa->used)
+			ixgbe_ipsec_set_tx_sa(hw, i, tsa->key, tsa->salt);
+	}
+}
+
+/**
  * ixgbe_ipsec_find_empty_idx - find the first unused security parameter index
  * @ipsec: pointer to ipsec struct
  * @rxtable: true if we need to look in the Rx table
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2b3da0c..04e8b26 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5347,6 +5347,7 @@ static void ixgbe_configure(struct ixgbe_adapter *adapter)
 
 	ixgbe_set_rx_mode(adapter->netdev);
 	ixgbe_restore_vlan(adapter);
+	ixgbe_ipsec_restore(adapter);
 
 	switch (hw->mac.type) {
 	case ixgbe_mac_82599EB:
-- 
2.7.4


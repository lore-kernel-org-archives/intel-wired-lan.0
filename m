From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon,  4 Dec 2017 21:35:12 -0800
Subject: [Intel-wired-lan] [next-queue 06/10] ixgbe: restore offloaded SAs
 after a reset
In-Reply-To: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1512452116-14795-7-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On a chip reset most of the table contents are lost, so must be
restored.  This scans the driver's ipsec tables and restores both
the filled and empty table slots to their pre-reset values.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 53 ++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  1 +
 3 files changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 9487750..7e8bca7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -1009,7 +1009,9 @@ s32 ixgbe_negotiate_fc(struct ixgbe_hw *hw, u32 adv_reg, u32 lp_reg,
 		       u32 adv_sym, u32 adv_asm, u32 lp_sym, u32 lp_asm);
 #ifdef CONFIG_XFRM_OFFLOAD
 void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter);
+void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter);
 #else
 static inline void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter) { };
+static inline void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter) { };
 #endif /* CONFIG_XFRM_OFFLOAD */
 #endif /* _IXGBE_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 7b01d92..b93ee7f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -292,6 +292,59 @@ static void ixgbe_ipsec_start_engine(struct ixgbe_adapter *adapter)
 }
 
 /**
+ * ixgbe_ipsec_restore - restore the ipsec HW settings after a reset
+ * @adapter: board private structure
+ **/
+void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_ipsec *ipsec = adapter->ipsec;
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 zbuf[4] = {0, 0, 0, 0};
+	int i;
+
+	if (!(adapter->flags2 & IXGBE_FLAG2_IPSEC_ENABLED))
+		return;
+
+	/* clean up the engine settings */
+	ixgbe_ipsec_stop_engine(adapter);
+
+	/* start the engine */
+	ixgbe_ipsec_start_engine(adapter);
+
+	/* reload the IP addrs */
+	for (i = 0; i < IXGBE_IPSEC_MAX_RX_IP_COUNT; i++) {
+		struct rx_ip_sa *ipsa = &ipsec->ip_tbl[i];
+
+		if (ipsa->used)
+			ixgbe_ipsec_set_rx_ip(hw, i, ipsa->ipaddr);
+		else
+			ixgbe_ipsec_set_rx_ip(hw, i, zbuf);
+	}
+
+	/* reload the Rx keys */
+	for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT; i++) {
+		struct rx_sa *rsa = &ipsec->rx_tbl[i];
+
+		if (rsa->used)
+			ixgbe_ipsec_set_rx_sa(hw, i, rsa->xs->id.spi,
+					      rsa->key, rsa->salt,
+					      rsa->mode, rsa->iptbl_ind);
+		else
+			ixgbe_ipsec_set_rx_sa(hw, i, 0, zbuf, 0, 0, 0);
+	}
+
+	/* reload the Tx keys */
+	for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT; i++) {
+		struct tx_sa *tsa = &ipsec->tx_tbl[i];
+
+		if (tsa->used)
+			ixgbe_ipsec_set_tx_sa(hw, i, tsa->key, tsa->salt);
+		else
+			ixgbe_ipsec_set_tx_sa(hw, i, zbuf, 0);
+	}
+}
+
+/**
  * ixgbe_ipsec_find_empty_idx - find the first unused security parameter index
  * @ipsec: pointer to ipsec struct
  * @rxtable: true if we need to look in the Rx table
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 01fd89b..6eabf92 100644
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


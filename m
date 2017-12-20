From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 19 Dec 2017 16:00:02 -0800
Subject: [Intel-wired-lan] [PATCH v3 next-queue 10/10] ixgbe: register ipsec
 offload with the xfrm subsystem
In-Reply-To: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1513728002-7643-11-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With all the support code in place we can now link in the ipsec
offload operations and set the ESP feature flag for the XFRM
subsystem to see.

v3: added ifdef CONFIG_XFRM_OFFLOAD in ixgbe_features_check

v2: added the xdo_dev_state_free callback to make XFRM happy
    changed use of NETIF_F_HW_CSUM_BIT to NETIF_F_HW_CSUM

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 17 +++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 4b16466..424dbf7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -715,10 +715,23 @@ static bool ixgbe_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	return true;
 }
 
+/**
+ * ixgbe_ipsec_free - called by xfrm garbage collections
+ * @xs: pointer to transformer state struct
+ *
+ * We don't have any garbage to collect, so we shouldn't bother
+ * implementing this function, but the XFRM code doesn't check for
+ * existence before calling the API callback.
+ **/
+static void ixgbe_ipsec_free(struct xfrm_state *xs)
+{
+}
+
 static const struct xfrmdev_ops ixgbe_xfrmdev_ops = {
 	.xdo_dev_state_add = ixgbe_ipsec_add_sa,
 	.xdo_dev_state_delete = ixgbe_ipsec_del_sa,
 	.xdo_dev_offload_ok = ixgbe_ipsec_offload_ok,
+	.xdo_dev_state_free = ixgbe_ipsec_free,
 };
 
 /**
@@ -877,6 +890,10 @@ void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
 	ixgbe_ipsec_stop_engine(adapter);
 	ixgbe_ipsec_clear_hw_tables(adapter);
 
+	adapter->netdev->xfrmdev_ops = &ixgbe_xfrmdev_ops;
+	adapter->netdev->features |= NETIF_F_HW_ESP;
+	adapter->netdev->hw_enc_features |= NETIF_F_HW_ESP;
+
 	return;
 
 err2:
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8c88d32..2f56309 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9798,6 +9798,12 @@ ixgbe_features_check(struct sk_buff *skb, struct net_device *dev,
 	if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
 		features &= ~NETIF_F_TSO;
 
+#ifdef CONFIG_XFRM_OFFLOAD
+	/* IPsec offload doesn't get along well with others *yet* */
+	if (skb->sp)
+		features &= ~(NETIF_F_TSO | NETIF_F_HW_CSUM);
+#endif
+
 	return features;
 }
 
-- 
2.7.4


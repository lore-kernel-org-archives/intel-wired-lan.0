From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 13 Feb 2020 13:31:23 -0800
Subject: [Intel-wired-lan] [PATCH S39 v2 09/15] ice: Don't reject odd values
 of usecs set by user
In-Reply-To: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
References: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
Message-ID: <20200213213129.34023-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently if a user sets an odd [tx|rx]-usecs value through ethtool,
the request is denied because the hardware is set to have an ITR
granularity of 2us. This caused poor customer experience. Fix this by
aligning to a register allowed value, which results in rounding down.
Also, print a once per ring container type message to be clear about
our intentions.

Also, change the ITR_TO_REG define to be the bitwise and of the ITR
setting and the ICE_ITR_MASK. This makes the purpose of ITR_TO_REG more
obvious.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 49 +++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_txrx.h    |  2 +-
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 63a69ea02d22..22a9f59e7218 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3488,21 +3488,13 @@ ice_set_rc_coalesce(enum ice_container_type c_type, struct ethtool_coalesce *ec,
 		return -EINVAL;
 	}
 
-	/* hardware only supports an ITR granularity of 2us */
-	if (coalesce_usecs % 2 != 0) {
-		netdev_info(vsi->netdev, "Invalid value, %s-usecs must be even\n",
-			    c_type_str);
-		return -EINVAL;
-	}
-
 	if (use_adaptive_coalesce) {
 		rc->itr_setting |= ICE_ITR_DYNAMIC;
 	} else {
-		/* store user facing value how it was set */
+		/* save the user set usecs */
 		rc->itr_setting = coalesce_usecs;
-		/* set to static and convert to value HW understands */
-		rc->target_itr =
-			ITR_TO_REG(ITR_REG_ALIGN(rc->itr_setting));
+		/* device ITR granularity is in 2 usec increments */
+		rc->target_itr = ITR_REG_ALIGN(rc->itr_setting);
 	}
 
 	return 0;
@@ -3595,6 +3587,30 @@ ice_is_coalesce_param_invalid(struct net_device *netdev,
 	return 0;
 }
 
+/**
+ * ice_print_if_odd_usecs - print message if user tries to set odd [tx|rx]-usecs
+ * @netdev: netdev used for print
+ * @itr_setting: previous user setting
+ * @use_adaptive_coalesce: if adaptive coalesce is enabled or being enabled
+ * @coalesce_usecs: requested value of [tx|rx]-usecs
+ * @c_type_str: either "rx" or "tx" to match user set field of [tx|rx]-usecs
+ */
+static void
+ice_print_if_odd_usecs(struct net_device *netdev, u16 itr_setting,
+		       u32 use_adaptive_coalesce, u32 coalesce_usecs,
+		       const char *c_type_str)
+{
+	if (use_adaptive_coalesce)
+		return;
+
+	itr_setting = ITR_TO_REG(itr_setting);
+
+	if (itr_setting != coalesce_usecs && (coalesce_usecs % 2))
+		netdev_info(netdev, "User set %s-usecs to %d, device only supports even values. Rounding down and attempting to set %s-usecs to %d\n",
+			    c_type_str, coalesce_usecs, c_type_str,
+			    ITR_REG_ALIGN(coalesce_usecs));
+}
+
 /**
  * __ice_set_coalesce - set ITR/INTRL values for the device
  * @netdev: pointer to the netdev associated with this query
@@ -3615,8 +3631,19 @@ __ice_set_coalesce(struct net_device *netdev, struct ethtool_coalesce *ec,
 		return -EINVAL;
 
 	if (q_num < 0) {
+		struct ice_q_vector *q_vector = vsi->q_vectors[0];
 		int v_idx;
 
+		if (q_vector) {
+			ice_print_if_odd_usecs(netdev, q_vector->rx.itr_setting,
+					       ec->use_adaptive_rx_coalesce,
+					       ec->rx_coalesce_usecs, "rx");
+
+			ice_print_if_odd_usecs(netdev, q_vector->tx.itr_setting,
+					       ec->use_adaptive_tx_coalesce,
+					       ec->tx_coalesce_usecs, "tx");
+		}
+
 		ice_for_each_q_vector(vsi, v_idx) {
 			/* In some cases if DCB is configured the num_[rx|tx]q
 			 * can be less than vsi->num_q_vectors. This check
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 14a1bf445889..7ee00a128663 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -222,7 +222,7 @@ enum ice_rx_dtype {
 #define ICE_ITR_GRAN_S		1	/* ITR granularity is always 2us */
 #define ICE_ITR_GRAN_US		BIT(ICE_ITR_GRAN_S)
 #define ICE_ITR_MASK		0x1FFE	/* ITR register value alignment mask */
-#define ITR_REG_ALIGN(setting)	__ALIGN_MASK(setting, ~ICE_ITR_MASK)
+#define ITR_REG_ALIGN(setting)	((setting) & ICE_ITR_MASK)
 
 #define ICE_ITR_ADAPTIVE_MIN_INC	0x0002
 #define ICE_ITR_ADAPTIVE_MIN_USECS	0x0002
-- 
2.20.1


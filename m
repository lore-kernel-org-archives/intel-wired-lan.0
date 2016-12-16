From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Thu, 15 Dec 2016 21:18:31 -0500
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbevf: Add support for VF
	promiscuous mode
Message-ID: <1481854712-29454-1-git-send-email-donald.c.skidmore@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch extends the mailbox message to allow for VF promiscous
mode support.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  1 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 15 +++++++++++++-
 drivers/net/ethernet/intel/ixgbevf/mbx.h          |  1 +
 drivers/net/ethernet/intel/ixgbevf/vf.c           | 24 +++++++++++++++++++----
 4 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 5639fbe..3fe6504 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -464,6 +464,7 @@ enum ixgbevf_xcast_modes {
 	IXGBEVF_XCAST_MODE_NONE = 0,
 	IXGBEVF_XCAST_MODE_MULTI,
 	IXGBEVF_XCAST_MODE_ALLMULTI,
+	IXGBEVF_XCAST_MODE_PROMISC,
 };
 
 extern const struct ixgbevf_info ixgbevf_82599_vf_info;
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 897f1b4..4027225 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1931,6 +1931,16 @@ static void ixgbevf_set_rx_mode(struct net_device *netdev)
 		     (flags & (IFF_BROADCAST | IFF_MULTICAST)) ?
 		     IXGBEVF_XCAST_MODE_MULTI : IXGBEVF_XCAST_MODE_NONE;
 
+	/* request the most inclusive mode we need */
+	if (flags & IFF_PROMISC)
+		xcast_mode = IXGBEVF_XCAST_MODE_PROMISC;
+	else if (flags & IFF_ALLMULTI)
+		xcast_mode = IXGBEVF_XCAST_MODE_ALLMULTI;
+	else if (flags & (IFF_BROADCAST | IFF_MULTICAST))
+		xcast_mode = IXGBEVF_XCAST_MODE_MULTI;
+	else
+		xcast_mode = IXGBEVF_XCAST_MODE_NONE;
+
 	spin_lock_bh(&adapter->mbx_lock);
 
 	hw->mac.ops.update_xcast_mode(hw, xcast_mode);
@@ -2072,7 +2082,8 @@ static void ixgbevf_init_last_counter_stats(struct ixgbevf_adapter *adapter)
 static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
-	int api[] = { ixgbe_mbox_api_12,
+	int api[] = { ixgbe_mbox_api_13,
+		      ixgbe_mbox_api_12,
 		      ixgbe_mbox_api_11,
 		      ixgbe_mbox_api_10,
 		      ixgbe_mbox_api_unknown };
@@ -2374,6 +2385,7 @@ static void ixgbevf_set_num_queues(struct ixgbevf_adapter *adapter)
 		switch (hw->api_version) {
 		case ixgbe_mbox_api_11:
 		case ixgbe_mbox_api_12:
+		case ixgbe_mbox_api_13:
 			adapter->num_rx_queues = rss;
 			adapter->num_tx_queues = rss;
 		default:
@@ -4125,6 +4137,7 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	switch (adapter->hw.api_version) {
 	case ixgbe_mbox_api_11:
 	case ixgbe_mbox_api_12:
+	case ixgbe_mbox_api_13:
 		netdev->max_mtu = IXGBE_MAX_JUMBO_FRAME_SIZE -
 				  (ETH_HLEN + ETH_FCS_LEN);
 		break;
diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.h b/drivers/net/ethernet/intel/ixgbevf/mbx.h
index 340cdd4..bc0442a 100644
--- a/drivers/net/ethernet/intel/ixgbevf/mbx.h
+++ b/drivers/net/ethernet/intel/ixgbevf/mbx.h
@@ -84,6 +84,7 @@ enum ixgbe_pfvf_api_rev {
 	ixgbe_mbox_api_20,	/* API version 2.0, solaris Phase1 VF driver */
 	ixgbe_mbox_api_11,	/* API version 1.1, linux/freebsd VF driver */
 	ixgbe_mbox_api_12,	/* API version 1.2, linux/freebsd VF driver */
+	ixgbe_mbox_api_13,	/* API version 1.3, linux/freebsd VF driver */
 	/* This value should always be last */
 	ixgbe_mbox_api_unknown,	/* indicates that API version is not known */
 };
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index d46ba1d..8a5db9d 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -330,9 +330,14 @@ int ixgbevf_get_reta_locked(struct ixgbe_hw *hw, u32 *reta, int num_rx_queues)
 	 * Thus return an error if API doesn't support RETA querying or querying
 	 * is not supported for this device type.
 	 */
-	if (hw->api_version != ixgbe_mbox_api_12 ||
-	    hw->mac.type >= ixgbe_mac_X550_vf)
+	switch (hw->api_version) {
+	case ixgbe_mbox_api_13:
+	case ixgbe_mbox_api_12:
+		if (hw->mac.type >= ixgbe_mac_X550_vf)
+			break;
+	default:
 		return -EOPNOTSUPP;
+	}
 
 	msgbuf[0] = IXGBE_VF_GET_RETA;
 
@@ -391,9 +396,14 @@ int ixgbevf_get_rss_key_locked(struct ixgbe_hw *hw, u8 *rss_key)
 	 * Thus return an error if API doesn't support RSS Random Key retrieval
 	 * or if the operation is not supported for this device type.
 	 */
-	if (hw->api_version != ixgbe_mbox_api_12 ||
-	    hw->mac.type >= ixgbe_mac_X550_vf)
+	switch (hw->api_version) {
+	case ixgbe_mbox_api_13:
+	case ixgbe_mbox_api_12:
+		if (hw->mac.type >= ixgbe_mac_X550_vf)
+			break;
+	default:
 		return -EOPNOTSUPP;
+	}
 
 	msgbuf[0] = IXGBE_VF_GET_RSS_KEY;
 	err = hw->mbx.ops.write_posted(hw, msgbuf, 1);
@@ -545,6 +555,11 @@ static s32 ixgbevf_update_xcast_mode(struct ixgbe_hw *hw, int xcast_mode)
 
 	switch (hw->api_version) {
 	case ixgbe_mbox_api_12:
+		/* promisc introduced in 1.3 version */
+		if (xcast_mode == IXGBEVF_XCAST_MODE_PROMISC)
+			return -EOPNOTSUPP;
+		/* Fall threw */
+	case ixgbe_mbox_api_13:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -884,6 +899,7 @@ int ixgbevf_get_queues(struct ixgbe_hw *hw, unsigned int *num_tcs,
 	switch (hw->api_version) {
 	case ixgbe_mbox_api_11:
 	case ixgbe_mbox_api_12:
+	case ixgbe_mbox_api_13:
 		break;
 	default:
 		return 0;
-- 
2.4.3


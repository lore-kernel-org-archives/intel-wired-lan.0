From: Radoslaw Tyl <radoslawx.tyl@intel.com>
Date: Tue, 29 Jun 2021 12:49:41 +0200
Subject: [Intel-wired-lan] [PATCH 5/5] ixgbevf: Add support for new mailbox
 communication between PF and VF
In-Reply-To: <20210629104941.2460721-1-radoslawx.tyl@intel.com>
References: <20210629104941.2460721-1-radoslawx.tyl@intel.com>
Message-ID: <20210629104941.2460721-6-radoslawx.tyl@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Provide improved mailbox communication, between PF and VF,
which is defined as API version 1.5.

Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ipsec.c        |  1 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  9 +++++++++
 drivers/net/ethernet/intel/ixgbevf/mbx.h          |  1 +
 drivers/net/ethernet/intel/ixgbevf/vf.c           | 14 ++++++++++++--
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index 793da1fba81c..e68b55a239ec 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -617,6 +617,7 @@ void ixgbevf_init_ipsec_offload(struct ixgbevf_adapter *adapter)
 
 	switch (adapter->hw.api_version) {
 	case ixgbe_mbox_api_14:
+	case ixgbe_mbox_api_15:
 		break;
 	default:
 		return;
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index e9b99929588b..403b25ecf6bd 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2268,6 +2268,7 @@ static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	static const int api[] = {
+		ixgbe_mbox_api_15,
 		ixgbe_mbox_api_14,
 		ixgbe_mbox_api_13,
 		ixgbe_mbox_api_12,
@@ -2286,6 +2287,12 @@ static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 		idx++;
 	}
 
+	if (hw->api_version >= ixgbe_mbox_api_15) {
+		hw->mbx.ops.init_params(hw);
+		memcpy(&hw->mbx.ops, &ixgbevf_mbx_ops,
+		       sizeof(struct ixgbe_mbx_operations));
+	}
+
 	spin_unlock_bh(&adapter->mbx_lock);
 }
 
@@ -2629,6 +2636,7 @@ static void ixgbevf_set_num_queues(struct ixgbevf_adapter *adapter)
 		case ixgbe_mbox_api_12:
 		case ixgbe_mbox_api_13:
 		case ixgbe_mbox_api_14:
+		case ixgbe_mbox_api_15:
 			if (adapter->xdp_prog &&
 			    hw->mac.max_tx_queues == rss)
 				rss = rss > 3 ? 2 : 1;
@@ -4627,6 +4635,7 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	case ixgbe_mbox_api_12:
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
+	case ixgbe_mbox_api_15:
 		netdev->max_mtu = IXGBE_MAX_JUMBO_FRAME_SIZE -
 				  (ETH_HLEN + ETH_FCS_LEN);
 		break;
diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.h b/drivers/net/ethernet/intel/ixgbevf/mbx.h
index b3b83c95babf..7346ccf014a5 100644
--- a/drivers/net/ethernet/intel/ixgbevf/mbx.h
+++ b/drivers/net/ethernet/intel/ixgbevf/mbx.h
@@ -65,6 +65,7 @@ enum ixgbe_pfvf_api_rev {
 	ixgbe_mbox_api_12,	/* API version 1.2, linux/freebsd VF driver */
 	ixgbe_mbox_api_13,	/* API version 1.3, linux/freebsd VF driver */
 	ixgbe_mbox_api_14,	/* API version 1.4, linux/freebsd VF driver */
+	ixgbe_mbox_api_15,	/* API version 1.5, linux/freebsd VF driver */
 	/* This value should always be last */
 	ixgbe_mbox_api_unknown,	/* indicates that API version is not known */
 };
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index ac0e94d70a09..e9e1926f7585 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -74,6 +74,9 @@ static s32 ixgbevf_reset_hw_vf(struct ixgbe_hw *hw)
 
 	/* reset the api version */
 	hw->api_version = ixgbe_mbox_api_10;
+	hw->mbx.ops.init_params(hw);
+	memcpy(&hw->mbx.ops, &ixgbevf_mbx_ops_legacy,
+	       sizeof(struct ixgbe_mbx_operations));
 
 	IXGBE_WRITE_REG(hw, IXGBE_VFCTRL, IXGBE_CTRL_RST);
 	IXGBE_WRITE_FLUSH(hw);
@@ -310,6 +313,7 @@ int ixgbevf_get_reta_locked(struct ixgbe_hw *hw, u32 *reta, int num_rx_queues)
 	 * is not supported for this device type.
 	 */
 	switch (hw->api_version) {
+	case ixgbe_mbox_api_15:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_12:
@@ -378,6 +382,7 @@ int ixgbevf_get_rss_key_locked(struct ixgbe_hw *hw, u8 *rss_key)
 	 * or if the operation is not supported for this device type.
 	 */
 	switch (hw->api_version) {
+	case ixgbe_mbox_api_15:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_12:
@@ -544,8 +549,9 @@ static s32 ixgbevf_update_xcast_mode(struct ixgbe_hw *hw, int xcast_mode)
 		if (xcast_mode == IXGBEVF_XCAST_MODE_PROMISC)
 			return -EOPNOTSUPP;
 		fallthrough;
-	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
+	case ixgbe_mbox_api_14:
+	case ixgbe_mbox_api_15:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -704,8 +710,11 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
 	/* if the read failed it could just be a mailbox collision, best wait
 	 * until we are called again and don't report an error
 	 */
-	if (mbx->ops.read(hw, &in_msg, 1))
+	if (mbx->ops.read(hw, &in_msg, 1)) {
+		if (hw->api_version >= ixgbe_mbox_api_15)
+			mac->get_link_status = false;
 		goto out;
+	}
 
 	if (!(in_msg & IXGBE_VT_MSGTYPE_CTS)) {
 		/* msg is not CTS and is NACK we must have lost CTS status */
@@ -901,6 +910,7 @@ int ixgbevf_get_queues(struct ixgbe_hw *hw, unsigned int *num_tcs,
 	case ixgbe_mbox_api_12:
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
+	case ixgbe_mbox_api_15:
 		break;
 	default:
 		return 0;
-- 
2.27.0


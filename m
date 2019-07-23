From: Alice Michael <alice.michael@intel.com>
Date: Tue, 23 Jul 2019 06:03:35 -0400
Subject: [Intel-wired-lan] [next PATCH S8 02/12] i40e: Add drop mode
 parameter to set mac config
In-Reply-To: <20190723100345.57522-1-alice.michael@intel.com>
References: <20190723100345.57522-1-alice.michael@intel.com>
Message-ID: <20190723100345.57522-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sylwia Wnuczko <sylwia.wnuczko@intel.com>

This patch adds "drop mode" parameter to set mac config AQ command.
This bit controls the behavior when a no-drop packet is blocking a TC
queue.
0 ? The PF driver is notified.
1 ? The blocking packet is dropped and then the PF driver is notified.

Signed-off-by: Sylwia Wnuczko <sylwia.wnuczko@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c |  4 ++-
 .../net/ethernet/intel/i40e/i40e_adminq_cmd.h | 29 ++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  1 +
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 814acbe79ffd..72c04881d290 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -610,8 +610,10 @@ i40e_status i40e_init_adminq(struct i40e_hw *hw)
 
 	if (hw->aq.api_maj_ver > 1 ||
 	    (hw->aq.api_maj_ver == 1 &&
-	     hw->aq.api_min_ver >= 8))
+	     hw->aq.api_min_ver >= 8)) {
 		hw->flags |= I40E_HW_FLAG_FW_LLDP_PERSISTENT;
+		hw->flags |= I40E_HW_FLAG_DROP_MODE;
+	}
 
 	if (hw->aq.api_maj_ver > I40E_FW_API_VERSION_MAJOR) {
 		ret_code = I40E_ERR_FIRMWARE_API_VERSION;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 6536023fa074..4d966d80305f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -2051,20 +2051,21 @@ I40E_CHECK_CMD_LENGTH(i40e_aq_set_phy_config);
 struct i40e_aq_set_mac_config {
 	__le16	max_frame_size;
 	u8	params;
-#define I40E_AQ_SET_MAC_CONFIG_CRC_EN		0x04
-#define I40E_AQ_SET_MAC_CONFIG_PACING_MASK	0x78
-#define I40E_AQ_SET_MAC_CONFIG_PACING_SHIFT	3
-#define I40E_AQ_SET_MAC_CONFIG_PACING_NONE	0x0
-#define I40E_AQ_SET_MAC_CONFIG_PACING_1B_13TX	0xF
-#define I40E_AQ_SET_MAC_CONFIG_PACING_1DW_9TX	0x9
-#define I40E_AQ_SET_MAC_CONFIG_PACING_1DW_4TX	0x8
-#define I40E_AQ_SET_MAC_CONFIG_PACING_3DW_7TX	0x7
-#define I40E_AQ_SET_MAC_CONFIG_PACING_2DW_3TX	0x6
-#define I40E_AQ_SET_MAC_CONFIG_PACING_1DW_1TX	0x5
-#define I40E_AQ_SET_MAC_CONFIG_PACING_3DW_2TX	0x4
-#define I40E_AQ_SET_MAC_CONFIG_PACING_7DW_3TX	0x3
-#define I40E_AQ_SET_MAC_CONFIG_PACING_4DW_1TX	0x2
-#define I40E_AQ_SET_MAC_CONFIG_PACING_9DW_1TX	0x1
+#define I40E_AQ_SET_MAC_CONFIG_CRC_EN			0x04
+#define I40E_AQ_SET_MAC_CONFIG_PACING_MASK		0x78
+#define I40E_AQ_SET_MAC_CONFIG_PACING_SHIFT		3
+#define I40E_AQ_SET_MAC_CONFIG_PACING_NONE		0x0
+#define I40E_AQ_SET_MAC_CONFIG_PACING_1B_13TX		0xF
+#define I40E_AQ_SET_MAC_CONFIG_PACING_1DW_9TX		0x9
+#define I40E_AQ_SET_MAC_CONFIG_PACING_1DW_4TX		0x8
+#define I40E_AQ_SET_MAC_CONFIG_PACING_3DW_7TX		0x7
+#define I40E_AQ_SET_MAC_CONFIG_PACING_2DW_3TX		0x6
+#define I40E_AQ_SET_MAC_CONFIG_PACING_1DW_1TX		0x5
+#define I40E_AQ_SET_MAC_CONFIG_PACING_3DW_2TX		0x4
+#define I40E_AQ_SET_MAC_CONFIG_PACING_7DW_3TX		0x3
+#define I40E_AQ_SET_MAC_CONFIG_PACING_4DW_1TX		0x2
+#define I40E_AQ_SET_MAC_CONFIG_PACING_9DW_1TX		0x1
+#define I40E_AQ_SET_MAC_CONFIG_DROP_BLOCKING_PACKET_EN	0x80
 	u8	tx_timer_priority; /* bitmap */
 	__le16	tx_timer_value;
 	__le16	fc_refresh_threshold;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 2a6219d66771..06e2499de363 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -624,6 +624,7 @@ struct i40e_hw {
 #define I40E_HW_FLAG_NVM_READ_REQUIRES_LOCK BIT_ULL(3)
 #define I40E_HW_FLAG_FW_LLDP_STOPPABLE      BIT_ULL(4)
 #define I40E_HW_FLAG_FW_LLDP_PERSISTENT     BIT_ULL(5)
+#define I40E_HW_FLAG_DROP_MODE		    BIT_ULL(7)
 	u64 flags;
 
 	/* Used in set switch config AQ command */
-- 
2.21.0


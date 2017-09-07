From: Alice Michael <alice.michael@intel.com>
Date: Thu,  7 Sep 2017 08:05:55 -0400
Subject: [Intel-wired-lan] [next PATCH S80-V3 10/11] i40e: Retry AQC
	GetPhyAbilities to overcome I2CRead hangs
In-Reply-To: <20170907120556.45699-1-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
Message-ID: <20170907120556.45699-10-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jayaprakash Shanmugam <jayaprakash.shanmugam@intel.com>

- When the I2C is busy, the PHY reads are delayed.  The firmware will
  return EGAIN in these cases with an expectation that the SW will
  trigger the reads again
- This patch retries the operation for a maximum period of 500ms

Signed-off-by: Jayaprakash Shanmugam <jayaprakash.shanmugam@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 42 ++++++++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  3 ++
 drivers/net/ethernet/intel/i40evf/i40e_type.h |  3 ++
 3 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index cb4468c..e7d8a01 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1567,30 +1567,46 @@ i40e_status i40e_aq_get_phy_capabilities(struct i40e_hw *hw,
 	struct i40e_aq_desc desc;
 	i40e_status status;
 	u16 abilities_size = sizeof(struct i40e_aq_get_phy_abilities_resp);
+	u16 max_delay = I40E_MAX_PHY_TIMEOUT, total_delay = 0;
 
 	if (!abilities)
 		return I40E_ERR_PARAM;
 
-	i40e_fill_default_direct_cmd_desc(&desc,
-					  i40e_aqc_opc_get_phy_abilities);
+	do {
+		i40e_fill_default_direct_cmd_desc(&desc,
+					       i40e_aqc_opc_get_phy_abilities);
 
-	desc.flags |= cpu_to_le16((u16)I40E_AQ_FLAG_BUF);
-	if (abilities_size > I40E_AQ_LARGE_BUF)
-		desc.flags |= cpu_to_le16((u16)I40E_AQ_FLAG_LB);
+		desc.flags |= cpu_to_le16((u16)I40E_AQ_FLAG_BUF);
+		if (abilities_size > I40E_AQ_LARGE_BUF)
+			desc.flags |= cpu_to_le16((u16)I40E_AQ_FLAG_LB);
 
-	if (qualified_modules)
-		desc.params.external.param0 |=
+		if (qualified_modules)
+			desc.params.external.param0 |=
 			cpu_to_le32(I40E_AQ_PHY_REPORT_QUALIFIED_MODULES);
 
-	if (report_init)
-		desc.params.external.param0 |=
+		if (report_init)
+			desc.params.external.param0 |=
 			cpu_to_le32(I40E_AQ_PHY_REPORT_INITIAL_VALUES);
 
-	status = i40e_asq_send_command(hw, &desc, abilities, abilities_size,
-				       cmd_details);
+		status = i40e_asq_send_command(hw, &desc, abilities,
+					       abilities_size, cmd_details);
 
-	if (hw->aq.asq_last_status == I40E_AQ_RC_EIO)
-		status = I40E_ERR_UNKNOWN_PHY;
+		if (status)
+			break;
+
+		if (hw->aq.asq_last_status == I40E_AQ_RC_EIO) {
+			status = I40E_ERR_UNKNOWN_PHY;
+			break;
+		} else if (hw->aq.asq_last_status == I40E_AQ_RC_EAGAIN) {
+			usleep_range(1000, 2000);
+			total_delay++;
+			status = I40E_ERR_TIMEOUT;
+		}
+	} while ((hw->aq.asq_last_status != I40E_AQ_RC_OK) &&
+		 (total_delay < max_delay));
+
+	if (status)
+		return status;
 
 	if (report_init) {
 		if (hw->mac.type ==  I40E_MAC_XL710 &&
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 4b32b1d..0410fcb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -46,6 +46,9 @@
 /* Max default timeout in ms, */
 #define I40E_MAX_NVM_TIMEOUT		18000
 
+/* Max timeout in ms for the phy to respond */
+#define I40E_MAX_PHY_TIMEOUT		500
+
 /* Switch from ms to the 1usec global time (this is the GTIME resolution) */
 #define I40E_MS_TO_GTIME(time)		((time) * 1000)
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index 9364b67..213b773 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -46,6 +46,9 @@
 /* Max default timeout in ms, */
 #define I40E_MAX_NVM_TIMEOUT		18000
 
+/* Max timeout in ms for the phy to respond */
+#define I40E_MAX_PHY_TIMEOUT		500
+
 /* Switch from ms to the 1usec global time (this is the GTIME resolution) */
 #define I40E_MS_TO_GTIME(time)		((time) * 1000)
 
-- 
2.9.4


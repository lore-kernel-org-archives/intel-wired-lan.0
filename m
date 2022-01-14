From: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
Date: Fri, 14 Jan 2022 13:19:30 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 3/4] i40e: Add new version of
 i40e_aq_add_macvlan function
In-Reply-To: <20220114131931.346687-1-jedrzej.jagielski@intel.com>
References: <20220114131931.346687-1-jedrzej.jagielski@intel.com>
Message-ID: <20220114131931.346687-4-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

ASQ send command functions are returning only i40e status codes
yet some calling functions also need Admin Queue status
that is stored in hw->aq.asq_last_status. Since hw object
is stored on a heap it introduces a possibility for
a race condition in access to hw if calling function is not
fast enough to read hw->aq.asq_last_status before next
send ASQ command is executed.

Add new _v2 version of i40e_aq_add_macvlan that is using
new _v2 versions of ASQ send command functions and returns
the Admin Queue status on the stack.

Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 92 +++++++++++++++----
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  5 +
 2 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index d3e2b3005f86..6aefffd83615 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2634,33 +2634,28 @@ i40e_status i40e_aq_get_veb_parameters(struct i40e_hw *hw,
 }
 
 /**
- * i40e_aq_add_macvlan
- * @hw: pointer to the hw struct
- * @seid: VSI for the mac address
+ * i40e_prepare_add_macvlan
  * @mv_list: list of macvlans to be added
+ * @desc: pointer to AQ descriptor structure
  * @count: length of the list
- * @cmd_details: pointer to command details structure or NULL
+ * @seid: VSI for the mac address
  *
- * Add MAC/VLAN addresses to the HW filtering
+ * Internal helper function that prepares the add macvlan request
+ * and returns the buffer size.
  **/
-i40e_status i40e_aq_add_macvlan(struct i40e_hw *hw, u16 seid,
-			struct i40e_aqc_add_macvlan_element_data *mv_list,
-			u16 count, struct i40e_asq_cmd_details *cmd_details)
+static u16
+i40e_prepare_add_macvlan(struct i40e_aqc_add_macvlan_element_data *mv_list,
+			 struct i40e_aq_desc *desc, u16 count, u16 seid)
 {
-	struct i40e_aq_desc desc;
 	struct i40e_aqc_macvlan *cmd =
-		(struct i40e_aqc_macvlan *)&desc.params.raw;
-	i40e_status status;
+		(struct i40e_aqc_macvlan *)&desc->params.raw;
 	u16 buf_size;
 	int i;
 
-	if (count == 0 || !mv_list || !hw)
-		return I40E_ERR_PARAM;
-
 	buf_size = count * sizeof(*mv_list);
 
 	/* prep the rest of the request */
-	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_add_macvlan);
+	i40e_fill_default_direct_cmd_desc(desc, i40e_aqc_opc_add_macvlan);
 	cmd->num_addresses = cpu_to_le16(count);
 	cmd->seid[0] = cpu_to_le16(I40E_AQC_MACVLAN_CMD_SEID_VALID | seid);
 	cmd->seid[1] = 0;
@@ -2671,14 +2666,71 @@ i40e_status i40e_aq_add_macvlan(struct i40e_hw *hw, u16 seid,
 			mv_list[i].flags |=
 			       cpu_to_le16(I40E_AQC_MACVLAN_ADD_USE_SHARED_MAC);
 
-	desc.flags |= cpu_to_le16((u16)(I40E_AQ_FLAG_BUF | I40E_AQ_FLAG_RD));
+	desc->flags |= cpu_to_le16((u16)(I40E_AQ_FLAG_BUF | I40E_AQ_FLAG_RD));
 	if (buf_size > I40E_AQ_LARGE_BUF)
-		desc.flags |= cpu_to_le16((u16)I40E_AQ_FLAG_LB);
+		desc->flags |= cpu_to_le16((u16)I40E_AQ_FLAG_LB);
 
-	status = i40e_asq_send_command_atomic(hw, &desc, mv_list, buf_size,
-					      cmd_details, true);
+	return buf_size;
+}
 
-	return status;
+/**
+ * i40e_aq_add_macvlan
+ * @hw: pointer to the hw struct
+ * @seid: VSI for the mac address
+ * @mv_list: list of macvlans to be added
+ * @count: length of the list
+ * @cmd_details: pointer to command details structure or NULL
+ *
+ * Add MAC/VLAN addresses to the HW filtering
+ **/
+i40e_status
+i40e_aq_add_macvlan(struct i40e_hw *hw, u16 seid,
+		    struct i40e_aqc_add_macvlan_element_data *mv_list,
+		    u16 count, struct i40e_asq_cmd_details *cmd_details)
+{
+	struct i40e_aq_desc desc;
+	u16 buf_size;
+
+	if (count == 0 || !mv_list || !hw)
+		return I40E_ERR_PARAM;
+
+	buf_size = i40e_prepare_add_macvlan(mv_list, &desc, count, seid);
+
+	return i40e_asq_send_command_atomic(hw, &desc, mv_list, buf_size,
+					    cmd_details, true);
+}
+
+/**
+ * i40e_aq_add_macvlan_v2
+ * @hw: pointer to the hw struct
+ * @seid: VSI for the mac address
+ * @mv_list: list of macvlans to be added
+ * @count: length of the list
+ * @cmd_details: pointer to command details structure or NULL
+ * @aq_status: pointer to Admin Queue status return value
+ *
+ * Add MAC/VLAN addresses to the HW filtering.
+ * The _v2 version returns the last Admin Queue status in aq_status
+ * to avoid race conditions in access to hw->aq.asq_last_status.
+ * It also calls _v2 versions of asq_send_command functions to
+ * get the aq_status on the stack.
+ **/
+i40e_status
+i40e_aq_add_macvlan_v2(struct i40e_hw *hw, u16 seid,
+		       struct i40e_aqc_add_macvlan_element_data *mv_list,
+		       u16 count, struct i40e_asq_cmd_details *cmd_details,
+		       enum i40e_admin_queue_err *aq_status)
+{
+	struct i40e_aq_desc desc;
+	u16 buf_size;
+
+	if (count == 0 || !mv_list || !hw)
+		return I40E_ERR_PARAM;
+
+	buf_size = i40e_prepare_add_macvlan(mv_list, &desc, count, seid);
+
+	return i40e_asq_send_command_atomic_v2(hw, &desc, mv_list, buf_size,
+					       cmd_details, true, aq_status);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 4ace56a911d9..ebdcde6f1aeb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -165,6 +165,11 @@ i40e_status i40e_aq_get_veb_parameters(struct i40e_hw *hw,
 i40e_status i40e_aq_add_macvlan(struct i40e_hw *hw, u16 vsi_id,
 			struct i40e_aqc_add_macvlan_element_data *mv_list,
 			u16 count, struct i40e_asq_cmd_details *cmd_details);
+i40e_status
+i40e_aq_add_macvlan_v2(struct i40e_hw *hw, u16 seid,
+		       struct i40e_aqc_add_macvlan_element_data *mv_list,
+		       u16 count, struct i40e_asq_cmd_details *cmd_details,
+		       enum i40e_admin_queue_err *aq_status);
 i40e_status i40e_aq_remove_macvlan(struct i40e_hw *hw, u16 vsi_id,
 			struct i40e_aqc_remove_macvlan_element_data *mv_list,
 			u16 count, struct i40e_asq_cmd_details *cmd_details);
-- 
2.18.2


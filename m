From: Alice Michael <alice.michael@intel.com>
Date: Mon,  7 Aug 2017 10:28:39 -0400
Subject: [Intel-wired-lan] [next PATCH S78-V6 12/12] i40e: Stop dropping
	802.1ad tags (eth proto 0x88a8
In-Reply-To: <20170807142839.60975-1-alice.michael@intel.com>
References: <20170807142839.60975-1-alice.michael@intel.com>
Message-ID: <20170807142839.60975-13-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Scott Peterson <scott.d.peterson@intel.com>

Enable i40e to pass traffic with VLAN tags using the 802.1ad ethernet
protocol ID (0x88a8).

This requires NIC firmware providing version 1.7 of the API. With
older NIC firmware 802.1ad tagged packets will continue to be dropped.

No VLAN offloads nor RSS are supported for 802.1ad VLANs.

Signed-off-by: Scott Peterson <scott.d.peterson@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c       |  6 ++++++
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 17 ++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_common.c       |  6 +++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c         |  7 +++++++
 drivers/net/ethernet/intel/i40e/i40e_type.h         |  6 ++++++
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 17 ++++++++++++++++-
 drivers/net/ethernet/intel/i40evf/i40e_type.h       |  6 ++++++
 7 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 340e5a2..8553f2b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -613,6 +613,12 @@ i40e_status i40e_init_adminq(struct i40e_hw *hw)
 		hw->flags |= I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE;
 	}
 
+	/* The ability to RX (not drop) 802.1ad frames was added in API 1.7 */
+	if ((hw->aq.api_maj_ver > 1) ||
+	    ((hw->aq.api_maj_ver == 1) &&
+	     (hw->aq.api_min_ver >= 7)))
+		hw->flags |= I40E_HW_FLAG_802_1AD_CAPABLE;
+
 	if (hw->aq.api_maj_ver > I40E_FW_API_VERSION_MAJOR) {
 		ret_code = I40E_ERR_FIRMWARE_API_VERSION;
 		goto init_adminq_free_arq;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index ef0a897..0129e9b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -775,7 +775,22 @@ struct i40e_aqc_set_switch_config {
 #define I40E_AQ_SET_SWITCH_CFG_PROMISC		0x0001
 #define I40E_AQ_SET_SWITCH_CFG_L2_FILTER	0x0002
 	__le16	valid_flags;
-	u8	reserved[12];
+	/* The ethertype in switch_tag is dropped on ingress and used
+	 * internally by the switch. Set this to zero for the default
+	 * of 0x88a8 (802.1ad). Should be zero for firmware API
+	 * versions lower than 1.7.
+	 */
+	__le16	switch_tag;
+	/* The ethertypes in first_tag and second_tag are used to
+	 * match the outer and inner VLAN tags (respectively) when HW
+	 * double VLAN tagging is enabled via the set port parameters
+	 * AQ command. Otherwise these are both ignored. Set them to
+	 * zero for their defaults of 0x8100 (802.1Q). Should be zero
+	 * for firmware API versions lower than 1.7.
+	 */
+	__le16	first_tag;
+	__le16	second_tag;
+	u8	reserved[6];
 };
 
 I40E_CHECK_CMD_LENGTH(i40e_aqc_set_switch_config);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index fbbc3e8..249c660 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2406,7 +2406,11 @@ enum i40e_status_code i40e_aq_set_switch_config(struct i40e_hw *hw,
 					  i40e_aqc_opc_set_switch_config);
 	scfg->flags = cpu_to_le16(flags);
 	scfg->valid_flags = cpu_to_le16(valid_flags);
-
+	if (hw->flags & I40E_HW_FLAG_802_1AD_CAPABLE) {
+		scfg->switch_tag = cpu_to_le16(hw->switch_tag);
+		scfg->first_tag = cpu_to_le16(hw->first_tag);
+		scfg->second_tag = cpu_to_le16(hw->second_tag);
+	}
 	status = i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
 
 	return status;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 728acad..e95d91e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11359,6 +11359,13 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->bus.bus_id = pdev->bus->number;
 	pf->instance = pfs_found;
 
+	/* Select something other than the 802.1ad ethertype for the
+	 * switch to use internally and drop on ingress.
+	 */
+	hw->switch_tag = 0xffff;
+	hw->first_tag = ETH_P_8021AD;
+	hw->second_tag = ETH_P_8021Q;
+
 	INIT_LIST_HEAD(&pf->l3_flex_pit_list);
 	INIT_LIST_HEAD(&pf->l4_flex_pit_list);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 8b0b9f8..4b32b1d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -610,9 +610,15 @@ struct i40e_hw {
 	struct i40e_dcbx_config desired_dcbx_config; /* CEE Desired Cfg */
 
 #define I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE BIT_ULL(0)
+#define I40E_HW_FLAG_802_1AD_CAPABLE        BIT_ULL(1)
 #define I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE  BIT_ULL(2)
 	u64 flags;
 
+	/* Used in set switch config AQ command */
+	u16 switch_tag;
+	u16 first_tag;
+	u16 second_tag;
+
 	/* debug mask */
 	u32 debug_mask;
 	char err_str[16];
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index 5a271a4..4b02300 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -771,7 +771,22 @@ struct i40e_aqc_set_switch_config {
 #define I40E_AQ_SET_SWITCH_CFG_PROMISC		0x0001
 #define I40E_AQ_SET_SWITCH_CFG_L2_FILTER	0x0002
 	__le16	valid_flags;
-	u8	reserved[12];
+	/* The ethertype in switch_tag is dropped on ingress and used
+	 * internally by the switch. Set this to zero for the default
+	 * of 0x88a8 (802.1ad). Should be zero for firmware API
+	 * versions lower than 1.7.
+	 */
+	__le16	switch_tag;
+	/* The ethertypes in first_tag and second_tag are used to
+	 * match the outer and inner VLAN tags (respectively) when HW
+	 * double VLAN tagging is enabled via the set port parameters
+	 * AQ command. Otherwise these are both ignored. Set them to
+	 * zero for their defaults of 0x8100 (802.1Q). Should be zero
+	 * for firmware API versions lower than 1.7.
+	 */
+	__le16	first_tag;
+	__le16	second_tag;
+	u8	reserved[6];
 };
 
 I40E_CHECK_CMD_LENGTH(i40e_aqc_set_switch_config);
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index 48eacf5..9364b67 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -568,6 +568,7 @@ struct i40e_hw {
 	/* LLDP/DCBX Status */
 	u16 dcbx_status;
 
+#define I40E_HW_FLAG_802_1AD_CAPABLE        BIT_ULL(1)
 #define I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE  BIT_ULL(2)
 
 	/* DCBX info */
@@ -575,6 +576,11 @@ struct i40e_hw {
 	struct i40e_dcbx_config remote_dcbx_config; /* Peer Cfg */
 	struct i40e_dcbx_config desired_dcbx_config; /* CEE Desired Cfg */
 
+	/* Used in set switch config AQ command */
+	u16 switch_tag;
+	u16 first_tag;
+	u16 second_tag;
+
 	/* debug mask */
 	u32 debug_mask;
 	char err_str[16];
-- 
2.9.4


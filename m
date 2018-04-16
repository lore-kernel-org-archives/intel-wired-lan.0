From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Mon, 16 Apr 2018 10:07:03 -0700
Subject: [Intel-wired-lan] [PATCH] ice: Fix insufficient memory issue in
 ice_aq_manage_mac_read
Message-ID: <20180416170703.9153-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>

For the MAC read operation, the device can return upto two (LAN and WoL)
MAC addresses. Without access to adequate memory, the device will return
an error. Fixed this by allocating the right amount of memory. Also, logic
to detect and copy the LAN MAC address into the port_info structure has
been added. Note that the WoL MAC address is ignored currently as the WoL
feature isn't supported yet.

Fixes: dc49c7723676 ("ice: Get MAC/PHY/link info and scheduler topology")

Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 21977ec984c4..71d032cc5fa7 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -78,6 +78,7 @@ ice_aq_manage_mac_read(struct ice_hw *hw, void *buf, u16 buf_size,
 	struct ice_aq_desc desc;
 	enum ice_status status;
 	u16 flags;
+	u8 i;
 
 	cmd = &desc.params.mac_read;
 
@@ -98,8 +99,16 @@ ice_aq_manage_mac_read(struct ice_hw *hw, void *buf, u16 buf_size,
 		return ICE_ERR_CFG;
 	}
 
-	ether_addr_copy(hw->port_info->mac.lan_addr, resp->mac_addr);
-	ether_addr_copy(hw->port_info->mac.perm_addr, resp->mac_addr);
+	/* A single port can report up to two (LAN and WoL) addresses */
+	for (i = 0; i < cmd->num_addr; i++)
+		if (resp[i].addr_type == ICE_AQC_MAN_MAC_ADDR_TYPE_LAN) {
+			ether_addr_copy(hw->port_info->mac.lan_addr,
+					resp[i].mac_addr);
+			ether_addr_copy(hw->port_info->mac.perm_addr,
+					resp[i].mac_addr);
+			break;
+		}
+
 	return 0;
 }
 
@@ -464,9 +473,12 @@ enum ice_status ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_sched;
 
-	/* Get port MAC information */
-	mac_buf_len = sizeof(struct ice_aqc_manage_mac_read_resp);
-	mac_buf = devm_kzalloc(ice_hw_to_dev(hw), mac_buf_len, GFP_KERNEL);
+	/* Get MAC information */
+	/* A single port can report up to two (LAN and WoL) addresses */
+	mac_buf = devm_kcalloc(ice_hw_to_dev(hw), 2,
+			       sizeof(struct ice_aqc_manage_mac_read_resp),
+			       GFP_KERNEL);
+	mac_buf_len = 2 * sizeof(struct ice_aqc_manage_mac_read_resp);
 
 	if (!mac_buf) {
 		status = ICE_ERR_NO_MEMORY;
-- 
2.14.3


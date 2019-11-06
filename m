From: Alice Michael <alice.michael@intel.com>
Date: Wed,  6 Nov 2019 06:23:56 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: Set PHY Access flag on X722
Message-ID: <20191106142356.48768-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Adam Ludkiewicz <adam.ludkiewicz@intel.com>

The X722 FW API version 1.9 adds support for accessing PHY
registers with Admin Queue Command. This enables reading
EEPROM data from (Q)SFP+ transceivers, what was previously
possible only on X710 devices.

Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c     | 5 +++++
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 9f0a4e92a231..37514a75f928 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -536,6 +536,11 @@ static void i40e_set_hw_flags(struct i40e_hw *hw)
 		    (aq->api_maj_ver == 1 &&
 		     aq->api_min_ver >= I40E_MINOR_VER_FW_LLDP_STOPPABLE_X722))
 			hw->flags |= I40E_HW_FLAG_FW_LLDP_STOPPABLE;
+
+		if (aq->api_maj_ver > 1 ||
+		    (aq->api_maj_ver == 1 &&
+		     aq->api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_X722))
+			hw->flags |= I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE;
 		/* fall through */
 	default:
 		break;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index a23f89fb33ee..aa5f1c0aa721 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -20,6 +20,8 @@
 
 /* API version 1.7 implements additional link and PHY-specific APIs  */
 #define I40E_MINOR_VER_GET_LINK_INFO_XL710 0x0007
+/* API version 1.9 for X722 implements additional link and PHY-specific APIs */
+#define I40E_MINOR_VER_GET_LINK_INFO_X722 0x0009
 /* API version 1.6 for X722 devices adds ability to stop FW LLDP agent */
 #define I40E_MINOR_VER_FW_LLDP_STOPPABLE_X722 0x0006
 
-- 
2.21.0


From: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Date: Wed, 10 Jun 2015 01:15:55 +0300
Subject: [Intel-wired-lan] [PATCH 2/5] e1000e: i219 - fix to enable both ulp
	and EEE in Sx state
In-Reply-To: <f60bcfb3d2cf6db3c53fe84b1620dad209976300.1433877893.git.yanirx.lubetkin@intel.com>
References: <f60bcfb3d2cf6db3c53fe84b1620dad209976300.1433877893.git.yanirx.lubetkin@intel.com>
Message-ID: <78dc0c19f5ddc7fc59e6f54e1950ed1aa7d7ddcc.1433877893.git.yanirx.lubetkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In Jacksonville, there is a hardware bug that prevented ULP entry.
A side effect of the original software fix for this was that EEE in
Sx couldn't be enabled.
This patch implements a modified flow that allows both ULP and EEE in Sx.

Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 46 +++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index c742a4f..bdb745d 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1089,6 +1089,7 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	u32 mac_reg;
 	s32 ret_val = 0;
 	u16 phy_reg;
+	u16 oem_reg = 0;
 
 	if ((hw->mac.type < e1000_pch_lpt) ||
 	    (hw->adapter->pdev->device == E1000_DEV_ID_PCH_LPT_I217_LM) ||
@@ -1130,33 +1131,37 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	if (ret_val)
 		goto out;
 
+	/* Force SMBus mode in PHY */
+	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
+	if (ret_val)
+		goto release;
+	phy_reg |= CV_SMB_CTRL_FORCE_SMBUS;
+	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
+
+	/* Force SMBus mode in MAC */
+	mac_reg = er32(CTRL_EXT);
+	mac_reg |= E1000_CTRL_EXT_FORCE_SMBUS;
+	ew32(CTRL_EXT, mac_reg);
+
 	/* Si workaround for ULP entry flow on i127/rev6 h/w.  Enable
 	 * LPLU and disable Gig speed when entering ULP
 	 */
 	if ((hw->phy.type == e1000_phy_i217) && (hw->phy.revision == 6)) {
 		ret_val = e1000_read_phy_reg_hv_locked(hw, HV_OEM_BITS,
-						       &phy_reg);
+						       &oem_reg);
 		if (ret_val)
 			goto release;
+
+		phy_reg = oem_reg;
 		phy_reg |= HV_OEM_BITS_LPLU | HV_OEM_BITS_GBE_DIS;
+
 		ret_val = e1000_write_phy_reg_hv_locked(hw, HV_OEM_BITS,
 							phy_reg);
+
 		if (ret_val)
 			goto release;
 	}
 
-	/* Force SMBus mode in PHY */
-	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
-	if (ret_val)
-		goto release;
-	phy_reg |= CV_SMB_CTRL_FORCE_SMBUS;
-	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
-
-	/* Force SMBus mode in MAC */
-	mac_reg = er32(CTRL_EXT);
-	mac_reg |= E1000_CTRL_EXT_FORCE_SMBUS;
-	ew32(CTRL_EXT, mac_reg);
-
 	/* Set Inband ULP Exit, Reset to SMBus mode and
 	 * Disable SMBus Release on PERST# in PHY
 	 */
@@ -1168,10 +1173,15 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	if (to_sx) {
 		if (er32(WUFC) & E1000_WUFC_LNKC)
 			phy_reg |= I218_ULP_CONFIG1_WOL_HOST;
+		else
+			phy_reg &= ~I218_ULP_CONFIG1_WOL_HOST;
 
 		phy_reg |= I218_ULP_CONFIG1_STICKY_ULP;
+		phy_reg &= ~I218_ULP_CONFIG1_INBAND_EXIT;
 	} else {
 		phy_reg |= I218_ULP_CONFIG1_INBAND_EXIT;
+		phy_reg &= ~I218_ULP_CONFIG1_STICKY_ULP;
+		phy_reg &= ~I218_ULP_CONFIG1_WOL_HOST;
 	}
 	e1000_write_phy_reg_hv_locked(hw, I218_ULP_CONFIG1, phy_reg);
 
@@ -1183,6 +1193,16 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	/* Commit ULP changes in PHY by starting auto ULP configuration */
 	phy_reg |= I218_ULP_CONFIG1_START;
 	e1000_write_phy_reg_hv_locked(hw, I218_ULP_CONFIG1, phy_reg);
+
+	if ((hw->phy.type == e1000_phy_i217) && (hw->phy.revision == 6) &&
+	    to_sx && (er32(STATUS) & E1000_STATUS_LU)) {
+
+		ret_val = e1000_write_phy_reg_hv_locked(hw, HV_OEM_BITS,
+							oem_reg);
+		if (ret_val)
+			goto release;
+	}
+
 release:
 	hw->phy.ops.release(hw);
 out:
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


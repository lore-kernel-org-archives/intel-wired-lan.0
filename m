From: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Date: Wed, 10 Jun 2015 01:15:51 +0300
Subject: [Intel-wired-lan] [PATCH 1/5] e1000e: synchronization of MAC-PHY
	interface only on non- ME systems
Message-ID: <f60bcfb3d2cf6db3c53fe84b1620dad209976300.1433877893.git.yanirx.lubetkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On power up, the MAC - PHY interface needs to be set to PCIe, even if
cable is disconnected.  In ME systems, the ME handles this on exit from
Sx state. In non-ME, the driver handles it. Added a check for non-ME
system to the driver code that handles that.

Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index b074b9a..c742a4f 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -237,17 +237,19 @@ static bool e1000_phy_is_accessible_pchlan(struct e1000_hw *hw)
 	if (ret_val)
 		return false;
 out:
-	if ((hw->mac.type == e1000_pch_lpt) ||
-	    (hw->mac.type == e1000_pch_spt)) {
-		/* Unforce SMBus mode in PHY */
-		e1e_rphy_locked(hw, CV_SMB_CTRL, &phy_reg);
-		phy_reg &= ~CV_SMB_CTRL_FORCE_SMBUS;
-		e1e_wphy_locked(hw, CV_SMB_CTRL, phy_reg);
+	if ((hw->mac.type == e1000_pch_lpt) || (hw->mac.type == e1000_pch_spt)) {
+		/* Only unforce SMBus if ME is not active */
+		if (!(er32(FWSM) & E1000_ICH_FWSM_FW_VALID)) {
+			/* Unforce SMBus mode in PHY */
+			e1e_rphy_locked(hw, CV_SMB_CTRL, &phy_reg);
+			phy_reg &= ~CV_SMB_CTRL_FORCE_SMBUS;
+			e1e_wphy_locked(hw, CV_SMB_CTRL, phy_reg);
 
-		/* Unforce SMBus mode in MAC */
-		mac_reg = er32(CTRL_EXT);
-		mac_reg &= ~E1000_CTRL_EXT_FORCE_SMBUS;
-		ew32(CTRL_EXT, mac_reg);
+			/* Unforce SMBus mode in MAC */
+			mac_reg = er32(CTRL_EXT);
+			mac_reg &= ~E1000_CTRL_EXT_FORCE_SMBUS;
+			ew32(CTRL_EXT, mac_reg);
+		}
 	}
 
 	return true;
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


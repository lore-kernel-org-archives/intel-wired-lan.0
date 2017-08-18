From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Fri, 18 Aug 2017 15:48:02 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: add error checks when initializing
	the PHY
Message-ID: <20170818224802.6099.62913.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Ignoring errors when attempting to identify the PHY can lead to a crash.
Specifically in the case of FW controlled PHYs where the PHY read/write
operations are set to NULL.

Removed redundant comment.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 11c0378..1974f8f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -3292,6 +3292,9 @@ static s32 ixgbe_init_phy_ops_X550em(struct ixgbe_hw *hw)
 
 	/* Identify the PHY or SFP module */
 	ret_val = phy->ops.identify(hw);
+	if (ret_val == IXGBE_ERR_SFP_NOT_SUPPORTED ||
+	    ret_val == IXGBE_ERR_PHY_ADDR_INVALID)
+		return ret_val;
 
 	/* Setup function pointers based on detected hardware */
 	ixgbe_init_mac_link_ops_X550em(hw);
@@ -3494,9 +3497,10 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 	ixgbe_clear_tx_pending(hw);
 
 	/* PHY ops must be identified and initialized prior to reset */
-
-	/* Identify PHY and related function pointers */
 	status = hw->phy.ops.init(hw);
+	if (status == IXGBE_ERR_SFP_NOT_SUPPORTED ||
+	    status == IXGBE_ERR_PHY_ADDR_INVALID)
+		return status;
 
 	/* start the external PHY */
 	if (hw->phy.type == ixgbe_phy_x550em_ext_t) {


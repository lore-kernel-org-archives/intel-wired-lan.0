From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Fri, 05 Jun 2015 19:59:37 -0400
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Set lan_id before using
	I2C
Message-ID: <20150605235937.19454.93135.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We need to call the set_lan_id before accessing I2C and this wasn't
being done so this patch corrects that.  Likewise we do the same for
QSFP just to be consistent.

In the X550 case this is even more important as with out it the mux
is not controlled properly.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    6 +++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index ac6c0af..526a20b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -1352,6 +1352,9 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 		return IXGBE_ERR_SFP_NOT_PRESENT;
 	}
 
+	/* LAN ID is needed for sfp_type determination */
+	hw->mac.ops.set_lan_id(hw);
+
 	status = hw->phy.ops.read_i2c_eeprom(hw, IXGBE_SFF_IDENTIFIER,
 					     &identifier);
 
@@ -1365,9 +1368,6 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 
 	hw->phy.id = identifier;
 
-	/* LAN ID is needed for sfp_type determination */
-	hw->mac.ops.set_lan_id(hw);
-
 	status = hw->phy.ops.read_i2c_eeprom(hw, IXGBE_SFF_QSFP_10GBE_COMP,
 					     &comp_codes_10g);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 0736513..7b5b48e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1457,6 +1457,8 @@ static s32 ixgbe_init_phy_ops_X550em(struct ixgbe_hw *hw)
 	ixgbe_link_speed speed;
 	s32 ret_val;
 
+	hw->mac.ops.set_lan_id(hw);
+
 	if (hw->mac.ops.get_media_type(hw) == ixgbe_media_type_fiber) {
 		phy->phy_semaphore_mask = IXGBE_GSSR_SHARED_I2C_SM;
 		ixgbe_setup_mux_ctl(hw);


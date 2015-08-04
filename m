From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Tue, 04 Aug 2015 13:41:35 -0700
Subject: [Intel-wired-lan] [PATCH V4 05/13] ixgbe: Set lan_id before first
	I2C eeprom access
In-Reply-To: <20150804204010.51606.29686.stgit@mdrustad-wks.jf.intel.com>
References: <20150804204010.51606.29686.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150804204135.51606.32977.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The lan_id is being set after a previous I2C eeprom access which
makes no sense because it needs to be set before any access. Move
the setting to before the access.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 7ff7d7012f68..f342174a4840 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -1165,6 +1165,9 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 		return IXGBE_ERR_SFP_NOT_PRESENT;
 	}
 
+	/* LAN ID is needed for sfp_type determination */
+	hw->mac.ops.set_lan_id(hw);
+
 	status = hw->phy.ops.read_i2c_eeprom(hw,
 					     IXGBE_SFF_IDENTIFIER,
 					     &identifier);
@@ -1172,9 +1175,6 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 	if (status)
 		goto err_read_i2c_eeprom;
 
-	/* LAN ID is needed for sfp_type determination */
-	hw->mac.ops.set_lan_id(hw);
-
 	if (identifier != IXGBE_SFF_IDENTIFIER_SFP) {
 		hw->phy.type = ixgbe_phy_sfp_unsupported;
 		return IXGBE_ERR_SFP_NOT_SUPPORTED;


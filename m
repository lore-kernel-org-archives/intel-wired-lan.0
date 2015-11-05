From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Thu, 05 Nov 2015 11:02:14 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Always turn phy power on when
	requested
Message-ID: <20151105190214.4418.67222.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Instead of inhibiting phy power control when manageability is
present, only inhibit turning phy power off when manageability
is present. Consequently, phy power will always be turned on when
requested. Without this patch, some systems with X540 or X550
devices in some conditions will never get link.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    3 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |    3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index fb8673d63806..db0731e05401 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -2393,6 +2393,9 @@ s32 ixgbe_set_copper_phy_power(struct ixgbe_hw *hw, bool on)
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)
 		return 0;
 
+	if (!on && ixgbe_mng_present(hw))
+		return 0;
+
 	status = hw->phy.ops.read_reg(hw, IXGBE_MDIO_VENDOR_SPECIFIC_1_CONTROL,
 				      IXGBE_MDIO_VENDOR_SPECIFIC_1_DEV_TYPE,
 				      &reg);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index e44952eeab00..2358c1b7d586 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -57,8 +57,7 @@ s32 ixgbe_get_invariants_X540(struct ixgbe_hw *hw)
 	struct ixgbe_phy_info *phy = &hw->phy;
 
 	/* set_phy_power was set by default to NULL */
-	if (!ixgbe_mng_present(hw))
-		phy->ops.set_phy_power = ixgbe_set_copper_phy_power;
+	phy->ops.set_phy_power = ixgbe_set_copper_phy_power;
 
 	mac->mcft_size = IXGBE_X540_MC_TBL_SIZE;
 	mac->vft_size = IXGBE_X540_VFT_TBL_SIZE;


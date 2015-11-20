From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 20 Nov 2015 13:12:17 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Correct X550EM_x revision check
Message-ID: <20151120211217.98450.66003.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The X550EM_x revision check needs to check a value, not just a bit.
Use a mask and check the value. Also remove the redundant check
inside the ixgbe_enter_lplu_t_x550em, because it can only be called
when both the mac type and revision check pass.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    9 +++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 06add27c8b8c..5f53cc6c609a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3520,7 +3520,7 @@ struct ixgbe_info {
 
 #define IXGBE_FUSES0_GROUP(_i)		(0x11158 + ((_i) * 4))
 #define IXGBE_FUSES0_300MHZ		BIT(5)
-#define IXGBE_FUSES0_REV1		BIT(6)
+#define IXGBE_FUSES0_REV_MASK		(3 << 6)
 
 #define IXGBE_KRM_PORT_CAR_GEN_CTRL(P)	((P) ? 0x8010 : 0x4010)
 #define IXGBE_KRM_LINK_CTRL_1(P)	((P) ? 0x820C : 0x420C)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index f4ef0d1a5dbe..87aca3f7c3de 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1857,10 +1857,6 @@ static s32 ixgbe_enter_lplu_t_x550em(struct ixgbe_hw *hw)
 	u32 save_autoneg;
 	bool link_up;
 
-	/* SW LPLU not required on later HW revisions. */
-	if (IXGBE_FUSES0_REV1 & IXGBE_READ_REG(hw, IXGBE_FUSES0_GROUP(0)))
-		return 0;
-
 	/* If blocked by MNG FW, then don't restart AN */
 	if (ixgbe_check_reset_blocked(hw))
 		return 0;
@@ -2000,8 +1996,9 @@ static s32 ixgbe_init_phy_ops_X550em(struct ixgbe_hw *hw)
 					      ixgbe_setup_internal_phy_t_x550em;
 
 		/* setup SW LPLU only for first revision */
-		if (!(IXGBE_FUSES0_REV1 & IXGBE_READ_REG(hw,
-							IXGBE_FUSES0_GROUP(0))))
+		if (hw->mac.type == ixgbe_mac_X550EM_x &&
+		    !(IXGBE_READ_REG(hw, IXGBE_FUSES0_GROUP(0)) &
+		      IXGBE_FUSES0_REV_MASK))
 			phy->ops.enter_lplu = ixgbe_enter_lplu_t_x550em;
 
 		phy->ops.handle_lasi = ixgbe_handle_lasi_ext_t_x550em;


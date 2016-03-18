From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 18 Mar 2016 14:07:31 -0700
Subject: [Intel-wired-lan] [PATCH 5/6] ixgbe: Introduce function to control
	MDIO speed
In-Reply-To: <20160318210612.41255.22539.stgit@mdrustad-wks.jf.intel.com>
References: <20160318210612.41255.22539.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160318210731.41255.8900.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Move code that controls MDIO speed into a new function because
there will be more MACs that need the control.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   27 +++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 4e5f389be270..9365807e6e1d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2315,6 +2315,26 @@ static s32 ixgbe_init_ext_t_x550em(struct ixgbe_hw *hw)
 	return status;
 }
 
+/**
+ * ixgbe_set_mdio_speed - Set MDIO clock speed
+ * @hw: pointer to hardware structure
+ */
+static void ixgbe_set_mdio_speed(struct ixgbe_hw *hw)
+{
+	u32 hlreg0;
+
+	switch (hw->device_id) {
+	case IXGBE_DEV_ID_X550EM_X_10G_T:
+		/* Config MDIO clock speed before the first MDIO PHY access */
+		hlreg0 = IXGBE_READ_REG(hw, IXGBE_HLREG0);
+		hlreg0 &= ~IXGBE_HLREG0_MDCSPD;
+		IXGBE_WRITE_REG(hw, IXGBE_HLREG0, hlreg0);
+		break;
+	default:
+		break;
+	}
+}
+
 /**  ixgbe_reset_hw_X550em - Perform hardware reset
  **  @hw: pointer to hardware structure
  **
@@ -2328,7 +2348,6 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 	s32 status;
 	u32 ctrl = 0;
 	u32 i;
-	u32 hlreg0;
 	bool link_up = false;
 
 	/* Call adapter stop to disable Tx/Rx and clear interrupts */
@@ -2414,11 +2433,7 @@ mac_reset_top:
 	hw->mac.num_rar_entries = 128;
 	hw->mac.ops.init_rx_addrs(hw);
 
-	if (hw->device_id == IXGBE_DEV_ID_X550EM_X_10G_T) {
-		hlreg0 = IXGBE_READ_REG(hw, IXGBE_HLREG0);
-		hlreg0 &= ~IXGBE_HLREG0_MDCSPD;
-		IXGBE_WRITE_REG(hw, IXGBE_HLREG0, hlreg0);
-	}
+	ixgbe_set_mdio_speed(hw);
 
 	if (hw->device_id == IXGBE_DEV_ID_X550EM_X_SFP)
 		ixgbe_setup_mux_ctl(hw);


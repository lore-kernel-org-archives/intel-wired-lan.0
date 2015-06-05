From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Fri, 05 Jun 2015 00:51:09 -0400
Subject: [Intel-wired-lan] [net-next PATCH 2 06/13] ixgbe: Add reset for
	X550 device
In-Reply-To: <20150605045038.26373.94842.stgit@dcs-desk.jf.intel.com>
References: <20150605045038.26373.94842.stgit@dcs-desk.jf.intel.com>
Message-ID: <20150605045109.26373.74718.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds a PHY reset function ixgbe_reset_phy_t_X550em. Which
allows devices that have LASI support in enable their interrupt.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index ec9112e..7b9b124 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1385,6 +1385,22 @@ s32 ixgbe_setup_internal_phy_t_x550em(struct ixgbe_hw *hw)
 	return ixgbe_setup_ixfi_x550em(hw, &force_speed);
 }
 
+/** ixgbe_reset_phy_t_X550em - Performs X557 PHY reset and enables LASI
+ *  @hw: pointer to hardware structure
+ **/
+static s32 ixgbe_reset_phy_t_X550em(struct ixgbe_hw *hw)
+{
+	s32 status;
+
+	status = ixgbe_reset_phy_generic(hw);
+
+	if (status)
+		return status;
+
+	/* Configure Link Status Alarm and Temperature Threshold interrupts */
+	return ixgbe_enable_lasi_ext_t_x550em(hw);
+}
+
 /** ixgbe_init_phy_ops_X550em - PHY/SFP specific init
  *  @hw: pointer to hardware structure
  *
@@ -1454,6 +1470,7 @@ static s32 ixgbe_init_phy_ops_X550em(struct ixgbe_hw *hw)
 		}
 
 		phy->ops.handle_lasi = ixgbe_handle_lasi_ext_t_x550em;
+		phy->ops.reset = ixgbe_reset_phy_t_X550em;
 		break;
 	default:
 		break;


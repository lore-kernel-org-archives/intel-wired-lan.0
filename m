From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 17 May 2017 15:17:46 -0700
Subject: [Intel-wired-lan] [PATCH 2/5] ixgbe: add write flush when
	configuring CS4223/7
In-Reply-To: <20170517221424.15538.5968.stgit@localhost6.localdomain6>
References: <20170517221424.15538.5968.stgit@localhost6.localdomain6>
Message-ID: <20170517221746.15538.89916.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Make sure the writes are processed immediately. Without the flush it
is possible for operations on one port to spill over the other as the
resource is shared.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 870f9e1..cb5d363 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1824,12 +1824,28 @@ static s32 ixgbe_setup_sfi_x550a(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 
 	/* Configure CS4227/CS4223 LINE side to proper mode. */
 	reg_slice = IXGBE_CS4227_LINE_SPARE24_LSB + slice_offset;
+
+	ret_val = hw->phy.ops.read_reg(hw, reg_slice,
+				       IXGBE_MDIO_ZERO_DEV_TYPE, &reg_phy_ext);
+	if (ret_val)
+		return ret_val;
+
+	reg_phy_ext &= ~((IXGBE_CS4227_EDC_MODE_CX1 << 1) |
+			 (IXGBE_CS4227_EDC_MODE_SR << 1));
+
 	if (setup_linear)
 		reg_phy_ext = (IXGBE_CS4227_EDC_MODE_CX1 << 1) | 1;
 	else
 		reg_phy_ext = (IXGBE_CS4227_EDC_MODE_SR << 1) | 1;
-	return hw->phy.ops.write_reg(hw, reg_slice, IXGBE_MDIO_ZERO_DEV_TYPE,
-				     reg_phy_ext);
+
+	ret_val = hw->phy.ops.write_reg(hw, reg_slice,
+					IXGBE_MDIO_ZERO_DEV_TYPE, reg_phy_ext);
+	if (ret_val)
+		return ret_val;
+
+	/* Flush previous write with a read */
+	return hw->phy.ops.read_reg(hw, reg_slice,
+				    IXGBE_MDIO_ZERO_DEV_TYPE, &reg_phy_ext);
 }
 
 /**


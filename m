From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 17 May 2017 15:17:41 -0700
Subject: [Intel-wired-lan] [PATCH 1/5] ixgbe: correct CS4223/7 PHY
	identification
In-Reply-To: <20170517221424.15538.5968.stgit@localhost6.localdomain6>
References: <20170517221424.15538.5968.stgit@localhost6.localdomain6>
Message-ID: <20170517221741.15538.227.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Previous method was unreliable. Use a different register to
diferentiate between the SKUs.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |    5 +++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    8 ++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index 5aa2c3c..b0cac96 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -84,8 +84,9 @@
 #define IXGBE_CS4227_GLOBAL_ID_LSB		0
 #define IXGBE_CS4227_GLOBAL_ID_MSB		1
 #define IXGBE_CS4227_SCRATCH			2
-#define IXGBE_CS4223_PHY_ID			0x7003	/* Quad port */
-#define IXGBE_CS4227_PHY_ID			0x3003	/* Dual port */
+#define IXGBE_CS4227_EFUSE_PDF_SKU		0x19F
+#define IXGBE_CS4223_SKU_ID			0x0010  /* Quad port */
+#define IXGBE_CS4227_SKU_ID			0x0014  /* Dual port */
 #define IXGBE_CS4227_RESET_PENDING		0x1357
 #define IXGBE_CS4227_RESET_COMPLETE		0x5AA5
 #define IXGBE_CS4227_RETRIES			15
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index b8d9097..870f9e1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1807,16 +1807,16 @@ static s32 ixgbe_setup_sfi_x550a(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 	if (hw->phy.mdio.prtad == MDIO_PRTAD_NONE)
 		return IXGBE_ERR_PHY_ADDR_INVALID;
 
-	/* Get external PHY device id */
-	ret_val = hw->phy.ops.read_reg(hw, IXGBE_CS4227_GLOBAL_ID_MSB,
-				  IXGBE_MDIO_ZERO_DEV_TYPE, &reg_phy_ext);
+	/* Get external PHY SKU id */
+	ret_val = hw->phy.ops.read_reg(hw, IXGBE_CS4227_EFUSE_PDF_SKU,
+				       IXGBE_MDIO_ZERO_DEV_TYPE, &reg_phy_ext);
 	if (ret_val)
 		return ret_val;
 
 	/* When configuring quad port CS4223, the MAC instance is part
 	 * of the slice offset.
 	 */
-	if (reg_phy_ext == IXGBE_CS4223_PHY_ID)
+	if (reg_phy_ext == IXGBE_CS4223_SKU_ID)
 		slice_offset = (hw->bus.lan_id +
 				(hw->bus.instance_id << 1)) << 12;
 	else


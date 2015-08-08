From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Sat, 08 Aug 2015 16:17:57 -0700
Subject: [Intel-wired-lan] [PATCH V5 03/19] ixgbe: Provide I2C combined on
	X550EM
In-Reply-To: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150808231756.94784.9100.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Provide I2C combined operations on X550EM, not X550 devices.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 80db6e51a73d..acf78c5d8cc4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2039,14 +2039,14 @@ static struct ixgbe_phy_operations phy_ops_X550 = {
 	X550_COMMON_PHY
 	.init			= NULL,
 	.identify		= &ixgbe_identify_phy_generic,
-	.read_i2c_combined	= &ixgbe_read_i2c_combined_generic,
-	.write_i2c_combined	= &ixgbe_write_i2c_combined_generic,
 };
 
 static struct ixgbe_phy_operations phy_ops_X550EM_x = {
 	X550_COMMON_PHY
 	.init			= &ixgbe_init_phy_ops_X550em,
 	.identify		= &ixgbe_identify_phy_x550em,
+	.read_i2c_combined	= &ixgbe_read_i2c_combined_generic,
+	.write_i2c_combined	= &ixgbe_write_i2c_combined_generic,
 };
 
 static const u32 ixgbe_mvals_X550[IXGBE_MVALS_IDX_LIMIT] = {


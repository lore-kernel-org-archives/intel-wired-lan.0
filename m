From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 26 Aug 2016 14:48:28 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Resolve NULL reference by setting
 {read, write}_reg_mdi
Message-ID: <147224810802.93893.10477874136622778687.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Set the read_reg_mdi and write_reg_mdi method pointers for
X550EM_A_10G_T devices to resolve jumping to NULL.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index dec8b116e6a2..cd22efb940ad 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -3049,6 +3049,8 @@ static const struct ixgbe_phy_operations phy_ops_x550em_a = {
 	.identify		= &ixgbe_identify_phy_x550em,
 	.read_reg		= &ixgbe_read_phy_reg_x550a,
 	.write_reg		= &ixgbe_write_phy_reg_x550a,
+	.read_reg_mdi		= &ixgbe_read_phy_reg_mdi,
+	.write_reg_mdi		= &ixgbe_write_phy_reg_mdi,
 };
 
 static const u32 ixgbe_mvals_X550[IXGBE_MVALS_IDX_LIMIT] = {


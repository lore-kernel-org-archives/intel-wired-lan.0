From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Thu, 19 Apr 2018 17:06:57 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: return error on upsupported SFP
 module when resetting
Message-ID: <20180420000657.2316.31792.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add check for unsupported module and return the error code.
This fixes a Coverity hit due to unused return status from setup_sfp.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index beec1d0..a8148c7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -3408,6 +3408,9 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 		hw->phy.sfp_setup_needed = false;
 	}
 
+	if (status == IXGBE_ERR_SFP_NOT_SUPPORTED)
+		return status;
+
 	/* Reset PHY */
 	if (!hw->phy.reset_disable && hw->phy.ops.reset)
 		hw->phy.ops.reset(hw);


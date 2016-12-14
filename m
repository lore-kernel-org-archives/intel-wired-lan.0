From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Tue, 13 Dec 2016 20:34:51 -0500
Subject: [Intel-wired-lan] [PATCH] ixgbe: Configure advertised speeds
	correctly for KR/KX backplane
Message-ID: <1481679291-26608-1-git-send-email-donald.c.skidmore@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch ensures that the advertised link speeds are configured
for X553 KR/KX backplane.  Without this patch the link remains at
1G when resuming form low power after being downshifted by LPLU.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 80be82d..6e0590a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2149,12 +2149,11 @@ static s32 ixgbe_setup_kr_speed_x550em(struct ixgbe_hw *hw,
 /**
  * ixgbe_setup_kr_x550em - Configure the KR PHY
  * @hw: pointer to hardware structure
- *
- * Configures the integrated KR PHY for X550EM_x.
  **/
 static s32 ixgbe_setup_kr_x550em(struct ixgbe_hw *hw)
 {
-	if (hw->mac.type != ixgbe_mac_X550EM_x)
+	/* leave linke alone for 2.5G */
+	if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_2_5GB_FULL)
 		return 0;
 
 	return ixgbe_setup_kr_speed_x550em(hw, hw->phy.autoneg_advertised);
-- 
2.4.3


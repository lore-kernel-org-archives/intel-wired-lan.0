From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 14 Mar 2018 11:19:11 -0700
Subject: [Intel-wired-lan] [PATCH S88 1/8] i40e: Properly check allowed
 advertisement capabilities
Message-ID: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jan Sokolowski <jan.sokolowski@intel.com>

The i40e_set_link_ksettings and i40e_get_link_ksettings use different
codepaths to check available and supported advertisement modes. This
creates scenarios where it's possible to set a mode that's not allowed,
resulting in a link down.

Fix setting advertisement in i40e_set_link_ksettings by calling
i40e_get_link_ksettings to check what modes are allowed.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index f9493f11fbb2..9bb85daa2c6c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -871,23 +871,21 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 	/* save autoneg out of ksettings */
 	autoneg = copy_ks.base.autoneg;
 
-	memset(&safe_ks, 0, sizeof(safe_ks));
+	/* get our own copy of the bits to check against */
+	memset(&safe_ks, 0, sizeof(struct ethtool_link_ksettings));
+	safe_ks.base.cmd = copy_ks.base.cmd;
+	safe_ks.base.link_mode_masks_nwords =
+		copy_ks.base.link_mode_masks_nwords;
+	i40e_get_link_ksettings(netdev, &safe_ks);
+
 	/* Get link modes supported by hardware and check against modes
 	 * requested by the user.  Return an error if unsupported mode was set.
 	 */
-	i40e_phy_type_to_ethtool(pf, &safe_ks);
 	if (!bitmap_subset(copy_ks.link_modes.advertising,
 			   safe_ks.link_modes.supported,
 			   __ETHTOOL_LINK_MODE_MASK_NBITS))
 		return -EINVAL;
 
-	/* get our own copy of the bits to check against */
-	memset(&safe_ks, 0, sizeof(struct ethtool_link_ksettings));
-	safe_ks.base.cmd = copy_ks.base.cmd;
-	safe_ks.base.link_mode_masks_nwords =
-		copy_ks.base.link_mode_masks_nwords;
-	i40e_get_link_ksettings(netdev, &safe_ks);
-
 	/* set autoneg back to what it currently is */
 	copy_ks.base.autoneg = safe_ks.base.autoneg;
 
-- 
2.14.3


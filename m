From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Wed, 10 Mar 2021 11:12:54 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix autoneg disabling for
 non-10GBaseT links
Message-ID: <20210310111254.7610-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Disabling autonegotiation was allowed only for 10GBaseT PHY.
The condition was changed to check if link media type is BaseT.

Fixes: 3ce12ee9d8f9("i40e: Fix order of checks when enabling/disabling autoneg in ethtool")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Karen Sornek <karen.sornek@intel.com>
Signed-off-by: Dawid Lukwinski <dawid.lukwinski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 45f5dc2..9c1a0f7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1253,8 +1253,7 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 			if (ethtool_link_ksettings_test_link_mode(&safe_ks,
 								  supported,
 								  Autoneg) &&
-			    hw->phy.link_info.phy_type !=
-			    I40E_PHY_TYPE_10GBASE_T) {
+			    hw->phy.media_type != I40E_MEDIA_TYPE_BASET) {
 				netdev_info(netdev, "Autoneg cannot be disabled on this phy\n");
 				err = -EINVAL;
 				goto done;
-- 
2.17.1


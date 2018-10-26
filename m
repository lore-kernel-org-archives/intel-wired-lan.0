From: Alice Michael <alice.michael@intel.com>
Date: Fri, 26 Oct 2018 14:33:28 -0700
Subject: [Intel-wired-lan] [next PATCH S98 1/6] i40e: don't restart nway if
 autoneg not supported
Message-ID: <20181026213333.51495-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

On link types that do not support autoneg, we cannot attempt to restart
nway negotiation. This results in a dead link that requires a power
cycle to remedy.

Fix this by saving off the autoneg state and checking this value before
we try to restart nway.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 9f8464f..71db006 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1335,6 +1335,7 @@ static int i40e_set_pauseparam(struct net_device *netdev,
 	i40e_status status;
 	u8 aq_failures;
 	int err = 0;
+	u32 is_an;
 
 	/* Changing the port's flow control is not supported if this isn't the
 	 * port's controlling PF
@@ -1347,15 +1348,14 @@ static int i40e_set_pauseparam(struct net_device *netdev,
 	if (vsi != pf->vsi[pf->lan_vsi])
 		return -EOPNOTSUPP;
 
-	if (pause->autoneg != ((hw_link_info->an_info & I40E_AQ_AN_COMPLETED) ?
-	    AUTONEG_ENABLE : AUTONEG_DISABLE)) {
+	is_an = hw_link_info->an_info & I40E_AQ_AN_COMPLETED;
+	if (pause->autoneg != is_an) {
 		netdev_info(netdev, "To change autoneg please use: ethtool -s <dev> autoneg <on|off>\n");
 		return -EOPNOTSUPP;
 	}
 
 	/* If we have link and don't have autoneg */
-	if (!test_bit(__I40E_DOWN, pf->state) &&
-	    !(hw_link_info->an_info & I40E_AQ_AN_COMPLETED)) {
+	if (!test_bit(__I40E_DOWN, pf->state) && !is_an) {
 		/* Send message that it might not necessarily work*/
 		netdev_info(netdev, "Autoneg did not complete so changing settings may not result in an actual change.\n");
 	}
@@ -1406,7 +1406,7 @@ static int i40e_set_pauseparam(struct net_device *netdev,
 		err = -EAGAIN;
 	}
 
-	if (!test_bit(__I40E_DOWN, pf->state)) {
+	if (!test_bit(__I40E_DOWN, pf->state) && is_an) {
 		/* Give it a little more time to try to come back */
 		msleep(75);
 		if (!test_bit(__I40E_DOWN, pf->state))
-- 
2.9.5


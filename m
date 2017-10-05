From: Alan Brady <alan.brady@intel.com>
Date: Thu,  5 Oct 2017 11:42:33 -0700
Subject: [Intel-wired-lan] [PATCH v2 12/13 net-next] i40e: rename 'change'
	variable to 'autoneg_changed'
In-Reply-To: <20171005184234.21288-1-alan.brady@intel.com>
References: <20171005184234.21288-1-alan.brady@intel.com>
Message-ID: <20171005184234.21288-13-alan.brady@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This variable isn't actually very descriptive and makes the code a bit
confusing as to what it is being used for.  This patch enhances the
variable with the longer name, 'autoneg_changed', which makes it clear
we are concerned with autoneg changing in this context.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 2c34c82cfc54..17cb58d8d050 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -822,14 +822,14 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_aq_get_phy_abilities_resp abilities;
+	struct ethtool_link_ksettings safe_ks;
+	struct ethtool_link_ksettings copy_ks;
 	struct i40e_aq_set_phy_config config;
 	struct i40e_pf *pf = np->vsi->back;
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_hw *hw = &pf->hw;
-	struct ethtool_link_ksettings safe_ks;
-	struct ethtool_link_ksettings copy_ks;
+	bool autoneg_changed = false;
 	i40e_status status = 0;
-	bool change = false;
 	int timeout = 50;
 	int err = 0;
 	u32 autoneg;
@@ -921,7 +921,7 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 			/* Autoneg is allowed to change */
 			config.abilities = abilities.abilities |
 					   I40E_AQ_PHY_ENABLE_AN;
-			change = true;
+			autoneg_changed = true;
 		}
 	} else {
 		/* If autoneg is currently enabled */
@@ -940,7 +940,7 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 			/* Autoneg is allowed to change */
 			config.abilities = abilities.abilities &
 					   ~I40E_AQ_PHY_ENABLE_AN;
-			change = true;
+			autoneg_changed = true;
 		}
 	}
 
@@ -974,7 +974,7 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 	 */
 	if (!config.link_speed)
 		config.link_speed = abilities.link_speed;
-	if (change || (abilities.link_speed != config.link_speed)) {
+	if (autoneg_changed || abilities.link_speed != config.link_speed) {
 		/* copy over the rest of the abilities */
 		config.phy_type = abilities.phy_type;
 		config.phy_type_ext = abilities.phy_type_ext;
-- 
2.14.1


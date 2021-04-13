From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Tue, 13 Apr 2021 14:19:40 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: fix the restart
 auto-negotiation after FEC modified
Message-ID: <20210413141940.3456-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jaroslaw Gawin <jaroslawx.gawin@intel.com>

When FEC mode was changed the link didn't know it because
the link was not reset and new parameters were not negotiated.
Set a flag 'I40E_AQ_PHY_ENABLE_ATOMIC_LINK' in 'abilities'
to restart the link and make it run with the new settings.

Fixes: 1d96340196f1 ("i40e: Add support FEC configuration for Fortville
25G")
Signed-off-by: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 v2: Fixed fixes tag
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index fe5befa..1ccf0dc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1409,7 +1409,8 @@ static int i40e_set_fec_cfg(struct net_device *netdev, u8 fec_cfg)
 
 		memset(&config, 0, sizeof(config));
 		config.phy_type = abilities.phy_type;
-		config.abilities = abilities.abilities;
+		config.abilities = abilities.abilities |
+				   I40E_AQ_PHY_ENABLE_ATOMIC_LINK;
 		config.phy_type_ext = abilities.phy_type_ext;
 		config.link_speed = abilities.link_speed;
 		config.eee_capability = abilities.eee_capability;
-- 
2.17.1


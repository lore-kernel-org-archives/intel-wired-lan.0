From: Alice Michael <alice.michael@intel.com>
Date: Wed, 19 Dec 2018 06:45:39 -0800
Subject: [Intel-wired-lan] [next PATCH S1 3/6] i40e: Change unmatched
 function types
In-Reply-To: <20181219144542.85924-1-alice.michael@intel.com>
References: <20181219144542.85924-1-alice.michael@intel.com>
Message-ID: <20181219144542.85924-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Grzegorz Siwik <grzegorz.siwik@intel.com>

Change of function declaration from int to u64 due to
return type mismatch (u64).

Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 1592b8244661..f86f129a5d24 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2370,7 +2370,7 @@ static int i40e_get_ts_info(struct net_device *dev,
 	return 0;
 }
 
-static int i40e_link_test(struct net_device *netdev, u64 *data)
+static u64 i40e_link_test(struct net_device *netdev, u64 *data)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_pf *pf = np->vsi->back;
@@ -2393,7 +2393,7 @@ static int i40e_link_test(struct net_device *netdev, u64 *data)
 	return *data;
 }
 
-static int i40e_reg_test(struct net_device *netdev, u64 *data)
+static u64 i40e_reg_test(struct net_device *netdev, u64 *data)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_pf *pf = np->vsi->back;
@@ -2404,7 +2404,7 @@ static int i40e_reg_test(struct net_device *netdev, u64 *data)
 	return *data;
 }
 
-static int i40e_eeprom_test(struct net_device *netdev, u64 *data)
+static u64 i40e_eeprom_test(struct net_device *netdev, u64 *data)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_pf *pf = np->vsi->back;
@@ -2418,7 +2418,7 @@ static int i40e_eeprom_test(struct net_device *netdev, u64 *data)
 	return *data;
 }
 
-static int i40e_intr_test(struct net_device *netdev, u64 *data)
+static u64 i40e_intr_test(struct net_device *netdev, u64 *data)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_pf *pf = np->vsi->back;
-- 
2.19.2


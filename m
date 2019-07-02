From: Alice Michael <alice.michael@intel.com>
Date: Tue,  2 Jul 2019 08:22:51 -0400
Subject: [Intel-wired-lan] [next PATCH S7 1/9] i40e: fix incorrect ethtool
 statistics veb and veb.tc_
Message-ID: <20190702122259.79070-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dmitrii Golovanov <dmitrii.golovanov@intel.com>

This patch fixes missing call of i40e_update_veb_stats() in function
i40e_get_ethtool_stats() to update stats data of VEB and VEB TC
counters before they are written into ethtool buffer.
Before the patch ethtool counters may fell behind interface counters.

Signed-off-by: Dmitrii Golovanov <dmitrii.golovanov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 8 +++++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 84bd06901014..3e535d3263b3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1021,6 +1021,7 @@ i40e_find_vsi_by_type(struct i40e_pf *pf, u16 type)
 	return NULL;
 }
 void i40e_update_stats(struct i40e_vsi *vsi);
+void i40e_update_veb_stats(struct i40e_veb *veb);
 void i40e_update_eth_stats(struct i40e_vsi *vsi);
 struct rtnl_link_stats64 *i40e_get_vsi_stats_struct(struct i40e_vsi *vsi);
 int i40e_fetch_switch_configuration(struct i40e_pf *pf,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 527eb52c5401..65e016f54f58 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2250,7 +2250,7 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	struct i40e_veb *veb = pf->veb[pf->lan_veb];
+	struct i40e_veb *veb = NULL;
 	unsigned int i;
 	bool veb_stats;
 	u64 *p = data;
@@ -2273,8 +2273,14 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 		goto check_data_pointer;
 
 	veb_stats = ((pf->lan_veb != I40E_NO_VEB) &&
+		     (pf->lan_veb < I40E_MAX_VEB) &&
 		     (pf->flags & I40E_FLAG_VEB_STATS_ENABLED));
 
+	if (veb_stats) {
+		veb = pf->veb[pf->lan_veb];
+		i40e_update_veb_stats(veb);
+	}
+
 	/* If veb stats aren't enabled, pass NULL instead of the veb so that
 	 * we initialize stats to zero and update the data pointer
 	 * intelligently
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5361c08328f7..8dac7a87834d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -677,7 +677,7 @@ void i40e_update_eth_stats(struct i40e_vsi *vsi)
  * i40e_update_veb_stats - Update Switch component statistics
  * @veb: the VEB being updated
  **/
-static void i40e_update_veb_stats(struct i40e_veb *veb)
+void i40e_update_veb_stats(struct i40e_veb *veb)
 {
 	struct i40e_pf *pf = veb->pf;
 	struct i40e_hw *hw = &pf->hw;
-- 
2.21.0


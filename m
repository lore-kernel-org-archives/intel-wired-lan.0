From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 23 Jul 2015 16:54:40 -0400
Subject: [Intel-wired-lan] [next PATCH S9 11/15] i40e: Strip VEB stats if
	they are disabled in HW
In-Reply-To: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1437684884-222825-12-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

Due to performance reasons, VEB stats have been disabled in the hw. This
patch adds code to check for that condition before accumulating these
stats.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: I7d805669476fedabb073790403703798ae5d878e
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  9 ++++++---
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 13 +++++++++----
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index d821c99..5a25c2c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -326,6 +326,7 @@ struct i40e_pf {
 #define I40E_FLAG_OUTER_UDP_CSUM_CAPABLE	BIT_ULL(33)
 #define I40E_FLAG_128_QP_RSS_CAPABLE		BIT_ULL(34)
 #define I40E_FLAG_WB_ON_ITR_CAPABLE		BIT_ULL(35)
+#define I40E_FLAG_VEB_STATS_ENABLED		BIT_ULL(37)
 #define I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE	BIT_ULL(38)
 #define I40E_FLAG_VEB_MODE_ENABLED		BIT_ULL(40)
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index dd2b620..1345de2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1264,7 +1264,8 @@ static int i40e_get_sset_count(struct net_device *netdev, int sset)
 		if (vsi == pf->vsi[pf->lan_vsi] && pf->hw.partition_id == 1) {
 			int len = I40E_PF_STATS_LEN(netdev);
 
-			if (pf->lan_veb != I40E_NO_VEB)
+			if ((pf->lan_veb != I40E_NO_VEB) &&
+			    (pf->flags & I40E_FLAG_VEB_STATS_ENABLED))
 				len += I40E_VEB_STATS_TOTAL;
 			return len;
 		} else {
@@ -1337,7 +1338,8 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 	if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
 		return;
 
-	if (pf->lan_veb != I40E_NO_VEB) {
+	if ((pf->lan_veb != I40E_NO_VEB) &&
+	    (pf->flags & I40E_FLAG_VEB_STATS_ENABLED)) {
 		struct i40e_veb *veb = pf->veb[pf->lan_veb];
 		for (j = 0; j < I40E_VEB_STATS_LEN; j++) {
 			p = (char *)veb;
@@ -1410,7 +1412,8 @@ static void i40e_get_strings(struct net_device *netdev, u32 stringset,
 		if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
 			return;
 
-		if (pf->lan_veb != I40E_NO_VEB) {
+		if ((pf->lan_veb != I40E_NO_VEB) &&
+		    (pf->flags & I40E_FLAG_VEB_STATS_ENABLED)) {
 			for (i = 0; i < I40E_VEB_STATS_LEN; i++) {
 				snprintf(p, ETH_GSTRING_LEN, "veb.%s",
 					i40e_gstrings_veb_stats[i].stat_string);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4f0660f..464fba3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5761,10 +5761,12 @@ static void i40e_watchdog_subtask(struct i40e_pf *pf)
 		if (pf->vsi[i] && pf->vsi[i]->netdev)
 			i40e_update_stats(pf->vsi[i]);
 
-	/* Update the stats for the active switching components */
-	for (i = 0; i < I40E_MAX_VEB; i++)
-		if (pf->veb[i])
-			i40e_update_veb_stats(pf->veb[i]);
+	if (pf->flags & I40E_FLAG_VEB_STATS_ENABLED) {
+		/* Update the stats for the active switching components */
+		for (i = 0; i < I40E_MAX_VEB; i++)
+			if (pf->veb[i])
+				i40e_update_veb_stats(pf->veb[i]);
+	}
 
 	i40e_ptp_rx_hang(pf->vsi[pf->lan_vsi]);
 }
@@ -7851,6 +7853,9 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	pf->lan_veb = I40E_NO_VEB;
 	pf->lan_vsi = I40E_NO_VSI;
 
+	/* By default FW has this off for performance reasons */
+	pf->flags &= ~I40E_FLAG_VEB_STATS_ENABLED;
+
 	/* set up queue assignment tracking */
 	size = sizeof(struct i40e_lump_tracking)
 		+ (sizeof(u16) * pf->hw.func_caps.num_tx_qp);
-- 
1.9.3


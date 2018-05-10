From: Alice Michael <alice.michael@intel.com>
Date: Thu, 10 May 2018 05:59:41 -0700
Subject: [Intel-wired-lan] [next PATCH S91 03/11] i40e: calculate ethtool
 stats size in a separate function
In-Reply-To: <20180510125949.79823-1-alice.michael@intel.com>
References: <20180510125949.79823-1-alice.michael@intel.com>
Message-ID: <20180510125949.79823-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Use a separate function to calculate the number of stats for
a particular device. This helps reduce the clutter in
i40e_get_sset_count().

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 28 +++++++++++++++++---------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index fc6a5ee..a62142f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1658,6 +1658,23 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	return err;
 }
 
+static int i40e_get_stats_count(struct net_device *netdev)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_pf *pf = vsi->back;
+
+	if (vsi == pf->vsi[pf->lan_vsi] && pf->hw.partition_id == 1) {
+		if (pf->lan_veb != I40E_NO_VEB &&
+		    pf->flags & I40E_FLAG_VEB_STATS_ENABLED)
+			return I40E_PF_STATS_LEN(netdev) + I40E_VEB_STATS_TOTAL;
+		else
+			return I40E_PF_STATS_LEN(netdev);
+	} else {
+		return I40E_VSI_STATS_LEN(netdev);
+	}
+}
+
 static int i40e_get_sset_count(struct net_device *netdev, int sset)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
@@ -1668,16 +1685,7 @@ static int i40e_get_sset_count(struct net_device *netdev, int sset)
 	case ETH_SS_TEST:
 		return I40E_TEST_LEN;
 	case ETH_SS_STATS:
-		if (vsi == pf->vsi[pf->lan_vsi] && pf->hw.partition_id == 1) {
-			int len = I40E_PF_STATS_LEN(netdev);
-
-			if ((pf->lan_veb != I40E_NO_VEB) &&
-			    (pf->flags & I40E_FLAG_VEB_STATS_ENABLED))
-				len += I40E_VEB_STATS_TOTAL;
-			return len;
-		} else {
-			return I40E_VSI_STATS_LEN(netdev);
-		}
+		return i40e_get_stats_count(netdev);
 	case ETH_SS_PRIV_FLAGS:
 		return I40E_PRIV_FLAGS_STR_LEN +
 			(pf->hw.pf_id == 0 ? I40E_GL_PRIV_FLAGS_STR_LEN : 0);
-- 
2.9.5


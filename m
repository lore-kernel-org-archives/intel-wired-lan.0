From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 20 Nov 2020 16:38:32 -0800
Subject: [Intel-wired-lan] [net 3/6] ice: update the number of available RSS
 queues
In-Reply-To: <20201121003835.48424-1-anthony.l.nguyen@intel.com>
References: <20201121003835.48424-1-anthony.l.nguyen@intel.com>
Message-ID: <20201121003835.48424-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Henry Tieman <henry.w.tieman@intel.com>

It was possible to have Rx queues that were not available for use
by RSS. This would happen when increasing the number of Rx queues
while there was a user defined RSS LUT.

Always update the number of available RSS queues when changing the
number of Rx queues.

Fixes: 87324e747fde ("ice: Implement ethtool ops for channels")
Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 31 ++++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 9e8e9531cd87..8515a3a7515f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3321,6 +3321,18 @@ ice_get_channels(struct net_device *dev, struct ethtool_channels *ch)
 	ch->max_other = ch->other_count;
 }
 
+/**
+ * ice_get_valid_rss_size - return valid number of RSS queues
+ * @hw: pointer to the HW structure
+ * @new_size: requested RSS queues
+ */
+static int ice_get_valid_rss_size(struct ice_hw *hw, int new_size)
+{
+	struct ice_hw_common_caps *caps = &hw->func_caps.common_cap;
+
+	return min_t(int, new_size, BIT(caps->rss_table_entry_width));
+}
+
 /**
  * ice_vsi_set_dflt_rss_lut - set default RSS LUT with requested RSS size
  * @vsi: VSI to reconfigure RSS LUT on
@@ -3348,14 +3360,10 @@ static int ice_vsi_set_dflt_rss_lut(struct ice_vsi *vsi, int req_rss_size)
 		return -ENOMEM;
 
 	/* set RSS LUT parameters */
-	if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags)) {
+	if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags))
 		vsi->rss_size = 1;
-	} else {
-		struct ice_hw_common_caps *caps = &hw->func_caps.common_cap;
-
-		vsi->rss_size = min_t(int, req_rss_size,
-				      BIT(caps->rss_table_entry_width));
-	}
+	else
+		vsi->rss_size = ice_get_valid_rss_size(hw, req_rss_size);
 
 	/* create/set RSS LUT */
 	ice_fill_rss_lut(lut, vsi->rss_table_size, vsi->rss_size);
@@ -3434,8 +3442,13 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 
 	ice_vsi_recfg_qs(vsi, new_rx, new_tx);
 
-	if (new_rx && !netif_is_rxfh_configured(dev))
-		return ice_vsi_set_dflt_rss_lut(vsi, new_rx);
+	if (new_rx) {
+		if (!netif_is_rxfh_configured(dev))
+			return ice_vsi_set_dflt_rss_lut(vsi, new_rx);
+
+		/* Update rss_size due to change in Rx queues */
+		vsi->rss_size = ice_get_valid_rss_size(&pf->hw, new_rx);
+	}
 
 	return 0;
 }
-- 
2.20.1


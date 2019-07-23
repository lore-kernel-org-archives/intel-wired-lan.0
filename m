From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 23 Jul 2019 02:27:52 -0700
Subject: [Intel-wired-lan] [PATCH S24 05/12] ice: Fix RSS LUT table when
 setting Rx channels
In-Reply-To: <20190723092759.3614-1-anthony.l.nguyen@intel.com>
References: <20190723092759.3614-1-anthony.l.nguyen@intel.com>
Message-ID: <20190723092759.3614-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently there are multiple problems involved with setting Rx channels
in regards to the RSS LUT. First, if the user set the indirection table
manually through ethtool, changing the Rx channels will blindly use the
user set value. Second when increasing the number of Rx channels the RSS
table size is doing of minimum of the last RSS table width and the newly
requested one, this is causing the previously set RSS table width to be
used.

Fix these issues by adding the function ice_pf_set_dflt_rss_lut() that
is called when changing the number of Rx channels. This function updates
the RSS LUT to the default configuration for the PF any time the user
has changed the number of Rx channels.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 64 ++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index ba29aede99ad..35aa4a3f59df 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3154,6 +3154,67 @@ ice_get_channels(struct net_device *dev, struct ethtool_channels *ch)
 	ch->tx_count = vsi->num_txq;
 }
 
+/**
+ * ice_pf_set_dflt_rss_lut - set default RSS LUT with requested RSS size
+ * @pf: PF to reconfigure RSS LUT on
+ * @req_rss_size: requested range of queue numbers for hashing
+ *
+ * Set the PF's RSS parameters, configure the RSS LUT based on these, and then
+ * clear the previous vsi->rss_lut_user because it is assumed to be invalid at
+ * this point.
+ */
+static int ice_pf_set_dflt_rss_lut(struct ice_pf *pf, int req_rss_size)
+{
+	struct device *dev = &pf->pdev->dev;
+	struct ice_hw *hw = &pf->hw;
+	enum ice_status status;
+	struct ice_vsi *vsi;
+	int err = 0;
+	u8 *lut;
+
+	if (!req_rss_size)
+		return -EINVAL;
+
+	vsi = ice_find_vsi_by_type(pf, ICE_VSI_PF);
+	if (!vsi)
+		return -EINVAL;
+
+	lut = devm_kzalloc(dev, vsi->rss_table_size, GFP_KERNEL);
+	if (!lut)
+		return -ENOMEM;
+
+	/* set RSS LUT parameters */
+	if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags)) {
+		vsi->rss_size = 1;
+	} else {
+		struct ice_hw_common_caps *caps = &hw->func_caps.common_cap;
+
+		vsi->rss_size = min_t(int, req_rss_size,
+				      BIT(caps->rss_table_entry_width));
+	}
+
+	/* create/set RSS LUT */
+	ice_fill_rss_lut(lut, vsi->rss_table_size, vsi->rss_size);
+	status = ice_aq_set_rss_lut(hw, vsi->idx, vsi->rss_lut_type, lut,
+				    vsi->rss_table_size);
+	if (status) {
+		dev_err(dev, "Cannot set RSS lut, err %d aq_err %d\n",
+			status, hw->adminq.sq_last_status);
+		err = -EIO;
+	}
+
+	/* get rid of invalid user configuration */
+	if (vsi->rss_lut_user) {
+		netdev_info(vsi->netdev,
+			    "Rx queue count changed, clearing user modified RSS LUT, re-run ethtool [-x|-X] to [check|set] settings if needed\n");
+		devm_kfree(dev, vsi->rss_lut_user);
+		vsi->rss_lut_user = NULL;
+	}
+
+	devm_kfree(dev, lut);
+	return err;
+}
+
 /**
  * ice_set_channels - set the number channels
  * @dev: network interface device structure
@@ -3189,6 +3250,9 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 
 	ice_vsi_recfg_qs(vsi, new_rx, new_tx);
 
+	if (new_rx)
+		return ice_pf_set_dflt_rss_lut(pf, new_rx);
+
 	return 0;
 }
 
-- 
2.20.1


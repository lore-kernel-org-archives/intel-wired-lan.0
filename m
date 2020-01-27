From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 27 Jan 2020 00:59:17 -0800
Subject: [Intel-wired-lan] [PATCH S39 05/15] ice: Add DCBNL ops required to
 configure ETS in CEE for SW DCB
In-Reply-To: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
References: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
Message-ID: <20200127085927.13999-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Avinash JD <avinash.dayanand@intel.com>

Couple of DCBNL ops are required for configuring ETS in SW DCB CEE mode. If
these functions are not added, it'll break the CEE functionality.

Signed-off-by: Avinash JD <avinash.dayanand@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 43 +++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index a45e8abef8f3..912467add847 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -541,6 +541,30 @@ ice_dcbnl_get_pg_tc_cfg_rx(struct net_device *netdev, int prio,
 	*pgid = pi->local_dcbx_cfg.etscfg.prio_table[prio];
 }
 
+/**
+ * ice_dcbnl_set_pg_tc_cfg_rx
+ * @netdev: relevant netdev struct
+ * @prio: corresponding user priority
+ * @prio_type: the traffic priority type
+ * @pgid: the PG ID
+ * @bw_pct: BW percentage for corresponding BWG
+ * @up_map: prio mapped to corresponding TC
+ *
+ * lldpad requires this function pointer to be non-NULL to complete CEE config.
+ */
+static void
+ice_dcbnl_set_pg_tc_cfg_rx(struct net_device *netdev,
+			   int __always_unused prio,
+			   u8 __always_unused prio_type,
+			   u8 __always_unused pgid,
+			   u8 __always_unused bw_pct,
+			   u8 __always_unused up_map)
+{
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
+
+	dev_dbg(ice_pf_to_dev(pf), "Rx TC PG Config Not Supported.\n");
+}
+
 /**
  * ice_dcbnl_get_pg_bwg_cfg_rx - Get CEE PG BW Rx config
  * @netdev: pointer to netdev struct
@@ -560,6 +584,23 @@ ice_dcbnl_get_pg_bwg_cfg_rx(struct net_device *netdev, int __always_unused pgid,
 	*bw_pct = 0;
 }
 
+/**
+ * ice_dcbnl_set_pg_bwg_cfg_rx
+ * @netdev: the corresponding netdev
+ * @pgid: corresponding TC
+ * @bw_pct: BW percentage for given TC
+ *
+ * lldpad requires this function pointer to be non-NULL to complete CEE config.
+ */
+static void
+ice_dcbnl_set_pg_bwg_cfg_rx(struct net_device *netdev, int __always_unused pgid,
+			    u8 __always_unused bw_pct)
+{
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
+
+	dev_dbg(ice_pf_to_dev(pf), "Rx BWG PG Config Not Supported.\n");
+}
+
 /**
  * ice_dcbnl_get_cap - Get DCBX capabilities of adapter
  * @netdev: pointer to netdev struct
@@ -806,6 +847,8 @@ static const struct dcbnl_rtnl_ops dcbnl_ops = {
 	.getpermhwaddr = ice_dcbnl_get_perm_hw_addr,
 	.setpgtccfgtx = ice_dcbnl_set_pg_tc_cfg_tx,
 	.setpgbwgcfgtx = ice_dcbnl_set_pg_bwg_cfg_tx,
+	.setpgtccfgrx = ice_dcbnl_set_pg_tc_cfg_rx,
+	.setpgbwgcfgrx = ice_dcbnl_set_pg_bwg_cfg_rx,
 	.getpgtccfgtx = ice_dcbnl_get_pg_tc_cfg_tx,
 	.getpgbwgcfgtx = ice_dcbnl_get_pg_bwg_cfg_tx,
 	.getpgtccfgrx = ice_dcbnl_get_pg_tc_cfg_rx,
-- 
2.20.1


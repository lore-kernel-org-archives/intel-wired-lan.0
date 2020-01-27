From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 27 Jan 2020 00:59:18 -0800
Subject: [Intel-wired-lan] [PATCH S39 06/15] ice: Report correct DCB mode
In-Reply-To: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
References: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
Message-ID: <20200127085927.13999-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Avinash Dayanand <avinash.dayanand@intel.com>

Add code to detect if DCB is in IEEE or CEE mode. Without this the code
will always report as IEEE mode which is incorrect and confuses the
user.

Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
Signed-off-by: Scott Register <scottx.register@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 27 +++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index bd361212921c..a072d115fe73 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -62,6 +62,26 @@ u8 ice_dcb_get_ena_tc(struct ice_dcbx_cfg *dcbcfg)
 	return ena_tc;
 }
 
+/**
+ * ice_dcb_get_mode - gets the DCB mode
+ * @port_info: pointer to port info structure
+ * @host: if set it's HOST if not it's MANAGED
+ */
+static u8 ice_dcb_get_mode(struct ice_port_info *port_info, bool host)
+{
+	u8 mode;
+
+	if (host)
+		mode = DCB_CAP_DCBX_HOST;
+	else
+		mode = DCB_CAP_DCBX_LLD_MANAGED;
+
+	if (port_info->local_dcbx_cfg.dcbx_mode & ICE_DCBX_MODE_CEE)
+		return (mode | DCB_CAP_DCBX_VER_CEE);
+	else
+		return (mode | DCB_CAP_DCBX_VER_IEEE);
+}
+
 /**
  * ice_dcb_get_num_tc - Get the number of TCs from DCBX config
  * @dcbcfg: config to retrieve number of TCs from
@@ -694,14 +714,14 @@ int ice_init_pf_dcb(struct ice_pf *pf, bool locked)
 
 		ice_cfg_sw_lldp(pf_vsi, false, true);
 
-		pf->dcbx_cap = DCB_CAP_DCBX_HOST | DCB_CAP_DCBX_VER_IEEE;
+		pf->dcbx_cap = ice_dcb_get_mode(port_info, true);
 		return 0;
 	}
 
 	set_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags);
 
-	/* DCBX in FW and LLDP enabled in FW */
-	pf->dcbx_cap = DCB_CAP_DCBX_LLD_MANAGED | DCB_CAP_DCBX_VER_IEEE;
+	/* DCBX/LLDP enabled in FW, set DCBNL mode advertisement */
+	pf->dcbx_cap = ice_dcb_get_mode(port_info, false);
 
 	err = ice_dcb_init_cfg(pf, locked);
 	if (err)
@@ -893,6 +913,7 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
 	/* No change detected in DCBX configs */
 	if (!memcmp(&tmp_dcbx_cfg, &pi->local_dcbx_cfg, sizeof(tmp_dcbx_cfg))) {
 		dev_dbg(dev, "No change detected in DCBX configuration.\n");
+		pf->dcbx_cap = ice_dcb_get_mode(pi, false);
 		mutex_unlock(&pf->tc_mutex);
 		return;
 	}
-- 
2.20.1


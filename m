From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 27 Feb 2020 10:14:57 -0800
Subject: [Intel-wired-lan] [PATCH S40 07/15] ice: Fix corner case when
 switching from IEEE to CEE
In-Reply-To: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
Message-ID: <20200227181505.61720-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Avinash JD <avinash.dayanand@intel.com>

While testing DCB for a corner case in which mode is switched from IEEE to
CEE and pfc_ena bitmask unchanged then DCBX mode doesn't get updated.

This is happening because the function ice_dcb_get_mode() is called
in a "no change detected block" instead of "change detected block".

Signed-off-by: Avinash JD <avinash.dayanand@intel.com>
Signed-off-by: Scott Register <scottx.register@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 49e05f8ad93e..f9145a471f4d 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -873,10 +873,11 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
 	/* No change detected in DCBX configs */
 	if (!memcmp(&tmp_dcbx_cfg, &pi->local_dcbx_cfg, sizeof(tmp_dcbx_cfg))) {
 		dev_dbg(dev, "No change detected in DCBX configuration.\n");
-		pf->dcbx_cap = ice_dcb_get_mode(pi, false);
 		goto out;
 	}
 
+	pf->dcbx_cap = ice_dcb_get_mode(pi, false);
+
 	need_reconfig = ice_dcb_need_recfg(pf, &tmp_dcbx_cfg,
 					   &pi->local_dcbx_cfg);
 	ice_dcbnl_flush_apps(pf, &tmp_dcbx_cfg, &pi->local_dcbx_cfg);
-- 
2.20.1


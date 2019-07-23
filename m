From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 23 Jul 2019 02:27:53 -0700
Subject: [Intel-wired-lan] [PATCH S24 06/12] ice: Copy dcbx configuration
 only if mode is correct
In-Reply-To: <20190723092759.3614-1-anthony.l.nguyen@intel.com>
References: <20190723092759.3614-1-anthony.l.nguyen@intel.com>
Message-ID: <20190723092759.3614-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Swiatkowski <michal.swiatkowski@intel.com>

In rebuild DCB desired_dcbx_cfg was copy to local_dcbx_cfg, but
if DCBX mode is IEEE desired_dcbx_cfg is not initialized by DCBX
config from FW. Change logic to copy config value only if mode is
set to CEE.

If driver copy desired_dcbx_cfg to local_dcbx_cfg in IEEE mode there
is problem with globr. System is frozen after two or more globr.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 9ab9ec1ce19e..2a868eea2a37 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -339,8 +339,10 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	devm_kfree(&pf->pdev->dev, prev_cfg);
 
 	/* Set the local desired config */
-	memset(&pf->hw.port_info->local_dcbx_cfg, 0, sizeof(*local_dcbx_cfg));
-	memcpy(local_dcbx_cfg, desired_dcbx_cfg, sizeof(*local_dcbx_cfg));
+	if (local_dcbx_cfg->dcbx_mode == ICE_DCBX_MODE_CEE)
+		memcpy(local_dcbx_cfg, desired_dcbx_cfg,
+		       sizeof(*local_dcbx_cfg));
+
 	ice_cfg_etsrec_defaults(pf->hw.port_info);
 	ret = ice_set_dcb_cfg(pf->hw.port_info);
 	if (ret) {
-- 
2.20.1


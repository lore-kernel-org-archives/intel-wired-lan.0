From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 12 Dec 2019 03:13:04 -0800
Subject: [Intel-wired-lan] [PATCH S35 12/15] ice: suppress checked_return
 error
In-Reply-To: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
Message-ID: <20191212111307.33566-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Coverity reports an error that is not really an error; suppress it.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index f950deef524b..00d6c0a8614c 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -420,6 +420,12 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	prev_cfg->etscfg.tcbwtable[0] = ICE_TC_MAX_BW;
 	prev_cfg->etscfg.tsatable[0] = ICE_IEEE_TSA_ETS;
 	memcpy(&prev_cfg->etsrec, &prev_cfg->etscfg, sizeof(prev_cfg->etsrec));
+	/* Coverity warns the return code of ice_pf_dcb_cfg() is not checked
+	 * here as is done for other calls to that function. That check is
+	 * not necessary since this is in this function's error cleanup path.
+	 * Suppress the Coverity warning with the following comment...
+	 */
+	/* coverity[check_return] */
 	ice_pf_dcb_cfg(pf, prev_cfg, false);
 	kfree(prev_cfg);
 }
-- 
2.20.1


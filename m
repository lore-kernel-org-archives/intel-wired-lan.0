From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  5 May 2021 14:18:00 -0700
Subject: [Intel-wired-lan] [PATCH net 4/4] ice: fix FDIR init missing when
 reset VF
In-Reply-To: <20210505211800.11908-1-anthony.l.nguyen@intel.com>
References: <20210505211800.11908-1-anthony.l.nguyen@intel.com>
Message-ID: <20210505211800.11908-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Yahui Cao <yahui.cao@intel.com>

When VF is being reset, ice_reset_vf() will be called and FDIR
resource should be released and initialized again.

Fixes: 1f7ea1cd6a37 ("ice: Enable FDIR Configure for AVF")
Signed-off-by: Yahui Cao <yahui.cao@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 4001dc723e1f..c827977f4539 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1565,6 +1565,7 @@ bool ice_reset_all_vfs(struct ice_pf *pf, bool is_vflr)
 		ice_vc_set_default_allowlist(vf);
 
 		ice_vf_fdir_exit(vf);
+		ice_vf_fdir_init(vf);
 		/* clean VF control VSI when resetting VFs since it should be
 		 * setup only when VF creates its first FDIR rule.
 		 */
@@ -1693,6 +1694,7 @@ bool ice_reset_vf(struct ice_vf *vf, bool is_vflr)
 	}
 
 	ice_vf_fdir_exit(vf);
+	ice_vf_fdir_init(vf);
 	/* clean VF control VSI when resetting VF since it should be setup
 	 * only when VF creates its first FDIR rule.
 	 */
-- 
2.20.1


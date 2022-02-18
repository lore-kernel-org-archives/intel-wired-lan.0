From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 18 Feb 2022 12:23:34 -0800
Subject: [Intel-wired-lan] [PATCH] fixup! ice: fix concurrent reset and
 removal of VFs
Message-ID: <20220218202334.822004-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

One call to ice_vc_reset_vf failed to grab the VF cfg_lock. Add the
missing mutex_lock/unlock to ice_vf_lan_overflow_event.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 353c2a3755d0..1be3cd4b2bef 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2150,7 +2150,9 @@ ice_vf_lan_overflow_event(struct ice_pf *pf, struct ice_rq_event_info *event)
 	if (!vf)
 		return;
 
+	mutex_lock(&vf->cfg_lock);
 	ice_vc_reset_vf(vf);
+	mutex_unlock(&vf->cfg_lock);
 }
 
 /**

base-commit: 967260db57d52ff5e97dc07407aeeb014653b969
-- 

Noticed this gap while reviewing other refactor work I am planning on. Tony,
can you squash this into the relevant commit? Thanks.

2.35.1.129.gb80121027d12


From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:58 -0800
Subject: [Intel-wired-lan] [PATCH S12 11/14] ice: Reset all VFs with VFLR
 during SR-IOV init flow
In-Reply-To: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205101.12078-12-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

During SR-IOV initialization, we allocate and setup VFs with reset, and
since we were going to inform Firmware about our intention to do VFLR by
disabling LAN TX Queue, then we really have to complete VF reset flow with
VFLR using appropriate registers - Otherwise, reset status bit for VF in
the Guest OS might returns DEADBEEF.
This resolves issue to properly initialize VFs in the Guest OS via PCI
passthrough.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 99c8cddb2162..a93db0a7ac1c 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1029,7 +1029,7 @@ static int ice_alloc_vfs(struct ice_pf *pf, u16 num_alloc_vfs)
 	pf->num_alloc_vfs = num_alloc_vfs;
 
 	/* VF resources get allocated during reset */
-	if (!ice_reset_all_vfs(pf, false))
+	if (!ice_reset_all_vfs(pf, true))
 		goto err_unroll_sriov;
 
 	goto err_unroll_intr;
-- 
2.14.5


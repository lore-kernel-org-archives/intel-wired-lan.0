From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 16 Feb 2022 13:37:31 -0800
Subject: [Intel-wired-lan] [net-next PATCH v2 04/11] ice: move clear_malvf
 call in ice_free_vfs
In-Reply-To: <20220216213738.3826664-1-jacob.e.keller@intel.com>
References: <20220216213738.3826664-1-jacob.e.keller@intel.com>
Message-ID: <20220216213738.3826664-5-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ice_mbx_clear_malvf function is used to clear the indication and
count of how many times a VF was detected as malicious. During
ice_free_vfs, we use this function to ensure that all removed VFs are
reset to a clean state.

The call currently is done at the end of ice_free_vfs() using a tmp
value to iterate over all of the entries in the bitmap.

This separate iteration using tmp is problematic for a planned refactor
of the VF array data structure. To avoid this, lets move the call
slightly higher into the function inside the loop where we teardown all
of the VFs. This avoids one use of the tmp value used for iteration.
We'll fix the other user in a future change.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 44037d569755..c469b32f665b 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -536,6 +536,12 @@ void ice_free_vfs(struct ice_pf *pf)
 			ice_free_vf_res(vf);
 		}
 
+		/* clear malicious info since the VF is getting released */
+		if (ice_mbx_clear_malvf(&hw->mbx_snapshot, pf->malvfs,
+					ICE_MAX_VF_COUNT, vf->vf_id))
+			dev_dbg(dev, "failed to clear malicious VF state for VF %u\n",
+				vf->vf_id);
+
 		mutex_unlock(&vf->cfg_lock);
 
 		mutex_destroy(&vf->cfg_lock);
@@ -566,13 +572,6 @@ void ice_free_vfs(struct ice_pf *pf)
 		}
 	}
 
-	/* clear malicious info if the VFs are getting released */
-	for (i = 0; i < tmp; i++)
-		if (ice_mbx_clear_malvf(&hw->mbx_snapshot, pf->malvfs,
-					ICE_MAX_VF_COUNT, i))
-			dev_dbg(dev, "failed to clear malicious VF state for VF %u\n",
-				i);
-
 	clear_bit(ICE_VF_DIS, pf->state);
 	clear_bit(ICE_FLAG_SRIOV_ENA, pf->flags);
 }
-- 
2.35.1.129.gb80121027d12


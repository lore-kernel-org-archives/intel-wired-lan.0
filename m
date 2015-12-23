From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Wed, 23 Dec 2015 12:05:46 -0800
Subject: [Intel-wired-lan] [next PATCH S25 06/16] i40e: Store lan_vsi_idx
	and lan_vsi_id in the right size
In-Reply-To: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450901156-30904-7-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Pandi Maharajan <pandi.maharajan@intel.com>

lan_vsi_idx and lan_vsi_id are assigned to u16 data sized variables but
declared in u8. This patch fixes the width of the datatype.

Signed-off-by: Pandi Kumar Maharajan <pandi.maharajan@intel.com>
Change-ID: If4bcbcc7d32f2b287c51cb33d17879691258dce2
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index da44995..e74642a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -91,8 +91,8 @@ struct i40e_vf {
 	 * When assigned, these will be non-zero, because VSI 0 is always
 	 * the main LAN VSI for the PF.
 	 */
-	u8 lan_vsi_idx;	        /* index into PF struct */
-	u8 lan_vsi_id;		/* ID as used by firmware */
+	u16 lan_vsi_idx;	/* index into PF struct */
+	u16 lan_vsi_id;		/* ID as used by firmware */
 
 	u8 num_queue_pairs;	/* num of qps assigned to VF vsis */
 	u64 num_mdd_events;	/* num of mdd events detected */
-- 
2.1.0


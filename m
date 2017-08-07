From: Alice Michael <alice.michael@intel.com>
Date: Mon,  7 Aug 2017 09:18:10 -0400
Subject: [Intel-wired-lan] [next PATCH S78-V5 10/12] i40e: fix handling of
	vf_states variable
In-Reply-To: <20170807131812.86747-1-alice.michael@intel.com>
References: <20170807131812.86747-1-alice.michael@intel.com>
Message-ID: <20170807131812.86747-10-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

Currently we inappropriately clear the vf_states variable with a null
assignment.  This is problematic because we should be using atomic
bitops on this variable and we don't actually want to clear all the
flags.  We should just clear the ones we know we want to clear.
Additionally remove the I40E_VF_STATE_FCOEENA bit because it is no
longer being used.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 5 ++++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index c7f1819..e65ecaf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -876,7 +876,8 @@ static void i40e_free_vf_res(struct i40e_vf *vf)
 	}
 	/* reset some of the state variables keeping track of the resources */
 	vf->num_queue_pairs = 0;
-	vf->vf_states = 0;
+	clear_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states);
+	clear_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states);
 }
 
 /**
@@ -1582,6 +1583,8 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	    (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_IWARP)) {
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_IWARP;
 		set_bit(I40E_VF_STATE_IWARPENA, &vf->vf_states);
+	} else {
+		clear_bit(I40E_VF_STATE_IWARPENA, &vf->vf_states);
 	}
 
 	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RSS_PF) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 5ea42ad..5efc4f9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -56,7 +56,6 @@ enum i40e_vf_states {
 	I40E_VF_STATE_INIT = 0,
 	I40E_VF_STATE_ACTIVE,
 	I40E_VF_STATE_IWARPENA,
-	I40E_VF_STATE_FCOEENA,
 	I40E_VF_STATE_DISABLED,
 	I40E_VF_STATE_MC_PROMISC,
 	I40E_VF_STATE_UC_PROMISC,
-- 
2.9.4


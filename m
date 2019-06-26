From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 26 Jun 2019 02:20:18 -0700
Subject: [Intel-wired-lan] [PATCH S22 07/16] ice: Disable VFs until reset is
 completed
In-Reply-To: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
Message-ID: <20190626092027.52845-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

This patch adds code to clear VFs enable status until reset is completed,
and Tx/Rx rings are setup. Without this patch, the code flow request Tx
queues to be disabled after reset, especially PFR - where VF VSI Tx rings
have already been wiped off in the NVM and result to adminq error based on
the call to disable Tx lan queue in ice_reset_all_vfs function call.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4e5a92dbbf32..8d6c4f64cdb9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -488,6 +488,7 @@ static void
 ice_prepare_for_reset(struct ice_pf *pf)
 {
 	struct ice_hw *hw = &pf->hw;
+	u8 i;
 
 	/* already prepared for reset */
 	if (test_bit(__ICE_PREPARED_FOR_RESET, pf->state))
@@ -497,6 +498,10 @@ ice_prepare_for_reset(struct ice_pf *pf)
 	if (ice_check_sq_alive(hw, &hw->mailboxq))
 		ice_vc_notify_reset(pf);
 
+	/* Disable VFs until reset is completed */
+	for (i = 0; i < pf->num_alloc_vfs; i++)
+		clear_bit(ICE_VF_STATE_ENA, pf->vf[i].vf_states);
+
 	/* disable the VSIs and their queues that are not already DOWN */
 	ice_pf_dis_all_vsi(pf, false);
 
-- 
2.20.1


From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  2 Aug 2019 01:25:22 -0700
Subject: [Intel-wired-lan] [PATCH S26 04/15] ice: Fix VF configuration
 issues due to reset
In-Reply-To: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
Message-ID: <20190802082533.23083-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

This patch fixes a critical reset issue that resulting to the server
reboot when an Admin changes VF configuration on the host, for example
changing VF to Trusted/non_Trusted mode, the PF driver send reset
notification to AVF driver while also continue with reset flow. However,
AVF driver schedule another reset due to notification, which causes two
concurrent reset going on, and trigger lock up in the FW, with AQ call to
delete VSI.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 78fd3fa8ac8b..b93324e9f4bc 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1152,12 +1152,19 @@ static bool ice_reset_vf(struct ice_vf *vf, bool is_vflr)
 	u32 reg;
 	int i;
 
-	/* If the VFs have been disabled, this means something else is
-	 * resetting the VF, so we shouldn't continue.
+	/* If the PF has been disabled, there is no need resetting VF until
+	 * PF is active again.
 	 */
 	if (test_bit(__ICE_VF_DIS, pf->state))
 		return false;
 
+	/* If the VF has been disabled, this means something else is
+	 * resetting the VF, so we shouldn't continue. Otherwise, set
+	 * disable VF state bit for actual reset, and continue.
+	 */
+	if (test_and_set_bit(ICE_VF_STATE_DIS, vf->vf_states))
+		return false;
+
 	ice_trigger_vf_reset(vf, is_vflr);
 
 	vsi = pf->vsi[vf->lan_vsi_idx];
-- 
2.20.1


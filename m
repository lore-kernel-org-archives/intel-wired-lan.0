From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 14 Jun 2021 14:46:07 -0700
Subject: [Intel-wired-lan] [PATCH net-next 2/2] ice: remove unnecessary VSI
 assignment
In-Reply-To: <20210614214607.41749-1-anthony.l.nguyen@intel.com>
References: <20210614214607.41749-1-anthony.l.nguyen@intel.com>
Message-ID: <20210614214607.41749-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ice_get_vf_vsi() is being called twice for the same VSI. Remove the
unnecessary call/assignment.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index ccf5d117e008..699e0a842b85 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1665,7 +1665,6 @@ bool ice_reset_vf(struct ice_vf *vf, bool is_vflr)
 		else
 			promisc_m = ICE_UCAST_PROMISC_BITS;
 
-		vsi = ice_get_vf_vsi(vf);
 		if (ice_vf_clear_vsi_promisc(vf, vsi, promisc_m))
 			dev_err(dev, "disabling promiscuous mode failed\n");
 	}
-- 
2.20.1


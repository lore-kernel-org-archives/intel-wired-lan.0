From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 26 Jun 2019 02:20:21 -0700
Subject: [Intel-wired-lan] [PATCH S22 10/16] ice: Update number of VF queue
 before setting VSI resources
In-Reply-To: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
Message-ID: <20190626092027.52845-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

In case there is a request from a VF to change its number of queues, and
the request was successful, we need to update number of queues
configured on the VF before updating corresponding VSI for that VF,
especially LAN Tx queue tree and TC update, otherwise, we would continued
to use old value of vf->num_vf_qs for allocated Tx/Rx queues...

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index f5eaf3059063..c26f379713a4 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -567,11 +567,6 @@ static int ice_alloc_vf_res(struct ice_vf *vf)
 	int tx_rx_queue_left;
 	int status;
 
-	/* setup VF VSI and necessary resources */
-	status = ice_alloc_vsi_res(vf);
-	if (status)
-		goto ice_alloc_vf_res_exit;
-
 	/* Update number of VF queues, in case VF had requested for queue
 	 * changes
 	 */
@@ -581,6 +576,11 @@ static int ice_alloc_vf_res(struct ice_vf *vf)
 	    vf->num_req_qs != vf->num_vf_qs)
 		vf->num_vf_qs = vf->num_req_qs;
 
+	/* setup VF VSI and necessary resources */
+	status = ice_alloc_vsi_res(vf);
+	if (status)
+		goto ice_alloc_vf_res_exit;
+
 	if (vf->trusted)
 		set_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
 	else
-- 
2.20.1


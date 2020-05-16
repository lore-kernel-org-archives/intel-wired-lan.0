From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:55:04 -0700
Subject: [Intel-wired-lan] [PATCH S46 7/9] ice: Use coalesce values from
 q_vector 0 when increasing q_vectors
In-Reply-To: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
References: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516005506.5113-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently when a VSI is built (i.e. reset, set channels, etc.)
the coalesce settings will be preserved in most cases. However, when the
number of q_vectors are increased the settings for the new q_vectors
will be set to the driver defaults of AIM on, Rx/Tx ITR 50, and INTRL 0.
This is causing issues with how the ethtool layer gets the current
coalesce settings since it only uses q_vector 0. So, assume that the user
set the coalesce settings globally (i.e. ethtool -C eth0) and use q_vector
0's settings for all of the new q_vectors.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 7cd4afcade13..392fb6e7de5d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2753,15 +2753,13 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
 		ice_vsi_rebuild_update_coalesce(vsi->q_vectors[i],
 						&coalesce[i]);
 
-	for (; i < vsi->num_q_vectors; i++) {
-		struct ice_coalesce_stored coalesce_dflt = {
-			.itr_tx = ICE_DFLT_TX_ITR,
-			.itr_rx = ICE_DFLT_RX_ITR,
-			.intrl = 0
-		};
+	/* number of q_vectors increased, so assume coalesce settings were
+	 * changed globally (i.e. ethtool -C eth0 instead of per-queue) and use
+	 * the previous settings from q_vector 0 for all of the new q_vectors
+	 */
+	for (; i < vsi->num_q_vectors; i++)
 		ice_vsi_rebuild_update_coalesce(vsi->q_vectors[i],
-						&coalesce_dflt);
-	}
+						&coalesce[0]);
 }
 
 /**
-- 
2.20.1


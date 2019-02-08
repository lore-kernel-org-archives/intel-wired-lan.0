From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:59 -0800
Subject: [Intel-wired-lan] [PATCH S13 03/16] ice: fix the divide by zero
 issue
In-Reply-To: <20190208205112.12180-1-anirudh.venkataramanan@intel.com>
References: <20190208205112.12180-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205112.12180-4-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kiran Patil <kiran.patil@intel.com>

Static analysis flagged a potential divide by zero error because
vsi->num_rxq can become zero in certain condition and it is used as
divisor.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index be377107d9a9..f33097bcc4ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -893,7 +893,18 @@ static void ice_vsi_setup_q_map(struct ice_vsi *vsi, struct ice_vsi_ctx *ctxt)
 		tx_count += tx_numq_tc;
 		ctxt->info.tc_mapping[i] = cpu_to_le16(qmap);
 	}
-	vsi->num_rxq = offset;
+
+	/* if offset is non-zero, means it is calculated correctly based on
+	 * enabled TCs for a given VSI otherwise qcount_rx will always
+	 * be correct and non-zero because it is based off - VSI's
+	 * allocated Rx queues which is at least 1 (hence qcount_tx will be
+	 * at least 1)
+	 */
+	if (offset)
+		vsi->num_rxq = offset;
+	else
+		vsi->num_rxq = qcount_rx;
+
 	vsi->num_txq = tx_count;
 
 	if (vsi->type == ICE_VSI_VF && vsi->num_txq != vsi->num_rxq) {
-- 
2.14.5


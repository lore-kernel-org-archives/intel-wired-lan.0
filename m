From: Alice Michael <alice.michael@intel.com>
Date: Wed, 24 Apr 2019 05:20:49 -0700
Subject: [Intel-wired-lan] [next PATCH S5 04/10] i40e: Add bounds check for
 ch[] array
In-Reply-To: <20190424122055.27896-1-alice.michael@intel.com>
References: <20190424122055.27896-1-alice.michael@intel.com>
Message-ID: <20190424122055.27896-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Add bounds check for ch[] array.
Use ARRAY_SIZE() to ensure that idx is within the range.

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 8b07614ca568..4061da6c9dcb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2135,8 +2135,13 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 			}
 		}
 
-		if (vf->adq_enabled)
+		if (vf->adq_enabled) {
+			if (idx >= ARRAY_SIZE(vf->ch)) {
+				aq_ret = I40E_ERR_NO_AVAILABLE_VSI;
+				goto error_param;
+			}
 			vsi_id = vf->ch[idx].vsi_id;
+		}
 
 		if (i40e_config_vsi_rx_queue(vf, vsi_id, vsi_queue_id,
 					     &qpi->rxq) ||
@@ -2152,6 +2157,10 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		 * to its appropriate VSIs based on TC mapping
 		 **/
 		if (vf->adq_enabled) {
+			if (idx >= ARRAY_SIZE(vf->ch)) {
+				aq_ret = I40E_ERR_NO_AVAILABLE_VSI;
+				goto error_param;
+			}
 			if (j == (vf->ch[idx].num_qps - 1)) {
 				idx++;
 				j = 0; /* resetting the queue count */
-- 
2.19.2


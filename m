From: Alice Michael <alice.michael@intel.com>
Date: Tue,  2 Jul 2019 08:22:55 -0400
Subject: [Intel-wired-lan] [next PATCH S7 5/9] i40e: fix code comments
In-Reply-To: <20190702122259.79070-1-alice.michael@intel.com>
References: <20190702122259.79070-1-alice.michael@intel.com>
Message-ID: <20190702122259.79070-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Found a code comment that needed TLC to correct their formatting.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index bffdea629982..618781b3b7ac 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2159,7 +2159,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		 * VF does not know about these additional VSIs and all
 		 * it cares is about its own queues. PF configures these queues
 		 * to its appropriate VSIs based on TC mapping
-		 **/
+		 */
 		if (vf->adq_enabled) {
 			if (idx >= ARRAY_SIZE(vf->ch)) {
 				aq_ret = I40E_ERR_NO_AVAILABLE_VSI;
-- 
2.21.0


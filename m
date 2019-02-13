From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 13 Feb 2019 10:51:09 -0800
Subject: [Intel-wired-lan] [PATCH S14 09/15] ice: change VF VSI tc info
 along with num_queues
In-Reply-To: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190213185115.25877-10-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Preethi Banala <preethi.banala@intel.com>

Update VF VSI tc info along with vsi->num_txq/num_rxq when VF requests to
configure queues.

Signed-off-by: Preethi Banala <preethi.banala@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index ca8780891540..cc15b3c90656 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1927,6 +1927,9 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 	 */
 	vsi->num_txq = qci->num_queue_pairs;
 	vsi->num_rxq = qci->num_queue_pairs;
+	/* All queues of VF VSI are in TC 0 */
+	vsi->tc_cfg.tc_info[0].qcount_tx = qci->num_queue_pairs;
+	vsi->tc_cfg.tc_info[0].qcount_rx = qci->num_queue_pairs;
 
 	if (!ice_vsi_cfg_lan_txqs(vsi) && !ice_vsi_cfg_rxqs(vsi))
 		aq_ret = 0;
-- 
2.14.5


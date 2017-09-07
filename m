From: Alice Michael <alice.michael@intel.com>
Date: Thu,  7 Sep 2017 08:05:54 -0400
Subject: [Intel-wired-lan] [next PATCH S80-V3 09/11] i40e: add check for
	return from find_first_bit call
In-Reply-To: <20170907120556.45699-1-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
Message-ID: <20170907120556.45699-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lihong Yang <lihong.yang@intel.com>

The find_first_bit function will return the size passed to search
if the first set bit is not found. This patch adds the check in case
that happens as the return value would be used as the index in an array
and that would have caused the out-of-bounds access.

Detected by CoverityScan, CID 1295969 Out-of-bounds access

Signed-off-by: Lihong Yang <lihong.yang@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 7dc042b..b2bdf27 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -306,6 +306,10 @@ static void i40e_config_irq_link_list(struct i40e_vf *vf, u16 vsi_id,
 	next_q = find_first_bit(&linklistmap,
 				(I40E_MAX_VSI_QP *
 				 I40E_VIRTCHNL_SUPPORTED_QTYPES));
+	if (unlikely(next_q == (I40E_MAX_VSI_QP *
+				I40E_VIRTCHNL_SUPPORTED_QTYPES)))
+		goto irq_list_done;
+
 	vsi_queue_id = next_q / I40E_VIRTCHNL_SUPPORTED_QTYPES;
 	qtype = next_q % I40E_VIRTCHNL_SUPPORTED_QTYPES;
 	pf_queue_id = i40e_vc_get_pf_queue_id(vf, vsi_id, vsi_queue_id);
-- 
2.9.4


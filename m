From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri,  6 Nov 2015 15:26:10 -0800
Subject: [Intel-wired-lan] [next PATCH S21 12/14] i40e: fix whitespace
In-Reply-To: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1446852372-25480-13-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Operators should have spaces around them.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I64735e9aa8618b9a5059a87ace1c999d6d3bfcfb
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 98aa9c6..0606ee1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -290,8 +290,8 @@ static void i40e_config_irq_link_list(struct i40e_vf *vf, u16 vsi_id,
 	next_q = find_first_bit(&linklistmap,
 				(I40E_MAX_VSI_QP *
 				 I40E_VIRTCHNL_SUPPORTED_QTYPES));
-	vsi_queue_id = next_q/I40E_VIRTCHNL_SUPPORTED_QTYPES;
-	qtype = next_q%I40E_VIRTCHNL_SUPPORTED_QTYPES;
+	vsi_queue_id = next_q / I40E_VIRTCHNL_SUPPORTED_QTYPES;
+	qtype = next_q % I40E_VIRTCHNL_SUPPORTED_QTYPES;
 	pf_queue_id = i40e_vc_get_pf_queue_id(vf, vsi_id, vsi_queue_id);
 	reg = ((qtype << I40E_VPINT_LNKLSTN_FIRSTQ_TYPE_SHIFT) | pf_queue_id);
 
-- 
2.1.0


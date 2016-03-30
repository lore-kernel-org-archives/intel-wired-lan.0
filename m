From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Wed, 30 Mar 2016 03:49:36 -0700
Subject: [Intel-wired-lan] [v2 next PATCH S32 01/13] i40e: Inserting a HW
	capability display info
In-Reply-To: <1459334988-19951-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459334988-19951-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1459334988-19951-2-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Deepthi Kavalur <deepthi.kavalur@intel.com>

Display MSIx vector count for HW capabilities.

Signed-off-by: Deepthi Kavalur <deepthi.kavalur@intel.com>
Change-ID: I4b41e9b50360cf660e7fbcb85b9390fedcf313b1
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index ebcc0d3..f3c1d88 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -3080,6 +3080,9 @@ static void i40e_parse_discover_capabilities(struct i40e_hw *hw, void *buff,
 			break;
 		case I40E_AQ_CAP_ID_MSIX:
 			p->num_msix_vectors = number;
+			i40e_debug(hw, I40E_DEBUG_INIT,
+				   "HW Capability: MSIX vector count = %d\n",
+				   p->num_msix_vectors);
 			break;
 		case I40E_AQ_CAP_ID_VF_MSIX:
 			p->num_msix_vectors_vf = number;
-- 
2.4.3


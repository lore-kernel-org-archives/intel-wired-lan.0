From: Alice Michael <alice.michael@intel.com>
Date: Wed,  6 Feb 2019 15:08:21 -0800
Subject: [Intel-wired-lan] [next PATCH S2-V2 07/12] i40e: Remove misleading
 messages for untrusted VF
In-Reply-To: <20190206230826.24970-1-alice.michael@intel.com>
References: <20190206230826.24970-1-alice.michael@intel.com>
Message-ID: <20190206230826.24970-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Grzegorz Siwik <grzegorz.siwik@intel.com>

Removed misleading messages when untrusted VF tries to
add more addresses than NIC limit

Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e842b143f7b4..bae4c05e9d7e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2107,11 +2107,22 @@ void i40e_aqc_add_filters(struct i40e_vsi *vsi, const char *vsi_name,
 	fcnt = i40e_update_filter_state(num_add, list, add_head);
 
 	if (fcnt != num_add) {
-		set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
-		dev_warn(&vsi->back->pdev->dev,
-			 "Error %s adding RX filters on %s, promiscuous mode forced on\n",
-			 i40e_aq_str(hw, aq_err),
-			 vsi_name);
+		if (vsi->type == I40E_VSI_MAIN) {
+			set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
+			dev_warn(&vsi->back->pdev->dev,
+				 "Error %s adding RX filters on %s, promiscuous mode forced on\n",
+				 i40e_aq_str(hw, aq_err), vsi_name);
+		} else if (vsi->type == I40E_VSI_SRIOV ||
+			   vsi->type == I40E_VSI_VMDQ1 ||
+			   vsi->type == I40E_VSI_VMDQ2) {
+			dev_warn(&vsi->back->pdev->dev,
+				 "Error %s adding RX filters on %s, please set promiscuous on manually for %s\n",
+				 i40e_aq_str(hw, aq_err), vsi_name, vsi_name);
+		} else {
+			dev_warn(&vsi->back->pdev->dev,
+				 "Error %s adding RX filters on %s, incorrect VSI type: %i.\n",
+				 i40e_aq_str(hw, aq_err), vsi_name, vsi->type);
+		}
 	}
 }
 
-- 
2.19.2


From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 10:40:50 -0700
Subject: [Intel-wired-lan] [PATCH S8 01/16] ice: Set carrier state and
 start/stop queues in rebuild
In-Reply-To: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026174105.11628-2-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Set the carrier state post rebuild by querying the link status. Also
start/stop queues based on link status.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 05993451147a..6d31ffb64940 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3296,7 +3296,7 @@ static void ice_rebuild(struct ice_pf *pf)
 	struct device *dev = &pf->pdev->dev;
 	struct ice_hw *hw = &pf->hw;
 	enum ice_status ret;
-	int err;
+	int err, i;
 
 	if (test_bit(__ICE_DOWN, pf->state))
 		goto clear_recovery;
@@ -3370,6 +3370,22 @@ static void ice_rebuild(struct ice_pf *pf)
 	}
 
 	ice_reset_all_vfs(pf, true);
+
+	for (i = 0; i < pf->num_alloc_vsi; i++) {
+		bool link_up;
+
+		if (!pf->vsi[i] || pf->vsi[i]->type != ICE_VSI_PF)
+			continue;
+		ice_get_link_status(pf->vsi[i]->port_info, &link_up);
+		if (link_up) {
+			netif_carrier_on(pf->vsi[i]->netdev);
+			netif_tx_wake_all_queues(pf->vsi[i]->netdev);
+		} else {
+			netif_carrier_off(pf->vsi[i]->netdev);
+			netif_tx_stop_all_queues(pf->vsi[i]->netdev);
+		}
+	}
+
 	/* if we get here, reset flow is successful */
 	clear_bit(__ICE_RESET_FAILED, pf->state);
 	return;
-- 
2.14.3


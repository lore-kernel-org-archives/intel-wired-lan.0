From: Alice Michael <alice.michael@intel.com>
Date: Fri,  5 Jan 2018 04:55:21 -0500
Subject: [Intel-wired-lan] [patch] i40evf: ignore link up if not running
Message-ID: <20180105095521.3621-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

If we receive the link status message from PF with link up before queues
are actually enabled, it will trigger a TX hang.  This fixes the issue
by ignoring a link up message if the VF state is not yet in RUNNING
state.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 35 ++++++++++++++--------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 09b198e..d57a672 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -1007,23 +1007,34 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 	if (v_opcode == VIRTCHNL_OP_EVENT) {
 		struct virtchnl_pf_event *vpe =
 			(struct virtchnl_pf_event *)msg;
+		bool link_up = vpe->event_data.link_event.link_status;
 		switch (vpe->event) {
 		case VIRTCHNL_EVENT_LINK_CHANGE:
 			adapter->link_speed =
 				vpe->event_data.link_event.link_speed;
-			if (adapter->link_up !=
-			    vpe->event_data.link_event.link_status) {
-				adapter->link_up =
-					vpe->event_data.link_event.link_status;
-				if (adapter->link_up) {
-					netif_tx_start_all_queues(netdev);
-					netif_carrier_on(netdev);
-				} else {
-					netif_tx_stop_all_queues(netdev);
-					netif_carrier_off(netdev);
-				}
-				i40evf_print_link_message(adapter);
+
+			/* we've already got the right link status, bail */
+			if (adapter->link_up == link_up)
+				break;
+
+			/* If we get link up message and start queues before
+			 * our queues are configured it will trigger a TX hang.
+			 * In that case, just ignore the link status message,
+			 * we'll get another one after we enable queues and
+			 * actually prepared to send traffic.
+			 */
+			if (link_up && adapter->state != __I40EVF_RUNNING)
+				break;
+
+			adapter->link_up = link_up;
+			if (link_up) {
+				netif_tx_start_all_queues(netdev);
+				netif_carrier_on(netdev);
+			} else {
+				netif_tx_stop_all_queues(netdev);
+				netif_carrier_off(netdev);
 			}
+			i40evf_print_link_message(adapter);
 			break;
 		case VIRTCHNL_EVENT_RESET_IMPENDING:
 			dev_info(&adapter->pdev->dev, "PF reset warning received\n");
-- 
2.9.5


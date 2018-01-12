From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 12 Jan 2018 11:32:40 -0800
Subject: [Intel-wired-lan] [PATCH 01/12] i40evf: Fix link up issue when
 queues are disabled
Message-ID: <20180112193251.11739-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Avinash Dayanand <avinash.dayanand@intel.com>

One of the previous patch fixes the link up issue by ignoring it if
i40evf is not in __I40EVF_RUNNING state. However this doesn't fix the
race condition when queues are disabled esp for ADq on VF. Hence check
if all queues are enabled before starting all queues.

Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf.h         |  1 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  1 +
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 28 +++++++++++++++-------
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index b6991e8014d8..89ce2f9a0fbe 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -240,6 +240,7 @@ struct i40evf_adapter {
 #define I40EVF_FLAG_ALLMULTI_ON			BIT(14)
 #define I40EVF_FLAG_LEGACY_RX			BIT(15)
 #define I40EVF_FLAG_REINIT_ITR_NEEDED		BIT(16)
+#define I40EVF_FLAG_QUEUES_DISABLED		BIT(17)
 /* duplicates for common code */
 #define I40E_FLAG_DCB_ENABLED			0
 #define I40E_FLAG_RX_CSUM_ENABLED		I40EVF_FLAG_RX_CSUM_ENABLED
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 6fd09926181a..3014a5e3fbcc 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1895,6 +1895,7 @@ static void i40evf_reset_task(struct work_struct *work)
 	i40evf_free_all_rx_resources(adapter);
 	i40evf_free_all_tx_resources(adapter);
 
+	adapter->flags |= I40EVF_FLAG_QUEUES_DISABLED;
 	/* kill and reinit the admin queue */
 	i40evf_shutdown_adminq(hw);
 	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 82e6b115be87..9f8c007c1a99 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -1017,14 +1017,25 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 			if (adapter->link_up == link_up)
 				break;
 
-			/* If we get link up message and start queues before
-			 * our queues are configured it will trigger a TX hang.
-			 * In that case, just ignore the link status message,
-			 * we'll get another one after we enable queues and
-			 * actually prepared to send traffic.
-			 */
-			if (link_up && adapter->state != __I40EVF_RUNNING)
-				break;
+			if (link_up) {
+				/* If we get link up message and start queues
+				 * before our queues are configured it will
+				 * trigger a TX hang. In that case, just ignore
+				 * the link status message,we'll get another one
+				 * after we enable queues and actually prepared
+				 * to send traffic.
+				 */
+				if (adapter->state != __I40EVF_RUNNING)
+					break;
+
+				/* For ADq enabled VF, we reconfigure VSIs and
+				 * re-allocate queues. Hence wait till all
+				 * queues are enabled.
+				 */
+				if (adapter->flags &
+				    I40EVF_FLAG_QUEUES_DISABLED)
+					break;
+			}
 
 			adapter->link_up = link_up;
 			if (link_up) {
@@ -1108,6 +1119,7 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 	case VIRTCHNL_OP_ENABLE_QUEUES:
 		/* enable transmits */
 		i40evf_irq_enable(adapter, true);
+		adapter->flags &= ~I40EVF_FLAG_QUEUES_DISABLED;
 		break;
 	case VIRTCHNL_OP_DISABLE_QUEUES:
 		i40evf_free_all_tx_resources(adapter);
-- 
2.14.3


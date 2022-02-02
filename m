From: Michal Maloszewski <michal.maloszewski@intel.com>
Date: Wed,  2 Feb 2022 12:44:54 +0000
Subject: [Intel-wired-lan] [PATCH net v2] iavf: Fix adopting new combined
 setting
Message-ID: <20220202124454.28902-1-michal.maloszewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In some cases overloaded flag IAVF_FLAG_REINIT_ITR_NEEDED
which should indicate that interrupts need to be completety
reinitialized during reset leads to RTNL deadlocks using ethtool -C
while a reset is in progress.
To fix, it was added a new flag IAVF_FLAG_REINIT_MSIX_NEEDED
used to trigger MSI-X reinit.
New combined setting is fixed adopt after VF reset.
This has been implemented by call reinit interrupt scheme
during VF reset.
Without this fix new combined setting has never been adopted.

Fixes: 209f2f9c7181 ("iavf: Add support for VIRTCHNL_VF_OFFLOAD_VLAN_V2 negotiation")
Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
---
v2: Changed the fixes tag and made commit message more detailed
---
---
 drivers/net/ethernet/intel/iavf/iavf.h      |  1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c | 13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index bb8f9740e776..f1849f3a2ace 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -282,6 +282,7 @@ struct iavf_adapter {
 #define IAVF_FLAG_LEGACY_RX			BIT(15)
 #define IAVF_FLAG_REINIT_ITR_NEEDED		BIT(16)
 #define IAVF_FLAG_QUEUES_DISABLED		BIT(17)
+#define IAVF_FLAG_REINIT_MSIX_NEEDED		BIT(20)
 /* duplicates for common code */
 #define IAVF_FLAG_DCB_ENABLED			0
 	/* flags for admin queue service task */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 929744802af0..caacac4ac66d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2110,7 +2110,7 @@ int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter)
 			"Requested %d queues, but PF only gave us %d.\n",
 			num_req_queues,
 			adapter->vsi_res->num_queue_pairs);
-		adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
+		adapter->flags |= IAVF_FLAG_REINIT_MSIX_NEEDED;
 		adapter->num_req_queues = adapter->vsi_res->num_queue_pairs;
 		iavf_schedule_reset(adapter);
 
@@ -2691,7 +2691,8 @@ static void iavf_reset_task(struct work_struct *work)
 			 err);
 	adapter->aq_required = 0;
 
-	if (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED) {
+	if ((adapter->flags & IAVF_FLAG_REINIT_MSIX_NEEDED) ||
+	    (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED)) {
 		err = iavf_reinit_interrupt_scheme(adapter);
 		if (err)
 			goto reset_err;
@@ -2763,12 +2764,13 @@ static void iavf_reset_task(struct work_struct *work)
 		if (err)
 			goto reset_err;
 
-		if (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED) {
+		if ((adapter->flags & IAVF_FLAG_REINIT_MSIX_NEEDED) ||
+		    (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED)) {
 			err = iavf_request_traffic_irqs(adapter, netdev->name);
 			if (err)
 				goto reset_err;
 
-			adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
+			adapter->flags &= ~IAVF_FLAG_REINIT_MSIX_NEEDED;
 		}
 
 		iavf_configure(adapter);
@@ -2783,6 +2785,9 @@ static void iavf_reset_task(struct work_struct *work)
 		iavf_change_state(adapter, __IAVF_DOWN);
 		wake_up(&adapter->down_waitqueue);
 	}
+
+	adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
+
 	mutex_unlock(&adapter->client_lock);
 	mutex_unlock(&adapter->crit_lock);
 
-- 
2.27.0


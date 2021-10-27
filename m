From: Michal Maloszewski <michal.maloszewski@intel.com>
Date: Wed, 27 Oct 2021 15:51:56 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix adopting new combined
 setting
Message-ID: <20211027155156.54453-1-michal.maloszewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

New combined setting is fixed adopt after VF reset.
This has been implemented by call reinit interrupt scheme
during VF reset.
Without this fix new combined setting has never been adopted.

Fixes: 129cf89e5856 ("iavf: rename functions and structs to new name")
Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 80437ef26..355f98924 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2233,7 +2233,8 @@ continue_reset:
 			 err);
 	adapter->aq_required = 0;
 
-	if (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED) {
+	if ((adapter->flags & IAVF_FLAG_REINIT_MSIX_NEEDED) ||
+	    (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED)) {
 		err = iavf_reinit_interrupt_scheme(adapter);
 		if (err)
 			goto reset_err;
@@ -2304,10 +2305,11 @@ continue_reset:
 		if (err)
 			goto reset_err;
 
-		if (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED) {
-			err = iavf_request_traffic_irqs(adapter, netdev->name);
-			if (err)
-				goto reset_err;
+	if ((adapter->flags & IAVF_FLAG_REINIT_MSIX_NEEDED) ||
+	    (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED)) {
+		err = iavf_request_traffic_irqs(adapter, netdev->name);
+		if (err)
+			goto reset_err;
 
 			adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
 		}
@@ -2321,6 +2323,8 @@ continue_reset:
 		adapter->state = __IAVF_DOWN;
 		wake_up(&adapter->down_waitqueue);
 	}
+
+	adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
 	mutex_unlock(&adapter->client_lock);
 	mutex_unlock(&adapter->crit_lock);
 
-- 
2.27.0


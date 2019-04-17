From: Alice Michael <alice.michael@intel.com>
Date: Wed, 17 Apr 2019 15:17:37 -0700
Subject: [Intel-wired-lan] [next PATCH S4 iavf 9/9] iavf: update comments
 and file checks to match iavf
In-Reply-To: <20190417221737.11460-1-alice.michael@intel.com>
References: <20190417221737.11460-1-alice.michael@intel.com>
Message-ID: <20190417221737.11460-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Some small things were missed with recent name changes
from i40e to iavf.  Having a seperate patch allows to
correct the small misses in one place.

Signed-off-by: Alice Michael <alice.michael@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_client.c   | 4 ++--
 drivers/net/ethernet/intel/iavf/iavf_common.c   | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_trace.h    | 4 ++--
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_client.c b/drivers/net/ethernet/intel/iavf/iavf_client.c
index bd076c98c228..f61ac95d0802 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_client.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_client.c
@@ -498,7 +498,7 @@ static int iavf_client_setup_qvlist(struct iavf_info *ldev,
 }
 
 /**
- * iavf_register_client - Register a i40e client driver with the L2 driver
+ * iavf_register_client - Register a iavf client driver with the L2 driver
  * @client: pointer to the iavf_client  struct
  *
  * Returns 0 on success or non-0 on error
@@ -549,7 +549,7 @@ int iavf_register_client(struct iavf_client  *client)
 EXPORT_SYMBOL(iavf_register_client);
 
 /**
- * iavf_unregister_client - Unregister a i40e client driver with the L2 driver
+ * iavf_unregister_client - Unregister a iavf client driver with the L2 driver
  * @client: pointer to the iavf_client  struct
  *
  * Returns 0 on success or non-0 on error
diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c b/drivers/net/ethernet/intel/iavf/iavf_common.c
index 05ae5ce06537..8547fc8fdfd6 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_common.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
@@ -515,7 +515,7 @@ enum iavf_status iavf_aq_set_rss_key(struct iavf_hw *hw, u16 vsi_id,
  * IF NOT iavf_ptype_lookup[ptype].known
  * THEN
  *      Packet is unknown
- * ELSE IF iavf_ptype_lookup[ptype].outer_ip == I40E_RX_PTYPE_OUTER_IP
+ * ELSE IF iavf_ptype_lookup[ptype].outer_ip == IAVF_RX_PTYPE_OUTER_IP
  *      Use the rest of the fields to look at the tunnels, inner protocols, etc
  * ELSE
  *      Use the enum iavf_rx_l2_ptype to decode the packet type
diff --git a/drivers/net/ethernet/intel/iavf/iavf_trace.h b/drivers/net/ethernet/intel/iavf/iavf_trace.h
index 1474f5539751..1058e68a02b4 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_trace.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_trace.h
@@ -17,8 +17,8 @@
 /* See trace-events-sample.h for a detailed description of why this
  * guard clause is different from most normal include files.
  */
-#if !defined(_I40E_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
-#define _I40E_TRACE_H_
+#if !defined(_IAVF_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
+#define _IAVF_TRACE_H_
 
 #include <linux/tracepoint.h>
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index b9f73154dcee..3eea35cee25a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -41,7 +41,7 @@ static int iavf_send_pf_msg(struct iavf_adapter *adapter,
  *
  * Send API version admin queue message to the PF. The reply is not checked
  * in this function. Returns 0 if the message was successfully
- * sent, or one of the I40E_ADMIN_QUEUE_ERROR_ statuses if not.
+ * sent, or one of the IAVF_ADMIN_QUEUE_ERROR_ statuses if not.
  **/
 int iavf_send_api_ver(struct iavf_adapter *adapter)
 {
@@ -123,7 +123,7 @@ int iavf_verify_api_ver(struct iavf_adapter *adapter)
  *
  * Send VF configuration request admin queue message to the PF. The reply
  * is not checked in this function. Returns 0 if the message was
- * successfully sent, or one of the I40E_ADMIN_QUEUE_ERROR_ statuses if not.
+ * successfully sent, or one of the IAVF_ADMIN_QUEUE_ERROR_ statuses if not.
  **/
 int iavf_send_vf_config_msg(struct iavf_adapter *adapter)
 {
-- 
2.19.2


From: Alice Michael <alice.michael@intel.com>
Date: Fri, 26 Oct 2018 14:33:30 -0700
Subject: [Intel-wired-lan] [next PATCH S98 3/6] virtchnl: white space and
 reorder
In-Reply-To: <20181026213333.51495-1-alice.michael@intel.com>
References: <20181026213333.51495-1-alice.michael@intel.com>
Message-ID: <20181026213333.51495-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

White space change.

Move the check on the virtchnl_vsi_queue_config_info struct
to be close to the struct like all the other similar checks.
This keeps it clearer and easier to read.

Signed-off-by: Alice Michael <alice.michael@intel.com>
---
 include/linux/avf/virtchnl.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index b248805..3130dec 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -171,7 +171,7 @@ struct virtchnl_msg {
 
 VIRTCHNL_CHECK_STRUCT_LEN(20, virtchnl_msg);
 
-/* Message descriptions and data structures.*/
+/* Message descriptions and data structures. */
 
 /* VIRTCHNL_OP_VERSION
  * VF posts its version number to the PF. PF responds with its version number
@@ -342,6 +342,8 @@ struct virtchnl_vsi_queue_config_info {
 	struct virtchnl_queue_pair_info qpair[1];
 };
 
+VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_vsi_queue_config_info);
+
 /* VIRTCHNL_OP_REQUEST_QUEUES
  * VF sends this message to request the PF to allocate additional queues to
  * this VF.  Each VF gets a guaranteed number of queues on init but asking for
@@ -357,8 +359,6 @@ struct virtchnl_vf_res_request {
 	u16 num_queue_pairs;
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_vsi_queue_config_info);
-
 /* VIRTCHNL_OP_CONFIG_IRQ_MAP
  * VF uses this message to map vectors to queues.
  * The rxq_map and txq_map fields are bitmaps used to indicate which queues
-- 
2.9.5


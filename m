From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 11 May 2017 11:23:18 -0700
Subject: [Intel-wired-lan] [PATCH net-next v3 11/14] virtchnl: Add pad
	fields to a couple of structures
In-Reply-To: <20170511182321.147850-1-jesse.brandeburg@intel.com>
References: <20170511182321.147850-1-jesse.brandeburg@intel.com>
Message-ID: <20170511182321.147850-12-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sridhar Samudrala <sridhar.samudrala@intel.com>

This removes holes and makes structure sizes consistent across
32 and 64 bit builds.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 include/linux/avf/virtchnl.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index dab76e9..72466c6 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -275,8 +275,10 @@ struct virtchnl_rxq_info {
 	u16 splithdr_enabled; /* deprecated with AVF 1.0 */
 	u32 databuffer_size;
 	u32 max_pkt_size;
+	u32 pad1;
 	u64 dma_ring_addr;
 	enum virtchnl_rx_hsplit rx_split_pos; /* deprecated with AVF 1.0 */
+	u32 pad2;
 };
 
 /* VIRTCHNL_OP_CONFIG_VSI_QUEUES
@@ -295,6 +297,7 @@ struct virtchnl_queue_pair_info {
 struct virtchnl_vsi_queue_config_info {
 	u16 vsi_id;
 	u16 num_queue_pairs;
+	u32 pad;
 	struct virtchnl_queue_pair_info qpair[1];
 };
 
-- 
2.9.3


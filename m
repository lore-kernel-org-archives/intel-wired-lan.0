From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed,  3 May 2017 19:51:55 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 11/13] virtchnl: Add pad
	fields to a couple of structures
In-Reply-To: <20170504025157.71107-1-jeffrey.t.kirsher@intel.com>
References: <20170504025157.71107-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20170504025157.71107-12-jeffrey.t.kirsher@intel.com>
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

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 3f15d6a..ea34154 100644
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
1.8.3.1


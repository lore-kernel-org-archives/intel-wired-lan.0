From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Sep 2018 17:42:53 -0700
Subject: [Intel-wired-lan] [PATCH v2 01/16] virtchnl: Added support to
 exchange additional speed values
In-Reply-To: <20180920004308.13772-1-anirudh.venkataramanan@intel.com>
References: <20180920004308.13772-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180920004308.13772-2-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Yashaswini Raghuram Prathivadi Bhayankaram <yashaswini.raghuram.prathivadi.bhayankaram@intel.com>

Introduced a new virtchnl capability flag and a struct to support exchange
of additional supported speeds.

Signed-off-by: Yashaswini Raghuram Prathivadi Bhayankaram <yashaswini.raghuram.prathivadi.bhayankaram@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 include/linux/avf/virtchnl.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index b41f7bc958ef..2c9756bd9c4c 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -252,6 +252,8 @@ VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_vsi_resource);
 #define VIRTCHNL_VF_OFFLOAD_RX_ENCAP_CSUM	0X00400000
 #define VIRTCHNL_VF_OFFLOAD_ADQ			0X00800000
 
+/* Define below the capability flags that are not offloads */
+#define VIRTCHNL_VF_CAP_ADV_LINK_SPEED		0x00000080
 #define VF_BASE_MODE_OFFLOADS (VIRTCHNL_VF_OFFLOAD_L2 | \
 			       VIRTCHNL_VF_OFFLOAD_VLAN | \
 			       VIRTCHNL_VF_OFFLOAD_RSS_PF)
@@ -596,10 +598,23 @@ enum virtchnl_event_codes {
 struct virtchnl_pf_event {
 	enum virtchnl_event_codes event;
 	union {
+		/* If the PF driver does not support the new speed reporting
+		 * capabilities then use link_event else use link_event_adv to
+		 * get the speed and link information. The ability to understand
+		 * new speeds is indicated by setting the capability flag
+		 * VIRTCHNL_VF_CAP_ADV_LINK_SPEED in vf_cap_flags parameter
+		 * in virtchnl_vf_resource struct and can be used to determine
+		 * which link event struct to use below.
+		 */
 		struct {
 			enum virtchnl_link_speed link_speed;
 			bool link_status;
 		} link_event;
+		struct {
+			/* link_speed provided in Mbps */
+			u32 link_speed;
+			u8 link_status;
+		} link_event_adv;
 	} event_data;
 
 	int severity;
-- 
2.14.3


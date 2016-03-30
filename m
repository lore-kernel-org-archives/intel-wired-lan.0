From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Wed, 30 Mar 2016 03:49:45 -0700
Subject: [Intel-wired-lan] [v2 next PATCH S32 10/13] i40e: Add RSS
	configuration to virtual channel
In-Reply-To: <1459334988-19951-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459334988-19951-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1459334988-19951-11-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Add opcodes and structures to support RSS configuration by PF driver on
behalf of the VF drivers. This reduces complexity in the VF driver and
allows us to support future hardware designs without modifying the VF
driver.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I8c75765c630eacb71f95967f1109a198542593ac
---
Testing Hints : Compile code and make sure
there are no warnings. There's no actual code here.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h   | 45 +++++++++++++++++++++--
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h | 45 +++++++++++++++++++++--
 2 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
index ab866cf..ac4559e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
@@ -80,10 +80,15 @@ enum i40e_virtchnl_ops {
 	I40E_VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE = 14,
 	I40E_VIRTCHNL_OP_GET_STATS = 15,
 	I40E_VIRTCHNL_OP_FCOE = 16,
-	I40E_VIRTCHNL_OP_EVENT = 17,
+	I40E_VIRTCHNL_OP_EVENT = 17, /* must ALWAYS be 17 */
 	I40E_VIRTCHNL_OP_IWARP = 20,
 	I40E_VIRTCHNL_OP_CONFIG_IWARP_IRQ_MAP = 21,
 	I40E_VIRTCHNL_OP_RELEASE_IWARP_IRQ_MAP = 22,
+	I40E_VIRTCHNL_OP_CONFIG_RSS_KEY = 23,
+	I40E_VIRTCHNL_OP_CONFIG_RSS_LUT = 24,
+	I40E_VIRTCHNL_OP_GET_RSS_HENA_CAPS = 25,
+	I40E_VIRTCHNL_OP_SET_RSS_HENA = 26,
+
 };
 
 /* Virtual channel message descriptor. This overlays the admin queue
@@ -157,6 +162,7 @@ struct i40e_virtchnl_vsi_resource {
 #define I40E_VIRTCHNL_VF_OFFLOAD_VLAN		0x00010000
 #define I40E_VIRTCHNL_VF_OFFLOAD_RX_POLLING	0x00020000
 #define I40E_VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2	0x00040000
+#define I40E_VIRTCHNL_VF_OFFLOAD_RSS_PF		0X00080000
 
 struct i40e_virtchnl_vf_resource {
 	u16 num_vsis;
@@ -165,8 +171,8 @@ struct i40e_virtchnl_vf_resource {
 	u16 max_mtu;
 
 	u32 vf_offload_flags;
-	u32 max_fcoe_contexts;
-	u32 max_fcoe_filters;
+	u32 rss_key_size;
+	u32 rss_lut_size;
 
 	struct i40e_virtchnl_vsi_resource vsi_res[1];
 };
@@ -325,6 +331,39 @@ struct i40e_virtchnl_promisc_info {
  * PF replies with struct i40e_eth_stats in an external buffer.
  */
 
+/* I40E_VIRTCHNL_OP_CONFIG_RSS_KEY
+ * I40E_VIRTCHNL_OP_CONFIG_RSS_LUT
+ * VF sends these messages to configure RSS. Only supported if both PF
+ * and VF drivers set the I40E_VIRTCHNL_VF_OFFLOAD_RSS_PF bit during
+ * configuration negotiation. If this is the case, then the rss fields in
+ * the vf resource struct are valid.
+ * Both the key and LUT are initialized to 0 by the PF, meaning that
+ * RSS is effectively disabled until set up by the VF.
+ */
+struct i40e_virtchnl_rss_key {
+	u16 vsi_id;
+	u16 key_len;
+	u8 key[1];         /* RSS hash key, packed bytes */
+};
+
+struct i40e_virtchnl_rss_lut {
+	u16 vsi_id;
+	u16 lut_entries;
+	u8 lut[1];        /* RSS lookup table*/
+};
+
+/* I40E_VIRTCHNL_OP_GET_RSS_HENA_CAPS
+ * I40E_VIRTCHNL_OP_SET_RSS_HENA
+ * VF sends these messages to get and set the hash filter enable bits for RSS.
+ * By default, the PF sets these to all possible traffic types that the
+ * hardware supports. The VF can query this value if it wants to change the
+ * traffic types that are hashed by the hardware.
+ * Traffic types are defined in the i40e_filter_pctype enum in i40e_type.h
+ */
+struct i40e_virtchnl_rss_hena {
+	u64 hena;
+};
+
 /* I40E_VIRTCHNL_OP_EVENT
  * PF sends this message to inform the VF driver of events that may affect it.
  * No direct response is expected from the VF, though it may generate other
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
index 3b9d203..ce0b3f7 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
@@ -80,7 +80,12 @@ enum i40e_virtchnl_ops {
 	I40E_VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE = 14,
 	I40E_VIRTCHNL_OP_GET_STATS = 15,
 	I40E_VIRTCHNL_OP_FCOE = 16,
-	I40E_VIRTCHNL_OP_EVENT = 17,
+	I40E_VIRTCHNL_OP_EVENT = 17, /* must ALWAYS be 17 */
+	I40E_VIRTCHNL_OP_CONFIG_RSS_KEY = 23,
+	I40E_VIRTCHNL_OP_CONFIG_RSS_LUT = 24,
+	I40E_VIRTCHNL_OP_GET_RSS_HENA_CAPS = 25,
+	I40E_VIRTCHNL_OP_SET_RSS_HENA = 26,
+
 };
 
 /* Virtual channel message descriptor. This overlays the admin queue
@@ -154,6 +159,7 @@ struct i40e_virtchnl_vsi_resource {
 #define I40E_VIRTCHNL_VF_OFFLOAD_VLAN		0x00010000
 #define I40E_VIRTCHNL_VF_OFFLOAD_RX_POLLING	0x00020000
 #define I40E_VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2	0x00040000
+#define I40E_VIRTCHNL_VF_OFFLOAD_RSS_PF		0X00080000
 
 struct i40e_virtchnl_vf_resource {
 	u16 num_vsis;
@@ -162,8 +168,8 @@ struct i40e_virtchnl_vf_resource {
 	u16 max_mtu;
 
 	u32 vf_offload_flags;
-	u32 max_fcoe_contexts;
-	u32 max_fcoe_filters;
+	u32 rss_key_size;
+	u32 rss_lut_size;
 
 	struct i40e_virtchnl_vsi_resource vsi_res[1];
 };
@@ -322,6 +328,39 @@ struct i40e_virtchnl_promisc_info {
  * PF replies with struct i40e_eth_stats in an external buffer.
  */
 
+/* I40E_VIRTCHNL_OP_CONFIG_RSS_KEY
+ * I40E_VIRTCHNL_OP_CONFIG_RSS_LUT
+ * VF sends these messages to configure RSS. Only supported if both PF
+ * and VF drivers set the I40E_VIRTCHNL_VF_OFFLOAD_RSS_PF bit during
+ * configuration negotiation. If this is the case, then the rss fields in
+ * the vf resource struct are valid.
+ * Both the key and LUT are initialized to 0 by the PF, meaning that
+ * RSS is effectively disabled until set up by the VF.
+ */
+struct i40e_virtchnl_rss_key {
+	u16 vsi_id;
+	u16 key_len;
+	u8 key[1];         /* RSS hash key, packed bytes */
+};
+
+struct i40e_virtchnl_rss_lut {
+	u16 vsi_id;
+	u16 lut_entries;
+	u8 lut[1];        /* RSS lookup table*/
+};
+
+/* I40E_VIRTCHNL_OP_GET_RSS_HENA_CAPS
+ * I40E_VIRTCHNL_OP_SET_RSS_HENA
+ * VF sends these messages to get and set the hash filter enable bits for RSS.
+ * By default, the PF sets these to all possible traffic types that the
+ * hardware supports. The VF can query this value if it wants to change the
+ * traffic types that are hashed by the hardware.
+ * Traffic types are defined in the i40e_filter_pctype enum in i40e_type.h
+ */
+struct i40e_virtchnl_rss_hena {
+	u64 hena;
+};
+
 /* I40E_VIRTCHNL_OP_EVENT
  * PF sends this message to inform the VF driver of events that may affect it.
  * No direct response is expected from the VF, though it may generate other
-- 
2.4.3


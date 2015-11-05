From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  5 Nov 2015 13:37:38 -0800
Subject: [Intel-wired-lan] [PATCH v2] fm10k: correctly pack TLV structures
	and explain reasoning
Message-ID: <1446759458-2873-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use of __packed for the TLV structures is not correct, as we actually
need them to be 4byte aligned and packed, so use __attribute__(packed,
aligned(4)). Also add an explanatory comment as to why this is
necessary to prevent issues with the mailbox API.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
- v2
* Use packed, aligned(4)

 drivers/net/ethernet/intel/fm10k/fm10k_pf.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.h b/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
index a8fc512a2416..2bc69b4bbbee 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
@@ -74,6 +74,11 @@ enum fm10k_pf_tlv_attr_id_v1 {
 #define FM10K_MSG_UPDATE_PVID_PVID_SHIFT	16
 #define FM10K_MSG_UPDATE_PVID_PVID_SIZE		16
 
+/* The following data structures are overlayed directly onto TLV mailbox
+ * messages, and must not break 4 byte alignment. Ensure the structures line
+ * up correctly as per their TLV definition.
+ */
+
 struct fm10k_mac_update {
 	__le32	mac_lower;
 	__le16	mac_upper;
@@ -81,26 +86,26 @@ struct fm10k_mac_update {
 	__le16	glort;
 	u8	flags;
 	u8	action;
-} __packed;
+} __attritbute__((packed, aligned(4));
 
 struct fm10k_global_table_data {
 	__le32	used;
 	__le32	avail;
-} __packed;
+} __attritbute__((packed, aligned(4));
 
 struct fm10k_swapi_error {
 	__le32				status;
 	struct fm10k_global_table_data	mac;
 	struct fm10k_global_table_data	nexthop;
 	struct fm10k_global_table_data	ffu;
-} __packed;
+} __attritbute__((packed, aligned(4));
 
 struct fm10k_swapi_1588_timestamp {
 	__le64 egress;
 	__le64 ingress;
 	__le16 dglort;
 	__le16 sglort;
-} __packed;
+} __attritbute__((packed, aligned(4));
 
 s32 fm10k_msg_lport_map_pf(struct fm10k_hw *, u32 **, struct fm10k_mbx_info *);
 extern const struct fm10k_tlv_attr fm10k_lport_map_msg_attr[];
-- 
2.6.1.264.gbab76a9


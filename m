From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 Jun 2015 16:31:09 -0700
Subject: [Intel-wired-lan] [rc2 12/15] fm10k: pack TLV overlay structures
In-Reply-To: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
References: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1433374272-6684-13-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds the __attribute__((packed)) indicator to some structures
which are overlayed onto a TLV message. These structures must be packed
as small as possible in order to correctly align when copied into the
mailbox buffer. Without doing so, the receiving mailbox code incorrectly
parses the values and we get invalid message responses from the switch
manager software.

-rc2
* use __packed instead of __attribute__((packed))

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.h b/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
index 7ab1db4fff32..40a0dbc62a04 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
@@ -81,26 +81,26 @@ struct fm10k_mac_update {
 	__le16	glort;
 	u8	flags;
 	u8	action;
-};
+} __packed;
 
 struct fm10k_global_table_data {
 	__le32	used;
 	__le32	avail;
-};
+} __packed;
 
 struct fm10k_swapi_error {
 	__le32				status;
 	struct fm10k_global_table_data	mac;
 	struct fm10k_global_table_data	nexthop;
 	struct fm10k_global_table_data	ffu;
-};
+} __packed;
 
 struct fm10k_swapi_1588_timestamp {
 	__le64 egress;
 	__le64 ingress;
 	__le16 dglort;
 	__le16 sglort;
-};
+} __packed;
 
 s32 fm10k_msg_lport_map_pf(struct fm10k_hw *, u32 **, struct fm10k_mbx_info *);
 extern const struct fm10k_tlv_attr fm10k_lport_map_msg_attr[];
-- 
2.1.0


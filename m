From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue,  3 Nov 2015 11:32:34 -0800
Subject: [Intel-wired-lan] [next-queue] fm10k: explain why we need __packed
	on some TLV structures
Message-ID: <1446579154-1112-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add an explanatory comment about the __packed attribute on these
structures due to TLV data layout requirements.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.h b/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
index a8fc512a2416..661a4062b756 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
@@ -74,6 +74,11 @@ enum fm10k_pf_tlv_attr_id_v1 {
 #define FM10K_MSG_UPDATE_PVID_PVID_SHIFT	16
 #define FM10K_MSG_UPDATE_PVID_PVID_SIZE		16
 
+/* The following data structures are overlayed specifically to TLV mailbox
+ * messages, and must not have gaps between their values. They must line up
+ * correctly to the TLV definition.
+ */
+
 struct fm10k_mac_update {
 	__le32	mac_lower;
 	__le16	mac_upper;
-- 
2.6.1.264.gbab76a9


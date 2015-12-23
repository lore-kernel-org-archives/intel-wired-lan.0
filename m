From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Wed, 23 Dec 2015 12:05:41 -0800
Subject: [Intel-wired-lan] [next PATCH S25 01/16] i40e: AQ Shared resource
	flags
In-Reply-To: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450901156-30904-2-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Add flags to MAC allocation requests to signify that the macvlan filters
should come from the shared resource pool rather than the dedicated PF
resource pools.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Acked-by: Kevin Scott <kevin.c.scott@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Change-ID: I4c2da64c01856edcb0982bc4aab75c5a91047a7a
---
Testing-Hints:
Apply and compile cleanly.

 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 5 +++++
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 0e608d2..6e0834e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -976,6 +976,7 @@ struct i40e_aqc_add_macvlan_element_data {
 #define I40E_AQC_MACVLAN_ADD_HASH_MATCH		0x0002
 #define I40E_AQC_MACVLAN_ADD_IGNORE_VLAN	0x0004
 #define I40E_AQC_MACVLAN_ADD_TO_QUEUE		0x0008
+#define I40E_AQC_MACVLAN_ADD_USE_SHARED_MAC	0x0010
 	__le16	queue_number;
 #define I40E_AQC_MACVLAN_CMD_QUEUE_SHIFT	0
 #define I40E_AQC_MACVLAN_CMD_QUEUE_MASK		(0x7FF << \
@@ -1265,6 +1266,10 @@ struct i40e_aqc_add_remove_cloud_filters_element_data {
 #define I40E_AQC_ADD_CLOUD_TNL_TYPE_GENEVE		2
 #define I40E_AQC_ADD_CLOUD_TNL_TYPE_IP			3
 
+#define I40E_AQC_ADD_CLOUD_FLAGS_SHARED_OUTER_MAC	0x2000
+#define I40E_AQC_ADD_CLOUD_FLAGS_SHARED_INNER_MAC	0x4000
+#define I40E_AQC_ADD_CLOUD_FLAGS_SHARED_OUTER_IP	0x8000
+
 	__le32	tenant_id;
 	u8	reserved[4];
 	__le16	queue_number;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index 578b178..220b972 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -973,6 +973,7 @@ struct i40e_aqc_add_macvlan_element_data {
 #define I40E_AQC_MACVLAN_ADD_HASH_MATCH		0x0002
 #define I40E_AQC_MACVLAN_ADD_IGNORE_VLAN	0x0004
 #define I40E_AQC_MACVLAN_ADD_TO_QUEUE		0x0008
+#define I40E_AQC_MACVLAN_ADD_USE_SHARED_MAC	0x0010
 	__le16	queue_number;
 #define I40E_AQC_MACVLAN_CMD_QUEUE_SHIFT	0
 #define I40E_AQC_MACVLAN_CMD_QUEUE_MASK		(0x7FF << \
@@ -1262,6 +1263,10 @@ struct i40e_aqc_add_remove_cloud_filters_element_data {
 #define I40E_AQC_ADD_CLOUD_TNL_TYPE_GENEVE		2
 #define I40E_AQC_ADD_CLOUD_TNL_TYPE_IP			3
 
+#define I40E_AQC_ADD_CLOUD_FLAGS_SHARED_OUTER_MAC	0x2000
+#define I40E_AQC_ADD_CLOUD_FLAGS_SHARED_INNER_MAC	0x4000
+#define I40E_AQC_ADD_CLOUD_FLAGS_SHARED_OUTER_IP	0x8000
+
 	__le32	tenant_id;
 	u8	reserved[4];
 	__le16	queue_number;
-- 
2.1.0


From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  4 Jun 2015 16:23:55 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 1/8] i40e: add
	VF capabilities to virtual channel interface
In-Reply-To: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
References: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1433449442-31420-2-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

To prepare for the changes coming up in the X722 device and future
devices, the virtual channel interface has to change slightly. The VF
driver can now report what its capable of supporting, which then informs
the PF driver when it sends the configuration information back to the
VF.

A 1.1 VF driver on a 1.0 PF driver should not send its capabilities.
Likewise, a 1.1 PF driver controlling a 1.0 VF driver should not expect
or depend upon receiving the VF capabilities.

All other aspects of the API are unchanged.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Acked-by: Shannon Nelson <shannon.nelson@intel.com>
Acked-by: Anjali Singhai <anjali.singhai@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Change-ID: I530cc55f107edd1ee8bdf95830aa90b87854058a
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h   | 16 +++++++++++-----
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h | 16 +++++++++++-----
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
index 2d20af2..a7ab463 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
@@ -110,7 +110,9 @@ struct i40e_virtchnl_msg {
  * error regardless of version mismatch.
  */
 #define I40E_VIRTCHNL_VERSION_MAJOR		1
-#define I40E_VIRTCHNL_VERSION_MINOR		0
+#define I40E_VIRTCHNL_VERSION_MINOR		1
+#define I40E_VIRTCHNL_VERSION_MINOR_NO_VF_CAPS	0
+
 struct i40e_virtchnl_version_info {
 	u32 major;
 	u32 minor;
@@ -129,7 +131,8 @@ struct i40e_virtchnl_version_info {
  */
 
 /* I40E_VIRTCHNL_OP_GET_VF_RESOURCES
- * VF sends this request to PF with no parameters
+ * Version 1.0 VF sends this request to PF with no parameters
+ * Version 1.1 VF sends this request to PF with u32 bitmap of its capabilities
  * PF responds with an indirect message containing
  * i40e_virtchnl_vf_resource and one or more
  * i40e_virtchnl_vsi_resource structures.
@@ -143,9 +146,12 @@ struct i40e_virtchnl_vsi_resource {
 	u8 default_mac_addr[ETH_ALEN];
 };
 /* VF offload flags */
-#define I40E_VIRTCHNL_VF_OFFLOAD_L2	0x00000001
-#define I40E_VIRTCHNL_VF_OFFLOAD_FCOE	0x00000004
-#define I40E_VIRTCHNL_VF_OFFLOAD_VLAN	0x00010000
+#define I40E_VIRTCHNL_VF_OFFLOAD_L2		0x00000001
+#define I40E_VIRTCHNL_VF_OFFLOAD_IWARP		0x00000002
+#define I40E_VIRTCHNL_VF_OFFLOAD_FCOE		0x00000004
+#define I40E_VIRTCHNL_VF_OFFLOAD_RSS_AQ		0x00000008
+#define I40E_VIRTCHNL_VF_OFFLOAD_RSS_REG	0x00000010
+#define I40E_VIRTCHNL_VF_OFFLOAD_VLAN		0x00010000
 
 struct i40e_virtchnl_vf_resource {
 	u16 num_vsis;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
index 59f62f0..1e89dea 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
@@ -110,7 +110,9 @@ struct i40e_virtchnl_msg {
  * error regardless of version mismatch.
  */
 #define I40E_VIRTCHNL_VERSION_MAJOR		1
-#define I40E_VIRTCHNL_VERSION_MINOR		0
+#define I40E_VIRTCHNL_VERSION_MINOR		1
+#define I40E_VIRTCHNL_VERSION_MINOR_NO_VF_CAPS	0
+
 struct i40e_virtchnl_version_info {
 	u32 major;
 	u32 minor;
@@ -129,7 +131,8 @@ struct i40e_virtchnl_version_info {
  */
 
 /* I40E_VIRTCHNL_OP_GET_VF_RESOURCES
- * VF sends this request to PF with no parameters
+ * Version 1.0 VF sends this request to PF with no parameters
+ * Version 1.1 VF sends this request to PF with u32 bitmap of its capabilities
  * PF responds with an indirect message containing
  * i40e_virtchnl_vf_resource and one or more
  * i40e_virtchnl_vsi_resource structures.
@@ -143,9 +146,12 @@ struct i40e_virtchnl_vsi_resource {
 	u8 default_mac_addr[ETH_ALEN];
 };
 /* VF offload flags */
-#define I40E_VIRTCHNL_VF_OFFLOAD_L2	0x00000001
-#define I40E_VIRTCHNL_VF_OFFLOAD_FCOE	0x00000004
-#define I40E_VIRTCHNL_VF_OFFLOAD_VLAN	0x00010000
+#define I40E_VIRTCHNL_VF_OFFLOAD_L2		0x00000001
+#define I40E_VIRTCHNL_VF_OFFLOAD_IWARP		0x00000002
+#define I40E_VIRTCHNL_VF_OFFLOAD_FCOE		0x00000004
+#define I40E_VIRTCHNL_VF_OFFLOAD_RSS_AQ		0x00000008
+#define I40E_VIRTCHNL_VF_OFFLOAD_RSS_REG	0x00000010
+#define I40E_VIRTCHNL_VF_OFFLOAD_VLAN		0x00010000
 
 struct i40e_virtchnl_vf_resource {
 	u16 num_vsis;
-- 
1.9.3


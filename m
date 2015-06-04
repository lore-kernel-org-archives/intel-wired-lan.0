From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  4 Jun 2015 16:23:56 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 2/8]
	i40e/i40evf: add macros for virtual channel API version and
	device capability
In-Reply-To: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
References: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1433449442-31420-3-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Now that we've rolled the virtual channel API version to 1.1, add some
macros to test what version is being used by our partner in crime. For the
VF, add some macros to determine what our device capabilities are.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I79f6683d4c23bd76a8ad9fd492776fcc1208e1dc
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 3 +++
 drivers/net/ethernet/intel/i40evf/i40evf.h         | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 09043c1..d254a5e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -42,6 +42,9 @@
 #define I40E_VLAN_MASK			0xFFF
 #define I40E_PRIORITY_MASK		0x7000
 
+#define VF_IS_V10(_v) (((_v)->vf_ver.major == 1) && ((_v)->vf_ver.minor == 0))
+#define VF_IS_V11(_v) (((_v)->vf_ver.major == 1) && ((_v)->vf_ver.minor == 1))
+
 /* Various queue ctrls */
 enum i40e_queue_ctrl {
 	I40E_QUEUE_CTRL_UNKNOWN = 0,
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index 1b98c25..9961e17 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -249,8 +249,17 @@ struct i40evf_adapter {
 	bool netdev_registered;
 	bool link_up;
 	enum i40e_virtchnl_ops current_op;
+#define CLIENT_ENABLED(_a) ((_a)->vf_res->vf_offload_flags & \
+			    I40E_VIRTCHNL_VF_OFFLOAD_IWARP)
+#define RSS_AQ(_a) ((_a)->vf_res->vf_offload_flags & \
+		    I40E_VIRTCHNL_VF_OFFLOAD_RSS_AQ)
+#define VLAN_ALLOWED(_a) ((_a)->vf_res->vf_offload_flags & \
+			  I40E_VIRTCHNL_VF_OFFLOAD_VLAN)
 	struct i40e_virtchnl_vf_resource *vf_res; /* incl. all VSIs */
 	struct i40e_virtchnl_vsi_resource *vsi_res; /* our LAN VSI */
+	struct i40e_virtchnl_version_info pf_version;
+#define PF_IS_V11(_a) (((_a)->pf_version.major == 1) && \
+		       ((_a)->pf_version.minor == 1))
 	u16 msg_enable;
 	struct i40e_eth_stats current_stats;
 	struct i40e_vsi vsi;
-- 
1.9.3


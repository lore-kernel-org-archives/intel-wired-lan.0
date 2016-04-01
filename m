From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Fri,  1 Apr 2016 03:56:07 -0700
Subject: [Intel-wired-lan] [v3 next PATCH S32 07/13] i40e: Patch to support
	trusted VF
In-Reply-To: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1459508173-22777-8-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

This patch adds hook to support changing a VF from not-trusted
to trusted and vice-versa. Fixed the wrappers and function prototype.
Changed the dmesg to reflex the current state better. This patch also
disables turning on/off trusted VF in MFP mode.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: Ibcd910935c01f0be1f3fdd6d427230291ee92ebe
---
Testing Hints : Test the feature with ip link set dev eth0 vf 1 trust
on or ip link set dev eth0 vf 1 trust off

 drivers/net/ethernet/intel/i40e/i40e_main.c        |  1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 42 ++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  2 ++
 3 files changed, 45 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 86abd08..627acf0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9069,6 +9069,7 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_get_vf_config	= i40e_ndo_get_vf_config,
 	.ndo_set_vf_link_state	= i40e_ndo_set_vf_link_state,
 	.ndo_set_vf_spoofchk	= i40e_ndo_set_vf_spoofchk,
+	.ndo_set_vf_trust	= i40e_ndo_set_vf_trust,
 #if IS_ENABLED(CONFIG_VXLAN)
 	.ndo_add_vxlan_port	= i40e_add_vxlan_port,
 	.ndo_del_vxlan_port	= i40e_del_vxlan_port,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index f2a9c14..b353966 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2763,3 +2763,45 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable)
 out:
 	return ret;
 }
+
+/**
+ * i40e_ndo_set_vf_trust
+ * @netdev: network interface device structure of the pf
+ * @vf_id: VF identifier
+ * @setting: trust setting
+ *
+ * Enable or disable VF trust setting
+ **/
+int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_pf *pf = np->vsi->back;
+	struct i40e_vf *vf;
+	int ret = 0;
+
+	/* validate the request */
+	if (vf_id >= pf->num_alloc_vfs) {
+		dev_err(&pf->pdev->dev, "Invalid VF Identifier %d\n", vf_id);
+		return -EINVAL;
+	}
+
+	if (pf->flags & I40E_FLAG_MFP_ENABLED) {
+		dev_err(&pf->pdev->dev, "Trusted VF not supported in MFP mode.\n");
+		return -EINVAL;
+	}
+
+	vf = &pf->vf[vf_id];
+
+	if (!vf)
+		return -EINVAL;
+	if (setting == vf->trusted)
+		goto out;
+
+	vf->trusted = setting;
+	i40e_vc_notify_vf_reset(vf);
+	i40e_reset_vf(vf, false);
+	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
+		 vf_id, setting ? "" : "un");
+out:
+	return ret;
+}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index e7b2fba..838cbd2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -88,6 +88,7 @@ struct i40e_vf {
 	struct i40e_virtchnl_ether_addr default_fcoe_addr;
 	u16 port_vlan_id;
 	bool pf_set_mac;	/* The VMM admin set the VF MAC address */
+	bool trusted;
 
 	/* VSI indices - actual VSI pointers are maintained in the PF structure
 	 * When assigned, these will be non-zero, because VSI 0 is always
@@ -127,6 +128,7 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev,
 			      int vf_id, u16 vlan_id, u8 qos);
 int i40e_ndo_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
 		       int max_tx_rate);
+int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting);
 int i40e_ndo_get_vf_config(struct net_device *netdev,
 			   int vf_id, struct ifla_vf_info *ivi);
 int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link);
-- 
2.4.3


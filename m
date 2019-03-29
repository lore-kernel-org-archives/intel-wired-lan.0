From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Mar 2019 15:08:30 -0700
Subject: [Intel-wired-lan] [next PATCH S4 01/11] i40e: VF's promiscuous
 attribute is not kept
Message-ID: <20190329220840.51187-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Grzegorz Siwik <grzegorz.siwik@intel.com>

This patch fixes a bug where the promiscuous mode was not being
kept when the VF switched to a new VLAN.
Now we are config two times a promiscuous mode when we switch VLAN.
Without this change when we change VF VLAN we still receive
all the packets from previous VLAN and only unicast from new VLAN.

Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 8a6fb9c03955..00345bbf68ec 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4016,6 +4016,7 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 {
 	u16 vlanprio = vlan_id | (qos << I40E_VLAN_PRIORITY_SHIFT);
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	bool allmulti = false, alluni = false;
 	struct i40e_pf *pf = np->vsi->back;
 	struct i40e_vsi *vsi;
 	struct i40e_vf *vf;
@@ -4100,6 +4101,15 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 	}
 
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
+
+	/* disable promisc modes in case they were enabled */
+	ret = i40e_config_vf_promiscuous_mode(vf, vf->lan_vsi_id,
+					      allmulti, alluni);
+	if (ret) {
+		dev_err(&pf->pdev->dev, "Unable to config VF promiscuous mode\n");
+		goto error_pvid;
+	}
+
 	if (vlan_id || qos)
 		ret = i40e_vsi_add_pvid(vsi, vlanprio);
 	else
@@ -4126,6 +4136,12 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
 
+	if (test_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states))
+		alluni = true;
+
+	if (test_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states))
+		allmulti = true;
+
 	/* Schedule the worker thread to take care of applying changes */
 	i40e_service_event_schedule(vsi->back);
 
@@ -4138,6 +4154,13 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 	 * default LAN MAC address.
 	 */
 	vf->port_vlan_id = le16_to_cpu(vsi->info.pvid);
+
+	ret = i40e_config_vf_promiscuous_mode(vf, vsi->id, allmulti, alluni);
+	if (ret) {
+		dev_err(&pf->pdev->dev, "Unable to config vf promiscuous mode\n");
+		goto error_pvid;
+	}
+
 	ret = 0;
 
 error_pvid:
-- 
2.19.2


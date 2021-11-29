From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 29 Nov 2021 11:23:00 -0800
Subject: [Intel-wired-lan] [PATCH net-next 6/6] iavf: Restrict maximum VLAN
 filters for VIRTCHNL_VF_OFFLOAD_VLAN_V2
In-Reply-To: <20211129192300.14188-1-anthony.l.nguyen@intel.com>
References: <20211129192300.14188-1-anthony.l.nguyen@intel.com>
Message-ID: <20211129192300.14188-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

For VIRTCHNL_VF_OFFLOAD_VLAN, PF's would limit the number of VLAN
filters a VF was allowed to add. However, by the time the opcode failed,
the VLAN netdev had already been added. VIRTCHNL_VF_OFFLOAD_VLAN_V2
added the ability for a PF to tell the VF how many VLAN filters it's
allowed to add. Make changes to support that functionality.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 50 +++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 1e798b00cd82..5b5cd66e4ef2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -731,6 +731,50 @@ static void iavf_restore_filters(struct iavf_adapter *adapter)
 		iavf_add_vlan(adapter, IAVF_VLAN(vid, ETH_P_8021AD));
 }
 
+/**
+ * iavf_get_num_vlans_added - get number of VLANs added
+ * @adapter: board private structure
+ */
+static u16 iavf_get_num_vlans_added(struct iavf_adapter *adapter)
+{
+	return bitmap_weight(adapter->vsi.active_cvlans, VLAN_N_VID) +
+		bitmap_weight(adapter->vsi.active_svlans, VLAN_N_VID);
+}
+
+/**
+ * iavf_get_max_vlans_allowed - get maximum VLANs allowed for this VF
+ * @adapter: board private structure
+ *
+ * This depends on the negotiated VLAN capability. For VIRTCHNL_VF_OFFLOAD_VLAN,
+ * do not impose a limit as that maintains current behavior and for
+ * VIRTCHNL_VF_OFFLOAD_VLAN_V2, use the maximum allowed sent from the PF.
+ **/
+static u16 iavf_get_max_vlans_allowed(struct iavf_adapter *adapter)
+{
+	/* don't impose any limit for VIRTCHNL_VF_OFFLOAD_VLAN since there has
+	 * never been a limit on the VF driver side
+	 */
+	if (VLAN_ALLOWED(adapter))
+		return VLAN_N_VID;
+	else if (VLAN_V2_ALLOWED(adapter))
+		return adapter->vlan_v2_caps.filtering.max_filters;
+
+	return 0;
+}
+
+/**
+ * iavf_max_vlans_added - check if maximum VLANs allowed already exist
+ * @adapter: board private structure
+ **/
+static bool iavf_max_vlans_added(struct iavf_adapter *adapter)
+{
+	if (iavf_get_num_vlans_added(adapter) <
+	    iavf_get_max_vlans_allowed(adapter))
+		return false;
+
+	return true;
+}
+
 /**
  * iavf_vlan_rx_add_vid - Add a VLAN filter to a device
  * @netdev: network device struct
@@ -745,6 +789,12 @@ static int iavf_vlan_rx_add_vid(struct net_device *netdev,
 	if (!VLAN_FILTERING_ALLOWED(adapter))
 		return -EIO;
 
+	if (iavf_max_vlans_added(adapter)) {
+		netdev_err(netdev, "Max allowed VLAN filters %u. Remove existing VLANs or disable filtering via Ethtool if supported.\n",
+			   iavf_get_max_vlans_allowed(adapter));
+		return -EIO;
+	}
+
 	if (!iavf_add_vlan(adapter, IAVF_VLAN(vid, be16_to_cpu(proto))))
 		return -ENOMEM;
 
-- 
2.20.1


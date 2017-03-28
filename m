From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Tue, 28 Mar 2017 11:27:54 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: clean macvlan MAC filter table on
	VF reset
Message-ID: <20170328182754.3607.1614.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Flush the macvlan filters on VF reset to avoid conflict with other VFs that
may end up using the same MAC address.

The main change here is the call to ixgbe_set_vf_macvlan() with index 0.

Moved ixgbe_set_vf_macvlan() in front of ixgbe_vf_reset_event() to avoid
adding a  prototype.

Reported-by: Sritej Kanakadandi Sritej Rama <skanakad@cisco.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |  105 ++++++++++++------------
 1 file changed, 53 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 102ca93..c45de53 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -677,58 +677,6 @@ static void ixgbe_clear_vf_vlans(struct ixgbe_adapter *adapter, u32 vf)
 	}
 }
 
-static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32 vf)
-{
-	struct ixgbe_hw *hw = &adapter->hw;
-	struct vf_data_storage *vfinfo = &adapter->vfinfo[vf];
-	u8 num_tcs = netdev_get_num_tc(adapter->netdev);
-
-	/* remove VLAN filters beloning to this VF */
-	ixgbe_clear_vf_vlans(adapter, vf);
-
-	/* add back PF assigned VLAN or VLAN 0 */
-	ixgbe_set_vf_vlan(adapter, true, vfinfo->pf_vlan, vf);
-
-	/* reset offloads to defaults */
-	ixgbe_set_vmolr(hw, vf, !vfinfo->pf_vlan);
-
-	/* set outgoing tags for VFs */
-	if (!vfinfo->pf_vlan && !vfinfo->pf_qos && !num_tcs) {
-		ixgbe_clear_vmvir(adapter, vf);
-	} else {
-		if (vfinfo->pf_qos || !num_tcs)
-			ixgbe_set_vmvir(adapter, vfinfo->pf_vlan,
-					vfinfo->pf_qos, vf);
-		else
-			ixgbe_set_vmvir(adapter, vfinfo->pf_vlan,
-					adapter->default_up, vf);
-
-		if (vfinfo->spoofchk_enabled)
-			hw->mac.ops.set_vlan_anti_spoofing(hw, true, vf);
-	}
-
-	/* reset multicast table array for vf */
-	adapter->vfinfo[vf].num_vf_mc_hashes = 0;
-
-	/* Flush and reset the mta with the new values */
-	ixgbe_set_rx_mode(adapter->netdev);
-
-	ixgbe_del_mac_filter(adapter, adapter->vfinfo[vf].vf_mac_addresses, vf);
-
-	/* reset VF api back to unknown */
-	adapter->vfinfo[vf].vf_api = ixgbe_mbox_api_10;
-}
-
-static int ixgbe_set_vf_mac(struct ixgbe_adapter *adapter,
-			    int vf, unsigned char *mac_addr)
-{
-	ixgbe_del_mac_filter(adapter, adapter->vfinfo[vf].vf_mac_addresses, vf);
-	memcpy(adapter->vfinfo[vf].vf_mac_addresses, mac_addr, ETH_ALEN);
-	ixgbe_add_mac_filter(adapter, adapter->vfinfo[vf].vf_mac_addresses, vf);
-
-	return 0;
-}
-
 static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
 				int vf, int index, unsigned char *mac_addr)
 {
@@ -784,6 +732,59 @@ static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
 	return 0;
 }
 
+static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32 vf)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	struct vf_data_storage *vfinfo = &adapter->vfinfo[vf];
+	u8 num_tcs = netdev_get_num_tc(adapter->netdev);
+
+	/* remove VLAN filters beloning to this VF */
+	ixgbe_clear_vf_vlans(adapter, vf);
+
+	/* add back PF assigned VLAN or VLAN 0 */
+	ixgbe_set_vf_vlan(adapter, true, vfinfo->pf_vlan, vf);
+
+	/* reset offloads to defaults */
+	ixgbe_set_vmolr(hw, vf, !vfinfo->pf_vlan);
+
+	/* set outgoing tags for VFs */
+	if (!vfinfo->pf_vlan && !vfinfo->pf_qos && !num_tcs) {
+		ixgbe_clear_vmvir(adapter, vf);
+	} else {
+		if (vfinfo->pf_qos || !num_tcs)
+			ixgbe_set_vmvir(adapter, vfinfo->pf_vlan,
+					vfinfo->pf_qos, vf);
+		else
+			ixgbe_set_vmvir(adapter, vfinfo->pf_vlan,
+					adapter->default_up, vf);
+
+		if (vfinfo->spoofchk_enabled)
+			hw->mac.ops.set_vlan_anti_spoofing(hw, true, vf);
+	}
+
+	/* reset multicast table array for vf */
+	adapter->vfinfo[vf].num_vf_mc_hashes = 0;
+
+	/* Flush and reset the mta with the new values */
+	ixgbe_set_rx_mode(adapter->netdev);
+
+	ixgbe_del_mac_filter(adapter, adapter->vfinfo[vf].vf_mac_addresses, vf);
+	ixgbe_set_vf_macvlan(adapter, vf, 0, NULL);
+
+	/* reset VF api back to unknown */
+	adapter->vfinfo[vf].vf_api = ixgbe_mbox_api_10;
+}
+
+static int ixgbe_set_vf_mac(struct ixgbe_adapter *adapter,
+			    int vf, unsigned char *mac_addr)
+{
+	ixgbe_del_mac_filter(adapter, adapter->vfinfo[vf].vf_mac_addresses, vf);
+	memcpy(adapter->vfinfo[vf].vf_mac_addresses, mac_addr, ETH_ALEN);
+	ixgbe_add_mac_filter(adapter, adapter->vfinfo[vf].vf_mac_addresses, vf);
+
+	return 0;
+}
+
 int ixgbe_vf_configuration(struct pci_dev *pdev, unsigned int event_mask)
 {
 	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);


From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 19 Aug 2021 17:08:49 -0700
Subject: [Intel-wired-lan] [next-queue v4 02/12] ice: Move devlink port to
 PF/VF struct
In-Reply-To: <20210820000859.680522-1-anthony.l.nguyen@intel.com>
References: <20210820000859.680522-1-anthony.l.nguyen@intel.com>
Message-ID: <20210820000859.680522-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Wojciech Drewek <wojciech.drewek@intel.com>

Keeping devlink port inside VSI data structure causes some issues.
Since VF VSI is released during reset that means that we have to
unregister devlink port and register it again every time reset is
triggered. With the new changes in devlink API it
might cause deadlock issues. After calling
devlink_port_register/devlink_port_unregister devlink API is going to
lock rtnl_mutex. It's an issue when VF reset is triggered in netlink
operation context (like setting VF MAC address or VLAN),
because rtnl_lock is already taken by netlink. Another call of
rtnl_lock from devlink API results in dead-lock.

By moving devlink port to PF/VF we avoid creating/destroying it
during reset. Since this patch, devlink ports are created during
ice_probe, destroyed during ice_remove for PF and created during
ice_repr_add, destroyed during ice_repr_rem for VF.

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |   7 +-
 drivers/net/ethernet/intel/ice/ice_devlink.c  | 106 +++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_devlink.h  |   6 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   4 +-
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   2 +-
 .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |   9 ++
 7 files changed, 100 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index abdd87ce9e69..93a936766b4b 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -303,10 +303,6 @@ struct ice_vsi {
 	spinlock_t arfs_lock;	/* protects aRFS hash table and filter state */
 	atomic_t *arfs_last_fltr_id;
 
-	/* devlink port data */
-	struct devlink_port devlink_port;
-	bool devlink_port_registered;
-
 	u16 max_frame;
 	u16 rx_buf_len;
 
@@ -418,6 +414,9 @@ struct ice_pf {
 	struct devlink_region *nvm_region;
 	struct devlink_region *devcaps_region;
 
+	/* devlink port data */
+	struct devlink_port devlink_port;
+
 	/* OS reserved IRQ details */
 	struct msix_entry *msix_entries;
 	struct ice_res_tracker *irq_tracker;
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 7d5468b36a47..48b13fa33748 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -633,61 +633,113 @@ void ice_devlink_unregister(struct ice_pf *pf)
 }
 
 /**
- * ice_devlink_create_port - Create a devlink port for this VSI
- * @vsi: the VSI to create a port for
+ * ice_devlink_create_pf_port - Create a devlink port for this PF
+ * @pf: the PF to create a devlink port for
  *
- * Create and register a devlink_port for this VSI.
+ * Create and register a devlink_port for this PF.
  *
  * Return: zero on success or an error code on failure.
  */
-int ice_devlink_create_port(struct ice_vsi *vsi)
+int ice_devlink_create_pf_port(struct ice_pf *pf)
 {
 	struct devlink_port_attrs attrs = {};
-	struct ice_port_info *pi;
+	struct devlink_port *devlink_port;
 	struct devlink *devlink;
+	struct ice_vsi *vsi;
 	struct device *dev;
-	struct ice_pf *pf;
 	int err;
 
-	/* Currently we only create devlink_port instances for PF VSIs */
-	if (vsi->type != ICE_VSI_PF)
-		return -EINVAL;
-
-	pf = vsi->back;
-	devlink = priv_to_devlink(pf);
 	dev = ice_pf_to_dev(pf);
-	pi = pf->hw.port_info;
+
+	devlink_port = &pf->devlink_port;
+	vsi = ice_get_main_vsi(pf);
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
-	attrs.phys.port_number = pi->lport;
-	devlink_port_attrs_set(&vsi->devlink_port, &attrs);
+	attrs.phys.port_number = pf->hw.bus.func;
 
-	err = devlink_port_register(devlink, &vsi->devlink_port, vsi->idx);
+	devlink_port_attrs_set(devlink_port, &attrs);
+	devlink = priv_to_devlink(pf);
+
+	err = devlink_port_register(devlink, devlink_port, vsi->idx);
 	if (err) {
-		dev_err(dev, "devlink_port_register failed: %d\n", err);
+		dev_err(dev, "Failed to create devlink port for PF %d, error %d\n",
+			pf->hw.pf_id, err);
 		return err;
 	}
 
-	vsi->devlink_port_registered = true;
+	return 0;
+}
+
+/**
+ * ice_devlink_destroy_pf_port - Destroy the devlink_port for this PF
+ * @pf: the PF to cleanup
+ *
+ * Unregisters the devlink_port structure associated with this PF.
+ */
+void ice_devlink_destroy_pf_port(struct ice_pf *pf)
+{
+	struct devlink_port *devlink_port;
+
+	devlink_port = &pf->devlink_port;
+
+	devlink_port_type_clear(devlink_port);
+	devlink_port_unregister(devlink_port);
+}
+
+/**
+ * ice_devlink_create_vf_port - Create a devlink port for this VF
+ * @vf: the VF to create a port for
+ *
+ * Create and register a devlink_port for this VF.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int ice_devlink_create_vf_port(struct ice_vf *vf)
+{
+	struct devlink_port_attrs attrs = {};
+	struct devlink_port *devlink_port;
+	struct devlink *devlink;
+	struct ice_vsi *vsi;
+	struct device *dev;
+	struct ice_pf *pf;
+	int err;
+
+	pf = vf->pf;
+	dev = ice_pf_to_dev(pf);
+	vsi = ice_get_vf_vsi(vf);
+	devlink_port = &vf->devlink_port;
+
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_VF;
+	attrs.pci_vf.pf = pf->hw.bus.func;
+	attrs.pci_vf.vf = vf->vf_id;
+
+	devlink_port_attrs_set(devlink_port, &attrs);
+	devlink = priv_to_devlink(pf);
+
+	err = devlink_port_register(devlink, devlink_port, vsi->idx);
+	if (err) {
+		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
+			vf->vf_id, err);
+		return err;
+	}
 
 	return 0;
 }
 
 /**
- * ice_devlink_destroy_port - Destroy the devlink_port for this VSI
- * @vsi: the VSI to cleanup
+ * ice_devlink_destroy_vf_port - Destroy the devlink_port for this VF
+ * @vf: the VF to cleanup
  *
- * Unregisters the devlink_port structure associated with this VSI.
+ * Unregisters the devlink_port structure associated with this VF.
  */
-void ice_devlink_destroy_port(struct ice_vsi *vsi)
+void ice_devlink_destroy_vf_port(struct ice_vf *vf)
 {
-	if (!vsi->devlink_port_registered)
-		return;
+	struct devlink_port *devlink_port;
 
-	devlink_port_type_clear(&vsi->devlink_port);
-	devlink_port_unregister(&vsi->devlink_port);
+	devlink_port = &vf->devlink_port;
 
-	vsi->devlink_port_registered = false;
+	devlink_port_type_clear(devlink_port);
+	devlink_port_unregister(devlink_port);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.h b/drivers/net/ethernet/intel/ice/ice_devlink.h
index e07e74426bde..e30284ccbed4 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.h
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.h
@@ -8,8 +8,10 @@ struct ice_pf *ice_allocate_pf(struct device *dev);
 
 int ice_devlink_register(struct ice_pf *pf);
 void ice_devlink_unregister(struct ice_pf *pf);
-int ice_devlink_create_port(struct ice_vsi *vsi);
-void ice_devlink_destroy_port(struct ice_vsi *vsi);
+int ice_devlink_create_pf_port(struct ice_pf *pf);
+void ice_devlink_destroy_pf_port(struct ice_pf *pf);
+int ice_devlink_create_vf_port(struct ice_vf *vf);
+void ice_devlink_destroy_vf_port(struct ice_vf *vf);
 
 void ice_devlink_init_regions(struct ice_pf *pf);
 void ice_devlink_destroy_regions(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 2e553b8cceaf..274cbca8b1c4 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2856,7 +2856,8 @@ int ice_vsi_release(struct ice_vsi *vsi)
 		clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
 	}
 
-	ice_devlink_destroy_port(vsi);
+	if (vsi->type == ICE_VSI_PF)
+		ice_devlink_destroy_pf_port(pf);
 
 	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
 		ice_rss_clean(vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 00ee5cc26482..ae04ca1888fa 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4185,11 +4185,11 @@ static int ice_register_netdev(struct ice_pf *pf)
 	set_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
 	netif_carrier_off(vsi->netdev);
 	netif_tx_stop_all_queues(vsi->netdev);
-	err = ice_devlink_create_port(vsi);
+	err = ice_devlink_create_pf_port(pf);
 	if (err)
 		goto err_devlink_create;
 
-	devlink_port_type_eth_set(&vsi->devlink_port, vsi->netdev);
+	devlink_port_type_eth_set(&pf->devlink_port, vsi->netdev);
 
 	return 0;
 err_devlink_create:
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 022738295878..623f3210477e 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -251,7 +251,7 @@ ice_vc_hash_field_match_type ice_vc_hash_field_list_comms[] = {
  * ice_get_vf_vsi - get VF's VSI based on the stored index
  * @vf: VF used to get VSI
  */
-static struct ice_vsi *ice_get_vf_vsi(struct ice_vf *vf)
+struct ice_vsi *ice_get_vf_vsi(struct ice_vf *vf)
 {
 	return vf->pf->vsi[vf->lan_vsi_idx];
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
index 842cb077df86..38b4dc82c5c1 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
@@ -111,9 +111,13 @@ struct ice_vf {
 	struct ice_mdd_vf_events mdd_rx_events;
 	struct ice_mdd_vf_events mdd_tx_events;
 	DECLARE_BITMAP(opcodes_allowlist, VIRTCHNL_OP_MAX);
+
+	/* devlink port data */
+	struct devlink_port devlink_port;
 };
 
 #ifdef CONFIG_PCI_IOV
+struct ice_vsi *ice_get_vf_vsi(struct ice_vf *vf);
 void ice_process_vflr_event(struct ice_pf *pf);
 int ice_sriov_configure(struct pci_dev *pdev, int num_vfs);
 int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac);
@@ -171,6 +175,11 @@ static inline void ice_print_vfs_mdd_events(struct ice_pf *pf) { }
 static inline void ice_print_vf_rx_mdd_event(struct ice_vf *vf) { }
 static inline void ice_restore_all_vfs_msi_state(struct pci_dev *pdev) { }
 
+static inline struct ice_vsi *ice_get_vf_vsi(struct ice_vf *vf)
+{
+	return NULL;
+}
+
 static inline bool
 ice_is_malicious_vf(struct ice_pf __always_unused *pf,
 		    struct ice_rq_event_info __always_unused *event,
-- 
2.26.2


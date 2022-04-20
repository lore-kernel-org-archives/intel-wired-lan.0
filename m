From: Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Wed, 20 Apr 2022 13:22:43 +0200
Subject: [Intel-wired-lan] [PATCH net-next] ice: get switch id on switchdev
 devices
Message-ID: <20220420112243.142168-1-marcin.szycik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Switch id should be the same for each netdevice on a driver.
The id must be unique between devices on the same system, but
does not need to be unique between devices on different systems.

The switch id is used to locate ports on a switch and to know if
aggregated ports belong to the same switch.

To meet this requirements, use pci_get_dsn as switch id value, as
this is unique value for each devices on the same system.

Implementing switch id is needed by automatic tools for kubernetes.

Set switch id by setting devlink port attribiutes and calling
devlink_port_attrs_set while creating pf (for uplink) and vf
(for representator) devlink port.

To get switch id (in switchdev mode):
cat /sys/class/net/$PF0/phys_switch_id

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 22 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c    | 15 +++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 4a9de59121d8..3991d62473bf 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -647,6 +647,23 @@ void ice_devlink_unregister(struct ice_pf *pf)
 	devlink_unregister(priv_to_devlink(pf));
 }
 
+/**
+ * ice_devlink_set_switch_id - Set unique switch id based on pci dsn
+ * @pf: the PF to create a devlink port for
+ * @ppid: struct with switch id information
+ */
+static void
+ice_devlink_set_switch_id(struct ice_pf *pf, struct netdev_phys_item_id *ppid)
+{
+	struct pci_dev *pdev = pf->pdev;
+	u64 id;
+
+	id = pci_get_dsn(pdev);
+
+	ppid->id_len = sizeof(id);
+	put_unaligned_be64(id, &ppid->id);
+}
+
 int ice_devlink_register_params(struct ice_pf *pf)
 {
 	struct devlink *devlink = priv_to_devlink(pf);
@@ -704,6 +721,9 @@ int ice_devlink_create_pf_port(struct ice_pf *pf)
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
 	attrs.phys.port_number = pf->hw.bus.func;
+
+	ice_devlink_set_switch_id(pf, &attrs.switch_id);
+
 	devlink_port_attrs_set(devlink_port, &attrs);
 	devlink = priv_to_devlink(pf);
 
@@ -763,6 +783,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
 	attrs.pci_vf.pf = pf->hw.bus.func;
 	attrs.pci_vf.vf = vf->vf_id;
 
+	ice_devlink_set_switch_id(pf, &attrs.switch_id);
+
 	devlink_port_attrs_set(devlink_port, &attrs);
 	devlink = priv_to_devlink(pf);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4039f14b4db6..3d4e7f48217e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -296,6 +296,20 @@ static int ice_clear_promisc(struct ice_vsi *vsi, u8 promisc_m)
 	return status;
 }
 
+/**
+ * ice_get_devlink_port - Get devlink port from netdev
+ * @netdev: the netdevice structure
+ */
+static struct devlink_port *ice_get_devlink_port(struct net_device *netdev)
+{
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
+
+	if (!ice_is_switchdev_running(pf))
+		return NULL;
+
+	return &pf->devlink_port;
+}
+
 /**
  * ice_vsi_sync_fltr - Update the VSI filter list to the HW
  * @vsi: ptr to the VSI
@@ -8926,4 +8940,5 @@ static const struct net_device_ops ice_netdev_ops = {
 	.ndo_bpf = ice_xdp,
 	.ndo_xdp_xmit = ice_xdp_xmit,
 	.ndo_xsk_wakeup = ice_xsk_wakeup,
+	.ndo_get_devlink_port = ice_get_devlink_port,
 };
-- 
2.35.1


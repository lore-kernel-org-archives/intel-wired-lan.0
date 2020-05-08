From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  7 May 2020 17:41:03 -0700
Subject: [Intel-wired-lan] [PATCH S41 05/15] ice: Fix probe/open race
 condition
In-Reply-To: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
Message-ID: <20200508004113.39725-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

As soon as the driver registers the PF netdev, userspace utilities
like NetworkManager try to bring up the associated interface. When
this happens, the driver may not have finished initializing fully,
resulting in a bunch of errors in the interface up flow.

The driver already has a mechanism to indicate if it's not up yet;
by setting the __ICE_DOWN bit in pf->state, but this bit gets
cleared too early in the current flow. So clear this bit only when
the driver is fully up. Also check for the same bit in the ice_open
flow, and return -EBUSY if the bit is set.

Also in ice_open, replace references of vsi->back with a local
variable.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 24 +++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2128238a0f6d..f6c2dd55553f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2144,10 +2144,8 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 	}
 	ret = IRQ_HANDLED;
 
-	if (!test_bit(__ICE_DOWN, pf->state)) {
-		ice_service_task_schedule(pf);
-		ice_irq_dynamic_ena(hw, NULL, NULL);
-	}
+	ice_service_task_schedule(pf);
+	ice_irq_dynamic_ena(hw, NULL, NULL);
 
 	return ret;
 }
@@ -3339,9 +3337,6 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		goto err_init_interrupt_unroll;
 	}
 
-	/* Driver is mostly up */
-	clear_bit(__ICE_DOWN, pf->state);
-
 	/* In case of MSIX we are going to setup the misc vector right here
 	 * to handle admin queue events etc. In case of legacy and MSI
 	 * the misc functionality and queue processing is combined in
@@ -3397,9 +3392,9 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 
 	ice_verify_cacheline_size(pf);
 
-	/* If no DDP driven features have to be setup, return here */
+	/* If no DDP driven features have to be setup, we are done with probe */
 	if (ice_is_safe_mode(pf))
-		return 0;
+		goto probe_done;
 
 	/* initialize DDP driven features */
 
@@ -3434,6 +3429,9 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	/* print PCI link speed and width */
 	pcie_print_link_status(pf->pdev);
 
+probe_done:
+	/* ready to go, so clear down state bit */
+	clear_bit(__ICE_DOWN, pf->state);
 	return 0;
 
 err_init_peer_unroll:
@@ -5348,14 +5346,20 @@ int ice_open(struct net_device *netdev)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
+	struct ice_pf *pf = vsi->back;
 	struct ice_port_info *pi;
 	int err;
 
-	if (test_bit(__ICE_NEEDS_RESTART, vsi->back->state)) {
+	if (test_bit(__ICE_NEEDS_RESTART, pf->state)) {
 		netdev_err(netdev, "driver needs to be unloaded and reloaded\n");
 		return -EIO;
 	}
 
+	if (test_bit(__ICE_DOWN, pf->state)) {
+		netdev_err(netdev, "device is not ready yet\n");
+		return -EBUSY;
+	}
+
 	netif_carrier_off(netdev);
 
 	pi = vsi->port_info;
-- 
2.20.1


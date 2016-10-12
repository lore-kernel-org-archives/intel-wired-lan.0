From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 12 Oct 2016 12:34:25 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: set device if before calling
	get_invariants
Message-ID: <20161012193425.20797.48614.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix an issue where set_phy_power was NULL for X550 copper devices
because get_invariants was called before hw->device_id was set.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 5227b61..5fb6378 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5621,7 +5621,8 @@ static void ixgbe_init_dcb(struct ixgbe_adapter *adapter)
  * Fields are initialized based on PCI device information and
  * OS network device settings (MTU size).
  **/
-static int ixgbe_sw_init(struct ixgbe_adapter *adapter)
+static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
+			 const struct ixgbe_info *ii)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	struct pci_dev *pdev = adapter->pdev;
@@ -5637,6 +5638,9 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter)
 	hw->subsystem_vendor_id = pdev->subsystem_vendor;
 	hw->subsystem_device_id = pdev->subsystem_device;
 
+	/* get_invariants needs the device IDs */
+	ii->get_invariants(hw);
+
 	/* Set common capability flags and settings */
 	rss = min_t(int, ixgbe_max_rss_indices(adapter), num_online_cpus());
 	adapter->ring_feature[RING_F_RSS].limit = rss;
@@ -9505,10 +9509,8 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->phy.mdio.mdio_read = ixgbe_mdio_read;
 	hw->phy.mdio.mdio_write = ixgbe_mdio_write;
 
-	ii->get_invariants(hw);
-
 	/* setup the private structure */
-	err = ixgbe_sw_init(adapter);
+	err = ixgbe_sw_init(adapter, ii);
 	if (err)
 		goto err_sw_init;
 


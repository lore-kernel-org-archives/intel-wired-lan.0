From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu,  4 Aug 2016 18:49:43 +0200
Subject: [Intel-wired-lan] [next PATCH 1/5] i40e: Introduce devlink
	interface.
Message-ID: <1470329387-25138-1-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add initial devlink support to set/get the mode of SRIOV switch.
This patch allows the mode to be set to either 'legacy' or 'switchdev', but
doesn't implement any functionality to create vf representors in switchdev
mode.

With smode support in iproute2 'devlink' utility, switch mode can be set
and get via following commands.

    # devlink dev smode pci/0000:05:00.0
    mode: legacy
    # devlink dev set pci/0000:05:00.0 smode switchdev
    # devlink dev smode pci/0000:05:00.0
    mode: switchdev

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/ethernet/intel/Kconfig          |  1 +
 drivers/net/ethernet/intel/i40e/i40e.h      |  3 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c | 84 ++++++++++++++++++++++++++---
 3 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index c0e1743..2ede229 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -215,6 +215,7 @@ config I40E
 	tristate "Intel(R) Ethernet Controller XL710 Family support"
 	select PTP_1588_CLOCK
 	depends on PCI
+	depends on MAY_USE_DEVLINK
 	---help---
 	  This driver supports Intel(R) Ethernet Controller XL710 Family of
 	  devices.  For more information on how to identify your adapter, go
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 2a88291..724bd82 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -53,6 +53,8 @@
 #include <linux/clocksource.h>
 #include <linux/net_tstamp.h>
 #include <linux/ptp_clock_kernel.h>
+#include <net/devlink.h>
+
 #include "i40e_type.h"
 #include "i40e_prototype.h"
 #ifdef I40E_FCOE
@@ -446,6 +448,7 @@ struct i40e_pf {
 	u32 ioremap_len;
 	u32 fd_inv;
 	u16 phy_led_val;
+	enum devlink_eswitch_mode eswitch_mode;
 };
 
 enum i40e_filter_state {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 339d99b..bb44f09 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -27,6 +27,7 @@
 #include <linux/etherdevice.h>
 #include <linux/of_net.h>
 #include <linux/pci.h>
+#include <net/devlink.h>
 
 /* Local includes */
 #include "i40e.h"
@@ -10671,6 +10672,58 @@ static void i40e_get_platform_mac_addr(struct pci_dev *pdev, struct i40e_pf *pf)
 }
 
 /**
+ * i40e_devlink_eswitch_mode_get
+ *
+ * @devlink: pointer to devlink struct
+ * @mode: sr-iov switch mode pointer
+ *
+ * Returns the switch mode of the associated PF in the @mode pointer.
+ */
+static int i40e_devlink_eswitch_mode_get(struct devlink *devlink, u16 *mode)
+{
+	struct i40e_pf *pf = devlink_priv(devlink);
+
+	*mode = pf->eswitch_mode;
+
+	return 0;
+}
+
+/**
+ * i40e_devlink_eswitch_mode_set
+ *
+ * @devlink: pointer to devlink struct
+ * @mode: sr-iov switch mode
+ *
+ * Set the switch mode of the associated PF.
+ * Returns 0 on success and -EOPNOTSUPP on error.
+ */
+static int i40e_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode)
+{
+	struct i40e_pf *pf = devlink_priv(devlink);
+	int err = 0;
+
+	if (mode == pf->eswitch_mode)
+		goto done;
+
+	switch (mode) {
+	case DEVLINK_ESWITCH_MODE_LEGACY:
+	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
+		pf->eswitch_mode = mode;
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
+done:
+	return err;
+}
+
+static const struct devlink_ops i40e_devlink_ops = {
+	.eswitch_mode_get = i40e_devlink_eswitch_mode_get,
+	.eswitch_mode_set = i40e_devlink_eswitch_mode_set,
+};
+
+/**
  * i40e_probe - Device initialization routine
  * @pdev: PCI device information struct
  * @ent: entry in i40e_pci_tbl
@@ -10687,6 +10740,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct i40e_pf *pf;
 	struct i40e_hw *hw;
 	static u16 pfs_found;
+	struct devlink *devlink;
 	u16 wol_nvm_bits;
 	u16 link_status;
 	int err;
@@ -10721,16 +10775,21 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_enable_pcie_error_reporting(pdev);
 	pci_set_master(pdev);
 
+	devlink = devlink_alloc(&i40e_devlink_ops, sizeof(*pf));
+	if (!devlink) {
+		dev_err(&pdev->dev,
+			"devlink_alloc failed\n");
+		err = -ENOMEM;
+		goto err_devlink_alloc;
+	}
+
 	/* Now that we have a PCI connection, we need to do the
 	 * low level device setup.  This is primarily setting up
 	 * the Admin Queue structures and then querying for the
 	 * device's current profile information.
 	 */
-	pf = kzalloc(sizeof(*pf), GFP_KERNEL);
-	if (!pf) {
-		err = -ENOMEM;
-		goto err_pf_alloc;
-	}
+	pf = devlink_priv(devlink);
+
 	pf->next_vsi = 0;
 	pf->pdev = pdev;
 	set_bit(__I40E_DOWN, &pf->state);
@@ -11047,6 +11106,11 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
+	pf->eswitch_mode = DEVLINK_ESWITCH_MODE_LEGACY;
+	err = devlink_register(devlink, &pdev->dev);
+	if (err)
+		goto err_devlink_register;
+
 #ifdef CONFIG_PCI_IOV
 	/* prep for VF support */
 	if ((pf->flags & I40E_FLAG_SRIOV_ENABLED) &&
@@ -11188,6 +11252,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 	/* Unwind what we've done if something failed in the setup */
+err_devlink_register:
+	i40e_stop_misc_vector(pf);
 err_vsis:
 	set_bit(__I40E_DOWN, &pf->state);
 	i40e_clear_interrupt_scheme(pf);
@@ -11205,8 +11271,8 @@ err_adminq_setup:
 err_pf_reset:
 	iounmap(hw->hw_addr);
 err_ioremap:
-	kfree(pf);
-err_pf_alloc:
+	devlink_free(devlink);
+err_devlink_alloc:
 	pci_disable_pcie_error_reporting(pdev);
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
@@ -11229,9 +11295,11 @@ static void i40e_remove(struct pci_dev *pdev)
 {
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
 	struct i40e_hw *hw = &pf->hw;
+	struct devlink *devlink = priv_to_devlink(pf);
 	i40e_status ret_code;
 	int i;
 
+	devlink_unregister(devlink);
 	i40e_dbg_pf_exit(pf);
 
 	i40e_ptp_stop(pf);
@@ -11319,7 +11387,7 @@ static void i40e_remove(struct pci_dev *pdev)
 	kfree(pf->vsi);
 
 	iounmap(hw->hw_addr);
-	kfree(pf);
+	devlink_free(devlink);
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
 
-- 
2.5.5


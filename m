From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 28 Aug 2018 18:59:46 +0300
Subject: [Intel-wired-lan] [PATCH v7 01/11] igc: Add skeletal frame for
 Intel(R) 2.5G Ethernet Controller support.
Message-ID: <20180828155946.26270-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds the beginning framework onto which I am going to add
the igc driver which supports the Intel(R) I225-LM/I225-V 2.5G
Ethernet Controller.

Sasha Neftin (v2):
update module author, copyright and licence header
cosmetic changes

Sasha Neftin (v3):
remove unused header files

Sasha Neftin (v4):
update brand name
fix syntax by input from community
replace e1000_ prefix with igc_ prefix

Sasha Neftin (v5):
no changes

Sasha Neftin (v6):
no changes

Sasha Neftin (v7):
no changes

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/Kconfig        |  16 ++++
 drivers/net/ethernet/intel/Makefile       |   1 +
 drivers/net/ethernet/intel/igc/Makefile   |  10 ++
 drivers/net/ethernet/intel/igc/igc.h      |  29 ++++++
 drivers/net/ethernet/intel/igc/igc_hw.h   |  10 ++
 drivers/net/ethernet/intel/igc/igc_main.c | 146 ++++++++++++++++++++++++++++++
 6 files changed, 212 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/igc/Makefile
 create mode 100644 drivers/net/ethernet/intel/igc/igc.h
 create mode 100644 drivers/net/ethernet/intel/igc/igc_hw.h
 create mode 100644 drivers/net/ethernet/intel/igc/igc_main.c

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 1ab613eb5796..fcb676398022 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -280,4 +280,20 @@ config FM10K
 	  To compile this driver as a module, choose M here. The module
 	  will be called fm10k.  MSI-X interrupt support is required
 
+config IGC
+	tristate "Intel(R) Ethernet Controller I225-LM/I225-V support"
+	default n
+	depends on PCI
+	---help---
+	  This driver supports Intel(R) Ethernet Controller I225-LM/I225-V
+	  family of adapters.
+
+	  For more information on how to identify your adapter, go
+	  to the Adapter & Driver ID Guide that can be located at:
+
+	  <http://support.intel.com>
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called igc.
+
 endif # NET_VENDOR_INTEL
diff --git a/drivers/net/ethernet/intel/Makefile b/drivers/net/ethernet/intel/Makefile
index 807a4f8c7e4e..18f4aac68bc0 100644
--- a/drivers/net/ethernet/intel/Makefile
+++ b/drivers/net/ethernet/intel/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_E100) += e100.o
 obj-$(CONFIG_E1000) += e1000/
 obj-$(CONFIG_E1000E) += e1000e/
 obj-$(CONFIG_IGB) += igb/
+obj-$(CONFIG_IGC) += igc/
 obj-$(CONFIG_IGBVF) += igbvf/
 obj-$(CONFIG_IXGBE) += ixgbe/
 obj-$(CONFIG_IXGBEVF) += ixgbevf/
diff --git a/drivers/net/ethernet/intel/igc/Makefile b/drivers/net/ethernet/intel/igc/Makefile
new file mode 100644
index 000000000000..3d13b015d401
--- /dev/null
+++ b/drivers/net/ethernet/intel/igc/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c)  2018 Intel Corporation
+
+#
+# Intel(R) I225-LM/I225-V 2.5G Ethernet Controller
+#
+
+obj-$(CONFIG_IGC) += igc.o
+
+igc-objs := igc_main.o
diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
new file mode 100644
index 000000000000..afe595cfcf63
--- /dev/null
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c)  2018 Intel Corporation */
+
+#ifndef _IGC_H_
+#define _IGC_H_
+
+#include <linux/kobject.h>
+
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/vmalloc.h>
+
+#include <linux/ethtool.h>
+
+#include <linux/sctp.h>
+
+#define IGC_ERR(args...) pr_err("igc: " args)
+
+#define PFX "igc: "
+
+#include <linux/timecounter.h>
+#include <linux/net_tstamp.h>
+#include <linux/ptp_clock_kernel.h>
+
+/* main */
+extern char igc_driver_name[];
+extern char igc_driver_version[];
+
+#endif /* _IGC_H_ */
diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
new file mode 100644
index 000000000000..aa68b4516700
--- /dev/null
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c)  2018 Intel Corporation */
+
+#ifndef _IGC_HW_H_
+#define _IGC_HW_H_
+
+#define IGC_DEV_ID_I225_LM			0x15F2
+#define IGC_DEV_ID_I225_V			0x15F3
+
+#endif /* _IGC_HW_H_ */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
new file mode 100644
index 000000000000..c926dab0057d
--- /dev/null
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c)  2018 Intel Corporation */
+
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include "igc.h"
+#include "igc_hw.h"
+
+#define DRV_VERSION	"0.0.1-k"
+#define DRV_SUMMARY	"Intel(R) 2.5G Ethernet Linux Driver"
+
+char igc_driver_name[] = "igc";
+char igc_driver_version[] = DRV_VERSION;
+static const char igc_driver_string[] = DRV_SUMMARY;
+static const char igc_copyright[] =
+	"Copyright(c) 2018 Intel Corporation.";
+
+static const struct pci_device_id igc_pci_tbl[] = {
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LM) },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_V) },
+	/* required last entry */
+	{0, }
+};
+
+MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
+
+/**
+ *  igc_probe - Device Initialization Routine
+ *  @pdev: PCI device information struct
+ *  @ent: entry in igc_pci_tbl
+ *
+ *  Returns 0 on success, negative on failure
+ *
+ *  igc_probe initializes an adapter identified by a pci_dev structure.
+ *  The OS initialization, configuring the adapter private structure,
+ *  and a hardware reset occur.
+ **/
+static int igc_probe(struct pci_dev *pdev,
+		     const struct pci_device_id *ent)
+{
+	int err, pci_using_dac;
+
+	err = pci_enable_device_mem(pdev);
+	if (err)
+		return err;
+
+	pci_using_dac = 0;
+	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+	if (!err) {
+		err = dma_set_coherent_mask(&pdev->dev,
+					    DMA_BIT_MASK(64));
+		if (!err)
+			pci_using_dac = 1;
+	} else {
+		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+		if (err) {
+			err = dma_set_coherent_mask(&pdev->dev,
+						    DMA_BIT_MASK(32));
+			if (err) {
+				IGC_ERR("Wrong DMA configuration, aborting\n");
+				goto err_dma;
+			}
+		}
+	}
+
+	err = pci_request_selected_regions(pdev,
+					   pci_select_bars(pdev,
+							   IORESOURCE_MEM),
+					   igc_driver_name);
+	if (err)
+		goto err_pci_reg;
+
+	pci_set_master(pdev);
+	pci_save_state(pdev);
+	return 0;
+
+err_pci_reg:
+err_dma:
+	pci_disable_device(pdev);
+	return err;
+}
+
+/**
+ *  igc_remove - Device Removal Routine
+ *  @pdev: PCI device information struct
+ *
+ *  igc_remove is called by the PCI subsystem to alert the driver
+ *  that it should release a PCI device.  This could be caused by a
+ *  Hot-Plug event, or because the driver is going to be removed from
+ *  memory.
+ **/
+static void igc_remove(struct pci_dev *pdev)
+{
+	pci_release_selected_regions(pdev,
+				     pci_select_bars(pdev, IORESOURCE_MEM));
+
+	pci_disable_device(pdev);
+}
+
+static struct pci_driver igc_driver = {
+	.name     = igc_driver_name,
+	.id_table = igc_pci_tbl,
+	.probe    = igc_probe,
+	.remove   = igc_remove,
+};
+
+/**
+ *  igc_init_module - Driver Registration Routine
+ *
+ *  igc_init_module is the first routine called when the driver is
+ *  loaded. All it does is register with the PCI subsystem.
+ **/
+static int __init igc_init_module(void)
+{
+	int ret;
+
+	pr_info("%s - version %s\n",
+		igc_driver_string, igc_driver_version);
+
+	pr_info("%s\n", igc_copyright);
+
+	ret = pci_register_driver(&igc_driver);
+	return ret;
+}
+
+module_init(igc_init_module);
+
+/**
+ *  igc_exit_module - Driver Exit Cleanup Routine
+ *
+ *  igc_exit_module is called just before the driver is removed
+ *  from memory.
+ **/
+static void __exit igc_exit_module(void)
+{
+	pci_unregister_driver(&igc_driver);
+}
+
+module_exit(igc_exit_module);
+
+MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
+MODULE_DESCRIPTION(DRV_SUMMARY);
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+/* igc_main.c */
-- 
2.11.0


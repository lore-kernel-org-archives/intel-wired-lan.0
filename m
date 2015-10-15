From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 15 Oct 2015 14:24:41 -0700
Subject: [Intel-wired-lan] [next-queue v3 01/17] fm10k: conditionally
	compile DCB and DebugFS support
Message-ID: <1444944297-9733-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Rather than wrapping fm10k_dcbnl.c and fm10k_debugfs.c support with
 #ifdef blocks, just conditionally include the .o files in the Makefile.
 Also, since we're modifying it, update the copyright year on the
 Makefile.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/Makefile        | 20 +++++++++++++++-----
 drivers/net/ethernet/intel/fm10k/fm10k.h         |  4 ++++
 drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c   |  4 ----
 drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c |  4 ----
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c     |  4 ++++
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/Makefile b/drivers/net/ethernet/intel/fm10k/Makefile
index 08859dd220a8..b006ff66d028 100644
--- a/drivers/net/ethernet/intel/fm10k/Makefile
+++ b/drivers/net/ethernet/intel/fm10k/Makefile
@@ -1,7 +1,7 @@
 ################################################################################
 #
 # Intel Ethernet Switch Host Interface Driver
-# Copyright(c) 2013 - 2014 Intel Corporation.
+# Copyright(c) 2013 - 2015 Intel Corporation.
 #
 # This program is free software; you can redistribute it and/or modify it
 # under the terms and conditions of the GNU General Public License,
@@ -27,7 +27,17 @@
 
 obj-$(CONFIG_FM10K) += fm10k.o
 
-fm10k-objs := fm10k_main.o fm10k_common.o fm10k_pci.o \
-	      fm10k_netdev.o fm10k_ethtool.o fm10k_pf.o fm10k_vf.o \
-	      fm10k_mbx.o fm10k_iov.o fm10k_tlv.o \
-	      fm10k_debugfs.o fm10k_ptp.o fm10k_dcbnl.o
+fm10k-y := fm10k_main.o \
+	   fm10k_common.o \
+	   fm10k_pci.o \
+	   fm10k_ptp.o \
+	   fm10k_netdev.o \
+	   fm10k_ethtool.o \
+	   fm10k_pf.o \
+	   fm10k_vf.o \
+	   fm10k_mbx.o \
+	   fm10k_iov.o \
+	   fm10k_tlv.o
+
+fm10k-$(CONFIG_DEBUG_FS) += fm10k_debugfs.o
+fm10k-$(CONFIG_DCB) += fm10k_dcbnl.o
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 48809e5d3f79..aa9674a3d9ee 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -551,5 +551,9 @@ int fm10k_get_ts_config(struct net_device *netdev, struct ifreq *ifr);
 int fm10k_set_ts_config(struct net_device *netdev, struct ifreq *ifr);
 
 /* DCB */
+#ifdef CONFIG_DCB
 void fm10k_dcbnl_set_ops(struct net_device *dev);
+#else
+static inline void fm10k_dcbnl_set_ops(void) {}
+#endif
 #endif /* _FM10K_H_ */
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c b/drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c
index 5c7a4d7662d8..2be4361839db 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c
@@ -20,7 +20,6 @@
 
 #include "fm10k.h"
 
-#ifdef CONFIG_DCB
 /**
  * fm10k_dcbnl_ieee_getets - get the ETS configuration for the device
  * @dev: netdev interface for the device
@@ -155,7 +154,6 @@ static const struct dcbnl_rtnl_ops fm10k_dcbnl_ops = {
 	.setdcbx	= fm10k_dcbnl_setdcbx,
 };
 
-#endif /* CONFIG_DCB */
 /**
  * fm10k_dcbnl_set_ops - Configures dcbnl ops pointer for netdev
  * @dev: netdev interface for the device
@@ -164,11 +162,9 @@ static const struct dcbnl_rtnl_ops fm10k_dcbnl_ops = {
  **/
 void fm10k_dcbnl_set_ops(struct net_device *dev)
 {
-#ifdef CONFIG_DCB
 	struct fm10k_intfc *interface = netdev_priv(dev);
 	struct fm10k_hw *hw = &interface->hw;
 
 	if (hw->mac.type == fm10k_mac_pf)
 		dev->dcbnl_ops = &fm10k_dcbnl_ops;
-#endif /* CONFIG_DCB */
 }
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
index 5304bc1fbecd..5d6137faf7d1 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
@@ -18,8 +18,6 @@
  * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
  */
 
-#ifdef CONFIG_DEBUG_FS
-
 #include "fm10k.h"
 
 #include <linux/debugfs.h>
@@ -258,5 +256,3 @@ void fm10k_dbg_exit(void)
 	debugfs_remove_recursive(dbg_root);
 	dbg_root = NULL;
 }
-
-#endif /* CONFIG_DEBUG_FS */
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 5fbffbaefe32..0dece3c07727 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1729,8 +1729,10 @@ static int fm10k_sw_init(struct fm10k_intfc *interface,
 		netdev->hw_features &= ~NETIF_F_GSO_UDP_TUNNEL;
 	}
 
+#ifdef CONFIG_DCB
 	/* initialize DCBNL interface */
 	fm10k_dcbnl_set_ops(netdev);
+#endif
 
 	/* Initialize service timer and service task */
 	set_bit(__FM10K_SERVICE_DISABLE, &interface->state);
@@ -1919,8 +1921,10 @@ static int fm10k_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_sw_init;
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
 	/* enable debugfs support */
 	fm10k_dbg_intfc_init(interface);
+#endif
 
 	err = fm10k_init_queueing_scheme(interface);
 	if (err)
-- 
2.6.1.264.gbab76a9


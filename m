From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 13 Sep 2018 15:31:31 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 01/14] intel-ethernet:
 rename i40evf to iavf
In-Reply-To: <20180913223144.75823-1-jesse.brandeburg@intel.com>
References: <20180913223144.75823-1-jesse.brandeburg@intel.com>
Message-ID: <20180913223144.75823-2-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Rename the Intel Ethernet Adaptive Virtual Function driver
(i40evf) to a new name (iavf) that is more consistent with
the ongoing maintenance of the driver as the universal VF driver
for multiple product lines.

This first patch fixes up the directory names and the .ko name,
intentionally ignoring the function names inside the driver
for now.  Basically this is the simplest patch that gets
the rename done and will be followed by other patches that
rename the internal functions.

This patch also addresses a couple of string/name issues
and updates the Copyright year.

Also, made sure to add a MODULE_ALIAS to the old name.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 Documentation/networking/00-INDEX                        |  4 ++--
 Documentation/networking/{i40evf.txt => iavf.txt}        | 16 +++++++++-------
 MAINTAINERS                                              |  2 +-
 drivers/net/ethernet/intel/Kconfig                       | 12 +++++++-----
 drivers/net/ethernet/intel/Makefile                      |  2 +-
 drivers/net/ethernet/intel/{i40evf => iavf}/Makefile     | 11 +++++------
 .../net/ethernet/intel/{i40evf => iavf}/i40e_adminq.c    |  0
 .../net/ethernet/intel/{i40evf => iavf}/i40e_adminq.h    |  0
 .../ethernet/intel/{i40evf => iavf}/i40e_adminq_cmd.h    |  0
 drivers/net/ethernet/intel/{i40evf => iavf}/i40e_alloc.h |  0
 .../net/ethernet/intel/{i40evf => iavf}/i40e_common.c    |  0
 .../net/ethernet/intel/{i40evf => iavf}/i40e_devids.h    |  0
 drivers/net/ethernet/intel/{i40evf => iavf}/i40e_hmc.h   |  0
 .../net/ethernet/intel/{i40evf => iavf}/i40e_lan_hmc.h   |  0
 drivers/net/ethernet/intel/{i40evf => iavf}/i40e_osdep.h |  0
 .../net/ethernet/intel/{i40evf => iavf}/i40e_prototype.h |  0
 .../net/ethernet/intel/{i40evf => iavf}/i40e_register.h  |  0
 .../net/ethernet/intel/{i40evf => iavf}/i40e_status.h    |  0
 drivers/net/ethernet/intel/{i40evf => iavf}/i40e_trace.h |  0
 drivers/net/ethernet/intel/{i40evf => iavf}/i40e_txrx.c  |  0
 drivers/net/ethernet/intel/{i40evf => iavf}/i40e_txrx.h  |  0
 drivers/net/ethernet/intel/{i40evf => iavf}/i40e_type.h  |  0
 drivers/net/ethernet/intel/{i40evf => iavf}/i40evf.h     |  0
 .../net/ethernet/intel/{i40evf => iavf}/i40evf_client.c  |  0
 .../net/ethernet/intel/{i40evf => iavf}/i40evf_client.h  |  0
 .../net/ethernet/intel/{i40evf => iavf}/i40evf_ethtool.c |  0
 .../net/ethernet/intel/{i40evf => iavf}/i40evf_main.c    |  7 ++++---
 .../ethernet/intel/{i40evf => iavf}/i40evf_virtchnl.c    |  0
 28 files changed, 29 insertions(+), 25 deletions(-)
 rename Documentation/networking/{i40evf.txt => iavf.txt} (72%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/Makefile (37%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_adminq.c (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_adminq.h (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_adminq_cmd.h (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_alloc.h (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_common.c (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_devids.h (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_hmc.h (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_lan_hmc.h (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_osdep.h (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_prototype.h (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_register.h (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_status.h (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_trace.h (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_txrx.c (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_txrx.h (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40e_type.h (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40evf.h (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40evf_client.c (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40evf_client.h (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40evf_ethtool.c (100%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40evf_main.c (99%)
 rename drivers/net/ethernet/intel/{i40evf => iavf}/i40evf_virtchnl.c (100%)

diff --git a/Documentation/networking/00-INDEX b/Documentation/networking/00-INDEX
index dcbccae4043e..f4f2b5d6c8d8 100644
--- a/Documentation/networking/00-INDEX
+++ b/Documentation/networking/00-INDEX
@@ -94,8 +94,8 @@ gianfar.txt
 	- Gianfar Ethernet Driver.
 i40e.txt
 	- README for the Intel Ethernet Controller XL710 Driver (i40e).
-i40evf.txt
-	- Short note on the Driver for the Intel(R) XL710 X710 Virtual Function
+iavf.txt
+	- README for the Intel Ethernet Adaptive Virtual Function Driver (iavf).
 ieee802154.txt
 	- Linux IEEE 802.15.4 implementation, API and drivers
 igb.txt
diff --git a/Documentation/networking/i40evf.txt b/Documentation/networking/iavf.txt
similarity index 72%
rename from Documentation/networking/i40evf.txt
rename to Documentation/networking/iavf.txt
index e9b3035b95d0..cc902a2369d6 100644
--- a/Documentation/networking/i40evf.txt
+++ b/Documentation/networking/iavf.txt
@@ -2,7 +2,7 @@ Linux* Base Driver for Intel(R) Network Connection
 ==================================================
 
 Intel Ethernet Adaptive Virtual Function Linux driver.
-Copyright(c) 2013-2017 Intel Corporation.
+Copyright(c) 2013-2018 Intel Corporation.
 
 Contents
 ========
@@ -11,20 +11,21 @@ Contents
 - Known Issues/Troubleshooting
 - Support
 
-This file describes the i40evf Linux* Base Driver.
+This file describes the iavf Linux* Base Driver. This driver
+was formerly called i40evf.
 
-The i40evf driver supports the below mentioned virtual function
+The iavf driver supports the below mentioned virtual function
 devices and can only be activated on kernels running the i40e or
 newer Physical Function (PF) driver compiled with CONFIG_PCI_IOV.
-The i40evf driver requires CONFIG_PCI_MSI to be enabled.
+The iavf driver requires CONFIG_PCI_MSI to be enabled.
 
-The guest OS loading the i40evf driver must support MSI-X interrupts.
+The guest OS loading the iavf driver must support MSI-X interrupts.
 
 Supported Hardware
 ==================
 Intel XL710 X710 Virtual Function
-Intel Ethernet Adaptive Virtual Function
 Intel X722 Virtual Function
+Intel Ethernet Adaptive Virtual Function
 
 Identifying Your Adapter
 ========================
@@ -32,7 +33,8 @@ Identifying Your Adapter
 For more information on how to identify your adapter, go to the
 Adapter & Driver ID Guide at:
 
-    http://support.intel.com/support/go/network/adapter/idguide.htm
+    https://www.intel.com/content/www/us/en/support/articles/000005584/network-and-i-o/ethernet-products.html
+
 
 Known Issues/Troubleshooting
 ============================
diff --git a/MAINTAINERS b/MAINTAINERS
index 0b2e27e8abef..19c76e6f637d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7332,7 +7332,7 @@ F:	Documentation/networking/ixgb.txt
 F:	Documentation/networking/ixgbe.txt
 F:	Documentation/networking/ixgbevf.txt
 F:	Documentation/networking/i40e.txt
-F:	Documentation/networking/i40evf.txt
+F:	Documentation/networking/iavf.txt
 F:	Documentation/networking/ice.txt
 F:	drivers/net/ethernet/intel/
 F:	drivers/net/ethernet/intel/*/
diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 1ab613eb5796..9977884ef3c2 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -235,20 +235,22 @@ config I40E_DCB
 
 	  If unsure, say N.
 
-config I40EVF
+config IAVF
 	tristate "Intel(R) Ethernet Adaptive Virtual Function support"
 	depends on PCI_MSI
 	---help---
 	  This driver supports virtual functions for Intel XL710,
-	  X710, X722, and all devices advertising support for Intel
-	  Ethernet Adaptive Virtual Function devices. For more
+	  X710, X722, XXV710, and all devices advertising support for
+	  Intel Ethernet Adaptive Virtual Function devices. For more
 	  information on how to identify your adapter, go to the Adapter
 	  & Driver ID Guide that can be located at:
 
-	  <http://support.intel.com>
+	  <https://support.intel.com>
+
+	  This driver was formerly named i40evf.
 
 	  To compile this driver as a module, choose M here. The module
-	  will be called i40evf.  MSI-X interrupt support is required
+	  will be called iavf.  MSI-X interrupt support is required
 	  for this driver to work correctly.
 
 config ICE
diff --git a/drivers/net/ethernet/intel/Makefile b/drivers/net/ethernet/intel/Makefile
index 807a4f8c7e4e..b91153df6ee8 100644
--- a/drivers/net/ethernet/intel/Makefile
+++ b/drivers/net/ethernet/intel/Makefile
@@ -12,6 +12,6 @@ obj-$(CONFIG_IXGBE) += ixgbe/
 obj-$(CONFIG_IXGBEVF) += ixgbevf/
 obj-$(CONFIG_I40E) += i40e/
 obj-$(CONFIG_IXGB) += ixgb/
-obj-$(CONFIG_I40EVF) += i40evf/
+obj-$(CONFIG_IAVF) += iavf/
 obj-$(CONFIG_FM10K) += fm10k/
 obj-$(CONFIG_ICE) += ice/
diff --git a/drivers/net/ethernet/intel/i40evf/Makefile b/drivers/net/ethernet/intel/iavf/Makefile
similarity index 37%
rename from drivers/net/ethernet/intel/i40evf/Makefile
rename to drivers/net/ethernet/intel/iavf/Makefile
index 3c5c6e962280..ce2dce1e1ebf 100644
--- a/drivers/net/ethernet/intel/i40evf/Makefile
+++ b/drivers/net/ethernet/intel/iavf/Makefile
@@ -1,16 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright(c) 2013 - 2018 Intel Corporation.
-
 #
-## Makefile for the Intel(R) 40GbE VF driver
+# Makefile for the Intel(R) Ethernet Adaptive Virtual Function (iavf)
+# driver
 #
 #
 
 ccflags-y += -I$(src)
 subdir-ccflags-y += -I$(src)
 
-obj-$(CONFIG_I40EVF) += i40evf.o
-
-i40evf-objs :=	i40evf_main.o i40evf_ethtool.o i40evf_virtchnl.o \
-		i40e_txrx.o i40e_common.o i40e_adminq.o i40evf_client.o
+obj-$(CONFIG_IAVF) += iavf.o
 
+iavf-objs := i40evf_main.o i40evf_ethtool.o i40evf_virtchnl.o \
+		 i40e_txrx.o i40e_common.o i40e_adminq.o i40evf_client.o
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c b/drivers/net/ethernet/intel/iavf/i40e_adminq.c
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_adminq.c
rename to drivers/net/ethernet/intel/iavf/i40e_adminq.c
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq.h b/drivers/net/ethernet/intel/iavf/i40e_adminq.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_adminq.h
rename to drivers/net/ethernet/intel/iavf/i40e_adminq.h
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/iavf/i40e_adminq_cmd.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
rename to drivers/net/ethernet/intel/iavf/i40e_adminq_cmd.h
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_alloc.h b/drivers/net/ethernet/intel/iavf/i40e_alloc.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_alloc.h
rename to drivers/net/ethernet/intel/iavf/i40e_alloc.h
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/iavf/i40e_common.c
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_common.c
rename to drivers/net/ethernet/intel/iavf/i40e_common.c
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_devids.h b/drivers/net/ethernet/intel/iavf/i40e_devids.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_devids.h
rename to drivers/net/ethernet/intel/iavf/i40e_devids.h
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_hmc.h b/drivers/net/ethernet/intel/iavf/i40e_hmc.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_hmc.h
rename to drivers/net/ethernet/intel/iavf/i40e_hmc.h
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_lan_hmc.h b/drivers/net/ethernet/intel/iavf/i40e_lan_hmc.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_lan_hmc.h
rename to drivers/net/ethernet/intel/iavf/i40e_lan_hmc.h
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_osdep.h b/drivers/net/ethernet/intel/iavf/i40e_osdep.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_osdep.h
rename to drivers/net/ethernet/intel/iavf/i40e_osdep.h
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_prototype.h b/drivers/net/ethernet/intel/iavf/i40e_prototype.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_prototype.h
rename to drivers/net/ethernet/intel/iavf/i40e_prototype.h
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_register.h b/drivers/net/ethernet/intel/iavf/i40e_register.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_register.h
rename to drivers/net/ethernet/intel/iavf/i40e_register.h
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_status.h b/drivers/net/ethernet/intel/iavf/i40e_status.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_status.h
rename to drivers/net/ethernet/intel/iavf/i40e_status.h
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_trace.h b/drivers/net/ethernet/intel/iavf/i40e_trace.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_trace.h
rename to drivers/net/ethernet/intel/iavf/i40e_trace.h
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/iavf/i40e_txrx.c
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_txrx.c
rename to drivers/net/ethernet/intel/iavf/i40e_txrx.c
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/iavf/i40e_txrx.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_txrx.h
rename to drivers/net/ethernet/intel/iavf/i40e_txrx.h
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/iavf/i40e_type.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_type.h
rename to drivers/net/ethernet/intel/iavf/i40e_type.h
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/iavf/i40evf.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40evf.h
rename to drivers/net/ethernet/intel/iavf/i40evf.h
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_client.c b/drivers/net/ethernet/intel/iavf/i40evf_client.c
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40evf_client.c
rename to drivers/net/ethernet/intel/iavf/i40evf_client.c
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_client.h b/drivers/net/ethernet/intel/iavf/i40evf_client.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40evf_client.h
rename to drivers/net/ethernet/intel/iavf/i40evf_client.h
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c b/drivers/net/ethernet/intel/iavf/i40evf_ethtool.c
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
rename to drivers/net/ethernet/intel/iavf/i40evf_ethtool.c
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/iavf/i40evf_main.c
similarity index 99%
rename from drivers/net/ethernet/intel/i40evf/i40evf_main.c
rename to drivers/net/ethernet/intel/iavf/i40evf_main.c
index 174d1da2857b..6f34b54bd90f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/iavf/i40evf_main.c
@@ -17,20 +17,20 @@ static int i40evf_close(struct net_device *netdev);
 
 char i40evf_driver_name[] = "i40evf";
 static const char i40evf_driver_string[] =
-	"Intel(R) 40-10 Gigabit Virtual Function Network Driver";
+	"Intel(R) Ethernet Adaptive Virtual Function Network Driver";
 
 #define DRV_KERN "-k"
 
 #define DRV_VERSION_MAJOR 3
 #define DRV_VERSION_MINOR 2
-#define DRV_VERSION_BUILD 2
+#define DRV_VERSION_BUILD 3
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD) \
 	     DRV_KERN
 const char i40evf_driver_version[] = DRV_VERSION;
 static const char i40evf_copyright[] =
-	"Copyright (c) 2013 - 2015 Intel Corporation.";
+	"Copyright (c) 2013 - 2018 Intel Corporation.";
 
 /* i40evf_pci_tbl - PCI Device ID Table
  *
@@ -51,6 +51,7 @@ static const struct pci_device_id i40evf_pci_tbl[] = {
 
 MODULE_DEVICE_TABLE(pci, i40evf_pci_tbl);
 
+MODULE_ALIAS("i40evf");
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) XL710 X710 Virtual Function Network Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/iavf/i40evf_virtchnl.c
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
rename to drivers/net/ethernet/intel/iavf/i40evf_virtchnl.c
-- 
2.14.4


From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 13 Sep 2018 15:31:44 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 14/14] intel-ethernet: use
 correct module license
In-Reply-To: <20180913223144.75823-1-jesse.brandeburg@intel.com>
References: <20180913223144.75823-1-jesse.brandeburg@intel.com>
Message-ID: <20180913223144.75823-15-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We recently updated all our SPDX identifiers to correctly
indicate our net/ethernet/intel/* drivers were always released
and intended to be released under GPL v2, but the MODULE_LICENSE
declaration was never updated.

Fix the MODULE_LICENSE to be GPL v2, for all our drivers.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/e100.c                 | 2 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c     | 2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c        | 2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c     | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c       | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c       | 4 ++--
 drivers/net/ethernet/intel/ice/ice_main.c         | 2 +-
 drivers/net/ethernet/intel/igb/igb_main.c         | 2 +-
 drivers/net/ethernet/intel/igbvf/netdev.c         | 2 +-
 drivers/net/ethernet/intel/ixgb/ixgb_main.c       | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 12 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 27d5f27163d2..7c4b55482f72 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -164,7 +164,7 @@
 
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
 MODULE_AUTHOR(DRV_COPYRIGHT);
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
 MODULE_FIRMWARE(FIRMWARE_D101M);
 MODULE_FIRMWARE(FIRMWARE_D101S);
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 2110d5f2da19..7e0f1f96a8a1 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -195,7 +195,7 @@ static struct pci_driver e1000_driver = {
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) PRO/1000 Network Driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
 
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 3ba0c90e7055..c0f9faca70c4 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7592,7 +7592,7 @@ module_exit(e1000_exit_module);
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) PRO/1000 Network Driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
 
 /* netdev.c */
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 3f536541f45f..503bbc017792 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -21,7 +21,7 @@ static const char fm10k_copyright[] =
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION(DRV_SUMMARY);
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
 
 /* single workqueue for entire fm10k driver */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5d209d8fe9b8..c7d2c9010fdf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -91,7 +91,7 @@ MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all), Debug mask (0x8XXXXXXX
 
 MODULE_AUTHOR("Intel Corporation, <e1000-devel@lists.sourceforge.net>");
 MODULE_DESCRIPTION("Intel(R) Ethernet Connection XL710 Network Driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
 
 static struct workqueue_struct *i40e_wq;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 54d8a1ed05ac..0e2f78175f0e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -53,8 +53,8 @@ MODULE_DEVICE_TABLE(pci, iavf_pci_tbl);
 
 MODULE_ALIAS("i40evf");
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
-MODULE_DESCRIPTION("Intel(R) XL710 X710 Virtual Function Network Driver");
-MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Intel(R) Ethernet Adaptive Virtual Function Network Driver");
+MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
 
 static struct workqueue_struct *iavf_wq;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1b49a605d094..d54e63785ff0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -15,7 +15,7 @@ static const char ice_copyright[] = "Copyright (c) 2018, Intel Corporation.";
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION(DRV_SUMMARY);
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
 
 static int debug = -1;
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a32c576c1e65..c18e79112cad 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -243,7 +243,7 @@ static struct pci_driver igb_driver = {
 
 MODULE_AUTHOR("Intel Corporation, <e1000-devel@lists.sourceforge.net>");
 MODULE_DESCRIPTION("Intel(R) Gigabit Ethernet Network Driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
 
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index e0c989ffb2b3..820d49eb41ab 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -3011,7 +3011,7 @@ module_exit(igbvf_exit_module);
 
 MODULE_AUTHOR("Intel Corporation, <e1000-devel@lists.sourceforge.net>");
 MODULE_DESCRIPTION("Intel(R) Gigabit Virtual Function Network Driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
 
 /* netdev.c */
diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_main.c b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
index d3e72d0f66ef..4bb89587cd6a 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_main.c
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
@@ -107,7 +107,7 @@ static struct pci_driver ixgb_driver = {
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) PRO/10GbE Network Driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
 
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 604282f03d23..27a8546c88b2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -159,7 +159,7 @@ MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) 10 Gigabit PCI Express Network Driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
 
 static struct workqueue_struct *ixgbe_wq;
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 17e23f609d74..ba6562e8cd73 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -79,7 +79,7 @@ MODULE_DEVICE_TABLE(pci, ixgbevf_pci_tbl);
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) 10 Gigabit Virtual Function Network Driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
 
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
-- 
2.14.4


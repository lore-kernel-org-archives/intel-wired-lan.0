From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  9 Mar 2020 14:31:57 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: remove driver version from fm10k
 module
Message-ID: <20200309213157.181873-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

As with other networking drivers, remove the unnecessary driver version
from the fm10k module. The ethtool driver information and module version
will then report the kernel version instead.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h         | 1 -
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 2 --
 drivers/net/ethernet/intel/fm10k/fm10k_main.c    | 5 +----
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 5b78362b82ac..f9be10a04dd6 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -476,7 +476,6 @@ struct fm10k_cb {
 
 /* main */
 extern char fm10k_driver_name[];
-extern const char fm10k_driver_version[];
 int fm10k_init_queueing_scheme(struct fm10k_intfc *interface);
 void fm10k_clear_queueing_scheme(struct fm10k_intfc *interface);
 __be16 fm10k_tx_encap_offload(struct sk_buff *skb);
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 68edf55ac906..3cae18a3bcf0 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -449,8 +449,6 @@ static void fm10k_get_drvinfo(struct net_device *dev,
 
 	strncpy(info->driver, fm10k_driver_name,
 		sizeof(info->driver) - 1);
-	strncpy(info->version, fm10k_driver_version,
-		sizeof(info->version) - 1);
 	strncpy(info->bus_info, pci_name(interface->pdev),
 		sizeof(info->bus_info) - 1);
 }
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 17738b0a9873..05e9bdb5f4aa 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -11,9 +11,7 @@
 
 #include "fm10k.h"
 
-#define DRV_VERSION	"0.27.1-k"
 #define DRV_SUMMARY	"Intel(R) Ethernet Switch Host Interface Driver"
-const char fm10k_driver_version[] = DRV_VERSION;
 char fm10k_driver_name[] = "fm10k";
 static const char fm10k_driver_string[] = DRV_SUMMARY;
 static const char fm10k_copyright[] =
@@ -22,7 +20,6 @@ static const char fm10k_copyright[] =
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION(DRV_SUMMARY);
 MODULE_LICENSE("GPL v2");
-MODULE_VERSION(DRV_VERSION);
 
 /* single workqueue for entire fm10k driver */
 struct workqueue_struct *fm10k_workqueue;
@@ -35,7 +32,7 @@ struct workqueue_struct *fm10k_workqueue;
  **/
 static int __init fm10k_init_module(void)
 {
-	pr_info("%s - version %s\n", fm10k_driver_string, fm10k_driver_version);
+	pr_info("%s\n", fm10k_driver_string);
 	pr_info("%s\n", fm10k_copyright);
 
 	/* create driver workqueue */
-- 
2.24.1


From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  6 Nov 2015 15:09:58 -0800
Subject: [Intel-wired-lan] [net-next PATCH] fm10k: remove CONFIG_FM10K_VXLAN
	in favor of CONFIG_VXLAN
Message-ID: <1446851398-20915-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There isn't a really compelling reason to keep CONFIG_FM10K_VXLAN around
when we could just check against CONFIG_VXLAN directly.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/Kconfig              | 11 -----------
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |  8 ++++----
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 4163b16489b3..c69e4d241dd0 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -340,15 +340,4 @@ config FM10K
 	  To compile this driver as a module, choose M here. The module
 	  will be called fm10k.  MSI-X interrupt support is required
 
-config FM10K_VXLAN
-	bool "Virtual eXtensible Local Area Network Support"
-	default n
-	depends on FM10K && VXLAN && !(FM10K=y && VXLAN=m)
-	---help---
-	  This allows one to create VXLAN virtual interfaces that provide
-	  Layer 2 Networks over Layer 3 Networks. VXLAN is often used
-	  to tunnel virtual network infrastructure in virtualized environments.
-	  Say Y here if you want to use Virtual eXtensible Local Area Network
-	  (VXLAN) in the driver.
-
 endif # NET_VENDOR_INTEL
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 722ac52d9c96..7ab0e449a586 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -20,9 +20,9 @@
 
 #include "fm10k.h"
 #include <linux/vmalloc.h>
-#if IS_ENABLED(CONFIG_FM10K_VXLAN)
+#if IS_ENABLED(CONFIG_VXLAN)
 #include <net/vxlan.h>
-#endif /* CONFIG_FM10K_VXLAN */
+#endif /* CONFIG_VXLAN */
 
 /**
  * fm10k_setup_tx_resources - allocate Tx resources (Descriptors)
@@ -556,11 +556,11 @@ int fm10k_open(struct net_device *netdev)
 	if (err)
 		goto err_set_queues;
 
-#if IS_ENABLED(CONFIG_FM10K_VXLAN)
+#if IS_ENABLED(CONFIG_VXLAN)
 	/* update VXLAN port configuration */
 	vxlan_get_rx_port(netdev);
+#endif /* CONFIG_VXLAN */
 
-#endif
 	fm10k_up(interface);
 
 	return 0;
-- 
2.6.1.264.gbab76a9


From: Bruce Allan <bruce.w.allan@intel.com>
Date: Tue, 08 Dec 2015 17:20:49 -0800
Subject: [Intel-wired-lan] [PATCH] fm10k: IS_ENABLED() is not appropriate
 for boolean kconfig option
Message-ID: <20151209012049.134015.46680.stgit@bwallan-cwp1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Tri-states need 'if IS_ENABLED()', booleans should use 'ifdef'.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 55b52bb..8a9bcab 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -20,7 +20,7 @@
 
 #include "fm10k.h"
 #include <linux/vmalloc.h>
-#if IS_ENABLED(CONFIG_FM10K_VXLAN)
+#ifdef CONFIG_FM10K_VXLAN
 #include <net/vxlan.h>
 #endif /* CONFIG_FM10K_VXLAN */
 
@@ -556,11 +556,11 @@ int fm10k_open(struct net_device *netdev)
 	if (err)
 		goto err_set_queues;
 
-#if IS_ENABLED(CONFIG_FM10K_VXLAN)
+#ifdef CONFIG_FM10K_VXLAN
 	/* update VXLAN port configuration */
 	vxlan_get_rx_port(netdev);
-
 #endif
+
 	fm10k_up(interface);
 
 	return 0;


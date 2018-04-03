From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 03 Apr 2018 17:16:35 -0400
Subject: [Intel-wired-lan] [iwl next-queue PATCH 08/10] ixgbe/fm10k: Only
 support macvlan offload for types that support destination filtering
In-Reply-To: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180403211635.7880.27194.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Both the ixgbe and fm10k drivers support destination filtering.

Instead of adding a ton of complexity to support either source or passthru
mode we can instead just avoid offloading them for now. Doing this we avoid
leaking packets into interfaces that aren't meant to receive them.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |    8 ++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |    7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index ee645ba..26e7497 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -22,6 +22,7 @@
 #include "fm10k.h"
 #include <linux/vmalloc.h>
 #include <net/udp_tunnel.h>
+#include <linux/if_macvlan.h>
 
 /**
  * fm10k_setup_tx_resources - allocate Tx resources (Descriptors)
@@ -1449,6 +1450,13 @@ static void *fm10k_dfwd_add_station(struct net_device *dev,
 	int size = 0, i;
 	u16 glort;
 
+	/* The hardware supported by fm10k only filters on the destination MAC
+	 * address. In order to avoid issues we only support offloading modes
+	 * where the hardware can actually provide the functionality.
+	 */
+	if (!macvlan_supports_dest_filter(sdev))
+		return ERR_PTR(-EMEDIUMTYPE);
+
 	/* allocate l2 accel structure if it is not available */
 	if (!l2_accel) {
 		/* verify there is enough free GLORTs to support l2_accel */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2c5100e..7c0f310 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9744,6 +9744,13 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 	unsigned int limit;
 	int pool, err;
 
+	/* The hardware supported by ixgbe only filters on the destination MAC
+	 * address. In order to avoid issues we only support offloading modes
+	 * where the hardware can actually provide the functionality.
+	 */
+	if (!macvlan_supports_dest_filter(vdev))
+		return ERR_PTR(-EMEDIUMTYPE);
+
 	/* Hardware has a limited number of available pools. Each VF, and the
 	 * PF require a pool. Check to ensure we don't attempt to use more
 	 * then the available number of pools.


From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 24 Oct 2018 17:50:00 +0300
Subject: [Intel-wired-lan] [PATCH] igc: Minor cleaning up of code
Message-ID: <20181024145000.39034-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Address few community comments.
Remove unused code, will be add per demand.
Remove blank lines and unneeded includes.
Update driver version accordance to kernel version.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  9 ---------
 drivers/net/ethernet/intel/igc/igc_main.c | 17 +----------------
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index cdf18a5d9e08..3b00b109b34a 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -5,23 +5,14 @@
 #define _IGC_H_
 
 #include <linux/kobject.h>
-
 #include <linux/pci.h>
 #include <linux/netdevice.h>
 #include <linux/vmalloc.h>
-
 #include <linux/ethtool.h>
-
 #include <linux/sctp.h>
 
 #define IGC_ERR(args...) pr_err("igc: " args)
 
-#define PFX "igc: "
-
-#include <linux/timecounter.h>
-#include <linux/net_tstamp.h>
-#include <linux/ptp_clock_kernel.h>
-
 #include "igc_hw.h"
 
 /* main */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 9d85707e8a81..27d836f35bc2 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -9,7 +9,7 @@
 #include "igc.h"
 #include "igc_hw.h"
 
-#define DRV_VERSION	"0.0.1-k"
+#define DRV_VERSION	"0.4.20-k"
 #define DRV_SUMMARY	"Intel(R) 2.5G Ethernet Linux Driver"
 
 static int debug = -1;
@@ -1700,20 +1700,6 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
 }
 
 /**
- * igc_ioctl - I/O control method
- * @netdev: network interface device structure
- * @ifreq: frequency
- * @cmd: command
- */
-static int igc_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
-{
-	switch (cmd) {
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
-/**
  * igc_up - Open the interface and prepare it to handle traffic
  * @adapter: board private structure
  */
@@ -3445,7 +3431,6 @@ static const struct net_device_ops igc_netdev_ops = {
 	.ndo_set_mac_address	= igc_set_mac,
 	.ndo_change_mtu		= igc_change_mtu,
 	.ndo_get_stats		= igc_get_stats,
-	.ndo_do_ioctl		= igc_ioctl,
 };
 
 /* PCIe configuration access */
-- 
2.11.0


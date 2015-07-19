From: Raanan Avargil <raanan.avargil@intel.com>
Date: Sun, 19 Jul 2015 16:33:21 +0300
Subject: [Intel-wired-lan] [PATCH 2/2] e1000e: Increase driver version number
In-Reply-To: <eb0fc1b6ebdfe79027886fbf2f64f985a413614d.1437312332.git.raanan.avargil@intel.com>
References: <eb0fc1b6ebdfe79027886fbf2f64f985a413614d.1437312332.git.raanan.avargil@intel.com>
Message-ID: <f92a4875ce51f240570743318c821b69083234c4.1437312332.git.raanan.avargil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index f6db0c2..c058487 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -48,7 +48,7 @@
 
 #define DRV_EXTRAVERSION "-k"
 
-#define DRV_VERSION "3.2.5" DRV_EXTRAVERSION
+#define DRV_VERSION "3.2.6" DRV_EXTRAVERSION
 char e1000e_driver_name[] = "e1000e";
 const char e1000e_driver_version[] = DRV_VERSION;
 
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


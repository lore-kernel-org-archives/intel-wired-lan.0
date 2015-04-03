From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:33:10 -0700
Subject: [Intel-wired-lan] [net-next] fm10k: Bump driver version to 0.15.2
Message-ID: <1428093190-17097-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With the recent driver changes, bump the version.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index cd2e86a..7207071 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -28,7 +28,7 @@
 
 #include "fm10k.h"
 
-#define DRV_VERSION	"0.12.2-k"
+#define DRV_VERSION	"0.15.2-k"
 const char fm10k_driver_version[] = DRV_VERSION;
 char fm10k_driver_name[] = "fm10k";
 static const char fm10k_driver_string[] =
-- 
1.9.3


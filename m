From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 26 Oct 2015 14:35:39 -0700
Subject: [Intel-wired-lan] [next-queue] fm10k: bump driver version
Message-ID: <1445895339-1610-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We haven't bumped the driver version in a while despite many fixes being
pulled in from the out-of-tree Sourceforge driver. Update the version to
match.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 7114bea841d3..44576fe51132 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -28,7 +28,7 @@
 
 #include "fm10k.h"
 
-#define DRV_VERSION	"0.15.2-k"
+#define DRV_VERSION	"0.19.1-k"
 const char fm10k_driver_version[] = DRV_VERSION;
 char fm10k_driver_name[] = "fm10k";
 static const char fm10k_driver_string[] =
-- 
2.6.1.264.gbab76a9


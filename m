From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 26 Sep 2019 14:29:04 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: update driver version to match
 out-of-tree
Message-ID: <20190926212904.27184-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

An upcoming out-of-tree release will be occurring which will include the
recent functionality to support virtual function statistics. Update the
kernel driver version to match this.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 2be9222510e7..17738b0a9873 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -11,7 +11,7 @@
 
 #include "fm10k.h"
 
-#define DRV_VERSION	"0.26.1-k"
+#define DRV_VERSION	"0.27.1-k"
 #define DRV_SUMMARY	"Intel(R) Ethernet Switch Host Interface Driver"
 const char fm10k_driver_version[] = DRV_VERSION;
 char fm10k_driver_name[] = "fm10k";
-- 
2.23.0.245.gf157bbb9169d


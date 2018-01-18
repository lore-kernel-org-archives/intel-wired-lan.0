From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 18 Jan 2018 09:18:57 -0800
Subject: [Intel-wired-lan] [PATCH] fm10k: bump version number
Message-ID: <20180118171857.28279-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We're aligned with latest version released on SourceForge, so update the
version number to match.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 8e12aae065d8..2c93d719438f 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -28,13 +28,13 @@
 
 #include "fm10k.h"
 
-#define DRV_VERSION	"0.22.1-k"
+#define DRV_VERSION	"0.23.4-k"
 #define DRV_SUMMARY	"Intel(R) Ethernet Switch Host Interface Driver"
 const char fm10k_driver_version[] = DRV_VERSION;
 char fm10k_driver_name[] = "fm10k";
 static const char fm10k_driver_string[] = DRV_SUMMARY;
 static const char fm10k_copyright[] =
-	"Copyright(c) 2013 - 2017 Intel Corporation.";
+	"Copyright(c) 2013 - 2018 Intel Corporation.";
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION(DRV_SUMMARY);
-- 
2.15.1.478.ga1e07cd25f8b


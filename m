From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 10 Feb 2016 14:45:49 -0800
Subject: [Intel-wired-lan] [PATCH 4/6] fm10k: update driver summary and
	reduce code duplication
In-Reply-To: <1455144351-14758-1-git-send-email-jacob.e.keller@intel.com>
References: <1455144351-14758-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1455144351-14758-4-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use DRV_SUMMARY, similar to DRV_VERSION so that we don't have to
duplicate the driver summary. Also update summary to more accurately
describe the driver.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 3f6782bbd4dc..8ffe58540406 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -29,15 +29,15 @@
 #include "fm10k.h"
 
 #define DRV_VERSION	"0.19.3-k"
+#define DRV_SUMMARY	"Intel(R) Ethernet Multi-host Controller Driver"
 const char fm10k_driver_version[] = DRV_VERSION;
 char fm10k_driver_name[] = "fm10k";
-static const char fm10k_driver_string[] =
-	"Intel(R) Ethernet Switch Host Interface Driver";
+static const char fm10k_driver_string[] = DRV_SUMMARY;
 static const char fm10k_copyright[] =
 	"Copyright (c) 2013 Intel Corporation.";
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
-MODULE_DESCRIPTION("Intel(R) Ethernet Switch Host Interface Driver");
+MODULE_DESCRIPTION(DRV_SUMMARY);
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
-- 
2.7.0.236.gda096a0.dirty


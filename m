From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 25 Feb 2016 17:08:25 -0800
Subject: [Intel-wired-lan] [PATCH v3] fm10k: remove duplication of the
	driver summary
Message-ID: <1456448905-16882-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use DRV_SUMMARY, similar to DRV_VERSION so that we don't have duplicate
copies of the summary left in the driver.

Also update the file copyright string and the ethtool copyright string
while we are here.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 3a81c1451624..98166e8b0789 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1,5 +1,5 @@
 /* Intel Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2014 Intel Corporation.
+ * Copyright(c) 2013 - 2016 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -29,15 +29,15 @@
 #include "fm10k.h"
 
 #define DRV_VERSION	"0.19.3-k"
+#define DRV_SUMMARY	"Intel(R) Ethernet Switch Host Interface Driver"
 const char fm10k_driver_version[] = DRV_VERSION;
 char fm10k_driver_name[] = "fm10k";
-static const char fm10k_driver_string[] =
-	"Intel(R) Ethernet Switch Host Interface Driver";
+static const char fm10k_driver_string[] = DRV_SUMMARY;
 static const char fm10k_copyright[] =
-	"Copyright (c) 2013 Intel Corporation.";
+	"Copyright (c) 2013 - 2016 Intel Corporation.";
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
-MODULE_DESCRIPTION("Intel(R) Ethernet Switch Host Interface Driver");
+MODULE_DESCRIPTION(DRV_SUMMARY);
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
-- 
2.7.1.429.g45cd78e


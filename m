From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  9 Mar 2016 16:36:08 -0800
Subject: [Intel-wired-lan] [PATCH v2] fm10k: use DRV_SUMMARY to reduce code
	duplication
In-Reply-To: <1457570168-30798-1-git-send-email-jacob.e.keller@intel.com>
References: <1457570168-30798-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1457570168-30798-2-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use DRV_SUMMARY, similar to DRV_VERSION so that we don't have to
duplicate the driver summary in multiple places.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

As per the summary this is a complete replacement for 2a7b5dd0e752
("fm10k: update driver summary and reduce code duplication", 2016-03-09)
and should thus replace that patch in the queue.

Notes:
    - v2
    * Don't change the driver summary

 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 3a81c1451624..7832f9cdf743 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
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
 	"Copyright (c) 2013 Intel Corporation.";
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
-MODULE_DESCRIPTION("Intel(R) Ethernet Switch Host Interface Driver");
+MODULE_DESCRIPTION(DRV_SUMMARY);
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
-- 
2.8.0.rc1.177.g5628860


From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  9 Mar 2016 16:36:07 -0800
Subject: [Intel-wired-lan] [PATCH v2] fm10k:update driver summary and reduce
	code duplication
Message-ID: <1457570168-30798-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following patch is a complete replacement for 2a7b5dd0e752 ("fm10k:
update driver summary and reduce code duplication", 2016-03-09) and the
old version above should be dropped from the queue before applying this
one. For reviewers convenience I have shown an interdiff of the two
patches below.

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index c87613f1c7be..7832f9cdf743 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -29,7 +29,7 @@
 #include "fm10k.h"
 
 #define DRV_VERSION	"0.19.3-k"
-#define DRV_SUMMARY	"Intel(R) Ethernet Multi-host Controller Driver"
+#define DRV_SUMMARY	"Intel(R) Ethernet Switch Host Interface Driver"
 const char fm10k_driver_version[] = DRV_VERSION;
 char fm10k_driver_name[] = "fm10k";
 static const char fm10k_driver_string[] = DRV_SUMMARY;

Jacob Keller (1):
  fm10k: use DRV_SUMMARY to reduce code duplication

 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.8.0.rc1.177.g5628860


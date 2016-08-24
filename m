From: Todd Fujinaka <todd.fujinaka@intel.com>
Date: Wed, 24 Aug 2016 08:40:23 -0700
Subject: [Intel-wired-lan] [PATCH] igb: bump version to igb-5.4.0
Message-ID: <1472053223-2123-1-git-send-email-todd.fujinaka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bump igb version to match other igb drivers.

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1684a75..293c210 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -58,7 +58,7 @@
 #include "igb.h"
 
 #define MAJ 5
-#define MIN 3
+#define MIN 4
 #define BUILD 0
 #define DRV_VERSION __stringify(MAJ) "." __stringify(MIN) "." \
 __stringify(BUILD) "-k"
-- 
2.7.4


From: Todd Fujinaka <todd.fujinaka@intel.com>
Date: Wed, 23 Jan 2019 14:56:30 -0800
Subject: [Intel-wired-lan] [PATCH] igb: Bump version number
Message-ID: <20190123225630.2724-1-todd.fujinaka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index e0e8f7a708e9..e47149fbd440 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -39,7 +39,7 @@
 #include "igb.h"
 
 #define MAJ 5
-#define MIN 4
+#define MIN 6
 #define BUILD 0
 #define DRV_VERSION __stringify(MAJ) "." __stringify(MIN) "." \
 __stringify(BUILD) "-k"
-- 
2.20.1


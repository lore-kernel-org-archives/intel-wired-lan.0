From: Todd Fujinaka <todd.fujinaka@intel.com>
Date: Wed, 20 May 2015 15:40:20 -0700
Subject: [Intel-wired-lan] [PATCH] igb: bump version to igb-5.3.0
Message-ID: <20150520224020.16404.68655.stgit@htfujina-fc.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 23cf876..8533b3e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -57,8 +57,8 @@
 #include "igb.h"
 
 #define MAJ 5
-#define MIN 2
-#define BUILD 18
+#define MIN 3
+#define BUILD 0
 #define DRV_VERSION __stringify(MAJ) "." __stringify(MIN) "." \
 __stringify(BUILD) "-k"
 char igb_driver_name[] = "igb";


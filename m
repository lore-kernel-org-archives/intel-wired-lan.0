From: Todd Fujinaka <todd.fujinaka@intel.com>
Date: Fri, 17 Apr 2015 11:25:04 -0700
Subject: [Intel-wired-lan] [PATCH] igb: bump version of igb to 5.2.18
Message-ID: <20150417182504.13679.36234.stgit@htfujina-fc.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bump version of igb to igb-5.2.18

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 8457d03..a6e43bf 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -58,7 +58,7 @@
 
 #define MAJ 5
 #define MIN 2
-#define BUILD 15
+#define BUILD 18
 #define DRV_VERSION __stringify(MAJ) "." __stringify(MIN) "." \
 __stringify(BUILD) "-k"
 char igb_driver_name[] = "igb";


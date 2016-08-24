From: Todd Fujinaka <todd.fujinaka@intel.com>
Date: Wed, 24 Aug 2016 08:38:46 -0700
Subject: [Intel-wired-lan] [PATCH] igbvf: bump version to igbvf-2.4.0
Message-ID: <1472053126-1993-1-git-send-email-todd.fujinaka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bump version to match other igbvf drivers.

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index b0778ba..12bb877 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -47,7 +47,7 @@
 
 #include "igbvf.h"
 
-#define DRV_VERSION "2.0.2-k"
+#define DRV_VERSION "2.4.0-k"
 char igbvf_driver_name[] = "igbvf";
 const char igbvf_driver_version[] = DRV_VERSION;
 static const char igbvf_driver_string[] =
-- 
2.7.4


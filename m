From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 18 Sep 2015 10:08:00 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Delete redundant include file
Message-ID: <20150918170800.96392.40815.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Delete a redundant include of net/vxlan.h.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 49be9d21d6b5..708957c75936 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -65,9 +65,6 @@
 #include "ixgbe_common.h"
 #include "ixgbe_dcb_82599.h"
 #include "ixgbe_sriov.h"
-#ifdef CONFIG_IXGBE_VXLAN
-#include <net/vxlan.h>
-#endif
 
 char ixgbe_driver_name[] = "ixgbe";
 static const char ixgbe_driver_string[] =


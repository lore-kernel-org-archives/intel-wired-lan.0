From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 14 Sep 2020 18:44:50 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 05/10] drivers/net/ethernet:
 rid ethernet of no-prototype warnings
In-Reply-To: <20200915014455.1232507-1-jesse.brandeburg@intel.com>
References: <20200915014455.1232507-1-jesse.brandeburg@intel.com>
Message-ID: <20200915014455.1232507-6-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The W=1 builds showed a few files exporting functions
(non-static) that were not prototyped. What actually happened is
that there were prototypes, but the include file was forgotten in
the implementation file.

Add the include file and remove the warnings.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/cavium/liquidio/cn68xx_device.c   | 1 +
 drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c  | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn68xx_device.c b/drivers/net/ethernet/cavium/liquidio/cn68xx_device.c
index 50b533ff58e6..30254e4cf70f 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn68xx_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn68xx_device.c
@@ -25,6 +25,7 @@
 #include "octeon_main.h"
 #include "cn66xx_regs.h"
 #include "cn66xx_device.h"
+#include "cn68xx_device.h"
 #include "cn68xx_regs.h"
 
 static void lio_cn68xx_set_dpi_regs(struct octeon_device *oct)
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c b/drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c
index 4c85ae643b7b..7ccab36143c1 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c
@@ -22,6 +22,7 @@
 #include "octeon_iq.h"
 #include "response_manager.h"
 #include "octeon_device.h"
+#include "octeon_mem_ops.h"
 
 #define MEMOPS_IDX   BAR1_INDEX_DYNAMIC_MAP
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index d6c3952aba04..f28b8f3df857 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -3,6 +3,7 @@
 
 #include "hclge_main.h"
 #include "hclge_tm.h"
+#include "hclge_dcb.h"
 #include "hnae3.h"
 
 #define BW_PERCENT	100
-- 
2.28.0


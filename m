From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Date: Fri, 25 Sep 2020 15:24:40 -0700
Subject: [Intel-wired-lan] [PATCH net-next v3 4/9] drivers/net/ethernet: rid
 ethernet of no-prototype warnings
In-Reply-To: <20200925222445.74531-1-jesse.brandeburg@gmail.com>
References: <20200925222445.74531-1-jesse.brandeburg@gmail.com>
Message-ID: <20200925222445.74531-5-jesse.brandeburg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The W=1 builds showed a few files exporting functions
(non-static) that were not prototyped. What actually happened is
that there were prototypes, but the include file was forgotten in
the implementation file.

Add the include file and remove the warnings.

Fixed Warnings:
drivers/net/ethernet/cavium/liquidio/cn68xx_device.c:124:5: warning: no previous prototype for ?lio_setup_cn68xx_octeon_device? [-Wmissing-prototypes]
drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c:159:1: warning: no previous prototype for ?octeon_pci_read_core_mem? [-Wmissing-prototypes]
drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c:168:1: warning: no previous prototype for ?octeon_pci_write_core_mem? [-Wmissing-prototypes]
drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c:176:5: warning: no previous prototype for ?octeon_read_device_mem64? [-Wmissing-prototypes]
drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c:185:5: warning: no previous prototype for ?octeon_read_device_mem32? [-Wmissing-prototypes]
drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c:194:6: warning: no previous prototype for ?octeon_write_device_mem32? [-Wmissing-prototypes]
drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c:453:6: warning: no previous prototype for ?hclge_dcb_ops_set? [-Wmissing-prototypes]

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v3: add warnings detail
v2: first non-rfc version

Full list of warnings:
drivers/net/ethernet/cavium/liquidio/cn68xx_device.c:124:5: warning: no previous prototype for ?lio_setup_cn68xx_octeon_device? [-Wmissing-prototypes]
  124 | int lio_setup_cn68xx_octeon_device(struct octeon_device *oct)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c:159:1: warning: no previous prototype for ?octeon_pci_read_core_mem? [-Wmissing-prototypes]
  159 | octeon_pci_read_core_mem(struct octeon_device *oct,
      | ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c:168:1: warning: no previous prototype for ?octeon_pci_write_core_mem? [-Wmissing-prototypes]
  168 | octeon_pci_write_core_mem(struct octeon_device *oct,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c:176:5: warning: no previous prototype for ?octeon_read_device_mem64? [-Wmissing-prototypes]
  176 | u64 octeon_read_device_mem64(struct octeon_device *oct, u64 coreaddr)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c:185:5: warning: no previous prototype for ?octeon_read_device_mem32? [-Wmissing-prototypes]
  185 | u32 octeon_read_device_mem32(struct octeon_device *oct, u64 coreaddr)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c:194:6: warning: no previous prototype for ?octeon_write_device_mem32? [-Wmissing-prototypes]
  194 | void octeon_write_device_mem32(struct octeon_device *oct, u64 coreaddr,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c:453:6: warning: no previous prototype for ?hclge_dcb_ops_set? [-Wmissing-prototypes]
  453 | void hclge_dcb_ops_set(struct hclge_dev *hdev)
      |      ^~~~~~~~~~~~~~~~~
---
 drivers/net/ethernet/cavium/liquidio/cn68xx_device.c   | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn68xx_device.c b/drivers/net/ethernet/cavium/liquidio/cn68xx_device.c
index cd5d5d6e7e5e..2a6d1cadac9e 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn68xx_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn68xx_device.c
@@ -25,6 +25,7 @@
 #include "octeon_main.h"
 #include "cn66xx_regs.h"
 #include "cn66xx_device.h"
+#include "cn68xx_device.h"
 #include "cn68xx_regs.h"
 #include "cn68xx_device.h"
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index f990f6915226..3606240025a8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -4,6 +4,7 @@
 #include "hclge_main.h"
 #include "hclge_dcb.h"
 #include "hclge_tm.h"
+#include "hclge_dcb.h"
 #include "hnae3.h"
 
 #define BW_PERCENT	100
-- 
2.25.4


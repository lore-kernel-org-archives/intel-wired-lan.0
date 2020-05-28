From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Thu, 28 May 2020 12:43:38 -0700
Subject: [Intel-wired-lan] [PATCH 10/14] virtual-bus: reorder header includes
In-Reply-To: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
References: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
Message-ID: <20200528194342.3495-11-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/bus/virtual_bus.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/virtual_bus.c b/drivers/bus/virtual_bus.c
index 27db2d3463a3..613445640cd0 100644
--- a/drivers/bus/virtual_bus.c
+++ b/drivers/bus/virtual_bus.c
@@ -8,15 +8,15 @@
  * more information
  */
 
-#include <linux/string.h>
-#include <linux/virtual_bus.h>
-#include <linux/of_irq.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/pm_runtime.h>
-#include <linux/pm_domain.h>
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/string.h>
+#include <linux/virtual_bus.h>
 
 static DEFINE_IDA(virtbus_dev_ida);
 
-- 
2.17.1


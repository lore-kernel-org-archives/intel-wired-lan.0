From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 29 Jun 2018 14:25:39 -0400
Subject: [Intel-wired-lan] [PATCH v6 1/3] drivers core: refactor
 device_shutdown
In-Reply-To: <20180629182541.6735-1-pasha.tatashin@oracle.com>
References: <20180629182541.6735-1-pasha.tatashin@oracle.com>
Message-ID: <20180629182541.6735-2-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

device_shutdown() traverses through the list of devices, and calls
dev->{bug/driver}->shutdown() for each entry in the list.

Refactor the function by keeping device_shutdown() to do the logic of
traversing the list of devices, and device_shutdown_one() to perform the
actual shutdown operation on one device.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/base/core.c | 50 +++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index df3e1a44707a..07380aa0683b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2802,6 +2802,35 @@ int device_move(struct device *dev, struct device *new_parent,
 }
 EXPORT_SYMBOL_GPL(device_move);
 
+/*
+ * device_shutdown_one - call ->shutdown() for the device passed as
+ * argument.
+ */
+static void device_shutdown_one(struct device *dev)
+{
+	/* Don't allow any more runtime suspends */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_barrier(dev);
+
+	if (dev->class && dev->class->shutdown_pre) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown_pre\n");
+		dev->class->shutdown_pre(dev);
+	}
+	if (dev->bus && dev->bus->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->bus->shutdown(dev);
+	} else if (dev->driver && dev->driver->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->driver->shutdown(dev);
+	}
+
+	/* decrement the reference counter */
+	put_device(dev);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
@@ -2838,30 +2867,11 @@ void device_shutdown(void)
 			device_lock(parent);
 		device_lock(dev);
 
-		/* Don't allow any more runtime suspends */
-		pm_runtime_get_noresume(dev);
-		pm_runtime_barrier(dev);
-
-		if (dev->class && dev->class->shutdown_pre) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown_pre\n");
-			dev->class->shutdown_pre(dev);
-		}
-		if (dev->bus && dev->bus->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->bus->shutdown(dev);
-		} else if (dev->driver && dev->driver->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->driver->shutdown(dev);
-		}
-
+		device_shutdown_one(dev);
 		device_unlock(dev);
 		if (parent)
 			device_unlock(parent);
 
-		put_device(dev);
 		put_device(parent);
 
 		spin_lock(&devices_kset->list_lock);
-- 
2.18.0


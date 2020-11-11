From: Chen Yu <yu.c.chen@intel.com>
Date: Wed, 11 Nov 2020 13:51:33 +0800
Subject: [Intel-wired-lan] [PATCH 2/4][RFC] PM: sleep: export
 device_pm_remove() for driver use
In-Reply-To: <cover.1605073208.git.yu.c.chen@intel.com>
References: <cover.1605073208.git.yu.c.chen@intel.com>
Message-ID: <a0ed34e3486583770c6d0ee043a3ba9d7b08f504.1605073208.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Export device_pm_remove() and move the declaration of device_pm_remove()
into generic power header file so that the drivers could use this interface
to disable power management on that device.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/base/power/main.c  |  1 +
 drivers/base/power/power.h |  8 --------
 include/linux/pm.h         | 12 ++++++++++++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index c7ac49042cee..4693da9d7d80 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -164,6 +164,7 @@ void device_pm_remove(struct device *dev)
 	pm_runtime_remove(dev);
 	device_pm_check_callbacks(dev);
 }
+EXPORT_SYMBOL_GPL(device_pm_remove);
 
 /**
  * device_pm_move_before - Move device in the PM core's list of active devices.
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 54292cdd7808..8c2e45f3e5a9 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -20,7 +20,6 @@ static inline void pm_runtime_early_init(struct device *dev)
 
 extern void pm_runtime_init(struct device *dev);
 extern void pm_runtime_reinit(struct device *dev);
-extern void pm_runtime_remove(struct device *dev);
 extern u64 pm_runtime_active_time(struct device *dev);
 
 #define WAKE_IRQ_DEDICATED_ALLOCATED	BIT(0)
@@ -85,7 +84,6 @@ static inline void pm_runtime_early_init(struct device *dev)
 
 static inline void pm_runtime_init(struct device *dev) {}
 static inline void pm_runtime_reinit(struct device *dev) {}
-static inline void pm_runtime_remove(struct device *dev) {}
 
 static inline int dpm_sysfs_add(struct device *dev) { return 0; }
 static inline void dpm_sysfs_remove(struct device *dev) {}
@@ -109,7 +107,6 @@ static inline struct device *to_device(struct list_head *entry)
 
 extern void device_pm_sleep_init(struct device *dev);
 extern void device_pm_add(struct device *);
-extern void device_pm_remove(struct device *);
 extern void device_pm_move_before(struct device *, struct device *);
 extern void device_pm_move_after(struct device *, struct device *);
 extern void device_pm_move_last(struct device *);
@@ -133,11 +130,6 @@ static inline void device_pm_sleep_init(struct device *dev) {}
 
 static inline void device_pm_add(struct device *dev) {}
 
-static inline void device_pm_remove(struct device *dev)
-{
-	pm_runtime_remove(dev);
-}
-
 static inline void device_pm_move_before(struct device *deva,
 					 struct device *devb) {}
 static inline void device_pm_move_after(struct device *deva,
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 47aca6bac1d6..f9ceca6ac7ff 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -701,6 +701,11 @@ struct dev_pm_domain {
  * be able to use wakeup events to exit from runtime low-power states,
  * or from system low-power states such as standby or suspend-to-RAM.
  */
+#ifdef CONFIG_PM
+extern void pm_runtime_remove(struct device *dev);
+#else
+static inline void pm_runtime_remove(struct device *dev) {}
+#endif
 
 #ifdef CONFIG_PM_SLEEP
 extern void device_pm_lock(void);
@@ -753,6 +758,8 @@ extern void pm_generic_complete(struct device *dev);
 extern bool dev_pm_skip_resume(struct device *dev);
 extern bool dev_pm_skip_suspend(struct device *dev);
 
+extern void device_pm_remove(struct device *dev);
+
 #else /* !CONFIG_PM_SLEEP */
 
 #define device_pm_lock() do {} while (0)
@@ -774,6 +781,11 @@ static inline void dpm_for_each_dev(void *data, void (*fn)(struct device *, void
 {
 }
 
+static inline void device_pm_remove(struct device *dev)
+{
+	pm_runtime_remove(dev);
+}
+
 #define pm_generic_prepare		NULL
 #define pm_generic_suspend_late		NULL
 #define pm_generic_suspend_noirq	NULL
-- 
2.17.1


From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Thu, 28 May 2020 12:43:35 -0700
Subject: [Intel-wired-lan] [PATCH 07/14] virtual-bus: remove #ifdef for PM
 ops
In-Reply-To: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
References: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
Message-ID: <20200528194342.3495-8-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

not really needed.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/bus/virtual_bus.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bus/virtual_bus.c b/drivers/bus/virtual_bus.c
index 7518c6c8eaea..519b578a347f 100644
--- a/drivers/bus/virtual_bus.c
+++ b/drivers/bus/virtual_bus.c
@@ -54,9 +54,7 @@ static int virtbus_uevent(struct device *dev, struct kobj_uevent_env *env)
 static const struct dev_pm_ops virtbus_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(pm_generic_runtime_suspend,
 			   pm_generic_runtime_resume, NULL)
-#ifdef CONFIG_PM_SLEEP
 	SET_SYSTEM_SLEEP_PM_OPS(pm_generic_suspend, pm_generic_resume)
-#endif
 };
 
 struct bus_type virtual_bus_type = {
-- 
2.17.1


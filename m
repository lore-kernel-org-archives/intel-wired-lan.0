From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Thu, 28 May 2020 12:43:37 -0700
Subject: [Intel-wired-lan] [PATCH 09/14] virtual-bus: fix return value for
 match function
In-Reply-To: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
References: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
Message-ID: <20200528194342.3495-10-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/bus/virtual_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/virtual_bus.c b/drivers/bus/virtual_bus.c
index 2b0007932517..27db2d3463a3 100644
--- a/drivers/bus/virtual_bus.c
+++ b/drivers/bus/virtual_bus.c
@@ -37,7 +37,7 @@ static int virtbus_match(struct device *dev, struct device_driver *drv)
 	struct virtbus_driver *vdrv = to_virtbus_drv(drv);
 	struct virtbus_device *vdev = to_virtbus_dev(dev);
 
-	return virtbus_match_id(vdrv->id_table, vdev) != NULL;
+	return !!virtbus_match_id(vdrv->id_table, vdev);
 }
 
 static int virtbus_uevent(struct device *dev, struct kobj_uevent_env *env)
-- 
2.17.1


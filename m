From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Thu, 28 May 2020 12:43:36 -0700
Subject: [Intel-wired-lan] [PATCH 08/14] virtual-bus: remove superfluous
 assignment
In-Reply-To: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
References: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
Message-ID: <20200528194342.3495-9-ranjani.sridharan@linux.intel.com>
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
index 519b578a347f..2b0007932517 100644
--- a/drivers/bus/virtual_bus.c
+++ b/drivers/bus/virtual_bus.c
@@ -153,7 +153,7 @@ static int virtbus_remove_driver(struct device *_dev)
 {
 	struct virtbus_driver *vdrv = to_virtbus_drv(_dev->driver);
 	struct virtbus_device *vdev = to_virtbus_dev(_dev);
-	int ret = 0;
+	int ret;
 
 	ret = vdrv->remove(vdev);
 	dev_pm_domain_detach(_dev, true);
-- 
2.17.1


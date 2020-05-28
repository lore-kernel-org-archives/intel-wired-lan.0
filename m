From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Thu, 28 May 2020 12:43:34 -0700
Subject: [Intel-wired-lan] [PATCH 06/14] virtual-bus: remove INVALID_ID and
 fix error path
In-Reply-To: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
References: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
Message-ID: <20200528194342.3495-7-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

INVALID_ID is not really needed, so remove it and fix error
path to remove auto ID in case of errors.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/bus/virtual_bus.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/virtual_bus.c b/drivers/bus/virtual_bus.c
index 25f85672b70d..7518c6c8eaea 100644
--- a/drivers/bus/virtual_bus.c
+++ b/drivers/bus/virtual_bus.c
@@ -19,7 +19,6 @@
 #include <linux/device.h>
 
 static DEFINE_IDA(virtbus_dev_ida);
-#define VIRTBUS_INVALID_ID	0xFFFFFFFF
 
 static const
 struct virtbus_device_id *virtbus_match_id(const struct virtbus_device_id *id,
@@ -77,8 +76,7 @@ static void virtbus_release_device(struct device *_dev)
 	u32 ida = vdev->id;
 
 	vdev->release(vdev);
-	if (ida != VIRTBUS_INVALID_ID)
-		ida_simple_remove(&virtbus_dev_ida, ida);
+	ida_simple_remove(&virtbus_dev_ida, ida);
 }
 
 /**
@@ -103,9 +101,7 @@ int virtbus_register_device(struct virtbus_device *vdev)
 
 	/* All device IDs are automatically allocated */
 	ret = ida_simple_get(&virtbus_dev_ida, 0, 0, GFP_KERNEL);
-
 	if (ret < 0) {
-		vdev->id = VIRTBUS_INVALID_ID;
 		dev_err(&vdev->dev, "get IDA idx for virtbus device failed!\n");
 		goto device_add_err;
 	}
@@ -122,13 +118,12 @@ int virtbus_register_device(struct virtbus_device *vdev)
 		dev_name(&vdev->dev));
 
 	ret = device_add(&vdev->dev);
-	if (ret)
-		goto device_add_err;
+	if (!ret)
+		return ret;
 
-	return 0;
+	dev_err(&vdev->dev, "Add device to virtbus failed!: %d\n", ret);
 
 device_add_err:
-	dev_err(&vdev->dev, "Add device to virtbus failed!: %d\n", ret);
 	put_device(&vdev->dev);
 
 	return ret;
-- 
2.17.1


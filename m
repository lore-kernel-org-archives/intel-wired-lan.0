From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Thu, 28 May 2020 12:43:30 -0700
Subject: [Intel-wired-lan] [PATCH 02/14] virtual-bus: rename struct
 virtbus_dev_id
In-Reply-To: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
References: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
Message-ID: <20200528194342.3495-3-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Rename struct virtbus_dev_id to struct virtbus_device_id.
This is needed for auto loading of virtbus driver modules to work
with MODULE_DEVICE_TABLE().

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/bus/virtual_bus.c         | 7 ++++---
 include/linux/mod_devicetable.h   | 2 +-
 include/linux/virtual_bus.h       | 2 +-
 scripts/mod/devicetable-offsets.c | 4 ++--
 scripts/mod/file2alias.c          | 4 ++--
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/virtual_bus.c b/drivers/bus/virtual_bus.c
index b70023d5b58a..90d2ad19b5cb 100644
--- a/drivers/bus/virtual_bus.c
+++ b/drivers/bus/virtual_bus.c
@@ -27,8 +27,8 @@ static DEFINE_IDA(virtbus_dev_ida);
 #define VIRTBUS_INVALID_ID	0xFFFFFFFF
 
 static const
-struct virtbus_dev_id *virtbus_match_id(const struct virtbus_dev_id *id,
-					struct virtbus_device *vdev)
+struct virtbus_device_id *virtbus_match_id(const struct virtbus_device_id *id,
+					   struct virtbus_device *vdev)
 {
 	while (id->name[0]) {
 		if (!strcmp(vdev->match_name, id->name))
@@ -50,7 +50,8 @@ static int virtbus_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct virtbus_device *vdev = to_virtbus_dev(dev);
 
-	if (add_uevent_var(env, "MODALIAS=%s%s", "virtbus:", vdev->match_name))
+	if (add_uevent_var(env, "MODALIAS=%s%s", VIRTBUS_MODULE_PREFIX,
+			   vdev->match_name))
 		return -ENOMEM;
 
 	return 0;
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 60bcfe75fb94..1378bc165c07 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -835,7 +835,7 @@ struct mhi_device_id {
 #define VIRTBUS_NAME_SIZE 20
 #define VIRTBUS_MODULE_PREFIX "virtbus:"
 
-struct virtbus_dev_id {
+struct virtbus_device_id {
 	char name[VIRTBUS_NAME_SIZE];
 	kernel_ulong_t driver_data;
 };
diff --git a/include/linux/virtual_bus.h b/include/linux/virtual_bus.h
index 4872fd5a9218..aeac7144b220 100644
--- a/include/linux/virtual_bus.h
+++ b/include/linux/virtual_bus.h
@@ -26,7 +26,7 @@ struct virtbus_driver {
 	int (*suspend)(struct virtbus_device *, pm_message_t);
 	int (*resume)(struct virtbus_device *);
 	struct device_driver driver;
-	const struct virtbus_dev_id *id_table;
+	const struct virtbus_device_id *id_table;
 };
 
 static inline
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 0c8e0e3a7c84..2848926ed223 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -241,8 +241,8 @@ int main(void)
 	DEVID(mhi_device_id);
 	DEVID_FIELD(mhi_device_id, chan);
 
-	DEVID(virtbus_dev_id);
-	DEVID_FIELD(virtbus_dev_id, name);
+	DEVID(virtbus_device_id);
+	DEVID_FIELD(virtbus_device_id, name);
 
 	return 0;
 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 7d78fa3fba34..fd3908ed922d 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1363,7 +1363,7 @@ static int do_mhi_entry(const char *filename, void *symval, char *alias)
 
 static int do_virtbus_entry(const char *filename, void *symval, char *alias)
 {
-	DEF_FIELD_ADDR(symval, virtbus_dev_id, name);
+	DEF_FIELD_ADDR(symval, virtbus_device_id, name);
 	sprintf(alias, VIRTBUS_MODULE_PREFIX "%s", *name);
 	return 1;
 }
@@ -1442,7 +1442,7 @@ static const struct devtable devtable[] = {
 	{"tee", SIZE_tee_client_device_id, do_tee_entry},
 	{"wmi", SIZE_wmi_device_id, do_wmi_entry},
 	{"mhi", SIZE_mhi_device_id, do_mhi_entry},
-	{"virtbus", SIZE_virtbus_dev_id, do_virtbus_entry},
+	{"virtbus", SIZE_virtbus_device_id, do_virtbus_entry},
 };
 
 /* Create MODULE_ALIAS() statements.
-- 
2.17.1


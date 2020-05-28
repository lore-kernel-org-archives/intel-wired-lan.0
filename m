From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Thu, 28 May 2020 12:43:33 -0700
Subject: [Intel-wired-lan] [PATCH 05/14] virtual-bus: move MODULE macros to
 the end of the file
In-Reply-To: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
References: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
Message-ID: <20200528194342.3495-6-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/bus/virtual_bus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/virtual_bus.c b/drivers/bus/virtual_bus.c
index 90d2ad19b5cb..25f85672b70d 100644
--- a/drivers/bus/virtual_bus.c
+++ b/drivers/bus/virtual_bus.c
@@ -18,11 +18,6 @@
 #include <linux/acpi.h>
 #include <linux/device.h>
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Virtual Bus");
-MODULE_AUTHOR("David Ertman <david.m.ertman@intel.com>");
-MODULE_AUTHOR("Kiran Patil <kiran.patil@intel.com>");
-
 static DEFINE_IDA(virtbus_dev_ida);
 #define VIRTBUS_INVALID_ID	0xFFFFFFFF
 
@@ -214,3 +209,8 @@ static void __exit virtual_bus_exit(void)
 
 module_init(virtual_bus_init);
 module_exit(virtual_bus_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Virtual Bus");
+MODULE_AUTHOR("David Ertman <david.m.ertman@intel.com>");
+MODULE_AUTHOR("Kiran Patil <kiran.patil@intel.com>");
-- 
2.17.1


From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Thu, 28 May 2020 12:43:31 -0700
Subject: [Intel-wired-lan] [PATCH 03/14] virtual-bus: reword Kconfig help
In-Reply-To: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
References: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
Message-ID: <20200528194342.3495-4-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/bus/Kconfig | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 00553c78510c..b3f59bdf5c51 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -206,11 +206,12 @@ source "drivers/bus/mhi/Kconfig"
 config VIRTUAL_BUS
        tristate "Software based Virtual Bus"
        help
-         Provides a software bus for virtbus_devices to be added to it
-         and virtbus_drivers to be registered on it.  It matches driver
-         and device based on id and calls the driver's probe routine.
-         One example is the irdma driver needing to connect with various
-         PCI LAN drivers to request resources (queues) to be able to perform
-         its function.
+         Provides a software bus for virtual bus drivers to register and
+	 attach virtual bus devices.  It matches driver and device based on a
+	 unique string and calls the driver's probe routine. One example is
+	 SOF (Sound Open Firmware) clients such as audio cards or test
+	 tools needing to connect with the SOF core. Another example is
+	 the irdma driver needing to connect with various PCI LAN drivers
+	 to request resources (queues) to be able to perform its function.
 
 endmenu
-- 
2.17.1


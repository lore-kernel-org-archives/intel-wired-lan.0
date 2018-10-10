From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 10 Oct 2018 12:16:11 -0700
Subject: [Intel-wired-lan] [PATCH v2 10/12] Documentation: ice: Prepare
 documentation for RST conversion
In-Reply-To: <20181010191613.2770-1-jeffrey.t.kirsher@intel.com>
References: <20181010191613.2770-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20181010191613.2770-11-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Before making the conversion to the rst (reStructured Text) format, there
are changes needed to the documentation so that there are no build errors.

Also fixed old/broken URLs to the correct or updated URL.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 Documentation/networking/ice.txt | 34 +++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/ice.txt b/Documentation/networking/ice.txt
index 6261c46378e1..1e4948c9e989 100644
--- a/Documentation/networking/ice.txt
+++ b/Documentation/networking/ice.txt
@@ -1,4 +1,6 @@
-Intel(R) Ethernet Connection E800 Series Linux Driver
+.. SPDX-License-Identifier: GPL-2.0+
+
+Linux* Base Driver for the Intel(R) Ethernet Connection E800 Series
 ===================================================================
 
 Intel ice Linux driver.
@@ -6,34 +8,38 @@ Copyright(c) 2018 Intel Corporation.
 
 Contents
 ========
+
 - Enabling the driver
 - Support
 
 The driver in this release supports Intel's E800 Series of products. For
-more information, visit Intel's support page at http://support.intel.com.
+more information, visit Intel's support page at https://support.intel.com.
 
 Enabling the driver
 ===================
-
 The driver is enabled via the standard kernel configuration system,
-using the make command:
+using the make command::
 
-     Make oldconfig/silentoldconfig/menuconfig/etc.
+  make oldconfig/silentoldconfig/menuconfig/etc.
 
 The driver is located in the menu structure at:
 
-	-> Device Drivers
-	  -> Network device support (NETDEVICES [=y])
-	    -> Ethernet driver support
-	      -> Intel devices
-	        -> Intel(R) Ethernet Connection E800 Series Support
+  -> Device Drivers
+    -> Network device support (NETDEVICES [=y])
+      -> Ethernet driver support
+        -> Intel devices
+          -> Intel(R) Ethernet Connection E800 Series Support
 
 Support
 =======
-
 For general information, go to the Intel support website at:
 
-    http://support.intel.com
+https://www.intel.com/support/
+
+or the Intel Wired Networking project hosted by Sourceforge at:
+
+https://sourceforge.net/projects/e1000
 
-If an issue is identified with the released source code, please email
-the maintainer listed in the MAINTAINERS file.
+If an issue is identified with the released source code on a supported kernel
+with a supported adapter, email the specific information related to the issue
+to e1000-devel at lists.sf.net.
-- 
2.17.1


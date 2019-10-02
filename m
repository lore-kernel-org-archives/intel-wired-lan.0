From: Jonathan =?unknown-8bit?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Wed,  2 Oct 2019 17:09:55 +0200
Subject: [Intel-wired-lan] [PATCH] Documentation: networking: device
 drivers: Remove stray asterisks
Message-ID: <20191002150956.16234-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These asterisks were once references to a line that said:
  "* Other names and brands may be claimed as the property of others."
But now, they serve no purpose; they can only irritate the reader.

Fixes: de3edab4276c ("e1000: update README for e1000")
Fixes: a3fb65680f65 ("e100.txt: Cleanup license info in kernel doc")
Fixes: da8c01c4502a ("e1000e.txt: Add e1000e documentation")
Fixes: f12a84a9f650 ("Documentation: fm10k: Add kernel documentation")
Fixes: b55c52b1938c ("igb.txt: Add igb documentation")
Fixes: c4e9b56e2442 ("igbvf.txt: Add igbvf Documentation")
Fixes: d7064f4c192c ("Documentation/networking/: Update Intel wired LAN driver documentation")
Fixes: c4b8c01112a1 ("ixgbevf.txt: Update ixgbevf documentation")
Fixes: 1e06edcc2f22 ("Documentation: i40e: Prepare documentation for RST conversion")
Fixes: 105bf2fe6b32 ("i40evf: add driver to kernel build system")
Fixes: 1fae869bcf3d ("Documentation: ice: Prepare documentation for RST conversion")
Fixes: df69ba43217d ("ionic: Add basic framework for IONIC Network device driver")
Signed-off-by: Jonathan Neusch?fer <j.neuschaefer@gmx.net>
---
 .../networking/device_drivers/intel/e100.rst       | 14 +++++++-------
 .../networking/device_drivers/intel/e1000.rst      | 12 ++++++------
 .../networking/device_drivers/intel/e1000e.rst     | 14 +++++++-------
 .../networking/device_drivers/intel/fm10k.rst      | 10 +++++-----
 .../networking/device_drivers/intel/i40e.rst       |  8 ++++----
 .../networking/device_drivers/intel/iavf.rst       |  8 ++++----
 .../networking/device_drivers/intel/ice.rst        |  6 +++---
 .../networking/device_drivers/intel/igb.rst        | 12 ++++++------
 .../networking/device_drivers/intel/igbvf.rst      |  6 +++---
 .../networking/device_drivers/intel/ixgbe.rst      | 10 +++++-----
 .../networking/device_drivers/intel/ixgbevf.rst    |  6 +++---
 .../networking/device_drivers/pensando/ionic.rst   |  6 +++---
 12 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/Documentation/networking/device_drivers/intel/e100.rst b/Documentation/networking/device_drivers/intel/e100.rst
index 2b9f4887beda..caf023cc88de 100644
--- a/Documentation/networking/device_drivers/intel/e100.rst
+++ b/Documentation/networking/device_drivers/intel/e100.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-==============================================================
-Linux* Base Driver for the Intel(R) PRO/100 Family of Adapters
-==============================================================
+=============================================================
+Linux Base Driver for the Intel(R) PRO/100 Family of Adapters
+=============================================================
 
 June 1, 2018
 
@@ -21,7 +21,7 @@ Contents
 In This Release
 ===============
 
-This file describes the Linux* Base Driver for the Intel(R) PRO/100 Family of
+This file describes the Linux Base Driver for the Intel(R) PRO/100 Family of
 Adapters. This driver includes support for Itanium(R)2-based systems.
 
 For questions related to hardware requirements, refer to the documentation
@@ -138,9 +138,9 @@ version 1.6 or later is required for this functionality.
 The latest release of ethtool can be found from
 https://www.kernel.org/pub/software/network/ethtool/
 
-Enabling Wake on LAN* (WoL)
----------------------------
-WoL is provided through the ethtool* utility.  For instructions on
+Enabling Wake on LAN (WoL)
+--------------------------
+WoL is provided through the ethtool utility.  For instructions on
 enabling WoL with ethtool, refer to the ethtool man page.  WoL will be
 enabled on the system during the next shut down or reboot.  For this
 driver version, in order to enable WoL, the e100 driver must be loaded
diff --git a/Documentation/networking/device_drivers/intel/e1000.rst b/Documentation/networking/device_drivers/intel/e1000.rst
index 956560b6e745..4aaae0f7d6ba 100644
--- a/Documentation/networking/device_drivers/intel/e1000.rst
+++ b/Documentation/networking/device_drivers/intel/e1000.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-===========================================================
-Linux* Base Driver for Intel(R) Ethernet Network Connection
-===========================================================
+==========================================================
+Linux Base Driver for Intel(R) Ethernet Network Connection
+==========================================================
 
 Intel Gigabit Linux driver.
 Copyright(c) 1999 - 2013 Intel Corporation.
@@ -438,10 +438,10 @@ ethtool
   The latest release of ethtool can be found from
   https://www.kernel.org/pub/software/network/ethtool/
 
-Enabling Wake on LAN* (WoL)
----------------------------
+Enabling Wake on LAN (WoL)
+--------------------------
 
-  WoL is configured through the ethtool* utility.
+  WoL is configured through the ethtool utility.
 
   WoL will be enabled on the system during the next shut down or reboot.
   For this driver version, in order to enable WoL, the e1000 driver must be
diff --git a/Documentation/networking/device_drivers/intel/e1000e.rst b/Documentation/networking/device_drivers/intel/e1000e.rst
index 01999f05509c..f49cd370e7bf 100644
--- a/Documentation/networking/device_drivers/intel/e1000e.rst
+++ b/Documentation/networking/device_drivers/intel/e1000e.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-======================================================
-Linux* Driver for Intel(R) Ethernet Network Connection
-======================================================
+=====================================================
+Linux Driver for Intel(R) Ethernet Network Connection
+=====================================================
 
 Intel Gigabit Linux driver.
 Copyright(c) 2008-2018 Intel Corporation.
@@ -338,7 +338,7 @@ and higher cannot be forced. Use the autonegotiation advertising setting to
 manually set devices for 1 Gbps and higher.
 
 Speed, duplex, and autonegotiation advertising are configured through the
-ethtool* utility.
+ethtool utility.
 
 Caution: Only experienced network administrators should force speed and duplex
 or change autonegotiation advertising manually. The settings at the switch must
@@ -351,9 +351,9 @@ will not attempt to auto-negotiate with its link partner since those adapters
 operate only in full duplex and only at their native speed.
 
 
-Enabling Wake on LAN* (WoL)
----------------------------
-WoL is configured through the ethtool* utility.
+Enabling Wake on LAN (WoL)
+--------------------------
+WoL is configured through the ethtool utility.
 
 WoL will be enabled on the system during the next shut down or reboot. For
 this driver version, in order to enable WoL, the e1000e driver must be loaded
diff --git a/Documentation/networking/device_drivers/intel/fm10k.rst b/Documentation/networking/device_drivers/intel/fm10k.rst
index ac3269e34f55..4d279e64e221 100644
--- a/Documentation/networking/device_drivers/intel/fm10k.rst
+++ b/Documentation/networking/device_drivers/intel/fm10k.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-==============================================================
-Linux* Base Driver for Intel(R) Ethernet Multi-host Controller
-==============================================================
+=============================================================
+Linux Base Driver for Intel(R) Ethernet Multi-host Controller
+=============================================================
 
 August 20, 2018
 Copyright(c) 2015-2018 Intel Corporation.
@@ -120,8 +120,8 @@ rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|tcp6|udp6|ah6|esp6|sctp6 m|v|t|s|d|f|n|r
 Known Issues/Troubleshooting
 ============================
 
-Enabling SR-IOV in a 64-bit Microsoft* Windows Server* 2012/R2 guest OS under Linux KVM
----------------------------------------------------------------------------------------
+Enabling SR-IOV in a 64-bit Microsoft Windows Server 2012/R2 guest OS under Linux KVM
+-------------------------------------------------------------------------------------
 KVM Hypervisor/VMM supports direct assignment of a PCIe device to a VM. This
 includes traditional PCIe devices, as well as SR-IOV-capable devices based on
 the Intel Ethernet Controller XL710.
diff --git a/Documentation/networking/device_drivers/intel/i40e.rst b/Documentation/networking/device_drivers/intel/i40e.rst
index 848fd388fa6e..8a9b18573688 100644
--- a/Documentation/networking/device_drivers/intel/i40e.rst
+++ b/Documentation/networking/device_drivers/intel/i40e.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-==================================================================
-Linux* Base Driver for the Intel(R) Ethernet Controller 700 Series
-==================================================================
+=================================================================
+Linux Base Driver for the Intel(R) Ethernet Controller 700 Series
+=================================================================
 
 Intel 40 Gigabit Linux driver.
 Copyright(c) 1999-2018 Intel Corporation.
@@ -384,7 +384,7 @@ NOTE: You cannot set the speed for devices based on the Intel(R) Ethernet
 Network Adapter XXV710 based devices.
 
 Speed, duplex, and autonegotiation advertising are configured through the
-ethtool* utility.
+ethtool utility.
 
 Caution: Only experienced network administrators should force speed and duplex
 or change autonegotiation advertising manually. The settings at the switch must
diff --git a/Documentation/networking/device_drivers/intel/iavf.rst b/Documentation/networking/device_drivers/intel/iavf.rst
index cfc08842e32c..84ac7e75f363 100644
--- a/Documentation/networking/device_drivers/intel/iavf.rst
+++ b/Documentation/networking/device_drivers/intel/iavf.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-==================================================================
-Linux* Base Driver for Intel(R) Ethernet Adaptive Virtual Function
-==================================================================
+=================================================================
+Linux Base Driver for Intel(R) Ethernet Adaptive Virtual Function
+=================================================================
 
 Intel Ethernet Adaptive Virtual Function Linux driver.
 Copyright(c) 2013-2018 Intel Corporation.
@@ -19,7 +19,7 @@ Contents
 Overview
 ========
 
-This file describes the iavf Linux* Base Driver. This driver was formerly
+This file describes the iavf Linux Base Driver. This driver was formerly
 called i40evf.
 
 The iavf driver supports the below mentioned virtual function devices and
diff --git a/Documentation/networking/device_drivers/intel/ice.rst b/Documentation/networking/device_drivers/intel/ice.rst
index c220aa2711c6..ee43ea57d443 100644
--- a/Documentation/networking/device_drivers/intel/ice.rst
+++ b/Documentation/networking/device_drivers/intel/ice.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-===================================================================
-Linux* Base Driver for the Intel(R) Ethernet Connection E800 Series
-===================================================================
+==================================================================
+Linux Base Driver for the Intel(R) Ethernet Connection E800 Series
+==================================================================
 
 Intel ice Linux driver.
 Copyright(c) 2018 Intel Corporation.
diff --git a/Documentation/networking/device_drivers/intel/igb.rst b/Documentation/networking/device_drivers/intel/igb.rst
index fc8cfaa5dcfa..87e560fe5eaa 100644
--- a/Documentation/networking/device_drivers/intel/igb.rst
+++ b/Documentation/networking/device_drivers/intel/igb.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-===========================================================
-Linux* Base Driver for Intel(R) Ethernet Network Connection
-===========================================================
+==========================================================
+Linux Base Driver for Intel(R) Ethernet Network Connection
+==========================================================
 
 Intel Gigabit Linux driver.
 Copyright(c) 1999-2018 Intel Corporation.
@@ -129,9 +129,9 @@ version is required for this functionality. Download it at:
 https://www.kernel.org/pub/software/network/ethtool/
 
 
-Enabling Wake on LAN* (WoL)
----------------------------
-WoL is configured through the ethtool* utility.
+Enabling Wake on LAN (WoL)
+--------------------------
+WoL is configured through the ethtool utility.
 
 WoL will be enabled on the system during the next shut down or reboot. For
 this driver version, in order to enable WoL, the igb driver must be loaded
diff --git a/Documentation/networking/device_drivers/intel/igbvf.rst b/Documentation/networking/device_drivers/intel/igbvf.rst
index 9cddabe8108e..557fc020ef31 100644
--- a/Documentation/networking/device_drivers/intel/igbvf.rst
+++ b/Documentation/networking/device_drivers/intel/igbvf.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-============================================================
-Linux* Base Virtual Function Driver for Intel(R) 1G Ethernet
-============================================================
+===========================================================
+Linux Base Virtual Function Driver for Intel(R) 1G Ethernet
+===========================================================
 
 Intel Gigabit Virtual Function Linux driver.
 Copyright(c) 1999-2018 Intel Corporation.
diff --git a/Documentation/networking/device_drivers/intel/ixgbe.rst b/Documentation/networking/device_drivers/intel/ixgbe.rst
index c7d25483fedb..f1d5233e5e51 100644
--- a/Documentation/networking/device_drivers/intel/ixgbe.rst
+++ b/Documentation/networking/device_drivers/intel/ixgbe.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-=============================================================================
-Linux* Base Driver for the Intel(R) Ethernet 10 Gigabit PCI Express Adapters
-=============================================================================
+===========================================================================
+Linux Base Driver for the Intel(R) Ethernet 10 Gigabit PCI Express Adapters
+===========================================================================
 
 Intel 10 Gigabit Linux driver.
 Copyright(c) 1999-2018 Intel Corporation.
@@ -519,8 +519,8 @@ The offload is also supported for ixgbe's VFs, but the VF must be set as
 Known Issues/Troubleshooting
 ============================
 
-Enabling SR-IOV in a 64-bit Microsoft* Windows Server* 2012/R2 guest OS
------------------------------------------------------------------------
+Enabling SR-IOV in a 64-bit Microsoft Windows Server 2012/R2 guest OS
+---------------------------------------------------------------------
 Linux KVM Hypervisor/VMM supports direct assignment of a PCIe device to a VM.
 This includes traditional PCIe devices, as well as SR-IOV-capable devices based
 on the Intel Ethernet Controller XL710.
diff --git a/Documentation/networking/device_drivers/intel/ixgbevf.rst b/Documentation/networking/device_drivers/intel/ixgbevf.rst
index 5d4977360157..76bbde736f21 100644
--- a/Documentation/networking/device_drivers/intel/ixgbevf.rst
+++ b/Documentation/networking/device_drivers/intel/ixgbevf.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-=============================================================
-Linux* Base Virtual Function Driver for Intel(R) 10G Ethernet
-=============================================================
+============================================================
+Linux Base Virtual Function Driver for Intel(R) 10G Ethernet
+============================================================
 
 Intel 10 Gigabit Virtual Function Linux driver.
 Copyright(c) 1999-2018 Intel Corporation.
diff --git a/Documentation/networking/device_drivers/pensando/ionic.rst b/Documentation/networking/device_drivers/pensando/ionic.rst
index 67b6839d516b..3afe97514d68 100644
--- a/Documentation/networking/device_drivers/pensando/ionic.rst
+++ b/Documentation/networking/device_drivers/pensando/ionic.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-==========================================================
-Linux* Driver for the Pensando(R) Ethernet adapter family
-==========================================================
+========================================================
+Linux Driver for the Pensando(R) Ethernet adapter family
+========================================================
 
 Pensando Linux Ethernet driver.
 Copyright(c) 2019 Pensando Systems, Inc
-- 
2.20.1


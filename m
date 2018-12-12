From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 12 Dec 2018 14:44:24 -0800
Subject: [Intel-wired-lan] [next v2] docs/networking: fix formatting of
 Intel drivers documentation
Message-ID: <20181212224424.16787-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mike Rapoport <rppt@linux.ibm.com>

The documentation of Intel drivers is missing the heading adornment for
document titles.

This causes the generated html to have TOC entries from these documents to
appear as top level TOC entries:

* Linux* Base Driver for Intel(R) Ethernet Network Connection
* Contents
* Identifying Your Adapter
* Command Line Parameters
  * AutoNeg
  * Duplex
  ...

Add overline heading adornment to document titles.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
v2: update the Documentation path with the current net-next tree

Another interesting thing is that many of these documents have very similar
or even identical titles.
It would be nice to include the adapter name in the titles to make them
distinguishable.

 Documentation/networking/device_drivers/intel/e100.rst    | 1 +
 Documentation/networking/device_drivers/intel/e1000.rst   | 1 +
 Documentation/networking/device_drivers/intel/e1000e.rst  | 1 +
 Documentation/networking/device_drivers/intel/fm10k.rst   | 1 +
 Documentation/networking/device_drivers/intel/i40e.rst    | 1 +
 Documentation/networking/device_drivers/intel/iavf.rst    | 1 +
 Documentation/networking/device_drivers/intel/ice.rst     | 1 +
 Documentation/networking/device_drivers/intel/igb.rst     | 1 +
 Documentation/networking/device_drivers/intel/igbvf.rst   | 1 +
 Documentation/networking/device_drivers/intel/ixgb.rst    | 1 +
 Documentation/networking/device_drivers/intel/ixgbe.rst   | 1 +
 Documentation/networking/device_drivers/intel/ixgbevf.rst | 1 +
 12 files changed, 12 insertions(+)

diff --git a/Documentation/networking/device_drivers/intel/e100.rst b/Documentation/networking/device_drivers/intel/e100.rst
index 5e2839b..2b9f488 100644
--- a/Documentation/networking/device_drivers/intel/e100.rst
+++ b/Documentation/networking/device_drivers/intel/e100.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+==============================================================
 Linux* Base Driver for the Intel(R) PRO/100 Family of Adapters
 ==============================================================
 
diff --git a/Documentation/networking/device_drivers/intel/e1000.rst b/Documentation/networking/device_drivers/intel/e1000.rst
index 6379d4d..956560b 100644
--- a/Documentation/networking/device_drivers/intel/e1000.rst
+++ b/Documentation/networking/device_drivers/intel/e1000.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+===========================================================
 Linux* Base Driver for Intel(R) Ethernet Network Connection
 ===========================================================
 
diff --git a/Documentation/networking/device_drivers/intel/e1000e.rst b/Documentation/networking/device_drivers/intel/e1000e.rst
index 33554e5..01999f0 100644
--- a/Documentation/networking/device_drivers/intel/e1000e.rst
+++ b/Documentation/networking/device_drivers/intel/e1000e.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+======================================================
 Linux* Driver for Intel(R) Ethernet Network Connection
 ======================================================
 
diff --git a/Documentation/networking/device_drivers/intel/fm10k.rst b/Documentation/networking/device_drivers/intel/fm10k.rst
index bf5e594..ac3269e 100644
--- a/Documentation/networking/device_drivers/intel/fm10k.rst
+++ b/Documentation/networking/device_drivers/intel/fm10k.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+==============================================================
 Linux* Base Driver for Intel(R) Ethernet Multi-host Controller
 ==============================================================
 
diff --git a/Documentation/networking/device_drivers/intel/i40e.rst b/Documentation/networking/device_drivers/intel/i40e.rst
index 0cc16c5..848fd38 100644
--- a/Documentation/networking/device_drivers/intel/i40e.rst
+++ b/Documentation/networking/device_drivers/intel/i40e.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+==================================================================
 Linux* Base Driver for the Intel(R) Ethernet Controller 700 Series
 ==================================================================
 
diff --git a/Documentation/networking/device_drivers/intel/iavf.rst b/Documentation/networking/device_drivers/intel/iavf.rst
index f8b42b6..2d0c3ba 100644
--- a/Documentation/networking/device_drivers/intel/iavf.rst
+++ b/Documentation/networking/device_drivers/intel/iavf.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+==================================================================
 Linux* Base Driver for Intel(R) Ethernet Adaptive Virtual Function
 ==================================================================
 
diff --git a/Documentation/networking/device_drivers/intel/ice.rst b/Documentation/networking/device_drivers/intel/ice.rst
index 4d118b8..c220aa2 100644
--- a/Documentation/networking/device_drivers/intel/ice.rst
+++ b/Documentation/networking/device_drivers/intel/ice.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+===================================================================
 Linux* Base Driver for the Intel(R) Ethernet Connection E800 Series
 ===================================================================
 
diff --git a/Documentation/networking/device_drivers/intel/igb.rst b/Documentation/networking/device_drivers/intel/igb.rst
index ba16b86..e8f99af 100644
--- a/Documentation/networking/device_drivers/intel/igb.rst
+++ b/Documentation/networking/device_drivers/intel/igb.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+===========================================================
 Linux* Base Driver for Intel(R) Ethernet Network Connection
 ===========================================================
 
diff --git a/Documentation/networking/device_drivers/intel/igbvf.rst b/Documentation/networking/device_drivers/intel/igbvf.rst
index a8a9ffa..9cddabe 100644
--- a/Documentation/networking/device_drivers/intel/igbvf.rst
+++ b/Documentation/networking/device_drivers/intel/igbvf.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+============================================================
 Linux* Base Virtual Function Driver for Intel(R) 1G Ethernet
 ============================================================
 
diff --git a/Documentation/networking/device_drivers/intel/ixgb.rst b/Documentation/networking/device_drivers/intel/ixgb.rst
index 8bd80e27..9450182 100644
--- a/Documentation/networking/device_drivers/intel/ixgb.rst
+++ b/Documentation/networking/device_drivers/intel/ixgb.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+=====================================================================
 Linux Base Driver for 10 Gigabit Intel(R) Ethernet Network Connection
 =====================================================================
 
diff --git a/Documentation/networking/device_drivers/intel/ixgbe.rst b/Documentation/networking/device_drivers/intel/ixgbe.rst
index 725fc69..255bfe1 100644
--- a/Documentation/networking/device_drivers/intel/ixgbe.rst
+++ b/Documentation/networking/device_drivers/intel/ixgbe.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+=============================================================================
 Linux* Base Driver for the Intel(R) Ethernet 10 Gigabit PCI Express Adapters
 =============================================================================
 
diff --git a/Documentation/networking/device_drivers/intel/ixgbevf.rst b/Documentation/networking/device_drivers/intel/ixgbevf.rst
index 56cde63..5d49773 100644
--- a/Documentation/networking/device_drivers/intel/ixgbevf.rst
+++ b/Documentation/networking/device_drivers/intel/ixgbevf.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+=============================================================
 Linux* Base Virtual Function Driver for Intel(R) 10G Ethernet
 =============================================================
 

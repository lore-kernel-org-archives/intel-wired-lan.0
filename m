From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 10 Oct 2018 12:16:13 -0700
Subject: [Intel-wired-lan] [PATCH v2 12/12] Documentation: intel: Convert to
 RST format
In-Reply-To: <20181010191613.2770-1-jeffrey.t.kirsher@intel.com>
References: <20181010191613.2770-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20181010191613.2770-13-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Now that the documents have been updated to conform to the reStructured Text
guidelines, we can now change the file extensions and update the other
related references.

This converts all of the Intel wired LAN driver documentation to *.rst.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 Documentation/networking/00-INDEX             | 20 ----------------
 .../networking/{e1000e.txt => e1000e.rst}     |  0
 .../networking/{i40e.txt => i40e.rst}         |  0
 .../networking/{iavf.txt => iavf.rst}         |  0
 Documentation/networking/{ice.txt => ice.rst} |  0
 Documentation/networking/{igb.txt => igb.rst} |  0
 .../networking/{igbvf.txt => igbvf.rst}       |  0
 Documentation/networking/index.rst            |  9 ++++++++
 .../networking/{ixgb.txt => ixgb.rst}         |  0
 .../networking/{ixgbe.txt => ixgbe.rst}       |  0
 .../networking/{ixgbevf.txt => ixgbevf.rst}   |  0
 MAINTAINERS                                   | 18 +++++++--------
 drivers/net/ethernet/intel/Kconfig            | 23 +++++++++++++++----
 13 files changed, 37 insertions(+), 33 deletions(-)
 rename Documentation/networking/{e1000e.txt => e1000e.rst} (100%)
 rename Documentation/networking/{i40e.txt => i40e.rst} (100%)
 rename Documentation/networking/{iavf.txt => iavf.rst} (100%)
 rename Documentation/networking/{ice.txt => ice.rst} (100%)
 rename Documentation/networking/{igb.txt => igb.rst} (100%)
 rename Documentation/networking/{igbvf.txt => igbvf.rst} (100%)
 rename Documentation/networking/{ixgb.txt => ixgb.rst} (100%)
 rename Documentation/networking/{ixgbe.txt => ixgbe.rst} (100%)
 rename Documentation/networking/{ixgbevf.txt => ixgbevf.rst} (100%)

diff --git a/Documentation/networking/00-INDEX b/Documentation/networking/00-INDEX
index f4f2b5d6c8d8..1fc00ed79a5d 100644
--- a/Documentation/networking/00-INDEX
+++ b/Documentation/networking/00-INDEX
@@ -68,12 +68,6 @@ driver.txt
 	- Softnet driver issues.
 ena.txt
 	- info on Amazon's Elastic Network Adapter (ENA)
-e100.txt
-	- info on Intel's EtherExpress PRO/100 line of 10/100 boards
-e1000.txt
-	- info on Intel's E1000 line of gigabit ethernet boards
-e1000e.txt
-	- README for the Intel Gigabit Ethernet Driver (e1000e).
 eql.txt
 	- serial IP load balancing
 fib_trie.txt
@@ -92,16 +86,8 @@ generic_netlink.txt
 	- info on Generic Netlink
 gianfar.txt
 	- Gianfar Ethernet Driver.
-i40e.txt
-	- README for the Intel Ethernet Controller XL710 Driver (i40e).
-iavf.txt
-	- README for the Intel Ethernet Adaptive Virtual Function Driver (iavf).
 ieee802154.txt
 	- Linux IEEE 802.15.4 implementation, API and drivers
-igb.txt
-	- README for the Intel Gigabit Ethernet Driver (igb).
-igbvf.txt
-	- README for the Intel Gigabit Ethernet Driver (igbvf).
 ip-sysctl.txt
 	- /proc/sys/net/ipv4/* variables
 ip_dynaddr.txt
@@ -118,12 +104,6 @@ ipvs-sysctl.txt
 	- Per-inode explanation of the /proc/sys/net/ipv4/vs interface.
 irda.txt
 	- where to get IrDA (infrared) utilities and info for Linux.
-ixgb.txt
-	- README for the Intel 10 Gigabit Ethernet Driver (ixgb).
-ixgbe.txt
-	- README for the Intel 10 Gigabit Ethernet Driver (ixgbe).
-ixgbevf.txt
-	- README for the Intel Virtual Function (VF) Driver (ixgbevf).
 l2tp.txt
 	- User guide to the L2TP tunnel protocol.
 lapb-module.txt
diff --git a/Documentation/networking/e1000e.txt b/Documentation/networking/e1000e.rst
similarity index 100%
rename from Documentation/networking/e1000e.txt
rename to Documentation/networking/e1000e.rst
diff --git a/Documentation/networking/i40e.txt b/Documentation/networking/i40e.rst
similarity index 100%
rename from Documentation/networking/i40e.txt
rename to Documentation/networking/i40e.rst
diff --git a/Documentation/networking/iavf.txt b/Documentation/networking/iavf.rst
similarity index 100%
rename from Documentation/networking/iavf.txt
rename to Documentation/networking/iavf.rst
diff --git a/Documentation/networking/ice.txt b/Documentation/networking/ice.rst
similarity index 100%
rename from Documentation/networking/ice.txt
rename to Documentation/networking/ice.rst
diff --git a/Documentation/networking/igb.txt b/Documentation/networking/igb.rst
similarity index 100%
rename from Documentation/networking/igb.txt
rename to Documentation/networking/igb.rst
diff --git a/Documentation/networking/igbvf.txt b/Documentation/networking/igbvf.rst
similarity index 100%
rename from Documentation/networking/igbvf.txt
rename to Documentation/networking/igbvf.rst
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 8c8a0d2d39db..bd89dae8d578 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -14,7 +14,16 @@ Contents:
    dpaa2/index
    e100
    e1000
+   e1000e
    fm10k
+   igb
+   igbvf
+   ixgb
+   ixgbe
+   ixgbevf
+   i40e
+   iavf
+   ice
    kapi
    z8530book
    msg_zerocopy
diff --git a/Documentation/networking/ixgb.txt b/Documentation/networking/ixgb.rst
similarity index 100%
rename from Documentation/networking/ixgb.txt
rename to Documentation/networking/ixgb.rst
diff --git a/Documentation/networking/ixgbe.txt b/Documentation/networking/ixgbe.rst
similarity index 100%
rename from Documentation/networking/ixgbe.txt
rename to Documentation/networking/ixgbe.rst
diff --git a/Documentation/networking/ixgbevf.txt b/Documentation/networking/ixgbevf.rst
similarity index 100%
rename from Documentation/networking/ixgbevf.txt
rename to Documentation/networking/ixgbevf.rst
diff --git a/MAINTAINERS b/MAINTAINERS
index 01a346754652..6060679c7bdb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7346,16 +7346,16 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
 S:	Supported
 F:	Documentation/networking/e100.rst
 F:	Documentation/networking/e1000.rst
-F:	Documentation/networking/e1000e.txt
+F:	Documentation/networking/e1000e.rst
 F:	Documentation/networking/fm10k.rst
-F:	Documentation/networking/igb.txt
-F:	Documentation/networking/igbvf.txt
-F:	Documentation/networking/ixgb.txt
-F:	Documentation/networking/ixgbe.txt
-F:	Documentation/networking/ixgbevf.txt
-F:	Documentation/networking/i40e.txt
-F:	Documentation/networking/iavf.txt
-F:	Documentation/networking/ice.txt
+F:	Documentation/networking/igb.rst
+F:	Documentation/networking/igbvf.rst
+F:	Documentation/networking/ixgb.rst
+F:	Documentation/networking/ixgbe.rst
+F:	Documentation/networking/ixgbevf.rst
+F:	Documentation/networking/i40e.rst
+F:	Documentation/networking/iavf.rst
+F:	Documentation/networking/ice.rst
 F:	drivers/net/ethernet/intel/
 F:	drivers/net/ethernet/intel/*/
 F:	include/linux/avf/virtchnl.h
diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 9ff6da335b2a..fd3373d82a9e 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -68,6 +68,9 @@ config E1000E
 
 	  <http://support.intel.com>
 
+	  More specific information on configuring the driver is in
+	  <file:Documentation/networking/e1000e.rst>.
+
 	  To compile this driver as a module, choose M here. The module
 	  will be called e1000e.
 
@@ -94,7 +97,7 @@ config IGB
 	  <http://support.intel.com>
 
 	  More specific information on configuring the driver is in
-	  <file:Documentation/networking/e1000.rst>.
+	  <file:Documentation/networking/igb.rst>.
 
 	  To compile this driver as a module, choose M here. The module
 	  will be called igb.
@@ -130,7 +133,7 @@ config IGBVF
 	  <http://support.intel.com>
 
 	  More specific information on configuring the driver is in
-	  <file:Documentation/networking/e1000.rst>.
+	  <file:Documentation/networking/igbvf.rst>.
 
 	  To compile this driver as a module, choose M here. The module
 	  will be called igbvf.
@@ -147,7 +150,7 @@ config IXGB
 	  <http://support.intel.com>
 
 	  More specific information on configuring the driver is in
-	  <file:Documentation/networking/ixgb.txt>.
+	  <file:Documentation/networking/ixgb.rst>.
 
 	  To compile this driver as a module, choose M here. The module
 	  will be called ixgb.
@@ -164,6 +167,9 @@ config IXGBE
 
 	  <http://support.intel.com>
 
+	  More specific information on configuring the driver is in
+	  <file:Documentation/networking/ixgbe.rst>.
+
 	  To compile this driver as a module, choose M here. The module
 	  will be called ixgbe.
 
@@ -205,7 +211,7 @@ config IXGBEVF
 	  <http://support.intel.com>
 
 	  More specific information on configuring the driver is in
-	  <file:Documentation/networking/ixgbevf.txt>.
+	  <file:Documentation/networking/ixgbevf.rst>.
 
 	  To compile this driver as a module, choose M here. The module
 	  will be called ixgbevf.  MSI-X interrupt support is required
@@ -222,6 +228,9 @@ config I40E
 
 	  <http://support.intel.com>
 
+	  More specific information on configuring the driver is in
+	  <file:Documentation/networking/i40e.rst>.
+
 	  To compile this driver as a module, choose M here. The module
 	  will be called i40e.
 
@@ -254,6 +263,9 @@ config I40EVF
 
 	  This driver was formerly named i40evf.
 
+	  More specific information on configuring the driver is in
+	  <file:Documentation/networking/iavf.rst>.
+
 	  To compile this driver as a module, choose M here. The module
 	  will be called iavf.  MSI-X interrupt support is required
 	  for this driver to work correctly.
@@ -269,6 +281,9 @@ config ICE
 
 	  <http://support.intel.com>
 
+	  More specific information on configuring the driver is in
+	  <file:Documentation/networking/ice.rst>.
+
 	  To compile this driver as a module, choose M here. The module
 	  will be called ice.
 
-- 
2.17.1


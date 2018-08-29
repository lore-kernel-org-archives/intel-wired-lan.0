From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 29 Aug 2018 08:39:39 -0700
Subject: [Intel-wired-lan] [PATCH 2/2] Documentation: ixgb: Convert to RST
 format
In-Reply-To: <20180829153939.26656-1-jeffrey.t.kirsher@intel.com>
References: <20180829153939.26656-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20180829153939.26656-2-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Now that the document has been updated to conform to the reStructured Text
guidelines, we can now change the file extension and update the other
related references.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 Documentation/networking/index.rst              | 1 +
 Documentation/networking/{ixgb.txt => ixgb.rst} | 0
 MAINTAINERS                                     | 2 +-
 drivers/net/ethernet/intel/Kconfig              | 2 +-
 4 files changed, 3 insertions(+), 2 deletions(-)
 rename Documentation/networking/{ixgb.txt => ixgb.rst} (100%)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index fcd710f2cc7a..a9346dc77a74 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -14,6 +14,7 @@ Contents:
    dpaa2/index
    e100
    e1000
+   ixgb
    kapi
    z8530book
    msg_zerocopy
diff --git a/Documentation/networking/ixgb.txt b/Documentation/networking/ixgb.rst
similarity index 100%
rename from Documentation/networking/ixgb.txt
rename to Documentation/networking/ixgb.rst
diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052aeac39..33efe126a541 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7327,7 +7327,7 @@ F:	Documentation/networking/e1000.rst
 F:	Documentation/networking/e1000e.txt
 F:	Documentation/networking/igb.txt
 F:	Documentation/networking/igbvf.txt
-F:	Documentation/networking/ixgb.txt
+F:	Documentation/networking/ixgb.rst
 F:	Documentation/networking/ixgbe.txt
 F:	Documentation/networking/ixgbevf.txt
 F:	Documentation/networking/i40e.txt
diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index fcb676398022..b3a55925241b 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -147,7 +147,7 @@ config IXGB
 	  <http://support.intel.com>
 
 	  More specific information on configuring the driver is in
-	  <file:Documentation/networking/ixgb.txt>.
+	  <file:Documentation/networking/ixgb.rst>.
 
 	  To compile this driver as a module, choose M here. The module
 	  will be called ixgb.
-- 
2.17.1


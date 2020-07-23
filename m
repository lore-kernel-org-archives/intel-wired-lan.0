From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 23 Jul 2020 09:07:20 -0700
Subject: [Intel-wired-lan] [next-queue v3] Documentation: intel: Replace
 HTTP links with HTTPS ones
Message-ID: <20200723160720.795688-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Alexander A. Klimov" <grandmaster@al2klimov.de>

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
v3: Fixed to apply to dev-queue
v2: Undone broken link.

 .../networking/device_drivers/ethernet/intel/e100.rst         | 4 ++--
 .../networking/device_drivers/ethernet/intel/fm10k.rst        | 2 +-
 .../networking/device_drivers/ethernet/intel/iavf.rst         | 2 +-
 .../networking/device_drivers/ethernet/intel/igb.rst          | 2 +-
 .../networking/device_drivers/ethernet/intel/igbvf.rst        | 2 +-
 .../networking/device_drivers/ethernet/intel/ixgb.rst         | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/e100.rst b/Documentation/networking/device_drivers/ethernet/intel/e100.rst
index 3ac21e7119a7..3d4a9ba21946 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/e100.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/e100.rst
@@ -41,7 +41,7 @@ Identifying Your Adapter
 
 For information on how to identify your adapter, and for the latest Intel
 network drivers, refer to the Intel Support website:
-http://www.intel.com/support
+https://www.intel.com/support
 
 Driver Configuration Parameters
 ===============================
@@ -179,7 +179,7 @@ filtering by
 Support
 =======
 For general information, go to the Intel support website at:
-http://www.intel.com/support/
+https://www.intel.com/support/
 
 or the Intel Wired Networking project hosted by Sourceforge at:
 http://sourceforge.net/projects/e1000
diff --git a/Documentation/networking/device_drivers/ethernet/intel/fm10k.rst b/Documentation/networking/device_drivers/ethernet/intel/fm10k.rst
index 4d279e64e221..9258ef6f515c 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/fm10k.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/fm10k.rst
@@ -22,7 +22,7 @@ Ethernet Multi-host Controller.
 
 For information on how to identify your adapter, and for the latest Intel
 network drivers, refer to the Intel Support website:
-http://www.intel.com/support
+https://www.intel.com/support
 
 
 Flow Control
diff --git a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
index 84ac7e75f363..52e037b11c97 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
@@ -43,7 +43,7 @@ device.
 
 For information on how to identify your adapter, and for the latest NVM/FW
 images and Intel network drivers, refer to the Intel Support website:
-http://www.intel.com/support
+https://www.intel.com/support
 
 
 Additional Features and Configurations
diff --git a/Documentation/networking/device_drivers/ethernet/intel/igb.rst b/Documentation/networking/device_drivers/ethernet/intel/igb.rst
index 87e560fe5eaa..d46289e182cf 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/igb.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/igb.rst
@@ -20,7 +20,7 @@ Identifying Your Adapter
 ========================
 For information on how to identify your adapter, and for the latest Intel
 network drivers, refer to the Intel Support website:
-http://www.intel.com/support
+https://www.intel.com/support
 
 
 Command Line Parameters
diff --git a/Documentation/networking/device_drivers/ethernet/intel/igbvf.rst b/Documentation/networking/device_drivers/ethernet/intel/igbvf.rst
index 557fc020ef31..40fa210c5e14 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/igbvf.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/igbvf.rst
@@ -35,7 +35,7 @@ Identifying Your Adapter
 ========================
 For information on how to identify your adapter, and for the latest Intel
 network drivers, refer to the Intel Support website:
-http://www.intel.com/support
+https://www.intel.com/support
 
 
 Additional Features and Configurations
diff --git a/Documentation/networking/device_drivers/ethernet/intel/ixgb.rst b/Documentation/networking/device_drivers/ethernet/intel/ixgb.rst
index ab624f1a44a8..c6a233e68ad6 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ixgb.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ixgb.rst
@@ -203,7 +203,7 @@ With the 10 Gigabit server adapters, the default Linux configuration will
 very likely limit the total available throughput artificially.  There is a set
 of configuration changes that, when applied together, will increase the ability
 of Linux to transmit and receive data.  The following enhancements were
-originally acquired from settings published at http://www.spec.org/web99/ for
+originally acquired from settings published at https://www.spec.org/web99/ for
 various submitted results using Linux.
 
 NOTE:
-- 
2.26.2


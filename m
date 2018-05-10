From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 10 May 2018 12:55:38 -0700
Subject: [Intel-wired-lan] [PATCH v2] Documentation: e1000: Update kernel
 documentation
Message-ID: <20180510195538.19124-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Updated the e1000.txt kernel documentation with the latest information.

Also convert the text file to reStructuredText (RST) format, since the
Linux kernel documentation now uses this format for documentation.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
v2: fix the broken URL

 .../networking/{e1000.txt => e1000.rst}       | 59 ++++---------------
 Documentation/networking/index.rst            |  1 +
 MAINTAINERS                                   |  2 +-
 3 files changed, 12 insertions(+), 50 deletions(-)
 rename Documentation/networking/{e1000.txt => e1000.rst} (89%)

diff --git a/Documentation/networking/e1000.txt b/Documentation/networking/e1000.rst
similarity index 89%
rename from Documentation/networking/e1000.txt
rename to Documentation/networking/e1000.rst
index 1f6ed848363d..616848940e63 100644
--- a/Documentation/networking/e1000.txt
+++ b/Documentation/networking/e1000.rst
@@ -154,7 +154,7 @@ NOTE:  When e1000 is loaded with default settings and multiple adapters
        are in use simultaneously, the CPU utilization may increase non-
        linearly.  In order to limit the CPU utilization without impacting
        the overall throughput, we recommend that you load the driver as
-       follows:
+       follows::
 
            modprobe e1000 InterruptThrottleRate=3000,3000,3000
 
@@ -167,8 +167,8 @@ NOTE:  When e1000 is loaded with default settings and multiple adapters
 
 RxDescriptors
 -------------
-Valid Range:   80-256 for 82542 and 82543-based adapters
-               80-4096 for all other supported adapters
+Valid Range:   48-256 for 82542 and 82543-based adapters
+               48-4096 for all other supported adapters
 Default Value: 256
 
 This value specifies the number of receive buffer descriptors allocated
@@ -230,8 +230,8 @@ speed.  Duplex should also be set when Speed is set to either 10 or 100.
 
 TxDescriptors
 -------------
-Valid Range:   80-256 for 82542 and 82543-based adapters
-               80-4096 for all other supported adapters
+Valid Range:   48-256 for 82542 and 82543-based adapters
+               48-4096 for all other supported adapters
 Default Value: 256
 
 This value is the number of transmit descriptors allocated by the driver.
@@ -242,41 +242,10 @@ NOTE:  Depending on the available system resources, the request for a
        higher number of transmit descriptors may be denied.  In this case,
        use a lower number.
 
-TxDescriptorStep
-----------------
-Valid Range:    1 (use every Tx Descriptor)
-                4 (use every 4th Tx Descriptor)
-
-Default Value:  1 (use every Tx Descriptor)
-
-On certain non-Intel architectures, it has been observed that intense TX
-traffic bursts of short packets may result in an improper descriptor
-writeback. If this occurs, the driver will report a "TX Timeout" and reset
-the adapter, after which the transmit flow will restart, though data may
-have stalled for as much as 10 seconds before it resumes.
-
-The improper writeback does not occur on the first descriptor in a system
-memory cache-line, which is typically 32 bytes, or 4 descriptors long.
-
-Setting TxDescriptorStep to a value of 4 will ensure that all TX descriptors
-are aligned to the start of a system memory cache line, and so this problem
-will not occur.
-
-NOTES: Setting TxDescriptorStep to 4 effectively reduces the number of
-       TxDescriptors available for transmits to 1/4 of the normal allocation.
-       This has a possible negative performance impact, which may be
-       compensated for by allocating more descriptors using the TxDescriptors
-       module parameter.
-
-       There are other conditions which may result in "TX Timeout", which will
-       not be resolved by the use of the TxDescriptorStep parameter. As the
-       issue addressed by this parameter has never been observed on Intel
-       Architecture platforms, it should not be used on Intel platforms.
-
 TxIntDelay
 ----------
 Valid Range:   0-65535 (0=off)
-Default Value: 64
+Default Value: 8
 
 This value delays the generation of transmit interrupts in units of
 1.024 microseconds.  Transmit interrupt reduction can improve CPU
@@ -288,7 +257,7 @@ TxAbsIntDelay
 -------------
 (This parameter is supported only on 82540, 82545 and later adapters.)
 Valid Range:   0-65535 (0=off)
-Default Value: 64
+Default Value: 32
 
 This value, in units of 1.024 microseconds, limits the delay in which a
 transmit interrupt is generated.  Useful only if TxIntDelay is non-zero,
@@ -310,7 +279,7 @@ Copybreak
 ---------
 Valid Range:   0-xxxxxxx (0=off)
 Default Value: 256
-Usage: insmod e1000.ko copybreak=128
+Usage: modprobe e1000.ko copybreak=128
 
 Driver copies all packets below or equaling this size to a fresh RX
 buffer before handing it up the stack.
@@ -328,14 +297,6 @@ Default Value:  0 (disabled)
 Allows PHY to turn off in lower power states. The user can turn off
 this parameter in supported chipsets.
 
-KumeranLockLoss
----------------
-Valid Range: 0-1
-Default Value: 1 (enabled)
-
-This workaround skips resetting the PHY at shutdown for the initial
-silicon releases of ICH8 systems.
-
 Speed and Duplex Configuration
 ==============================
 
@@ -397,12 +358,12 @@ Additional Configurations
   ------------
   Jumbo Frames support is enabled by changing the MTU to a value larger than
   the default of 1500.  Use the ifconfig command to increase the MTU size.
-  For example:
+  For example::
 
        ifconfig eth<x> mtu 9000 up
 
   This setting is not saved across reboots.  It can be made permanent if
-  you add:
+  you add::
 
        MTU=9000
 
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index d11a62977edd..fec8588a588e 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -11,6 +11,7 @@ Contents:
    can
    dpaa2/index
    e100
+   e1000
    kapi
    z8530book
    msg_zerocopy
diff --git a/MAINTAINERS b/MAINTAINERS
index 0a5e36927540..79a725453d22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7081,7 +7081,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
 S:	Supported
 F:	Documentation/networking/e100.rst
-F:	Documentation/networking/e1000.txt
+F:	Documentation/networking/e1000.rst
 F:	Documentation/networking/e1000e.txt
 F:	Documentation/networking/igb.txt
 F:	Documentation/networking/igbvf.txt
-- 
2.17.0


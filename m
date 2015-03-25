From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 19:29:44 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix documentation
Message-ID: <1427250584-22752-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Stephen Hemminger <stephen@networkplumber.org>

The MTU values in the documentation do not match the source.
The source has frame limit of IXGBE_MAX_JUMBO_FRAME_SIZE (9728)
which is MTU of 9710 because of the accounting for Ethernet header
and CRC.

Also, don't refer to the obsolete ifconfig command.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 Documentation/networking/ixgbe.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/ixgbe.txt b/Documentation/networking/ixgbe.txt
index 0ace6e7..6f0cb57 100644
--- a/Documentation/networking/ixgbe.txt
+++ b/Documentation/networking/ixgbe.txt
@@ -70,10 +70,10 @@ Avago      1000BASE-T SFP                                    ABCU-5710RZ
 82599-based adapters support all passive and active limiting direct attach
 cables that comply with SFF-8431 v4.1 and SFF-8472 v10.4 specifications.
 
-Laser turns off for SFP+ when ifconfig down
+Laser turns off for SFP+ when device is down
 -------------------------------------------
-"ifconfig down" turns off the laser for 82599-based SFP+ fiber adapters.
-"ifconfig up" turns on the laser.
+"ip link set down" turns off the laser for 82599-based SFP+ fiber adapters.
+"ip link set up" turns on the laser.
 
 
 82598-BASED ADAPTERS
@@ -213,13 +213,13 @@ Additional Configurations
   ------------
   The driver supports Jumbo Frames for all adapters. Jumbo Frames support is
   enabled by changing the MTU to a value larger than the default of 1500.
-  The maximum value for the MTU is 16110.  Use the ifconfig command to
+  The maximum value for the MTU is 16110.  Use the ip command to
   increase the MTU size.  For example:
 
-        ifconfig ethx mtu 9000 up
+        ip link set dev ethx mtu 9000
 
-  The maximum MTU setting for Jumbo Frames is 16110.  This value coincides
-  with the maximum Jumbo Frames size of 16128.
+  The maximum MTU setting for Jumbo Frames is 9710.  This value coincides
+  with the maximum Jumbo Frames size of 9728.
 
   Generic Receive Offload, aka GRO
   --------------------------------
-- 
1.9.3


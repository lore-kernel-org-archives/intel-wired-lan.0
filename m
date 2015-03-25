From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 19:30:15 -0700
Subject: [Intel-wired-lan] [PATCH] ixgb: remove references to ifconfig
Message-ID: <1427250615-22799-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Stephen Hemminger <stephen@networkplumber.org>

Move documentation into this century, even if this device hasn't
been available for some time.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 Documentation/networking/ixgb.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/ixgb.txt b/Documentation/networking/ixgb.txt
index 1e0c045..9b4a10a1 100644
--- a/Documentation/networking/ixgb.txt
+++ b/Documentation/networking/ixgb.txt
@@ -39,7 +39,7 @@ Channel Bonding documentation can be found in the Linux kernel source:
 
 The driver information previously displayed in the /proc filesystem is not
 supported in this release.  Alternatively, you can use ethtool (version 1.6
-or later), lspci, and ifconfig to obtain the same information.
+or later), lspci, and iproute2 to obtain the same information.
 
 Instructions on updating ethtool can be found in the section "Additional
 Configurations" later in this document.
@@ -90,7 +90,7 @@ select m for "Intel(R) PRO/10GbE support" located at:
 3. Assign an IP address to the interface by entering the following, where
    x is the interface number:
 
-     ifconfig ethx <IP_address>
+     ip addr add ethx <IP_address>
 
 4. Verify that the interface works. Enter the following, where <IP_address>
    is the IP address for another machine on the same subnet as the interface
@@ -177,7 +177,7 @@ NOTE: These changes are only suggestions, and serve as a starting point for
       tuning your network performance.
 
 The changes are made in three major ways, listed in order of greatest effect:
-- Use ifconfig to modify the mtu (maximum transmission unit) and the txqueuelen
+- Use ip link to modify the mtu (maximum transmission unit) and the txqueuelen
   parameter.
 - Use sysctl to modify /proc parameters (essentially kernel tuning)
 - Use setpci to modify the MMRBC field in PCI-X configuration space to increase
@@ -202,7 +202,7 @@ setpci -d 8086:1a48 e6.b=2e
 # to change as well.
 # set the txqueuelen
 # your ixgb adapter should be loaded as eth1 for this to work, change if needed
-ifconfig eth1 mtu 9000 txqueuelen 1000 up
+ip li set dev eth1 mtu 9000 txqueuelen 1000 up
 # call the sysctl utility to modify /proc/sys entries
 sysctl -p ./sysctl_ixgb.conf
 - END ixgb_perf.sh
@@ -297,10 +297,10 @@ Additional Configurations
   ------------
   The driver supports Jumbo Frames for all adapters. Jumbo Frames support is
   enabled by changing the MTU to a value larger than the default of 1500.
-  The maximum value for the MTU is 16114.  Use the ifconfig command to
+  The maximum value for the MTU is 16114.  Use the ip command to
   increase the MTU size.  For example:
 
-        ifconfig ethx mtu 9000 up
+        ip li set dev ethx mtu 9000
 
   The maximum MTU setting for Jumbo Frames is 16114.  This value coincides
   with the maximum Jumbo Frames size of 16128.
-- 
1.9.3


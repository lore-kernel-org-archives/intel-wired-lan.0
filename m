From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 19:27:24 -0700
Subject: [Intel-wired-lan] [PATCH] igb: doc don't refer to ifconfig
Message-ID: <1427250444-22626-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Stephen Hemminger <stephen@networkplumber.org>

ifconfig command is obsolete, best to remove all references so that
new users learn ip.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 Documentation/networking/igb.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/igb.txt b/Documentation/networking/igb.txt
index 43d3549..15534fd 100644
--- a/Documentation/networking/igb.txt
+++ b/Documentation/networking/igb.txt
@@ -42,10 +42,10 @@ Additional Configurations
   Jumbo Frames
   ------------
   Jumbo Frames support is enabled by changing the MTU to a value larger than
-  the default of 1500.  Use the ifconfig command to increase the MTU size.
+  the default of 1500.  Use the ip command to increase the MTU size.
   For example:
 
-       ifconfig eth<x> mtu 9000 up
+       ip link set dev eth<x> mtu 9000
 
   This setting is not saved across reboots.
 
-- 
1.9.3


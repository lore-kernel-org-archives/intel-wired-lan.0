From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 29 Oct 2018 15:54:12 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: add ipsec hw offload note to ixgbe
 Documentation
Message-ID: <1540853652-5081-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a short note about using IPsec Hardware Offload with
the ixgbe driver.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 Documentation/networking/ixgbe.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/networking/ixgbe.rst b/Documentation/networking/ixgbe.rst
index 725fc69..e5936dc 100644
--- a/Documentation/networking/ixgbe.rst
+++ b/Documentation/networking/ixgbe.rst
@@ -501,6 +501,20 @@ NOTE: This feature can be disabled for a specific Virtual Function (VF)::
 
   ip link set <pf dev> vf <vf id> spoofchk {off|on}
 
+IPsec Offload
+-------------
+The ixgbe driver supports IPsec Hardware Offload.  When creating Security
+Associations with "ip xfrm ..." the 'offload' tag option can be used to
+register the IPsec SA with the driver in order to get higher throughput in
+the secure communications.
+
+The offload is also supported for ixgbe's VFs, but the VF must be set as
+'trusted' and the support must be enabled with::
+
+  ethtool --set-priv-flags eth<x> vf-ipsec on
+  ip link set eth<x> vf <y> trust on
+
+
 
 Known Issues/Troubleshooting
 ============================
-- 
2.7.4


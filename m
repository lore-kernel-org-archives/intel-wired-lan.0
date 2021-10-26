From: Robert Schlabbach <robert_s@gmx.net>
Date: Tue, 26 Oct 2021 02:24:48 +0200
Subject: [Intel-wired-lan] [PATCH net] ixgbe: Document how to enable NBASE-T
 support
Message-ID: <trinity-d1eee2a2-f92d-4a57-adcb-d82f227094f7-1635207888762@3c-app-gmx-bap12>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit a296d665eae1 ("ixgbe: Add ethtool support to enable 2.5 and 5.0
Gbps support") introduced suppression of the advertisement of NBASE-T
speeds by default, according to Todd Fujinaka to accommodate customers
with network switches which could not cope with advertised NBASE-T
speeds, as posted in the E1000-devel mailing list:

https://sourceforge.net/p/e1000/mailman/message/37106269/

However, the suppression was not documented at all, nor was how to
enable NBASE-T support.

Properly document the NBASE-T suppression and how to enable NBASE-T
support.

Fixes: a296d665eae1 ("ixgbe: Add ethtool support to enable 2.5 and 5.0 Gbps support")
Reported-by: Robert Schlabbach <robert_s@gmx.net>
Signed-off-by: Robert Schlabbach <robert_s@gmx.net>
---
 .../device_drivers/ethernet/intel/ixgbe.rst      | 16 ++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ixgbe.rst b/Documentation/networking/device_drivers/ethernet/intel/ixgbe.rst
index f1d5233e5e51..a60b507e5173 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ixgbe.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ixgbe.rst
@@ -515,6 +515,22 @@ The offload is also supported for ixgbe's VFs, but the VF must be set as
   ethtool --set-priv-flags eth<x> vf-ipsec on
   ip link set eth<x> vf <y> trust on

+NBASE-T Support
+---------------
+The ixgbe driver supports NBASE-T on some devices. However, the advertisement
+of NBASE-T speeds is suppressed by default, to accommodate broken network
+switches which cannot cope with advertised NBASE-T speeds. Use the ethtool
+command to enable advertising NBASE-T speeds on devices which support it::
+
+  ethtool -s eth? advertise 0x1800000001028
+
+On Linux systems with INTERFACES(5), this can be specified as a pre-up command
+in /etc/network/interfaces so that the interface is always brought up with
+NBASE-T support, e.g.::
+
+  iface eth? inet dhcp
+       pre-up ethtool -s eth? advertise 0x1800000001028 || true
+

 Known Issues/Troubleshooting
 ============================
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 13c4782b920a..750b02bb2fdc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5526,6 +5526,10 @@ static int ixgbe_non_sfp_link_config(struct ixgbe_hw *hw)
 	if (!speed && hw->mac.ops.get_link_capabilities) {
 		ret = hw->mac.ops.get_link_capabilities(hw, &speed,
 							&autoneg);
+		/* remove NBASE-T speeds from default autonegotiation
+		 * to accommodate broken network switches in the field
+		 * which cannot cope with advertised NBASE-T speeds
+		 */
 		speed &= ~(IXGBE_LINK_SPEED_5GB_FULL |
 			   IXGBE_LINK_SPEED_2_5GB_FULL);
 	}
--
2.17.1


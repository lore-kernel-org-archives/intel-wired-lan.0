From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Wed, 24 Jun 2015 16:38:53 -0400
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Add SFP+ detection for
	X550 hardware
Message-ID: <20150624203853.19061.45152.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch is part of the future enablement of X550 SFP+ support.  This
HW uses different SDP so the interrupts need to be set up accordingly.

Signed-off-by: Donald C Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 171b7da..205e0ec 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4904,9 +4904,15 @@ static void ixgbe_setup_gpie(struct ixgbe_adapter *adapter)
 	if (adapter->flags & IXGBE_FLAG_FAN_FAIL_CAPABLE)
 		gpie |= IXGBE_SDP1_GPIEN(hw);
 
-	if (hw->mac.type == ixgbe_mac_82599EB) {
-		gpie |= IXGBE_SDP1_GPIEN_8259X;
-		gpie |= IXGBE_SDP2_GPIEN_8259X;
+	switch (hw->mac.type) {
+	case ixgbe_mac_82599EB:
+		gpie |= IXGBE_SDP1_GPIEN_8259X | IXGBE_SDP2_GPIEN_8259X;
+		break;
+	case ixgbe_mac_X550EM_x:
+		gpie |= IXGBE_SDP0_GPIEN_X540;
+		break;
+	default:
+		break;
 	}
 
 	IXGBE_WRITE_REG(hw, IXGBE_GPIE, gpie);


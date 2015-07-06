From: Raanan Avargil <raanan.avargil@intel.com>
Date: Mon,  6 Jul 2015 16:48:00 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: Fix EEE in Sx implementation
Message-ID: <1436190480-20941-1-git-send-email-raanan.avargil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch implements the EEE in Sx code so that it only applies to parts
that support EEE in Sx (as opposed to all parts that support EEE).
It also uses the existing eee_advert and eee_lp_abiliity to set just the bits
(100/1000) that should be set.

Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 6c153c1..1ca8e98 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6317,6 +6317,32 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 			return retval;
 	}
 
+	/* Ensure that the appropriate bits are set in LPI_CTRL
+	 * for EEE in Sx
+	 */
+	if ((hw->phy.type >= e1000_phy_i217) &&
+	    adapter->eee_advert && hw->dev_spec.ich8lan.eee_lp_ability) {
+		u16 lpi_ctrl = 0;
+		retval = hw->phy.ops.acquire(hw);
+		if (!retval) {
+			retval = e1e_rphy_locked(hw, I82579_LPI_CTRL,
+						 &lpi_ctrl);
+			if (!retval) {
+				if (adapter->eee_advert &
+				    hw->dev_spec.ich8lan.eee_lp_ability &
+				    I82579_EEE_100_SUPPORTED)
+					lpi_ctrl |= I82579_LPI_CTRL_100_ENABLE;
+				if (adapter->eee_advert &
+				    hw->dev_spec.ich8lan.eee_lp_ability &
+				    I82579_EEE_1000_SUPPORTED)
+					lpi_ctrl |= I82579_LPI_CTRL_1000_ENABLE;
+
+				retval = e1e_wphy_locked(hw, I82579_LPI_CTRL,
+							 lpi_ctrl);
+			}
+		}
+		hw->phy.ops.release(hw);
+	}
 
 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
 	 * would have already happened in close and is redundant.
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


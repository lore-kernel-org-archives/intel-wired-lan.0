From: Raanan Avargil <raanan.avargil@intel.com>
Date: Tue, 22 Dec 2015 15:35:02 +0200
Subject: [Intel-wired-lan] [PATCH 2/5] e1000e: Increase PHY PLL clock gate
	timing
In-Reply-To: <1450791305-11285-1-git-send-email-raanan.avargil@intel.com>
References: <1450791305-11285-1-git-send-email-raanan.avargil@intel.com>
Message-ID: <1450791305-11285-2-git-send-email-raanan.avargil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Several packet loss issues were reported for which the root cause for
them was an incorrect configuration of internal HW Phy clock gating
mechanism by SW.
This patch provides the correct mechanism.

Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 12 ++++++++++++
 drivers/net/ethernet/intel/e1000e/ich8lan.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index c731465..786d214 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1433,6 +1433,18 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 			emi_addr = I217_RX_CONFIG;
 		ret_val = e1000_write_emi_reg_locked(hw, emi_addr, emi_val);
 
+		if (hw->mac.type == e1000_pch_lpt ||
+		    hw->mac.type == e1000_pch_spt) {
+			u16 phy_reg;
+
+			e1e_rphy_locked(hw, I217_PLL_CLOCK_GATE_REG, &phy_reg);
+			phy_reg &= ~I217_PLL_CLOCK_GATE_MASK;
+			if (speed == SPEED_100 || speed == SPEED_10)
+				phy_reg |= 0x3E8;
+			else
+				phy_reg |= 0xFA;
+			e1e_wphy_locked(hw, I217_PLL_CLOCK_GATE_REG, phy_reg);
+		}
 		hw->phy.ops.release(hw);
 
 		if (ret_val)
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
index 34c551e..7d85f00 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
@@ -226,6 +226,9 @@
 #define HV_PM_CTRL_PLL_STOP_IN_K1_GIGA	0x100
 #define HV_PM_CTRL_K1_ENABLE		0x4000
 
+#define I217_PLL_CLOCK_GATE_REG	PHY_REG(772, 28)
+#define I217_PLL_CLOCK_GATE_MASK	0x07FF
+
 #define SW_FLAG_TIMEOUT		1000	/* SW Semaphore flag timeout in ms */
 
 /* Inband Control */
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


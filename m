From: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Date: Wed, 10 Jun 2015 01:16:01 +0300
Subject: [Intel-wired-lan] [PATCH 4/5] e1000e: i219 - Increase minimum FIFO
	read/write min gap
In-Reply-To: <f60bcfb3d2cf6db3c53fe84b1620dad209976300.1433877893.git.yanirx.lubetkin@intel.com>
References: <f60bcfb3d2cf6db3c53fe84b1620dad209976300.1433877893.git.yanirx.lubetkin@intel.com>
Message-ID: <7c29aaeac25d60eb66d78eceb930c3da8e0f5a98.1433877893.git.yanirx.lubetkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Due to clocking changes in the Skylake platform, there was Jacksonville
data corruption. To work around this, HW team reported the need
to increase the minimum gap between the phy FIFO read and write pointers.

Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index af4431d..4ce57e8 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1438,6 +1438,52 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 
 		if (ret_val)
 			return ret_val;
+
+		if (hw->mac.type == e1000_pch_spt) {
+			u16 data;
+			u16 ptr_gap;
+
+			if (speed == SPEED_1000) {
+				ret_val = hw->phy.ops.acquire(hw);
+				if (ret_val)
+					return ret_val;
+
+				ret_val = e1e_rphy_locked(hw,
+							  PHY_REG(776, 20),
+							  &data);
+				if (ret_val) {
+					hw->phy.ops.release(hw);
+					return ret_val;
+				}
+
+				ptr_gap = (data & (0x3FF << 2)) >> 2;
+				if (ptr_gap < 0x18) {
+					data &= ~(0x3FF << 2);
+					data |= (0x18 << 2);
+					ret_val =
+					    e1e_wphy_locked(hw,
+							    PHY_REG(776, 20),
+							    data);
+				}
+				hw->phy.ops.release(hw);
+				if (ret_val)
+					return ret_val;
+			}
+		}
+	}
+
+	/* I217 Packet Loss issue:
+	 * ensure that FEXTNVM4 Beacon Duration is set correctly
+	 * on power up.
+	 * Set the Beacon Duration for I217 to 8 usec
+	 */
+	if ((hw->mac.type == e1000_pch_lpt) || (hw->mac.type == e1000_pch_spt)) {
+		u32 mac_reg;
+
+		mac_reg = er32(FEXTNVM4);
+		mac_reg &= ~E1000_FEXTNVM4_BEACON_DURATION_MASK;
+		mac_reg |= E1000_FEXTNVM4_BEACON_DURATION_8USEC;
+		ew32(FEXTNVM4, mac_reg);
 	}
 
 	/* Work-around I218 hang issue */
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


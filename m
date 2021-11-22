From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 23 Nov 2021 00:19:25 +0800
Subject: [Intel-wired-lan] [PATCH 1/3] Revert "e1000e: Additional PHY power
 saving in S0ix"
Message-ID: <20211122161927.874291-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This reverts commit 3ad3e28cb203309fb29022dea41cd65df0583632.

The s0ix series makes e1000e on TGL and ADL fails to work after s2idle
resume.

There doesn't seem to be any solution soon, so revert the whole series.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=214821
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 44e2dc8328a22..e16b7c0d98089 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6380,16 +6380,10 @@ static void e1000e_s0ix_entry_flow(struct e1000_adapter *adapter)
 		ew32(CTRL_EXT, mac_data);
 
 		/* DFT control: PHY bit: page769_20[0] = 1
-		 * page769_20[7] - PHY PLL stop
-		 * page769_20[8] - PHY go to the electrical idle
-		 * page769_20[9] - PHY serdes disable
 		 * Gate PPW via EXTCNF_CTRL - set 0x0F00[7] = 1
 		 */
 		e1e_rphy(hw, I82579_DFT_CTRL, &phy_data);
 		phy_data |= BIT(0);
-		phy_data |= BIT(7);
-		phy_data |= BIT(8);
-		phy_data |= BIT(9);
 		e1e_wphy(hw, I82579_DFT_CTRL, phy_data);
 
 		mac_data = er32(EXTCNF_CTRL);
-- 
2.32.0


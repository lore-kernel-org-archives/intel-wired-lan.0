From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu, 24 Jun 2021 11:19:08 +0300
Subject: [Intel-wired-lan] [PATCH v1 3/3] e1000e: Additional PHY power
 saving in s0ix
Message-ID: <20210624081908.568757-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

After transferring the MAC-PHY interface to the SMBus the PHY
will save power in S0ix low power idle mode.

Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 6e6e2e685e9d..c4f3e5ca7294 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6380,10 +6380,16 @@ static void e1000e_s0ix_entry_flow(struct e1000_adapter *adapter)
 		ew32(CTRL_EXT, mac_data);
 
 		/* DFT control: PHY bit: page769_20[0] = 1
+		 * page769_20[7] - PHY PLL stop
+		 * page769_20[8] - PHY go to the electrical idle
+		 * page769_20[9] - PHY serdes disable
 		 * Gate PPW via EXTCNF_CTRL - set 0x0F00[7] = 1
 		 */
 		e1e_rphy(hw, I82579_DFT_CTRL, &phy_data);
 		phy_data |= BIT(0);
+		phy_data |= BIT(7);
+		phy_data |= BIT(8);
+		phy_data |= BIT(9);
 		e1e_wphy(hw, I82579_DFT_CTRL, phy_data);
 
 		mac_data = er32(EXTCNF_CTRL);
-- 
2.25.1


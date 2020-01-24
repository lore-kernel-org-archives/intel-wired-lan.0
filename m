From: Sasha Levin <sashal@kernel.org>
Date: Fri, 24 Jan 2020 09:17:11 -0500
Subject: [Intel-wired-lan] [PATCH AUTOSEL 5.4 041/107] igb: Fix SGMII SFP
 module discovery for 100FX/LX.
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
Message-ID: <20200124141817.28793-41-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Manfred Rudigier <manfred.rudigier@omicronenergy.com>

[ Upstream commit 5365ec1aeff5b9f2962a9c9b31d63f9dad7e0e2d ]

Changing the link mode should also be done for 100BaseFX SGMII modules,
otherwise they just don't work when the default link mode in CTRL_EXT
coming from the EEPROM is SERDES.

Additionally 100Base-LX SGMII SFP modules are also supported now, which
was not the case before.

Tested with an i210 using Flexoptix S.1303.2M.G 100FX and
S.1303.10.G 100LX SGMII SFP modules.

Signed-off-by: Manfred Rudigier <manfred.rudigier@omicronenergy.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c | 8 ++------
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index 8a6ef35141292..438b42ce2cd9a 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -530,7 +530,7 @@ static s32 igb_set_sfp_media_type_82575(struct e1000_hw *hw)
 		dev_spec->module_plugged = true;
 		if (eth_flags->e1000_base_lx || eth_flags->e1000_base_sx) {
 			hw->phy.media_type = e1000_media_type_internal_serdes;
-		} else if (eth_flags->e100_base_fx) {
+		} else if (eth_flags->e100_base_fx || eth_flags->e100_base_lx) {
 			dev_spec->sgmii_active = true;
 			hw->phy.media_type = e1000_media_type_internal_serdes;
 		} else if (eth_flags->e1000_base_t) {
@@ -657,14 +657,10 @@ static s32 igb_get_invariants_82575(struct e1000_hw *hw)
 			break;
 		}
 
-		/* do not change link mode for 100BaseFX */
-		if (dev_spec->eth_flags.e100_base_fx)
-			break;
-
 		/* change current link mode setting */
 		ctrl_ext &= ~E1000_CTRL_EXT_LINK_MODE_MASK;
 
-		if (hw->phy.media_type == e1000_media_type_copper)
+		if (dev_spec->sgmii_active)
 			ctrl_ext |= E1000_CTRL_EXT_LINK_MODE_SGMII;
 		else
 			ctrl_ext |= E1000_CTRL_EXT_LINK_MODE_PCIE_SERDES;
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 3182b059bf55c..8959418776f67 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -181,7 +181,7 @@ static int igb_get_link_ksettings(struct net_device *netdev,
 				advertising &= ~ADVERTISED_1000baseKX_Full;
 			}
 		}
-		if (eth_flags->e100_base_fx) {
+		if (eth_flags->e100_base_fx || eth_flags->e100_base_lx) {
 			supported |= SUPPORTED_100baseT_Full;
 			advertising |= ADVERTISED_100baseT_Full;
 		}
-- 
2.20.1


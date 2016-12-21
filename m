From: Mitch Williams <mitch.a.williams@intel.com>
Date: Tue, 20 Dec 2016 16:35:28 -0800
Subject: [Intel-wired-lan] [PATCH v3] ethtool: stop the line wrapping madness
Message-ID: <20161221003528.4483-1-mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Folks, we have a hard limit of 80 characters per line in the kernel,
mostly due to Linus' insistence on printing out each release on greenbar
with his Decwriter. So why do we have function and macro names that are
over 30 characters long? Add a tab or two and a few parameters and boom!
you're wrapping lines.

This patch is a search-n-replace of the newly-added ethtool link
settings API with shorter names. In general, I replaced 'ksettings' with
'ks' and elided some unnecessary verbiage. In nearly every instance I
unwrapped lines and made the code easier to read, especially on a VT102.

In the case of the Amazon Ethernet driver, I found a bug where they were
setting bits in the the 'settings' field twice. Almost certainly this
was supposed to set bits in the 'advertising' field instead. So I fixed
it.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
v3: catch a few more drivers
v2: catch a few more drivers
---
 drivers/infiniband/hw/nes/nes_nic.c                |  12 +--
 drivers/net/ethernet/3com/3c509.c                  |   3 +-
 drivers/net/ethernet/3com/typhoon.c                |   6 +-
 drivers/net/ethernet/alteon/acenic.c               |   3 +-
 drivers/net/ethernet/amazon/ena/ena_ethtool.c      |   6 +-
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |  13 +--
 .../net/ethernet/apm/xgene/xgene_enet_ethtool.c    |  16 +---
 drivers/net/ethernet/atheros/alx/ethtool.c         |   9 +-
 drivers/net/ethernet/atheros/atl1c/atl1c_ethtool.c |   6 +-
 drivers/net/ethernet/atheros/atl1e/atl1e_ethtool.c |   9 +-
 drivers/net/ethernet/atheros/atlx/atl1.c           |   6 +-
 drivers/net/ethernet/atheros/atlx/atl2.c           |   9 +-
 drivers/net/ethernet/broadcom/b44.c                |   9 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c       |   6 +-
 drivers/net/ethernet/broadcom/bnx2.c               |   9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  | 102 ++++++++-------------
 drivers/net/ethernet/broadcom/tg3.c                |  14 +--
 drivers/net/ethernet/brocade/bna/bnad_ethtool.c    |   6 +-
 drivers/net/ethernet/calxeda/xgmac.c               |   4 +-
 drivers/net/ethernet/cavium/liquidio/lio_ethtool.c |   6 +-
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |   6 +-
 drivers/net/ethernet/chelsio/cxgb/cxgb2.c          |   9 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |  13 +--
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c |  12 +--
 .../net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c    |  12 +--
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     |  10 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |  12 +--
 drivers/net/ethernet/marvell/mv643xx_eth.c         |  24 ++---
 drivers/net/ethernet/marvell/pxa168_eth.c          |   3 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |  49 ++++------
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  25 +++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |  14 +--
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |   6 +-
 drivers/net/ethernet/sfc/ethtool.c                 |   6 +-
 drivers/net/ethernet/sfc/mcdi_port.c               |  12 +--
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  20 ++--
 drivers/net/ethernet/ti/netcp_ethss.c              |   6 +-
 drivers/net/mii.c                                  |  12 +--
 drivers/net/phy/phy.c                              |  13 +--
 drivers/net/usb/lan78xx.c                          |   6 +-
 include/linux/ethtool.h                            |  21 ++---
 net/core/ethtool.c                                 |  40 ++++----
 42 files changed, 217 insertions(+), 368 deletions(-)

diff --git a/drivers/infiniband/hw/nes/nes_nic.c b/drivers/infiniband/hw/nes/nes_nic.c
index 5921ea3..01ef46a 100644
--- a/drivers/infiniband/hw/nes/nes_nic.c
+++ b/drivers/infiniband/hw/nes/nes_nic.c
@@ -1503,10 +1503,8 @@ static int nes_netdev_get_link_ksettings(struct net_device *netdev,
 				cmd->base.autoneg = AUTONEG_DISABLE;
 			cmd->base.phy_address = phy_index;
 		}
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.supported, supported);
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.advertising, advertising);
+		ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+		ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 		return 0;
 	}
 	if ((phy_type == NES_PHY_TYPE_ARGUS) ||
@@ -1523,10 +1521,8 @@ static int nes_netdev_get_link_ksettings(struct net_device *netdev,
 	}
 	cmd->base.speed = SPEED_10000;
 	cmd->base.autoneg = AUTONEG_DISABLE;
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/3com/3c509.c b/drivers/net/ethernet/3com/3c509.c
index a753378..4cf0a1f 100644
--- a/drivers/net/ethernet/3com/3c509.c
+++ b/drivers/net/ethernet/3com/3c509.c
@@ -1078,8 +1078,7 @@ el3_netdev_get_ecmd(struct net_device *dev, struct ethtool_link_ksettings *cmd)
 			cmd->base.duplex = DUPLEX_FULL;
 	}
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
 	cmd->base.speed = SPEED_10;
 	EL3WINDOW(1);
 	return 0;
diff --git a/drivers/net/ethernet/3com/typhoon.c b/drivers/net/ethernet/3com/typhoon.c
index a0cacbe..8d45fdb 100644
--- a/drivers/net/ethernet/3com/typhoon.c
+++ b/drivers/net/ethernet/3com/typhoon.c
@@ -1049,10 +1049,8 @@ typhoon_get_link_ksettings(struct net_device *dev,
 	else
 		cmd->base.autoneg = AUTONEG_DISABLE;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/alteon/acenic.c b/drivers/net/ethernet/alteon/acenic.c
index 16f0c70..ccc39c3 100644
--- a/drivers/net/ethernet/alteon/acenic.c
+++ b/drivers/net/ethernet/alteon/acenic.c
@@ -2630,8 +2630,7 @@ static int ace_get_link_ksettings(struct net_device *dev,
 	ecmd->rxcoal = readl(&regs->TuneRxCoalTicks);
 #endif
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index 67b2338f..369c2d8 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -280,10 +280,8 @@ static int ena_get_link_ksettings(struct net_device *netdev,
 	link_ksettings->base.speed = link->speed;
 
 	if (link->flags & ENA_ADMIN_GET_FEATURE_LINK_DESC_AUTONEG_MASK) {
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, Autoneg);
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, Autoneg);
+		ethtool_ks_add_mode(link_ksettings, supported, Autoneg);
+		ethtool_ks_add_mode(link_ksettings, advertising, Autoneg);
 	}
 
 	link_ksettings->base.autoneg =
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index 920566a..9475777 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -279,12 +279,10 @@ static int xgbe_get_link_ksettings(struct net_device *netdev,
 
 	cmd->base.phy_address = pdata->phy.address;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						pdata->phy.supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						pdata->phy.advertising);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.lp_advertising,
-						pdata->phy.lp_advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, pdata->phy.supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, pdata->phy.advertising);
+	ethtool_u32_to_ks(cmd->link_modes.lp_advertising,
+			  pdata->phy.lp_advertising);
 
 	cmd->base.autoneg = pdata->phy.autoneg;
 	cmd->base.speed = pdata->phy.speed;
@@ -331,8 +329,7 @@ static int xgbe_set_link_ksettings(struct net_device *netdev,
 		}
 	}
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	netif_dbg(pdata, link, netdev,
 		  "requested advertisement %#x, phy supported %#x\n",
diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c b/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
index 28fdedc..bf5ac14 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
@@ -76,12 +76,8 @@ static int xgene_get_link_ksettings(struct net_device *ndev,
 
 		supported = SUPPORTED_1000baseT_Full | SUPPORTED_Autoneg |
 			SUPPORTED_MII;
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.supported,
-			supported);
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.advertising,
-			supported);
+		ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+		ethtool_u32_to_ks(cmd->link_modes.advertising, supported);
 
 		cmd->base.speed = SPEED_1000;
 		cmd->base.duplex = DUPLEX_FULL;
@@ -89,12 +85,8 @@ static int xgene_get_link_ksettings(struct net_device *ndev,
 		cmd->base.autoneg = AUTONEG_ENABLE;
 	} else {
 		supported = SUPPORTED_10000baseT_Full | SUPPORTED_FIBRE;
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.supported,
-			supported);
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.advertising,
-			supported);
+		ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+		ethtool_u32_to_ks(cmd->link_modes.advertising, supported);
 
 		cmd->base.speed = SPEED_10000;
 		cmd->base.duplex = DUPLEX_FULL;
diff --git a/drivers/net/ethernet/atheros/alx/ethtool.c b/drivers/net/ethernet/atheros/alx/ethtool.c
index 2f4eabf..f339500 100644
--- a/drivers/net/ethernet/atheros/alx/ethtool.c
+++ b/drivers/net/ethernet/atheros/alx/ethtool.c
@@ -166,10 +166,8 @@ static int alx_get_link_ksettings(struct net_device *netdev,
 	cmd->base.speed = hw->link_speed;
 	cmd->base.duplex = hw->duplex;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -184,8 +182,7 @@ static int alx_set_link_ksettings(struct net_device *netdev,
 
 	ASSERT_RTNL();
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
 		if (advertising & ~alx_get_supported_speeds(hw))
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_ethtool.c b/drivers/net/ethernet/atheros/atl1c/atl1c_ethtool.c
index cfe86a2..9f67af1 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_ethtool.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_ethtool.c
@@ -62,10 +62,8 @@ static int atl1c_get_link_ksettings(struct net_device *netdev,
 
 	cmd->base.autoneg = AUTONEG_ENABLE;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_ethtool.c b/drivers/net/ethernet/atheros/atl1e/atl1e_ethtool.c
index cb489e7..d31c169 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_ethtool.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_ethtool.c
@@ -63,10 +63,8 @@ static int atl1e_get_link_ksettings(struct net_device *netdev,
 
 	cmd->base.autoneg = AUTONEG_ENABLE;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -78,8 +76,7 @@ static int atl1e_set_link_ksettings(struct net_device *netdev,
 	struct atl1e_hw *hw = &adapter->hw;
 	u32 advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	while (test_and_set_bit(__AT_RESETTING, &adapter->flags))
 		msleep(1);
diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index 7dad8e4..004184b 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -3263,10 +3263,8 @@ static int atl1_get_link_ksettings(struct net_device *netdev,
 	else
 		cmd->base.autoneg = AUTONEG_DISABLE;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
index 63f2dee..7aaac50 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -1771,10 +1771,8 @@ static int atl2_get_link_ksettings(struct net_device *netdev,
 
 	cmd->base.autoneg = AUTONEG_ENABLE;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -1786,8 +1784,7 @@ static int atl2_set_link_ksettings(struct net_device *netdev,
 	struct atl2_hw *hw = &adapter->hw;
 	u32 advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising,	cmd->link_modes.advertising);
 
 	while (test_and_set_bit(__ATL2_RESETTING, &adapter->flags))
 		msleep(1);
diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 1df3048..5758cfc 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -1868,10 +1868,8 @@ static int b44_get_link_ksettings(struct net_device *dev,
 	if (cmd->base.autoneg == AUTONEG_ENABLE)
 		advertising |= ADVERTISED_Autoneg;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	if (!netif_running(dev)){
 		cmd->base.speed = 0;
@@ -1904,8 +1902,7 @@ static int b44_set_link_ksettings(struct net_device *dev,
 
 	speed = cmd->base.speed;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	/* We do not support gigabit. */
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 3b14d51..6e5bd3a 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1463,10 +1463,8 @@ static int bcm_enet_get_link_ksettings(struct net_device *dev,
 			ADVERTISED_100baseT_Half |
 			ADVERTISED_100baseT_Full;
 		advertising = 0;
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.supported, supported);
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.advertising, advertising);
+		ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+		ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 		cmd->base.port = PORT_MII;
 	}
 	return 0;
diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index d5d1026..dce4716 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -6956,10 +6956,8 @@ bnx2_get_link_ksettings(struct net_device *dev,
 
 	cmd->base.phy_address = bp->phy_addr;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -6993,8 +6991,7 @@ bnx2_set_link_ksettings(struct net_device *dev,
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
 		autoneg |= AUTONEG_SPEED;
 
-		ethtool_convert_link_mode_to_legacy_u32(
-			&advertising, cmd->link_modes.advertising);
+		ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 		if (cmd->base.port == PORT_TP) {
 			advertising &= ETHTOOL_ALL_COPPER_SPEED;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 784aa77..237a7e4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -832,61 +832,44 @@ u32 _bnxt_fw_to_ethtool_adv_spds(u16 fw_speeds, u8 fw_pause)
 	return speed_mask;
 }
 
-#define BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, fw_pause, lk_ksettings, name)\
-{									\
-	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_100MB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     100baseT_Full);	\
-	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_1GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     1000baseT_Full);	\
-	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_10GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     10000baseT_Full);	\
-	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_25GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     25000baseCR_Full);	\
-	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_40GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     40000baseCR4_Full);\
-	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_50GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     50000baseCR2_Full);\
-	if ((fw_pause) & BNXT_LINK_PAUSE_RX) {				\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     Pause);		\
-		if (!((fw_pause) & BNXT_LINK_PAUSE_TX))			\
-			ethtool_link_ksettings_add_link_mode(		\
-					lk_ksettings, name, Asym_Pause);\
-	} else if ((fw_pause) & BNXT_LINK_PAUSE_TX) {			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     Asym_Pause);	\
-	}								\
+#define BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, fw_pause, lk_ksettings, name)     \
+{									     \
+	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_100MB)			     \
+		ethtool_ks_add_mode(lk_ksettings, name, 100baseT_Full);	     \
+	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_1GB)			     \
+		ethtool_ks_add_mode(lk_ksettings, name, 1000baseT_Full);     \
+	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_10GB)			     \
+		ethtool_ks_add_mode(lk_ksettings, name, 10000baseT_Full);    \
+	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_25GB)			     \
+		ethtool_ks_add_mode(lk_ksettings, name, 25000baseCR_Full);   \
+	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_40GB)			     \
+		ethtool_ks_add_mode(lk_ksettings, name, 40000baseCR4_Full);  \
+	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_50GB)			     \
+		ethtool_ks_add_mode(lk_ksettings, name, 50000baseCR2_Full);  \
+	if ((fw_pause) & BNXT_LINK_PAUSE_RX) {				     \
+		ethtool_ks_add_mode(lk_ksettings, name, Pause);		     \
+		if (!((fw_pause) & BNXT_LINK_PAUSE_TX))			     \
+			ethtool_ks_add_mode(lk_ksettings, name, Asym_Pause); \
+	} else if ((fw_pause) & BNXT_LINK_PAUSE_TX) {			     \
+		ethtool_ks_add_mode(lk_ksettings, name, Asym_Pause);	     \
+	}								     \
 }
 
 #define BNXT_ETHTOOL_TO_FW_SPDS(fw_speeds, lk_ksettings, name)		\
 {									\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  100baseT_Full) ||	\
-	    ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  100baseT_Half))	\
+	if (ethtool_ks_test(lk_ksettings, name, 100baseT_Full) ||	\
+	    ethtool_ks_test(lk_ksettings, name, 100baseT_Half))		\
 		(fw_speeds) |= BNXT_LINK_SPEED_MSK_100MB;		\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  1000baseT_Full) ||	\
-	    ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  1000baseT_Half))	\
+	if (ethtool_ks_test(lk_ksettings, name, 1000baseT_Full) ||	\
+	    ethtool_ks_test(lk_ksettings, name, 1000baseT_Half))	\
 		(fw_speeds) |= BNXT_LINK_SPEED_MSK_1GB;			\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  10000baseT_Full))	\
+	if (ethtool_ks_test(lk_ksettings, name, 10000baseT_Full))	\
 		(fw_speeds) |= BNXT_LINK_SPEED_MSK_10GB;		\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  25000baseCR_Full))	\
+	if (ethtool_ks_test(lk_ksettings, name, 25000baseCR_Full))	\
 		(fw_speeds) |= BNXT_LINK_SPEED_MSK_25GB;		\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  40000baseCR4_Full))	\
+	if (ethtool_ks_test(lk_ksettings, name, 40000baseCR4_Full))	\
 		(fw_speeds) |= BNXT_LINK_SPEED_MSK_40GB;		\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  50000baseCR2_Full))	\
+	if (ethtool_ks_test(lk_ksettings, name, 50000baseCR2_Full))	\
 		(fw_speeds) |= BNXT_LINK_SPEED_MSK_50GB;		\
 }
 
@@ -922,13 +905,11 @@ static void bnxt_fw_to_ethtool_support_spds(struct bnxt_link_info *link_info,
 
 	BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, 0, lk_ksettings, supported);
 
-	ethtool_link_ksettings_add_link_mode(lk_ksettings, supported, Pause);
-	ethtool_link_ksettings_add_link_mode(lk_ksettings, supported,
-					     Asym_Pause);
+	ethtool_ks_add_mode(lk_ksettings, supported, Pause);
+	ethtool_ks_add_mode(lk_ksettings, supported, Asym_Pause);
 
 	if (link_info->support_auto_speeds)
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, supported,
-						     Autoneg);
+		ethtool_ks_add_mode(lk_ksettings, supported, Autoneg);
 }
 
 u32 bnxt_fw_to_ethtool_speed(u16 fw_link_speed)
@@ -963,14 +944,13 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 	struct ethtool_link_settings *base = &lk_ksettings->base;
 	u32 ethtool_speed;
 
-	ethtool_link_ksettings_zero_link_mode(lk_ksettings, supported);
+	ethtool_ks_clear(lk_ksettings, supported);
 	bnxt_fw_to_ethtool_support_spds(link_info, lk_ksettings);
 
-	ethtool_link_ksettings_zero_link_mode(lk_ksettings, advertising);
+	ethtool_ks_clear(lk_ksettings, advertising);
 	if (link_info->autoneg) {
 		bnxt_fw_to_ethtool_advertised_spds(link_info, lk_ksettings);
-		ethtool_link_ksettings_add_link_mode(lk_ksettings,
-						     advertising, Autoneg);
+		ethtool_ks_add_mode(lk_ksettings, advertising, Autoneg);
 		base->autoneg = AUTONEG_ENABLE;
 		if (link_info->phy_link_status == BNXT_LINK_LINK)
 			bnxt_fw_to_ethtool_lp_adv(link_info, lk_ksettings);
@@ -994,15 +974,11 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 	base->port = PORT_NONE;
 	if (link_info->media_type == PORT_PHY_QCFG_RESP_MEDIA_TYPE_TP) {
 		base->port = PORT_TP;
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, supported,
-						     TP);
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, advertising,
-						     TP);
+		ethtool_ks_add_mode(lk_ksettings, supported, TP);
+		ethtool_ks_add_mode(lk_ksettings, advertising, TP);
 	} else {
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, supported,
-						     FIBRE);
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, advertising,
-						     FIBRE);
+		ethtool_ks_add_mode(lk_ksettings, supported, FIBRE);
+		ethtool_ks_add_mode(lk_ksettings, advertising, FIBRE);
 
 		if (link_info->media_type == PORT_PHY_QCFG_RESP_MEDIA_TYPE_DAC)
 			base->port = PORT_DA;
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 185e9e0..27fc248 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -12110,8 +12110,7 @@ static int tg3_get_link_ksettings(struct net_device *dev,
 		supported |= SUPPORTED_FIBRE;
 		cmd->base.port = PORT_FIBRE;
 	}
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
 
 	advertising = tp->link_config.advertising;
 	if (tg3_flag(tp, PAUSE_AUTONEG)) {
@@ -12126,15 +12125,13 @@ static int tg3_get_link_ksettings(struct net_device *dev,
 			advertising |= ADVERTISED_Asym_Pause;
 		}
 	}
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	if (netif_running(dev) && tp->link_up) {
 		cmd->base.speed = tp->link_config.active_speed;
 		cmd->base.duplex = tp->link_config.active_duplex;
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.lp_advertising,
-			tp->link_config.rmt_adv);
+		ethtool_u32_to_ks(cmd->link_modes.lp_advertising,
+				  tp->link_config.rmt_adv);
 
 		if (!(tp->phy_flags & TG3_PHYFLG_ANY_SERDES)) {
 			if (tp->phy_flags & TG3_PHYFLG_MDIX_STATE)
@@ -12176,8 +12173,7 @@ static int tg3_set_link_ksettings(struct net_device *dev,
 	    cmd->base.duplex != DUPLEX_HALF)
 		return -EINVAL;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
 		u32 mask = ADVERTISED_Autoneg |
diff --git a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
index 2865939..34872a98 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
@@ -261,10 +261,8 @@ bnad_get_link_ksettings(struct net_device *netdev,
 		cmd->base.duplex = DUPLEX_UNKNOWN;
 	}
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
index ce7de6f..725af98 100644
--- a/drivers/net/ethernet/calxeda/xgmac.c
+++ b/drivers/net/ethernet/calxeda/xgmac.c
@@ -1536,8 +1536,8 @@ static int xgmac_ethtool_get_link_ksettings(struct net_device *dev,
 	cmd->base.autoneg = 0;
 	cmd->base.duplex = DUPLEX_FULL;
 	cmd->base.speed = 10000;
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported, 0);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising, 0);
+	ethtool_u32_to_ks(cmd->link_modes.supported, 0);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, 0);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
index b00c300..94eb1d2 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
@@ -224,10 +224,8 @@ static int lio_get_link_ksettings(struct net_device *netdev,
 		supported = (SUPPORTED_10000baseT_Full | SUPPORTED_FIBRE |
 			     SUPPORTED_Pause);
 		advertising = (ADVERTISED_10000baseT_Full | ADVERTISED_Pause);
-		ethtool_convert_legacy_u32_to_link_mode(
-			ecmd->link_modes.supported, supported);
-		ethtool_convert_legacy_u32_to_link_mode(
-			ecmd->link_modes.advertising, advertising);
+		ethtool_u32_to_ks(ecmd->link_modes.supported, supported);
+		ethtool_u32_to_ks(ecmd->link_modes.advertising, advertising);
 		ecmd->base.autoneg = AUTONEG_DISABLE;
 
 	} else {
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
index 2e74bba..4ca6516 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
@@ -171,10 +171,8 @@ static int nicvf_get_link_ksettings(struct net_device *netdev,
 	cmd->base.duplex = nic->duplex;
 	cmd->base.speed = nic->speed;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/chelsio/cxgb/cxgb2.c b/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
index 3a05f90..3ebde7c 100644
--- a/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
+++ b/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
@@ -590,10 +590,8 @@ static int get_link_ksettings(struct net_device *dev,
 	cmd->base.phy_address = p->phy->mdio.prtad;
 	cmd->base.autoneg = p->link_config.autoneg;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -641,8 +639,7 @@ static int set_link_ksettings(struct net_device *dev,
 	struct link_config *lc = &p->link_config;
 	u32 advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising,	cmd->link_modes.advertising);
 
 	if (!(lc->supported & SUPPORTED_Autoneg))
 		return -EOPNOTSUPP;             /* can't change speed/duplex */
diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index 7b2224a..5bdadab 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -1807,10 +1807,9 @@ static int get_link_ksettings(struct net_device *dev,
 	struct port_info *p = netdev_priv(dev);
 	u32 supported;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						p->link_config.supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						p->link_config.advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, p->link_config.supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising,
+			  p->link_config.advertising);
 
 	if (netif_carrier_ok(dev)) {
 		cmd->base.speed = p->link_config.speed;
@@ -1820,8 +1819,7 @@ static int get_link_ksettings(struct net_device *dev,
 		cmd->base.duplex = DUPLEX_UNKNOWN;
 	}
 
-	ethtool_convert_link_mode_to_legacy_u32(&supported,
-						cmd->link_modes.supported);
+	ethtool_ks_to_u32(&supported, cmd->link_modes.supported);
 
 	cmd->base.port = (supported & SUPPORTED_TP) ? PORT_TP : PORT_FIBRE;
 	cmd->base.phy_address = p->phy.mdio.prtad;
@@ -1871,8 +1869,7 @@ static int set_link_ksettings(struct net_device *dev,
 	struct link_config *lc = &p->link_config;
 	u32 advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	if (!(lc->supported & SUPPORTED_Autoneg)) {
 		/*
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 02f80fe..6b7df8a 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -677,9 +677,9 @@ static int get_link_ksettings(struct net_device *dev,
 	const struct port_info *pi = netdev_priv(dev);
 	struct ethtool_link_settings *base = &link_ksettings->base;
 
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, supported);
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, advertising);
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, lp_advertising);
+	ethtool_ks_clear(link_ksettings, supported);
+	ethtool_ks_clear(link_ksettings, advertising);
+	ethtool_ks_clear(link_ksettings, lp_advertising);
 
 	base->port = from_fw_port_mod_type(pi->port_type, pi->mod_type);
 
@@ -710,11 +710,9 @@ static int get_link_ksettings(struct net_device *dev,
 
 	base->autoneg = pi->link_cfg.autoneg;
 	if (pi->link_cfg.supported & FW_PORT_CAP_ANEG)
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, Autoneg);
+		ethtool_ks_add_mode(link_ksettings, supported, Autoneg);
 	if (pi->link_cfg.autoneg)
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising, Autoneg);
+		ethtool_ks_add_mode(link_ksettings, advertising, Autoneg);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index 0d1a134..1e35e28 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -1332,9 +1332,9 @@ static int cxgb4vf_get_link_ksettings(struct net_device *dev,
 	const struct port_info *pi = netdev_priv(dev);
 	struct ethtool_link_settings *base = &link_ksettings->base;
 
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, supported);
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, advertising);
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, lp_advertising);
+	ethtool_ks_clear(link_ksettings, supported);
+	ethtool_ks_clear(link_ksettings, advertising);
+	ethtool_ks_clear(link_ksettings, lp_advertising);
 
 	base->port = from_fw_port_mod_type(pi->port_type, pi->mod_type);
 
@@ -1365,11 +1365,9 @@ static int cxgb4vf_get_link_ksettings(struct net_device *dev,
 
 	base->autoneg = pi->link_cfg.autoneg;
 	if (pi->link_cfg.supported & FW_PORT_CAP_ANEG)
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, Autoneg);
+		ethtool_ks_add_mode(link_ksettings, supported, Autoneg);
 	if (pi->link_cfg.autoneg)
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising, Autoneg);
+		ethtool_ks_add_mode(link_ksettings, advertising, Autoneg);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index fd3980c..509b73f 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -109,12 +109,10 @@ static int enic_get_ksettings(struct net_device *netdev,
 	struct enic *enic = netdev_priv(netdev);
 	struct ethtool_link_settings *base = &ecmd->base;
 
-	ethtool_link_ksettings_add_link_mode(ecmd, supported,
-					     10000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(ecmd, supported, FIBRE);
-	ethtool_link_ksettings_add_link_mode(ecmd, advertising,
-					     10000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(ecmd, advertising, FIBRE);
+	ethtool_ks_add_mode(ecmd, supported, 10000baseT_Full);
+	ethtool_ks_add_mode(ecmd, supported, FIBRE);
+	ethtool_ks_add_mode(ecmd, advertising, 10000baseT_Full);
+	ethtool_ks_add_mode(ecmd, advertising, FIBRE);
 	base->port = PORT_FIBRE;
 
 	if (netif_carrier_ok(netdev)) {
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index 3ac2183..cb3dbc6 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -139,10 +139,8 @@ static int hns_nic_get_link_ksettings(struct net_device *net_dev,
 		return -EINVAL;
 	}
 
-	ethtool_convert_link_mode_to_legacy_u32(&supported,
-						cmd->link_modes.supported);
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&supported, cmd->link_modes.supported);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	/* When there is no phy, autoneg is off. */
 	cmd->base.autoneg = false;
@@ -185,10 +183,8 @@ static int hns_nic_get_link_ksettings(struct net_device *net_dev,
 	if (!(AE_IS_VER1(priv->enet_ver) && h->port_type == HNAE_PORT_DEBUG))
 		supported |= SUPPORTED_Pause;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	cmd->base.mdio_support = ETH_MDIO_SUPPORTS_C45 | ETH_MDIO_SUPPORTS_C22;
 	hns_get_mdix_mode(net_dev, cmd);
diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 1fa7c03..ea8d5f0 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -1511,16 +1511,12 @@ mv643xx_eth_get_link_ksettings_phy(struct mv643xx_eth_private *mp,
 	/*
 	 * The MAC does not support 1000baseT_Half.
 	 */
-	ethtool_convert_link_mode_to_legacy_u32(&supported,
-						cmd->link_modes.supported);
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&supported, cmd->link_modes.supported);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 	supported &= ~SUPPORTED_1000baseT_Half;
 	advertising &= ~ADVERTISED_1000baseT_Half;
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return err;
 }
@@ -1556,10 +1552,8 @@ mv643xx_eth_get_link_ksettings_phyless(struct mv643xx_eth_private *mp,
 	cmd->base.phy_address = 0;
 	cmd->base.autoneg = AUTONEG_DISABLE;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -1616,11 +1610,9 @@ mv643xx_eth_set_link_ksettings(struct net_device *dev,
 	/*
 	 * The MAC does not support 1000baseT_Half.
 	 */
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						c.link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, c.link_modes.advertising);
 	advertising &= ~ADVERTISED_1000baseT_Half;
-	ethtool_convert_legacy_u32_to_link_mode(c.link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(c.link_modes.advertising, advertising);
 
 	ret = phy_ethtool_ksettings_set(dev->phydev, &c);
 	if (!ret)
diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index 3af2814..cf72108 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -994,8 +994,7 @@ static int pxa168_init_phy(struct net_device *dev)
 	cmd.base.phy_address = pep->phy_addr;
 	cmd.base.speed = pep->phy_speed;
 	cmd.base.duplex = pep->phy_duplex;
-	ethtool_convert_legacy_u32_to_link_mode(cmd.link_modes.advertising,
-						PHY_BASIC_FEATURES);
+	ethtool_u32_to_ks(cmd.link_modes.advertising, PHY_BASIC_FEATURES);
 	cmd.base.autoneg = AUTONEG_ENABLE;
 
 	if (cmd.base.speed != 0)
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index d9c9f86..c248cab 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -755,8 +755,8 @@ ethtool_get_ptys_link_ksettings(struct net_device *dev,
 	       be32_to_cpu(ptys_reg.eth_proto_lp_adv));
 
 	/* reset supported/advertising masks */
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, supported);
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, advertising);
+	ethtool_ks_clear(link_ksettings, supported);
+	ethtool_ks_clear(link_ksettings, advertising);
 
 	ptys2ethtool_update_supported_port(link_ksettings->link_modes.supported,
 					   &ptys_reg);
@@ -769,25 +769,19 @@ ethtool_get_ptys_link_ksettings(struct net_device *dev,
 	ptys2ethtool_update_link_modes(link_ksettings->link_modes.advertising,
 				       eth_proto, ADVERTISED);
 
-	ethtool_link_ksettings_add_link_mode(link_ksettings, supported,
-					     Pause);
-	ethtool_link_ksettings_add_link_mode(link_ksettings, supported,
-					     Asym_Pause);
+	ethtool_ks_add_mode(link_ksettings, supported, Pause);
+	ethtool_ks_add_mode(link_ksettings, supported, Asym_Pause);
 
 	if (priv->prof->tx_pause)
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising, Pause);
+		ethtool_ks_add_mode(link_ksettings, advertising, Pause);
 	if (priv->prof->tx_pause ^ priv->prof->rx_pause)
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising, Asym_Pause);
+		ethtool_ks_add_mode(link_ksettings, advertising, Asym_Pause);
 
 	link_ksettings->base.port = ptys_get_active_port(&ptys_reg);
 
 	if (mlx4_en_autoneg_get(dev)) {
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, Autoneg);
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising, Autoneg);
+		ethtool_ks_add_mode(link_ksettings, supported, Autoneg);
+		ethtool_ks_add_mode(link_ksettings, advertising, Autoneg);
 	}
 
 	link_ksettings->base.autoneg
@@ -796,13 +790,12 @@ ethtool_get_ptys_link_ksettings(struct net_device *dev,
 
 	eth_proto = be32_to_cpu(ptys_reg.eth_proto_lp_adv);
 
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, lp_advertising);
+	ethtool_ks_clear(link_ksettings, lp_advertising);
 	ptys2ethtool_update_link_modes(
 		link_ksettings->link_modes.lp_advertising,
 		eth_proto, ADVERTISED);
 	if (priv->port_state.flags & MLX4_EN_PORT_ANC)
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     lp_advertising, Autoneg);
+		ethtool_ks_add_mode(link_ksettings, lp_advertising, Autoneg);
 
 	link_ksettings->base.phy_address = 0;
 	link_ksettings->base.mdio_support = 0;
@@ -821,27 +814,21 @@ ethtool_get_default_link_ksettings(
 
 	link_ksettings->base.autoneg = AUTONEG_DISABLE;
 
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, supported);
-	ethtool_link_ksettings_add_link_mode(link_ksettings, supported,
-					     10000baseT_Full);
+	ethtool_ks_clear(link_ksettings, supported);
+	ethtool_ks_add_mode(link_ksettings, supported, 10000baseT_Full);
 
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, advertising);
-	ethtool_link_ksettings_add_link_mode(link_ksettings, advertising,
-					     10000baseT_Full);
+	ethtool_ks_clear(link_ksettings, advertising);
+	ethtool_ks_add_mode(link_ksettings, advertising, 10000baseT_Full);
 
 	trans_type = priv->port_state.transceiver;
 	if (trans_type > 0 && trans_type <= 0xC) {
 		link_ksettings->base.port = PORT_FIBRE;
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, FIBRE);
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising, FIBRE);
+		ethtool_ks_add_mode(link_ksettings, supported, FIBRE);
+		ethtool_ks_add_mode(link_ksettings, advertising, FIBRE);
 	} else if (trans_type == 0x80 || trans_type == 0) {
 		link_ksettings->base.port = PORT_TP;
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, TP);
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising, TP);
+		ethtool_ks_add_mode(link_ksettings, supported, TP);
+		ethtool_ks_add_mode(link_ksettings, advertising, TP);
 	} else  {
 		link_ksettings->base.port = -1;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 352462a..da758a5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -722,7 +722,7 @@ static void ptys2ethtool_supported_port(struct ethtool_link_ksettings *link_kset
 			   | MLX5E_PROT_MASK(MLX5E_40GBASE_SR4)
 			   | MLX5E_PROT_MASK(MLX5E_100GBASE_SR4)
 			   | MLX5E_PROT_MASK(MLX5E_1000BASE_CX_SGMII))) {
-		ethtool_link_ksettings_add_link_mode(link_ksettings, supported, FIBRE);
+		ethtool_ks_add_mode(link_ksettings, supported, FIBRE);
 	}
 
 	if (eth_proto_cap & (MLX5E_PROT_MASK(MLX5E_100GBASE_KR4)
@@ -730,7 +730,7 @@ static void ptys2ethtool_supported_port(struct ethtool_link_ksettings *link_kset
 			   | MLX5E_PROT_MASK(MLX5E_10GBASE_KR)
 			   | MLX5E_PROT_MASK(MLX5E_10GBASE_KX4)
 			   | MLX5E_PROT_MASK(MLX5E_1000BASE_KX))) {
-		ethtool_link_ksettings_add_link_mode(link_ksettings, supported, Backplane);
+		ethtool_ks_add_mode(link_ksettings, supported, Backplane);
 	}
 }
 
@@ -783,8 +783,8 @@ static void get_supported(u32 eth_proto_cap,
 
 	ptys2ethtool_supported_port(link_ksettings, eth_proto_cap);
 	ptys2ethtool_supported_link(supported, eth_proto_cap);
-	ethtool_link_ksettings_add_link_mode(link_ksettings, supported, Pause);
-	ethtool_link_ksettings_add_link_mode(link_ksettings, supported, Asym_Pause);
+	ethtool_ks_add_mode(link_ksettings, supported, Pause);
+	ethtool_ks_add_mode(link_ksettings, supported, Asym_Pause);
 }
 
 static void get_advertising(u32 eth_proto_cap, u8 tx_pause,
@@ -795,9 +795,9 @@ static void get_advertising(u32 eth_proto_cap, u8 tx_pause,
 
 	ptys2ethtool_adver_link(advertising, eth_proto_cap);
 	if (tx_pause)
-		ethtool_link_ksettings_add_link_mode(link_ksettings, advertising, Pause);
+		ethtool_ks_add_mode(link_ksettings, advertising, Pause);
 	if (tx_pause ^ rx_pause)
-		ethtool_link_ksettings_add_link_mode(link_ksettings, advertising, Asym_Pause);
+		ethtool_ks_add_mode(link_ksettings, advertising, Asym_Pause);
 }
 
 static u8 get_connector_port(u32 eth_proto)
@@ -861,8 +861,8 @@ static int mlx5e_get_link_ksettings(struct net_device *netdev,
 	an_disable_admin = MLX5_GET(ptys_reg, out, an_disable_admin);
 	an_status        = MLX5_GET(ptys_reg, out, an_status);
 
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, supported);
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, advertising);
+	ethtool_ks_clear(link_ksettings, supported);
+	ethtool_ks_clear(link_ksettings, advertising);
 
 	get_supported(eth_proto_cap, link_ksettings);
 	get_advertising(eth_proto_admin, 0, 0, link_ksettings);
@@ -874,16 +874,13 @@ static int mlx5e_get_link_ksettings(struct net_device *netdev,
 	get_lp_advertising(eth_proto_lp, link_ksettings);
 
 	if (an_status == MLX5_AN_COMPLETE)
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     lp_advertising, Autoneg);
+		ethtool_ks_add_mode(link_ksettings, lp_advertising, Autoneg);
 
 	link_ksettings->base.autoneg = an_disable_admin ? AUTONEG_DISABLE :
 							  AUTONEG_ENABLE;
-	ethtool_link_ksettings_add_link_mode(link_ksettings, supported,
-					     Autoneg);
+	ethtool_ks_add_mode(link_ksettings, supported, Autoneg);
 	if (!an_disable_admin)
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising, Autoneg);
+		ethtool_ks_add_mode(link_ksettings, advertising, Autoneg);
 
 err_query_ptys:
 	return err;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index d768c7b..a529dee 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1857,14 +1857,14 @@ mlxsw_sp_from_ptys_supported_port(u32 ptys_eth_proto,
 			      MLXSW_REG_PTYS_ETH_SPEED_40GBASE_SR4 |
 			      MLXSW_REG_PTYS_ETH_SPEED_100GBASE_SR4 |
 			      MLXSW_REG_PTYS_ETH_SPEED_SGMII))
-		ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
+		ethtool_ks_add_mode(cmd, supported, FIBRE);
 
 	if (ptys_eth_proto & (MLXSW_REG_PTYS_ETH_SPEED_10GBASE_KR |
 			      MLXSW_REG_PTYS_ETH_SPEED_10GBASE_KX4 |
 			      MLXSW_REG_PTYS_ETH_SPEED_40GBASE_KR4 |
 			      MLXSW_REG_PTYS_ETH_SPEED_100GBASE_KR4 |
 			      MLXSW_REG_PTYS_ETH_SPEED_1000BASE_KX))
-		ethtool_link_ksettings_add_link_mode(cmd, supported, Backplane);
+		ethtool_ks_add_mode(cmd, supported, Backplane);
 }
 
 static void mlxsw_sp_from_ptys_link(u32 ptys_eth_proto, unsigned long *mode)
@@ -1963,9 +1963,9 @@ static u32 mlxsw_sp_to_ptys_upper_speed(u32 upper_speed)
 static void mlxsw_sp_port_get_link_supported(u32 eth_proto_cap,
 					     struct ethtool_link_ksettings *cmd)
 {
-	ethtool_link_ksettings_add_link_mode(cmd, supported, Asym_Pause);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, Autoneg);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, Pause);
+	ethtool_ks_add_mode(cmd, supported, Asym_Pause);
+	ethtool_ks_add_mode(cmd, supported, Autoneg);
+	ethtool_ks_add_mode(cmd, supported, Pause);
 
 	mlxsw_sp_from_ptys_supported_port(eth_proto_cap, cmd);
 	mlxsw_sp_from_ptys_link(eth_proto_cap, cmd->link_modes.supported);
@@ -1977,7 +1977,7 @@ static void mlxsw_sp_port_get_link_advertise(u32 eth_proto_admin, bool autoneg,
 	if (!autoneg)
 		return;
 
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, Autoneg);
+	ethtool_ks_add_mode(cmd, advertising, Autoneg);
 	mlxsw_sp_from_ptys_link(eth_proto_admin, cmd->link_modes.advertising);
 }
 
@@ -1988,7 +1988,7 @@ mlxsw_sp_port_get_link_lp_advertise(u32 eth_proto_lp, u8 autoneg_status,
 	if (autoneg_status != MLXSW_REG_PTYS_AN_STATUS_OK || !eth_proto_lp)
 		return;
 
-	ethtool_link_ksettings_add_link_mode(cmd, lp_advertising, Autoneg);
+	ethtool_ks_add_mode(cmd, lp_advertising, Autoneg);
 	mlxsw_sp_from_ptys_link(eth_proto_lp, cmd->link_modes.lp_advertising);
 }
 
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 1c48f44..8a9c27e 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -396,13 +396,13 @@ static int qede_get_link_ksettings(struct net_device *dev,
 	memset(&current_link, 0, sizeof(current_link));
 	edev->ops->common->get_link(edev->cdev, &current_link);
 
-	ethtool_link_ksettings_zero_link_mode(cmd, supported);
+	ethtool_ks_clear(cmd, supported);
 	QEDE_DRV_TO_ETHTOOL_CAPS(current_link.supported_caps, cmd, supported)
 
-	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
+	ethtool_ks_clear(cmd, advertising);
 	QEDE_DRV_TO_ETHTOOL_CAPS(current_link.advertised_caps, cmd, advertising)
 
-	ethtool_link_ksettings_zero_link_mode(cmd, lp_advertising);
+	ethtool_ks_clear(cmd, lp_advertising);
 	QEDE_DRV_TO_ETHTOOL_CAPS(current_link.lp_caps, cmd, lp_advertising)
 
 	if ((edev->state == QEDE_STATE_OPEN) && (current_link.link_up)) {
diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index 87bdc56..d7305d4 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -133,13 +133,11 @@ efx_ethtool_get_link_ksettings(struct net_device *net_dev,
 	mutex_unlock(&efx->mac_lock);
 
 	/* Both MACs support pause frames (bidirectional and respond-only) */
-	ethtool_convert_link_mode_to_legacy_u32(&supported,
-						cmd->link_modes.supported);
+	ethtool_ks_to_u32(&supported, cmd->link_modes.supported);
 
 	supported |= SUPPORTED_Pause | SUPPORTED_Asym_Pause;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
 
 	if (LOOPBACK_INTERNAL(efx)) {
 		cmd->base.speed = link_state->speed;
diff --git a/drivers/net/ethernet/sfc/mcdi_port.c b/drivers/net/ethernet/sfc/mcdi_port.c
index c905971..f71fa8b 100644
--- a/drivers/net/ethernet/sfc/mcdi_port.c
+++ b/drivers/net/ethernet/sfc/mcdi_port.c
@@ -521,10 +521,8 @@ static void efx_mcdi_phy_get_link_ksettings(struct efx_nic *efx,
 	cmd->base.mdio_support = (efx->mdio.mode_support &
 			      (MDIO_SUPPORTS_C45 | MDIO_SUPPORTS_C22));
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	BUILD_BUG_ON(MC_CMD_GET_LINK_IN_LEN != 0);
 	rc = efx_mcdi_rpc(efx, MC_CMD_GET_LINK, NULL, 0,
@@ -535,8 +533,7 @@ static void efx_mcdi_phy_get_link_ksettings(struct efx_nic *efx,
 		mcdi_to_ethtool_cap(phy_cfg->media,
 				    MCDI_DWORD(outbuf, GET_LINK_OUT_LP_CAP));
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.lp_advertising,
-						lp_advertising);
+	ethtool_u32_to_ks(cmd->link_modes.lp_advertising, lp_advertising);
 }
 
 static int
@@ -548,8 +545,7 @@ efx_mcdi_phy_set_link_ksettings(struct efx_nic *efx,
 	int rc;
 	u32 advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising,	cmd->link_modes.advertising);
 
 	if (cmd->base.autoneg) {
 		caps = (ethtool_to_mcdi_cap(advertising) |
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 699ee1d..fab5a1e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -301,12 +301,10 @@ static int stmmac_ethtool_get_link_ksettings(struct net_device *dev,
 
 		/* Encoding of PSE bits is defined in 802.3z, 37.2.1.4 */
 
-		ethtool_convert_link_mode_to_legacy_u32(
-			&supported, cmd->link_modes.supported);
-		ethtool_convert_link_mode_to_legacy_u32(
-			&advertising, cmd->link_modes.advertising);
-		ethtool_convert_link_mode_to_legacy_u32(
-			&lp_advertising, cmd->link_modes.lp_advertising);
+		ethtool_ks_to_u32(&supported, cmd->link_modes.supported);
+		ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
+		ethtool_ks_to_u32(&lp_advertising,
+				  cmd->link_modes.lp_advertising);
 
 		if (adv.pause & STMMAC_PCS_PAUSE)
 			advertising |= ADVERTISED_Pause;
@@ -348,12 +346,10 @@ static int stmmac_ethtool_get_link_ksettings(struct net_device *dev,
 					   ADVERTISED_10baseT_Half);
 		cmd->base.port = PORT_OTHER;
 
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.supported, supported);
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.advertising, advertising);
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.lp_advertising, lp_advertising);
+		ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+		ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
+		ethtool_u32_to_ks(cmd->link_modes.lp_advertising,
+				  lp_advertising);
 
 		return 0;
 	}
diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index c7e547e..b3fd7dc 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -1944,10 +1944,8 @@ static int keystone_set_link_ksettings(struct net_device *ndev,
 	u32 advertising, supported;
 	u32 features;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
-	ethtool_convert_link_mode_to_legacy_u32(&supported,
-						cmd->link_modes.supported);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&supported, cmd->link_modes.supported);
 	features = advertising & supported;
 
 	if (!phy)
diff --git a/drivers/net/mii.c b/drivers/net/mii.c
index 6d953c5..f36f2ac 100644
--- a/drivers/net/mii.c
+++ b/drivers/net/mii.c
@@ -219,12 +219,9 @@ int mii_ethtool_get_link_ksettings(struct mii_if_info *mii,
 
 	mii->full_duplex = cmd->base.duplex;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.lp_advertising,
-						lp_advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
+	ethtool_u32_to_ks(cmd->link_modes.lp_advertising, lp_advertising);
 
 	/* ignore maxtxpkt, maxrxpkt for now */
 
@@ -359,8 +356,7 @@ int mii_ethtool_set_link_ksettings(struct mii_if_info *mii,
 		u32 advert2 = 0, tmp2 = 0;
 		u32 advertising;
 
-		ethtool_convert_link_mode_to_legacy_u32(
-			&advertising, cmd->link_modes.advertising);
+		ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 		if ((advertising & (ADVERTISED_10baseT_Half |
 				    ADVERTISED_10baseT_Full |
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 25f93a9..5af791a 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -409,8 +409,7 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 	if (cmd->base.phy_address != phydev->mdio.addr)
 		return -EINVAL;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	/* We make sure that we don't pass unsupported values in to the PHY */
 	advertising &= phydev->supported;
@@ -479,14 +478,12 @@ EXPORT_SYMBOL(phy_ethtool_gset);
 int phy_ethtool_ksettings_get(struct phy_device *phydev,
 			      struct ethtool_link_ksettings *cmd)
 {
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						phydev->supported);
+	ethtool_u32_to_ks(cmd->link_modes.supported, phydev->supported);
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						phydev->advertising);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, phydev->advertising);
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.lp_advertising,
-						phydev->lp_advertising);
+	ethtool_u32_to_ks(cmd->link_modes.lp_advertising,
+			  phydev->lp_advertising);
 
 	cmd->base.speed = phydev->speed;
 	cmd->base.duplex = phydev->duplex;
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 08f8703..b8015e4 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1567,15 +1567,13 @@ static int lan78xx_set_pause(struct net_device *net,
 		u32 mii_adv;
 		u32 advertising;
 
-		ethtool_convert_link_mode_to_legacy_u32(
-			&advertising, ecmd.link_modes.advertising);
+		ethtool_ks_to_u32(&advertising, ecmd.link_modes.advertising);
 
 		advertising &= ~(ADVERTISED_Pause | ADVERTISED_Asym_Pause);
 		mii_adv = (u32)mii_advertise_flowctrl(dev->fc_request_control);
 		advertising |= mii_adv_to_ethtool_adv_t(mii_adv);
 
-		ethtool_convert_legacy_u32_to_link_mode(
-			ecmd.link_modes.advertising, advertising);
+		ethtool_u32_to_ks(ecmd.link_modes.advertising, advertising);
 
 		phy_ethtool_ksettings_set(phydev, &ecmd);
 	}
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 9ded8c6..90bb86b 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -116,26 +116,25 @@ struct ethtool_link_ksettings {
 };
 
 /**
- * ethtool_link_ksettings_zero_link_mode - clear link_ksettings link mode mask
+ * ethtool_ks_clear - clear link_ksettings link mode mask
  *   @ptr : pointer to struct ethtool_link_ksettings
  *   @name : one of supported/advertising/lp_advertising
  */
-#define ethtool_link_ksettings_zero_link_mode(ptr, name)		\
+#define ethtool_ks_clear(ptr, name)		\
 	bitmap_zero((ptr)->link_modes.name, __ETHTOOL_LINK_MODE_MASK_NBITS)
 
 /**
- * ethtool_link_ksettings_add_link_mode - set bit in link_ksettings
+ * ethtool_ks_add_mode - set bit in link_ksettings
  * link mode mask
  *   @ptr : pointer to struct ethtool_link_ksettings
  *   @name : one of supported/advertising/lp_advertising
  *   @mode : one of the ETHTOOL_LINK_MODE_*_BIT
  * (not atomic, no bound checking)
  */
-#define ethtool_link_ksettings_add_link_mode(ptr, name, mode)		\
+#define ethtool_ks_add_mode(ptr, name, mode)		\
 	__set_bit(ETHTOOL_LINK_MODE_ ## mode ## _BIT, (ptr)->link_modes.name)
-
 /**
- * ethtool_link_ksettings_test_link_mode - test bit in ksettings link mode mask
+ * ethtool_ks_test - test bit in ksettings link mode mask
  *   @ptr : pointer to struct ethtool_link_ksettings
  *   @name : one of supported/advertising/lp_advertising
  *   @mode : one of the ETHTOOL_LINK_MODE_*_BIT
@@ -143,19 +142,15 @@ struct ethtool_link_ksettings {
  *
  * Returns true/false.
  */
-#define ethtool_link_ksettings_test_link_mode(ptr, name, mode)		\
+#define ethtool_ks_test(ptr, name, mode)		\
 	test_bit(ETHTOOL_LINK_MODE_ ## mode ## _BIT, (ptr)->link_modes.name)
-
 extern int
 __ethtool_get_link_ksettings(struct net_device *dev,
 			     struct ethtool_link_ksettings *link_ksettings);
-
-void ethtool_convert_legacy_u32_to_link_mode(unsigned long *dst,
-					     u32 legacy_u32);
+void ethtool_u32_to_ks(unsigned long *dst, u32 legacy_u32);
 
 /* return false if src had higher bits set. lower bits always updated. */
-bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
-				     const unsigned long *src);
+bool ethtool_ks_to_u32(u32 *legacy_u32, const unsigned long *src);
 
 /**
  * struct ethtool_ops - optional netdev operations
diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index e23766c..0924a0c 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -403,17 +403,15 @@ static int __ethtool_set_flags(struct net_device *dev, u32 data)
 	return 0;
 }
 
-void ethtool_convert_legacy_u32_to_link_mode(unsigned long *dst,
-					     u32 legacy_u32)
+void ethtool_u32_to_ks(unsigned long *dst, u32 legacy_u32)
 {
 	bitmap_zero(dst, __ETHTOOL_LINK_MODE_MASK_NBITS);
 	dst[0] = legacy_u32;
 }
-EXPORT_SYMBOL(ethtool_convert_legacy_u32_to_link_mode);
+EXPORT_SYMBOL(ethtool_u32_to_ks);
 
 /* return false if src had higher bits set. lower bits always updated. */
-bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
-					     const unsigned long *src)
+bool ethtool_ks_to_u32(u32 *legacy_u32, const unsigned long *src)
 {
 	bool retval = true;
 
@@ -433,7 +431,7 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
 	*legacy_u32 = src[0];
 	return retval;
 }
-EXPORT_SYMBOL(ethtool_convert_link_mode_to_legacy_u32);
+EXPORT_SYMBOL(ethtool_ks_to_u32);
 
 /* return false if legacy contained non-0 deprecated fields
  * transceiver/maxtxpkt/maxrxpkt. rest of ksettings always updated
@@ -456,15 +454,12 @@ convert_legacy_settings_to_link_ksettings(
 	    legacy_settings->maxrxpkt)
 		retval = false;
 
-	ethtool_convert_legacy_u32_to_link_mode(
-		link_ksettings->link_modes.supported,
-		legacy_settings->supported);
-	ethtool_convert_legacy_u32_to_link_mode(
-		link_ksettings->link_modes.advertising,
-		legacy_settings->advertising);
-	ethtool_convert_legacy_u32_to_link_mode(
-		link_ksettings->link_modes.lp_advertising,
-		legacy_settings->lp_advertising);
+	ethtool_u32_to_ks(link_ksettings->link_modes.supported,
+			  legacy_settings->supported);
+	ethtool_u32_to_ks(link_ksettings->link_modes.advertising,
+			  legacy_settings->advertising);
+	ethtool_u32_to_ks(link_ksettings->link_modes.lp_advertising,
+			  legacy_settings->lp_advertising);
 	link_ksettings->base.speed
 		= ethtool_cmd_speed(legacy_settings);
 	link_ksettings->base.duplex
@@ -501,15 +496,12 @@ convert_link_ksettings_to_legacy_settings(
 	 * __u32	maxrxpkt;
 	 */
 
-	retval &= ethtool_convert_link_mode_to_legacy_u32(
-		&legacy_settings->supported,
-		link_ksettings->link_modes.supported);
-	retval &= ethtool_convert_link_mode_to_legacy_u32(
-		&legacy_settings->advertising,
-		link_ksettings->link_modes.advertising);
-	retval &= ethtool_convert_link_mode_to_legacy_u32(
-		&legacy_settings->lp_advertising,
-		link_ksettings->link_modes.lp_advertising);
+	retval &= ethtool_ks_to_u32(&legacy_settings->supported,
+				    link_ksettings->link_modes.supported);
+	retval &= ethtool_ks_to_u32(&legacy_settings->advertising,
+				    link_ksettings->link_modes.advertising);
+	retval &= ethtool_ks_to_u32(&legacy_settings->lp_advertising,
+				    link_ksettings->link_modes.lp_advertising);
 	ethtool_cmd_speed_set(legacy_settings, link_ksettings->base.speed);
 	legacy_settings->duplex
 		= link_ksettings->base.duplex;
-- 
2.9.3


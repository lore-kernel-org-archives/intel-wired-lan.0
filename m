From: Mitch Williams <mitch.a.williams@intel.com>
Date: Tue, 15 May 2018 10:32:08 -0700
Subject: [Intel-wired-lan] [PATCH] ethtool: stop the line wrapping madness
Message-ID: <20180515173208.20352-1-mitch.a.williams@intel.com>
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
setting bits in the 'settings' field twice. Almost certainly this
was supposed to set bits in the 'advertising' field instead. So I fixed
it.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/infiniband/hw/nes/nes_nic.c           |  12 +-
 drivers/net/ethernet/3com/3c509.c             |   3 +-
 drivers/net/ethernet/3com/typhoon.c           |   6 +-
 drivers/net/ethernet/alteon/acenic.c          |   3 +-
 drivers/net/ethernet/amazon/ena/ena_ethtool.c |   6 +-
 drivers/net/ethernet/amd/pcnet32.c            |   5 +-
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c   |   6 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  24 +-
 .../ethernet/apm/xgene/xgene_enet_ethtool.c   |  16 +-
 .../net/ethernet/aquantia/atlantic/aq_nic.c   |  53 +--
 drivers/net/ethernet/atheros/alx/ethtool.c    |   9 +-
 .../ethernet/atheros/atl1c/atl1c_ethtool.c    |   6 +-
 .../ethernet/atheros/atl1e/atl1e_ethtool.c    |   9 +-
 drivers/net/ethernet/atheros/atlx/atl1.c      |   6 +-
 drivers/net/ethernet/atheros/atlx/atl2.c      |   9 +-
 drivers/net/ethernet/broadcom/b44.c           |   9 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c  |   6 +-
 drivers/net/ethernet/broadcom/bnx2.c          |   9 +-
 .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   |  24 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  84 ++--
 drivers/net/ethernet/broadcom/tg3.c           |  14 +-
 .../net/ethernet/brocade/bna/bnad_ethtool.c   |   6 +-
 drivers/net/ethernet/calxeda/xgmac.c          |   4 +-
 .../ethernet/cavium/liquidio/lio_ethtool.c    | 149 +++---
 .../ethernet/cavium/thunder/nicvf_ethtool.c   |   6 +-
 drivers/net/ethernet/chelsio/cxgb/cxgb2.c     |   9 +-
 .../net/ethernet/chelsio/cxgb3/cxgb3_main.c   |  13 +-
 .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    |  25 +-
 .../ethernet/chelsio/cxgb4vf/cxgb4vf_main.c   |  25 +-
 .../net/ethernet/cisco/enic/enic_ethtool.c    |  10 +-
 drivers/net/ethernet/dec/tulip/de2104x.c      |   9 +-
 drivers/net/ethernet/dec/tulip/uli526x.c      |   6 +-
 drivers/net/ethernet/dlink/dl2k.c             |   6 +-
 .../net/ethernet/emulex/benet/be_ethtool.c    |   6 +-
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  |  12 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |   6 +-
 .../net/ethernet/huawei/hinic/hinic_main.c    |   8 +-
 drivers/net/ethernet/ibm/ehea/ehea_ethtool.c  |   6 +-
 drivers/net/ethernet/ibm/emac/core.c          |   9 +-
 drivers/net/ethernet/ibm/ibmveth.c            |   6 +-
 drivers/net/ethernet/ibm/ibmvnic.c            |   6 +-
 .../net/ethernet/intel/e1000/e1000_ethtool.c  |   9 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c   |   9 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 432 +++++++-----------
 .../ethernet/intel/i40evf/i40evf_ethtool.c    |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  42 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c  |   9 +-
 drivers/net/ethernet/intel/igbvf/ethtool.c    |   8 +-
 .../net/ethernet/intel/ixgb/ixgb_ethtool.c    |  12 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  15 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  |   4 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c    |  24 +-
 drivers/net/ethernet/marvell/pxa168_eth.c     |   3 +-
 drivers/net/ethernet/marvell/skge.c           |   9 +-
 drivers/net/ethernet/marvell/sky2.c           |   9 +-
 .../net/ethernet/mellanox/mlx4/en_ethtool.c   |  49 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  73 ++-
 .../mellanox/mlx5/core/ipoib/ethtool.c        |   4 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  14 +-
 .../net/ethernet/mellanox/mlxsw/switchx2.c    |  12 +-
 drivers/net/ethernet/micrel/ks8695net.c       |   9 +-
 drivers/net/ethernet/micrel/ksz884x.c         |  11 +-
 drivers/net/ethernet/microchip/enc28j60.c     |   8 +-
 drivers/net/ethernet/microchip/encx24j600.c   |   3 +-
 .../net/ethernet/myricom/myri10ge/myri10ge.c  |   4 +-
 drivers/net/ethernet/natsemi/natsemi.c        |   9 +-
 drivers/net/ethernet/natsemi/ns83820.c        |   3 +-
 drivers/net/ethernet/neterion/s2io.c          |  12 +-
 .../net/ethernet/neterion/vxge/vxge-ethtool.c |  12 +-
 .../ethernet/netronome/nfp/nfp_net_ethtool.c  |  14 +-
 drivers/net/ethernet/nvidia/forcedeth.c       |   9 +-
 .../oki-semi/pch_gbe/pch_gbe_ethtool.c        |  15 +-
 .../qlogic/netxen/netxen_nic_ethtool.c        |   6 +-
 .../net/ethernet/qlogic/qede/qede_ethtool.c   |   6 +-
 drivers/net/ethernet/qlogic/qla3xxx.c         |   6 +-
 .../ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c   |   9 +-
 .../ethernet/qlogic/qlcnic/qlcnic_ethtool.c   |   6 +-
 .../net/ethernet/qlogic/qlge/qlge_ethtool.c   |   6 +-
 drivers/net/ethernet/qualcomm/qca_debug.c     |   4 +-
 drivers/net/ethernet/realtek/r8169.c          |   9 +-
 drivers/net/ethernet/rocker/rocker_main.c     |   4 +-
 drivers/net/ethernet/sfc/ethtool.c            |   6 +-
 drivers/net/ethernet/sfc/falcon/ethtool.c     |   4 +-
 drivers/net/ethernet/sfc/falcon/mdio_10g.c    |   9 +-
 drivers/net/ethernet/silan/sc92031.c          |   9 +-
 drivers/net/ethernet/smsc/smc911x.c           |   3 +-
 drivers/net/ethernet/smsc/smc91c92_cs.c       |   3 +-
 drivers/net/ethernet/smsc/smc91x.c            |   3 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  20 +-
 drivers/net/ethernet/sun/cassini.c            |   6 +-
 drivers/net/ethernet/sun/niu.c                |   9 +-
 drivers/net/ethernet/sun/sungem.c             |  12 +-
 drivers/net/ethernet/sun/sunhme.c             |   3 +-
 drivers/net/ethernet/tehuti/tehuti.c          |  14 +-
 drivers/net/ethernet/ti/netcp_ethss.c         |   6 +-
 drivers/net/ethernet/toshiba/ps3_gelic_net.c  |   6 +-
 .../net/ethernet/toshiba/spider_net_ethtool.c |  12 +-
 drivers/net/ethernet/via/via-velocity.c       |   6 +-
 drivers/net/fjes/fjes_ethtool.c               |   4 +-
 drivers/net/hyperv/netvsc_drv.c               |   2 +-
 drivers/net/mdio.c                            |   9 +-
 drivers/net/mii.c                             |  12 +-
 drivers/net/ntb_netdev.c                      |   8 +-
 drivers/net/phy/marvell10g.c                  |   2 +-
 drivers/net/phy/phy.c                         |  13 +-
 drivers/net/phy/phylink.c                     |   7 +-
 drivers/net/tun.c                             |   4 +-
 drivers/net/usb/catc.c                        |  12 +-
 drivers/net/usb/lan78xx.c                     |   6 +-
 drivers/net/usb/rtl8150.c                     |   3 +-
 drivers/net/virtio_net.c                      |   2 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c         |  12 +-
 drivers/s390/net/qeth_core_main.c             |  58 +--
 include/linux/ethtool.h                       |  24 +-
 net/core/ethtool.c                            |  40 +-
 115 files changed, 723 insertions(+), 1176 deletions(-)

diff --git a/drivers/infiniband/hw/nes/nes_nic.c b/drivers/infiniband/hw/nes/nes_nic.c
index 007d5e8a0121..e96076851202 100644
--- a/drivers/infiniband/hw/nes/nes_nic.c
+++ b/drivers/infiniband/hw/nes/nes_nic.c
@@ -1502,10 +1502,8 @@ static int nes_netdev_get_link_ksettings(struct net_device *netdev,
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
@@ -1522,10 +1520,8 @@ static int nes_netdev_get_link_ksettings(struct net_device *netdev,
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
index b223769d6a5e..d69bcf9fa7c6 100644
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
 }
diff --git a/drivers/net/ethernet/3com/typhoon.c b/drivers/net/ethernet/3com/typhoon.c
index be823c186517..d5931a1c3b63 100644
--- a/drivers/net/ethernet/3com/typhoon.c
+++ b/drivers/net/ethernet/3com/typhoon.c
@@ -1048,10 +1048,8 @@ typhoon_get_link_ksettings(struct net_device *dev,
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
index 8f71b79b4949..0a4f47e389aa 100644
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
index 060cb18fa659..0a4de911e6cc 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -282,10 +282,8 @@ static int ena_get_link_ksettings(struct net_device *netdev,
 	link_ksettings->base.speed = link->speed;
 
 	if (link->flags & ENA_ADMIN_GET_FEATURE_LINK_DESC_AUTONEG_MASK) {
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, Autoneg);
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, Autoneg);
+		ethtool_ks_add_mode(link_ksettings, supported, Autoneg);
+		ethtool_ks_add_mode(link_ksettings, supported, Autoneg);
 	}
 
 	link_ksettings->base.autoneg =
diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index a561705f232c..73cba92dc589 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -748,9 +748,8 @@ static int pcnet32_get_link_ksettings(struct net_device *dev,
 		}
 		cmd->base.duplex = lp->fdx ? DUPLEX_FULL : DUPLEX_HALF;
 		cmd->base.speed = SPEED_10;
-		ethtool_convert_legacy_u32_to_link_mode(
-						cmd->link_modes.supported,
-						SUPPORTED_TP | SUPPORTED_AUI);
+		ethtool_u32_to_ks(cmd->link_modes.supported,
+				  SUPPORTED_TP | SUPPORTED_AUI);
 	}
 	spin_unlock_irqrestore(&lp->lock, flags);
 	return 0;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index aac884314000..3fac11599bf5 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -960,8 +960,7 @@ static int xgbe_phy_find_phy_device(struct xgbe_prv_data *pdata)
 
 	xgbe_phy_external_phy_quirks(pdata);
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						lks->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, lks->link_modes.advertising);
 	phydev->advertising &= advertising;
 
 	phy_start_aneg(phy_data->phydev);
@@ -1666,8 +1665,7 @@ static int xgbe_phy_an_config(struct xgbe_prv_data *pdata)
 	if (!phy_data->phydev)
 		return 0;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						lks->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, lks->link_modes.advertising);
 
 	phy_data->phydev->autoneg = pdata->phy.autoneg;
 	phy_data->phydev->advertising = phy_data->phydev->supported &
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 95d4b56448c6..85b269e1a137 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -300,40 +300,40 @@
 
 /* Link mode bit operations */
 #define XGBE_ZERO_SUP(_ls)		\
-	ethtool_link_ksettings_zero_link_mode((_ls), supported)
+	ethtool_ks_clear((_ls), supported)
 
 #define XGBE_SET_SUP(_ls, _mode)	\
-	ethtool_link_ksettings_add_link_mode((_ls), supported, _mode)
+	ethtool_ks_add_mode((_ls), supported, _mode)
 
 #define XGBE_CLR_SUP(_ls, _mode)	\
-	ethtool_link_ksettings_del_link_mode((_ls), supported, _mode)
+	ethtool_ks_del_mode((_ls), supported, _mode)
 
 #define XGBE_IS_SUP(_ls, _mode)	\
-	ethtool_link_ksettings_test_link_mode((_ls), supported, _mode)
+	ethtool_ks_test((_ls), supported, _mode)
 
 #define XGBE_ZERO_ADV(_ls)		\
-	ethtool_link_ksettings_zero_link_mode((_ls), advertising)
+	ethtool_ks_clear((_ls), advertising)
 
 #define XGBE_SET_ADV(_ls, _mode)	\
-	ethtool_link_ksettings_add_link_mode((_ls), advertising, _mode)
+	ethtool_ks_add_mode((_ls), advertising, _mode)
 
 #define XGBE_CLR_ADV(_ls, _mode)	\
-	ethtool_link_ksettings_del_link_mode((_ls), advertising, _mode)
+	ethtool_ks_del_mode((_ls), advertising, _mode)
 
 #define XGBE_ADV(_ls, _mode)		\
-	ethtool_link_ksettings_test_link_mode((_ls), advertising, _mode)
+	ethtool_ks_test((_ls), advertising, _mode)
 
 #define XGBE_ZERO_LP_ADV(_ls)		\
-	ethtool_link_ksettings_zero_link_mode((_ls), lp_advertising)
+	ethtool_ks_clear((_ls), lp_advertising)
 
 #define XGBE_SET_LP_ADV(_ls, _mode)	\
-	ethtool_link_ksettings_add_link_mode((_ls), lp_advertising, _mode)
+	ethtool_ks_add_mode((_ls), lp_advertising, _mode)
 
 #define XGBE_CLR_LP_ADV(_ls, _mode)	\
-	ethtool_link_ksettings_del_link_mode((_ls), lp_advertising, _mode)
+	ethtool_ks_del_mode((_ls), lp_advertising, _mode)
 
 #define XGBE_LP_ADV(_ls, _mode)		\
-	ethtool_link_ksettings_test_link_mode((_ls), lp_advertising, _mode)
+	ethtool_ks_test((_ls), lp_advertising, _mode)
 
 #define XGBE_LM_COPY(_dst, _dname, _src, _sname)	\
 	bitmap_copy((_dst)->link_modes._dname,		\
diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c b/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
index 4f50f11718f4..9f71f83c1f1b 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
@@ -146,12 +146,8 @@ static int xgene_get_link_ksettings(struct net_device *ndev,
 
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
@@ -159,12 +155,8 @@ static int xgene_get_link_ksettings(struct net_device *ndev,
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
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 1a1a6380c128..812a473b72f8 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -703,72 +703,61 @@ void aq_nic_get_link_ksettings(struct aq_nic_s *self,
 	cmd->base.duplex = DUPLEX_FULL;
 	cmd->base.autoneg = self->aq_nic_cfg.is_autoneg;
 
-	ethtool_link_ksettings_zero_link_mode(cmd, supported);
+	ethtool_ks_clear(cmd, supported);
 
 	if (self->aq_nic_cfg.aq_hw_caps->link_speed_msk & AQ_NIC_RATE_10G)
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     10000baseT_Full);
+		ethtool_ks_add_mode(cmd, supported, 10000baseT_Full);
 
 	if (self->aq_nic_cfg.aq_hw_caps->link_speed_msk & AQ_NIC_RATE_5G)
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     5000baseT_Full);
+		ethtool_ks_add_mode(cmd, supported, 5000baseT_Full);
 
 	if (self->aq_nic_cfg.aq_hw_caps->link_speed_msk & AQ_NIC_RATE_2GS)
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     2500baseT_Full);
+		ethtool_ks_add_mode(cmd, supported, 2500baseT_Full);
 
 	if (self->aq_nic_cfg.aq_hw_caps->link_speed_msk & AQ_NIC_RATE_1G)
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     1000baseT_Full);
+		ethtool_ks_add_mode(cmd, supported, 1000baseT_Full);
 
 	if (self->aq_nic_cfg.aq_hw_caps->link_speed_msk & AQ_NIC_RATE_100M)
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     100baseT_Full);
+		ethtool_ks_add_mode(cmd, supported, 100baseT_Full);
 
 	if (self->aq_nic_cfg.aq_hw_caps->flow_control)
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
+		ethtool_ks_add_mode(cmd, supported,
 						     Pause);
 
-	ethtool_link_ksettings_add_link_mode(cmd, supported, Autoneg);
+	ethtool_ks_add_mode(cmd, supported, Autoneg);
 
 	if (self->aq_nic_cfg.aq_hw_caps->media_type == AQ_HW_MEDIA_TYPE_FIBRE)
-		ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
+		ethtool_ks_add_mode(cmd, supported, FIBRE);
 	else
-		ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
+		ethtool_ks_add_mode(cmd, supported, TP);
 
-	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
+	ethtool_ks_clear(cmd, advertising);
 
 	if (self->aq_nic_cfg.is_autoneg)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, Autoneg);
+		ethtool_ks_add_mode(cmd, advertising, Autoneg);
 
 	if (self->aq_nic_cfg.link_speed_msk  & AQ_NIC_RATE_10G)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     10000baseT_Full);
+		ethtool_ks_add_mode(cmd, advertising, 10000baseT_Full);
 
 	if (self->aq_nic_cfg.link_speed_msk  & AQ_NIC_RATE_5G)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     5000baseT_Full);
+		ethtool_ks_add_mode(cmd, advertising, 5000baseT_Full);
 
 	if (self->aq_nic_cfg.link_speed_msk  & AQ_NIC_RATE_2GS)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     2500baseT_Full);
+		ethtool_ks_add_mode(cmd, advertising, 2500baseT_Full);
 
 	if (self->aq_nic_cfg.link_speed_msk  & AQ_NIC_RATE_1G)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     1000baseT_Full);
+		ethtool_ks_add_mode(cmd, advertising, 1000baseT_Full);
 
 	if (self->aq_nic_cfg.link_speed_msk  & AQ_NIC_RATE_100M)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     100baseT_Full);
+		ethtool_ks_add_mode(cmd, advertising, 100baseT_Full);
 
 	if (self->aq_nic_cfg.flow_control)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     Pause);
+		ethtool_ks_add_mode(cmd, advertising, Pause);
 
 	if (self->aq_nic_cfg.aq_hw_caps->media_type == AQ_HW_MEDIA_TYPE_FIBRE)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
+		ethtool_ks_add_mode(cmd, advertising, FIBRE);
 	else
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
+		ethtool_ks_add_mode(cmd, advertising, TP);
 }
 
 int aq_nic_set_link_ksettings(struct aq_nic_s *self,
@@ -963,4 +952,4 @@ void aq_nic_shutdown(struct aq_nic_s *self)
 
 err_exit:
 	rtnl_unlock();
-}
\ No newline at end of file
+}
diff --git a/drivers/net/ethernet/atheros/alx/ethtool.c b/drivers/net/ethernet/atheros/alx/ethtool.c
index 2f4eabf652e8..f33950040435 100644
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
index cfe86a20c899..9f67af109fb5 100644
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
index cb489e7e8374..d31c16906661 100644
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
index b81fbf119bce..64429070f57a 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -3262,10 +3262,8 @@ static int atl1_get_link_ksettings(struct net_device *netdev,
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
index db4bcc51023a..132e21f42eb6 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -1770,10 +1770,8 @@ static int atl2_get_link_ksettings(struct net_device *netdev,
 
 	cmd->base.autoneg = AUTONEG_ENABLE;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -1785,8 +1783,7 @@ static int atl2_set_link_ksettings(struct net_device *netdev,
 	struct atl2_hw *hw = &adapter->hw;
 	u32 advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	while (test_and_set_bit(__ATL2_RESETTING, &adapter->flags))
 		msleep(1);
diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index e445ab724827..b8a1bc2f711b 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -1867,10 +1867,8 @@ static int b44_get_link_ksettings(struct net_device *dev,
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
@@ -1903,8 +1901,7 @@ static int b44_set_link_ksettings(struct net_device *dev,
 
 	speed = cmd->base.speed;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	/* We do not support gigabit. */
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 14a59e51db67..88b6250241ff 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1465,10 +1465,8 @@ static int bcm_enet_get_link_ksettings(struct net_device *dev,
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
index 9ffc4a8c5fc7..f1c17e1d6926 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -6955,10 +6955,8 @@ bnx2_get_link_ksettings(struct net_device *dev,
 
 	cmd->base.phy_address = bp->phy_addr;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -6992,8 +6990,7 @@ bnx2_set_link_ksettings(struct net_device *dev,
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
 		autoneg |= AUTONEG_SPEED;
 
-		ethtool_convert_link_mode_to_legacy_u32(
-			&advertising, cmd->link_modes.advertising);
+		ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 		if (cmd->base.port == PORT_TP) {
 			advertising &= ETHTOOL_ALL_COPPER_SPEED;
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index da18aa239acb..b1031acd313a 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -222,10 +222,8 @@ static int bnx2x_get_vf_link_ksettings(struct net_device *dev,
 	struct bnx2x *bp = netdev_priv(dev);
 	u32 supported, advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&supported,
-						cmd->link_modes.supported);
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&supported, cmd->link_modes.supported);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	if (bp->state == BNX2X_STATE_OPEN) {
 		if (test_bit(BNX2X_LINK_REPORT_FD,
@@ -264,8 +262,7 @@ static int bnx2x_get_link_ksettings(struct net_device *dev,
 	u32 media_type;
 	u32 supported, advertising, lp_advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&lp_advertising,
-						cmd->link_modes.lp_advertising);
+	ethtool_ks_to_u32(&lp_advertising, cmd->link_modes.lp_advertising);
 
 	/* Dual Media boards present all available port types */
 	supported = bp->port.supported[cfg_idx] |
@@ -344,12 +341,9 @@ static int bnx2x_get_link_ksettings(struct net_device *dev,
 			lp_advertising |= ADVERTISED_20000baseKR2_Full;
 	}
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.lp_advertising,
-						lp_advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
+	ethtool_u32_to_ks(cmd->link_modes.lp_advertising, lp_advertising);
 
 	DP(BNX2X_MSG_ETHTOOL, "ethtool_cmd: cmd %d\n"
 	   "  supported 0x%x  advertising 0x%x  speed %u\n"
@@ -372,10 +366,8 @@ static int bnx2x_set_link_ksettings(struct net_device *dev,
 	u32 supported;
 	u8 duplex = cmd->base.duplex;
 
-	ethtool_convert_link_mode_to_legacy_u32(&supported,
-						cmd->link_modes.supported);
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&supported, cmd->link_modes.supported);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	if (IS_MF_SD(bp))
 		return 0;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 7270c8b0cef3..e3d39ac375e2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1012,64 +1012,45 @@ u32 _bnxt_fw_to_ethtool_adv_spds(u16 fw_speeds, u8 fw_pause)
 #define BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, fw_pause, lk_ksettings, name)\
 {									\
 	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_100MB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     100baseT_Full);	\
+		ethtool_ks_add_mode(lk_ksettings, name, 100baseT_Full);	\
 	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_1GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     1000baseT_Full);	\
+		ethtool_ks_add_mode(lk_ksettings, name, 1000baseT_Full);\
 	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_10GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     10000baseT_Full);	\
+		ethtool_ks_add_mode(lk_ksettings, name, 10000baseT_Full);\
 	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_25GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     25000baseCR_Full);	\
+		ethtool_ks_add_mode(lk_ksettings, name, 25000baseCR_Full);\
 	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_40GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     40000baseCR4_Full);\
+		ethtool_ks_add_mode(lk_ksettings, name, 40000baseCR4_Full);\
 	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_50GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     50000baseCR2_Full);\
+		ethtool_ks_add_mode(lk_ksettings, name, 50000baseCR2_Full);\
 	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_100GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     100000baseCR4_Full);\
+		ethtool_ks_add_mode(lk_ksettings, name, 100000baseCR4_Full);\
 	if ((fw_pause) & BNXT_LINK_PAUSE_RX) {				\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     Pause);		\
+		ethtool_ks_add_mode(lk_ksettings, name, Pause);		\
 		if (!((fw_pause) & BNXT_LINK_PAUSE_TX))			\
-			ethtool_link_ksettings_add_link_mode(		\
-					lk_ksettings, name, Asym_Pause);\
+			ethtool_ks_add_mode(lk_ksettings, name, Asym_Pause);\
 	} else if ((fw_pause) & BNXT_LINK_PAUSE_TX) {			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     Asym_Pause);	\
+		ethtool_ks_add_mode(lk_ksettings, name, Asym_Pause);	\
 	}								\
 }
 
 #define BNXT_ETHTOOL_TO_FW_SPDS(fw_speeds, lk_ksettings, name)		\
 {									\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  100baseT_Full) ||	\
-	    ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  100baseT_Half))	\
+	if (ethtool_ks_test(lk_ksettings, name, 100baseT_Full) ||	\
+	    ethtool_ks_test(lk_ksettings, name,	100baseT_Half))	\
 		(fw_speeds) |= BNXT_LINK_SPEED_MSK_100MB;		\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  1000baseT_Full) ||	\
-	    ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  1000baseT_Half))	\
+	if (ethtool_ks_test(lk_ksettings, name,	1000baseT_Full) ||	\
+	    ethtool_ks_test(lk_ksettings, name,	1000baseT_Half))	\
 		(fw_speeds) |= BNXT_LINK_SPEED_MSK_1GB;			\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  10000baseT_Full))	\
+	if (ethtool_ks_test(lk_ksettings, name,	10000baseT_Full))	\
 		(fw_speeds) |= BNXT_LINK_SPEED_MSK_10GB;		\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  25000baseCR_Full))	\
+	if (ethtool_ks_test(lk_ksettings, name,	25000baseCR_Full))	\
 		(fw_speeds) |= BNXT_LINK_SPEED_MSK_25GB;		\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  40000baseCR4_Full))	\
+	if (ethtool_ks_test(lk_ksettings, name,	40000baseCR4_Full))	\
 		(fw_speeds) |= BNXT_LINK_SPEED_MSK_40GB;		\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  50000baseCR2_Full))	\
+	if (ethtool_ks_test(lk_ksettings, name,	50000baseCR2_Full))	\
 		(fw_speeds) |= BNXT_LINK_SPEED_MSK_50GB;		\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  100000baseCR4_Full))	\
+	if (ethtool_ks_test(lk_ksettings, name,	100000baseCR4_Full))	\
 		(fw_speeds) |= BNXT_LINK_SPEED_MSK_100GB;		\
 }
 
@@ -1105,13 +1086,11 @@ static void bnxt_fw_to_ethtool_support_spds(struct bnxt_link_info *link_info,
 
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
@@ -1148,15 +1127,14 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 	struct ethtool_link_settings *base = &lk_ksettings->base;
 	u32 ethtool_speed;
 
-	ethtool_link_ksettings_zero_link_mode(lk_ksettings, supported);
+	ethtool_ks_clear(lk_ksettings, supported);
 	mutex_lock(&bp->link_lock);
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
@@ -1180,15 +1158,11 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
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
index 9f59b1270a7c..dcb9fc959d55 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -12141,8 +12141,7 @@ static int tg3_get_link_ksettings(struct net_device *dev,
 		supported |= SUPPORTED_FIBRE;
 		cmd->base.port = PORT_FIBRE;
 	}
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
 
 	advertising = tp->link_config.advertising;
 	if (tg3_flag(tp, PAUSE_AUTONEG)) {
@@ -12157,15 +12156,13 @@ static int tg3_get_link_ksettings(struct net_device *dev,
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
@@ -12207,8 +12204,7 @@ static int tg3_set_link_ksettings(struct net_device *dev,
 	    cmd->base.duplex != DUPLEX_HALF)
 		return -EINVAL;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
 		u32 mask = ADVERTISED_Autoneg |
diff --git a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
index 31032de5843b..38859ad73166 100644
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
index 2bd7c638b178..e7445db2276d 100644
--- a/drivers/net/ethernet/calxeda/xgmac.c
+++ b/drivers/net/ethernet/calxeda/xgmac.c
@@ -1535,8 +1535,8 @@ static int xgmac_ethtool_get_link_ksettings(struct net_device *dev,
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
index 06f7449c569d..4b7772037e3c 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
@@ -233,21 +233,19 @@ static int lio_get_link_ksettings(struct net_device *netdev,
 
 	linfo = &lio->linfo;
 
-	ethtool_link_ksettings_zero_link_mode(ecmd, supported);
-	ethtool_link_ksettings_zero_link_mode(ecmd, advertising);
+	ethtool_ks_clear(ecmd, supported);
+	ethtool_ks_clear(ecmd, advertising);
 
 	switch (linfo->link.s.phy_type) {
 	case LIO_PHY_PORT_TP:
 		ecmd->base.port = PORT_TP;
 		ecmd->base.autoneg = AUTONEG_DISABLE;
-		ethtool_link_ksettings_add_link_mode(ecmd, supported, TP);
-		ethtool_link_ksettings_add_link_mode(ecmd, supported, Pause);
-		ethtool_link_ksettings_add_link_mode(ecmd, supported,
-						     10000baseT_Full);
+		ethtool_ks_add_mode(ecmd, supported, TP);
+		ethtool_ks_add_mode(ecmd, supported, Pause);
+		ethtool_ks_add_mode(ecmd, supported, 10000baseT_Full);
 
-		ethtool_link_ksettings_add_link_mode(ecmd, advertising, Pause);
-		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
-						     10000baseT_Full);
+		ethtool_ks_add_mode(ecmd, advertising, Pause);
+		ethtool_ks_add_mode(ecmd, advertising, 10000baseT_Full);
 
 		break;
 
@@ -264,30 +262,27 @@ static int lio_get_link_ksettings(struct net_device *netdev,
 
 		ecmd->base.port = PORT_FIBRE;
 		ecmd->base.autoneg = AUTONEG_DISABLE;
-		ethtool_link_ksettings_add_link_mode(ecmd, supported, FIBRE);
+		ethtool_ks_add_mode(ecmd, supported, FIBRE);
 
-		ethtool_link_ksettings_add_link_mode(ecmd, supported, Pause);
-		ethtool_link_ksettings_add_link_mode(ecmd, advertising, Pause);
+		ethtool_ks_add_mode(ecmd, supported, Pause);
+		ethtool_ks_add_mode(ecmd, advertising, Pause);
 		if (oct->subsystem_id == OCTEON_CN2350_25GB_SUBSYS_ID ||
 		    oct->subsystem_id == OCTEON_CN2360_25GB_SUBSYS_ID) {
 			if (OCTEON_CN23XX_PF(oct)) {
-				ethtool_link_ksettings_add_link_mode
-					(ecmd, supported, 25000baseSR_Full);
-				ethtool_link_ksettings_add_link_mode
-					(ecmd, supported, 25000baseKR_Full);
-				ethtool_link_ksettings_add_link_mode
-					(ecmd, supported, 25000baseCR_Full);
+				ethtool_ks_add_mode(ecmd, supported,
+						    25000baseSR_Full);
+				ethtool_ks_add_mode(ecmd, supported,
+						    25000baseKR_Full);
+				ethtool_ks_add_mode(ecmd, supported,
+						    25000baseCR_Full);
 
 				if (oct->no_speed_setting == 0)  {
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, supported,
-						 10000baseSR_Full);
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, supported,
-						 10000baseKR_Full);
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, supported,
-						 10000baseCR_Full);
+					ethtool_ks_add_mode(ecmd, supported,
+							    10000baseSR_Full);
+					ethtool_ks_add_mode(ecmd, supported,
+							    10000baseKR_Full);
+					ethtool_ks_add_mode(ecmd, supported,
+							    10000baseCR_Full);
 				}
 
 				if (oct->no_speed_setting == 0)
@@ -296,77 +291,57 @@ static int lio_get_link_ksettings(struct net_device *netdev,
 					oct->speed_setting = 25;
 
 				if (oct->speed_setting == 10) {
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, advertising,
-						 10000baseSR_Full);
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, advertising,
-						 10000baseKR_Full);
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, advertising,
-						 10000baseCR_Full);
+					ethtool_ks_add_mode(ecmd, advertising,
+							    10000baseSR_Full);
+					ethtool_ks_add_mode(ecmd, advertising,
+							    10000baseKR_Full);
+					ethtool_ks_add_mode(ecmd, advertising,
+							    10000baseCR_Full);
 				}
 				if (oct->speed_setting == 25) {
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, advertising,
-						 25000baseSR_Full);
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, advertising,
-						 25000baseKR_Full);
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, advertising,
-						 25000baseCR_Full);
+					ethtool_ks_add_mode(ecmd, advertising,
+							    25000baseSR_Full);
+					ethtool_ks_add_mode(ecmd, advertising,
+							    25000baseKR_Full);
+					ethtool_ks_add_mode(ecmd, advertising,
+							    25000baseCR_Full);
 				}
 			} else { /* VF */
 				if (linfo->link.s.speed == 10000) {
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, supported,
-						 10000baseSR_Full);
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, supported,
-						 10000baseKR_Full);
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, supported,
-						 10000baseCR_Full);
-
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, advertising,
-						 10000baseSR_Full);
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, advertising,
-						 10000baseKR_Full);
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, advertising,
-						 10000baseCR_Full);
+					ethtool_ks_add_mode(ecmd, supported,
+							    10000baseSR_Full);
+					ethtool_ks_add_mode(ecmd, supported,
+							    10000baseKR_Full);
+					ethtool_ks_add_mode(ecmd, supported,
+							    10000baseCR_Full);
+
+					ethtool_ks_add_mode(ecmd, advertising,
+							    10000baseSR_Full);
+					ethtool_ks_add_mode(ecmd, advertising,
+							    10000baseKR_Full);
+					ethtool_ks_add_mode(ecmd, advertising,
+							    10000baseCR_Full);
 				}
 
 				if (linfo->link.s.speed == 25000) {
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, supported,
-						 25000baseSR_Full);
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, supported,
-						 25000baseKR_Full);
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, supported,
-						 25000baseCR_Full);
-
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, advertising,
-						 25000baseSR_Full);
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, advertising,
-						 25000baseKR_Full);
-					ethtool_link_ksettings_add_link_mode
-						(ecmd, advertising,
-						 25000baseCR_Full);
+					ethtool_ks_add_mode(ecmd, supported,
+							    25000baseSR_Full);
+					ethtool_ks_add_mode(ecmd, supported,
+							    25000baseKR_Full);
+					ethtool_ks_add_mode(ecmd, supported,
+							    25000baseCR_Full);
+
+					ethtool_ks_add_mode(ecmd, advertising,
+							    25000baseSR_Full);
+					ethtool_ks_add_mode(ecmd, advertising,
+							    25000baseKR_Full);
+					ethtool_ks_add_mode(ecmd, advertising,
+							    25000baseCR_Full);
 				}
 			}
 		} else {
-			ethtool_link_ksettings_add_link_mode(ecmd, supported,
-							     10000baseT_Full);
-			ethtool_link_ksettings_add_link_mode(ecmd, advertising,
-							     10000baseT_Full);
+			ethtool_ks_add_mode(ecmd, supported, 10000baseT_Full);
+			ethtool_ks_add_mode(ecmd, advertising, 10000baseT_Full);
 		}
 		break;
 	}
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
index 5603f5ab1fee..4beaab6ff602 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
@@ -174,10 +174,8 @@ static int nicvf_get_link_ksettings(struct net_device *netdev,
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
index 8623be13bf86..f54fd1a57b14 100644
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
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	if (!(lc->supported & SUPPORTED_Autoneg))
 		return -EOPNOTSUPP;             /* can't change speed/duplex */
diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index 2edfdbdaae48..401648fd51c2 100644
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
index 59d04d73c672..46fe071c2f2d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -728,9 +728,9 @@ static int get_link_ksettings(struct net_device *dev,
 	if (!netif_running(dev))
 		(void)t4_update_port_info(pi);
 
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, supported);
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, advertising);
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, lp_advertising);
+	ethtool_ks_clear(link_ksettings, supported);
+	ethtool_ks_clear(link_ksettings, advertising);
+	ethtool_ks_clear(link_ksettings, lp_advertising);
 
 	base->port = from_fw_port_mod_type(pi->port_type, pi->mod_type);
 
@@ -761,27 +761,20 @@ static int get_link_ksettings(struct net_device *dev,
 
 	if (pi->link_cfg.fc & PAUSE_RX) {
 		if (pi->link_cfg.fc & PAUSE_TX) {
-			ethtool_link_ksettings_add_link_mode(link_ksettings,
-							     advertising,
-							     Pause);
+			ethtool_ks_add_mode(link_ksettings, advertising, Pause);
 		} else {
-			ethtool_link_ksettings_add_link_mode(link_ksettings,
-							     advertising,
-							     Asym_Pause);
+			ethtool_ks_add_mode(link_ksettings, advertising,
+					    Asym_Pause);
 		}
 	} else if (pi->link_cfg.fc & PAUSE_TX) {
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising,
-						     Asym_Pause);
+		ethtool_ks_add_mode(link_ksettings, advertising, Asym_Pause);
 	}
 
 	base->autoneg = pi->link_cfg.autoneg;
 	if (pi->link_cfg.pcaps & FW_PORT_CAP32_ANEG)
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
index 71f13bd2b5e4..25b2c43a7f3d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -1388,9 +1388,9 @@ static int cxgb4vf_get_link_ksettings(struct net_device *dev,
 	if (!netif_running(dev))
 		(void)t4vf_update_port_info(pi);
 
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, supported);
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, advertising);
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, lp_advertising);
+	ethtool_ks_clear(link_ksettings, supported);
+	ethtool_ks_clear(link_ksettings, advertising);
+	ethtool_ks_clear(link_ksettings, lp_advertising);
 
 	base->port = from_fw_port_mod_type(pi->port_type, pi->mod_type);
 
@@ -1421,27 +1421,20 @@ static int cxgb4vf_get_link_ksettings(struct net_device *dev,
 
 	if (pi->link_cfg.fc & PAUSE_RX) {
 		if (pi->link_cfg.fc & PAUSE_TX) {
-			ethtool_link_ksettings_add_link_mode(link_ksettings,
-							     advertising,
-							     Pause);
+			ethtool_ks_add_mode(link_ksettings, advertising, Pause);
 		} else {
-			ethtool_link_ksettings_add_link_mode(link_ksettings,
-							     advertising,
-							     Asym_Pause);
+			ethtool_ks_add_mode(link_ksettings, advertising,
+					    Asym_Pause);
 		}
 	} else if (pi->link_cfg.fc & PAUSE_TX) {
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising,
-						     Asym_Pause);
+		ethtool_ks_add_mode(link_ksettings, advertising, Asym_Pause);
 	}
 
 	base->autoneg = pi->link_cfg.autoneg;
 	if (pi->link_cfg.pcaps & FW_PORT_CAP32_ANEG)
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
index 869006c2002d..157988f26bc9 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -110,12 +110,10 @@ static int enic_get_ksettings(struct net_device *netdev,
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
diff --git a/drivers/net/ethernet/dec/tulip/de2104x.c b/drivers/net/ethernet/dec/tulip/de2104x.c
index 13430f75496c..e15d912ccf29 100644
--- a/drivers/net/ethernet/dec/tulip/de2104x.c
+++ b/drivers/net/ethernet/dec/tulip/de2104x.c
@@ -1486,11 +1486,9 @@ static void __de_get_regs(struct de_private *de, u8 *buf)
 static void __de_get_link_ksettings(struct de_private *de,
 				    struct ethtool_link_ksettings *cmd)
 {
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						de->media_supported);
+	ethtool_u32_to_ks(cmd->link_modes.supported, de->media_supported);
 	cmd->base.phy_address = 0;
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						de->media_advertise);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, de->media_advertise);
 
 	switch (de->media_type) {
 	case DE_MEDIA_AUI:
@@ -1529,8 +1527,7 @@ static int __de_set_link_ksettings(struct de_private *de,
 	u8 autoneg = cmd->base.autoneg;
 	u32 advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	if (cmd->base.speed != 10)
 		return -EINVAL;
diff --git a/drivers/net/ethernet/dec/tulip/uli526x.c b/drivers/net/ethernet/dec/tulip/uli526x.c
index 488a744084c9..82aad26852c8 100644
--- a/drivers/net/ethernet/dec/tulip/uli526x.c
+++ b/drivers/net/ethernet/dec/tulip/uli526x.c
@@ -943,10 +943,8 @@ ULi_ethtool_get_link_ksettings(struct uli526x_board_info *db,
 	                   ADVERTISED_Autoneg |
 	                   ADVERTISED_MII);
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	cmd->base.port = PORT_MII;
 	cmd->base.phy_address = db->phy_addr;
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index f0536b16b3c3..be89239c9aa6 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -1288,10 +1288,8 @@ static int rio_get_link_ksettings(struct net_device *dev,
 
 	cmd->base.phy_address = np->phy_addr;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/emulex/benet/be_ethtool.c b/drivers/net/ethernet/emulex/benet/be_ethtool.c
index 7f7e206f95f8..a4750a67ccc2 100644
--- a/drivers/net/ethernet/emulex/benet/be_ethtool.c
+++ b/drivers/net/ethernet/emulex/benet/be_ethtool.c
@@ -673,10 +673,8 @@ static int be_get_link_ksettings(struct net_device *netdev,
 		DUPLEX_FULL : DUPLEX_UNKNOWN;
 	cmd->base.phy_address = adapter->port_num;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index 2e14a3ae1d8b..c3c5fe139b29 100644
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
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index c16bb6cb0564..c1fafcd7ac9b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -605,12 +605,10 @@ static int hns3_get_link_ksettings(struct net_device *netdev,
 		h->ae_algo->ops->get_flowctrl_adv(h, &flowctrl_adv);
 
 	if (flowctrl_adv & ADVERTISED_Pause)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     Pause);
+		ethtool_ks_add_mode(cmd, advertising, Pause);
 
 	if (flowctrl_adv & ADVERTISED_Asym_Pause)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     Asym_Pause);
+		ethtool_ks_add_mode(cmd, advertising, Asym_Pause);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index 5b122728dcb4..ba4bca3df871 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -118,9 +118,8 @@ static int hinic_get_link_ksettings(struct net_device *netdev,
 	struct hinic_port_cap port_cap;
 	int err;
 
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, advertising);
-	ethtool_link_ksettings_add_link_mode(link_ksettings, supported,
-					     Autoneg);
+	ethtool_ks_clear(link_ksettings, advertising);
+	ethtool_ks_add_mode(link_ksettings, supported, Autoneg);
 
 	link_ksettings->base.speed   = SPEED_UNKNOWN;
 	link_ksettings->base.autoneg = AUTONEG_DISABLE;
@@ -148,8 +147,7 @@ static int hinic_get_link_ksettings(struct net_device *netdev,
 	set_link_speed(link_ksettings, port_cap.speed);
 
 	if (!!(port_cap.autoneg_cap & HINIC_AUTONEG_SUPPORTED))
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising, Autoneg);
+		ethtool_ks_add_mode(link_ksettings, advertising, Autoneg);
 
 	if (port_cap.autoneg_state == HINIC_AUTONEG_ACTIVE)
 		link_ksettings->base.autoneg = AUTONEG_ENABLE;
diff --git a/drivers/net/ethernet/ibm/ehea/ehea_ethtool.c b/drivers/net/ethernet/ibm/ehea/ehea_ethtool.c
index 4f58d338d739..284b59da8b22 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_ethtool.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_ethtool.c
@@ -87,10 +87,8 @@ static int ehea_get_link_ksettings(struct net_device *dev,
 	cmd->base.autoneg = port->autoneg == 1 ?
 		AUTONEG_ENABLE : AUTONEG_DISABLE;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 354c0982847b..893fb138aa70 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2032,10 +2032,8 @@ static int emac_ethtool_get_link_ksettings(struct net_device *ndev,
 	cmd->base.duplex = dev->phy.duplex;
 	mutex_unlock(&dev->link_lock);
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -2048,8 +2046,7 @@ emac_ethtool_set_link_ksettings(struct net_device *ndev,
 	u32 f = dev->phy.features;
 	u32 advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	DBG(dev, "set_settings(%d, %d, %d, 0x%08x)" NL,
 	    cmd->base.autoneg, cmd->base.speed, cmd->base.duplex, advertising);
diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index c1b51edaaf62..a2efb5c4c421 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -740,10 +740,8 @@ static int netdev_get_link_ksettings(struct net_device *dev,
 	cmd->base.phy_address = 0;
 	cmd->base.autoneg = AUTONEG_ENABLE;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 6e8d6a6f6aaf..ad2eeb2ae403 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2205,10 +2205,8 @@ static int ibmvnic_get_link_ksettings(struct net_device *netdev,
 	cmd->base.phy_address = 0;
 	cmd->base.autoneg = AUTONEG_ENABLE;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index 5d365a986bb0..fdd5549f8a8c 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -153,10 +153,8 @@ static int e1000_get_link_ksettings(struct net_device *netdev,
 	else
 		cmd->base.eth_tp_mdix_ctrl = hw->mdix;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -168,8 +166,7 @@ static int e1000_set_link_ksettings(struct net_device *netdev,
 	struct e1000_hw *hw = &adapter->hw;
 	u32 advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	/* MDI setting is only allowed when autoneg enabled because
 	 * some hardware doesn't allow MDI setting when speed or
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index e084cb734eb1..882f6baf8d9f 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -185,10 +185,8 @@ static int e1000_get_link_ksettings(struct net_device *netdev,
 	if (hw->phy.media_type != e1000_media_type_copper)
 		cmd->base.eth_tp_mdix_ctrl = ETH_TP_MDI_INVALID;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -256,8 +254,7 @@ static int e1000_set_link_ksettings(struct net_device *netdev,
 	int ret_val = 0;
 	u32 advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	pm_runtime_get_sync(netdev->dev.parent);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 329e59eae4a1..4b78225966c4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -244,20 +244,16 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf,
 	struct i40e_link_status *hw_link_info = &pf->hw.phy.link_info;
 	u64 phy_types = pf->hw.phy.phy_types;
 
-	ethtool_link_ksettings_zero_link_mode(ks, supported);
-	ethtool_link_ksettings_zero_link_mode(ks, advertising);
+	ethtool_ks_clear(ks, supported);
+	ethtool_ks_clear(ks, advertising);
 
 	if (phy_types & I40E_CAP_PHY_TYPE_SGMII) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     1000baseT_Full);
+		ethtool_ks_add_mode(ks, supported, 1000baseT_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     1000baseT_Full);
+			ethtool_ks_add_mode(ks, advertising, 1000baseT_Full);
 		if (pf->hw_features & I40E_HW_100M_SGMII_CAPABLE) {
-			ethtool_link_ksettings_add_link_mode(ks, supported,
-							     100baseT_Full);
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     100baseT_Full);
+			ethtool_ks_add_mode(ks, supported, 100baseT_Full);
+			ethtool_ks_add_mode(ks, advertising, 100baseT_Full);
 		}
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_XAUI ||
@@ -265,150 +261,111 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf,
 	    phy_types & I40E_CAP_PHY_TYPE_SFI ||
 	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_SFPP_CU ||
 	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_AOC) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     10000baseT_Full);
+		ethtool_ks_add_mode(ks, supported, 10000baseT_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     10000baseT_Full);
+			ethtool_ks_add_mode(ks, advertising, 10000baseT_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_T) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     10000baseT_Full);
+		ethtool_ks_add_mode(ks, supported, 10000baseT_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     10000baseT_Full);
+			ethtool_ks_add_mode(ks, advertising, 10000baseT_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_XLAUI ||
 	    phy_types & I40E_CAP_PHY_TYPE_XLPPI ||
 	    phy_types & I40E_CAP_PHY_TYPE_40GBASE_AOC)
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     40000baseCR4_Full);
+		ethtool_ks_add_mode(ks, supported, 40000baseCR4_Full);
 	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_CR4_CU ||
 	    phy_types & I40E_CAP_PHY_TYPE_40GBASE_CR4) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     40000baseCR4_Full);
+		ethtool_ks_add_mode(ks, supported, 40000baseCR4_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_40GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     40000baseCR4_Full);
+			ethtool_ks_add_mode(ks, advertising, 40000baseCR4_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_100BASE_TX) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     100baseT_Full);
+		ethtool_ks_add_mode(ks, supported, 100baseT_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_100MB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     100baseT_Full);
+			ethtool_ks_add_mode(ks, advertising, 100baseT_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_1000BASE_T) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     1000baseT_Full);
+		ethtool_ks_add_mode(ks, supported, 1000baseT_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     1000baseT_Full);
+			ethtool_ks_add_mode(ks, advertising, 1000baseT_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_SR4)
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     40000baseSR4_Full);
+		ethtool_ks_add_mode(ks, supported, 40000baseSR4_Full);
 	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_LR4)
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     40000baseLR4_Full);
+		ethtool_ks_add_mode(ks, supported, 40000baseLR4_Full);
 	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_KR4) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     40000baseLR4_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     40000baseLR4_Full);
+		ethtool_ks_add_mode(ks, supported, 40000baseLR4_Full);
+		ethtool_ks_add_mode(ks, advertising, 40000baseLR4_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_20GBASE_KR2) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     20000baseKR2_Full);
+		ethtool_ks_add_mode(ks, supported, 20000baseKR2_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_20GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     20000baseKR2_Full);
+			ethtool_ks_add_mode(ks, advertising, 20000baseKR2_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_KX4) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     10000baseKX4_Full);
+		ethtool_ks_add_mode(ks, supported, 10000baseKX4_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     10000baseKX4_Full);
+			ethtool_ks_add_mode(ks, advertising, 10000baseKX4_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_KR &&
 	    !(pf->hw_features & I40E_HW_HAVE_CRT_RETIMER)) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     10000baseKR_Full);
+		ethtool_ks_add_mode(ks, supported, 10000baseKR_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     10000baseKR_Full);
+			ethtool_ks_add_mode(ks, advertising, 10000baseKR_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_1000BASE_KX &&
 	    !(pf->hw_features & I40E_HW_HAVE_CRT_RETIMER)) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     1000baseKX_Full);
+		ethtool_ks_add_mode(ks, supported, 1000baseKX_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     1000baseKX_Full);
+			ethtool_ks_add_mode(ks, advertising, 1000baseKX_Full);
 	}
 	/* need to add 25G PHY types */
 	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_KR) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     25000baseKR_Full);
+		ethtool_ks_add_mode(ks, supported, 25000baseKR_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_25GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     25000baseKR_Full);
+			ethtool_ks_add_mode(ks, advertising, 25000baseKR_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_CR) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     25000baseCR_Full);
+		ethtool_ks_add_mode(ks, supported, 25000baseCR_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_25GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     25000baseCR_Full);
+			ethtool_ks_add_mode(ks, advertising, 25000baseCR_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_SR ||
 	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_LR) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     25000baseSR_Full);
+		ethtool_ks_add_mode(ks, supported, 25000baseSR_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_25GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     25000baseSR_Full);
+			ethtool_ks_add_mode(ks, advertising, 25000baseSR_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_AOC ||
 	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_ACC) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     25000baseCR_Full);
+		ethtool_ks_add_mode(ks, supported, 25000baseCR_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_25GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     25000baseCR_Full);
+			ethtool_ks_add_mode(ks, advertising, 25000baseCR_Full);
 	}
 	/* need to add new 10G PHY types */
 	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_CR1 ||
 	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_CR1_CU) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     10000baseCR_Full);
+		ethtool_ks_add_mode(ks, supported, 10000baseCR_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     10000baseCR_Full);
+			ethtool_ks_add_mode(ks, advertising, 10000baseCR_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_SR) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     10000baseSR_Full);
+		ethtool_ks_add_mode(ks, supported, 10000baseSR_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     10000baseSR_Full);
+			ethtool_ks_add_mode(ks, advertising, 10000baseSR_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_LR) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     10000baseLR_Full);
+		ethtool_ks_add_mode(ks, supported, 10000baseLR_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     10000baseLR_Full);
+			ethtool_ks_add_mode(ks, advertising, 10000baseLR_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_1000BASE_SX ||
 	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_LX ||
 	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_T_OPTICAL) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     1000baseX_Full);
+		ethtool_ks_add_mode(ks, supported, 1000baseX_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     1000baseX_Full);
+			ethtool_ks_add_mode(ks, advertising, 1000baseX_Full);
 	}
 	/* Autoneg PHY types */
 	if (phy_types & I40E_CAP_PHY_TYPE_SGMII ||
@@ -433,10 +390,8 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf,
 	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_LX ||
 	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_KX ||
 	    phy_types & I40E_CAP_PHY_TYPE_100BASE_TX) {
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     Autoneg);
+		ethtool_ks_add_mode(ks, supported, Autoneg);
+		ethtool_ks_add_mode(ks, advertising, Autoneg);
 	}
 }
 
@@ -460,26 +415,21 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 	switch (hw_link_info->phy_type) {
 	case I40E_PHY_TYPE_40GBASE_CR4:
 	case I40E_PHY_TYPE_40GBASE_CR4_CU:
-		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     40000baseCR4_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     40000baseCR4_Full);
+		ethtool_ks_add_mode(ks, supported, Autoneg);
+		ethtool_ks_add_mode(ks, supported, 40000baseCR4_Full);
+		ethtool_ks_add_mode(ks, advertising, Autoneg);
+		ethtool_ks_add_mode(ks, advertising, 40000baseCR4_Full);
 		break;
 	case I40E_PHY_TYPE_XLAUI:
 	case I40E_PHY_TYPE_XLPPI:
 	case I40E_PHY_TYPE_40GBASE_AOC:
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     40000baseCR4_Full);
+		ethtool_ks_add_mode(ks, supported, 40000baseCR4_Full);
 		break;
 	case I40E_PHY_TYPE_40GBASE_SR4:
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     40000baseSR4_Full);
+		ethtool_ks_add_mode(ks, supported, 40000baseSR4_Full);
 		break;
 	case I40E_PHY_TYPE_40GBASE_LR4:
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     40000baseLR4_Full);
+		ethtool_ks_add_mode(ks, supported, 40000baseLR4_Full);
 		break;
 	case I40E_PHY_TYPE_25GBASE_SR:
 	case I40E_PHY_TYPE_25GBASE_LR:
@@ -487,104 +437,78 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 	case I40E_PHY_TYPE_10GBASE_LR:
 	case I40E_PHY_TYPE_1000BASE_SX:
 	case I40E_PHY_TYPE_1000BASE_LX:
-		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     25000baseSR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     25000baseSR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     10000baseSR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     10000baseSR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     10000baseLR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     10000baseLR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     1000baseX_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     1000baseX_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     10000baseT_Full);
+		ethtool_ks_add_mode(ks, supported, Autoneg);
+		ethtool_ks_add_mode(ks, advertising, Autoneg);
+		ethtool_ks_add_mode(ks, supported, 25000baseSR_Full);
+		ethtool_ks_add_mode(ks, advertising, 25000baseSR_Full);
+		ethtool_ks_add_mode(ks, supported, 10000baseSR_Full);
+		ethtool_ks_add_mode(ks, advertising, 10000baseSR_Full);
+		ethtool_ks_add_mode(ks, supported, 10000baseLR_Full);
+		ethtool_ks_add_mode(ks, advertising, 10000baseLR_Full);
+		ethtool_ks_add_mode(ks, supported, 1000baseX_Full);
+		ethtool_ks_add_mode(ks, advertising, 1000baseX_Full);
+		ethtool_ks_add_mode(ks, supported, 10000baseT_Full);
 		if (hw_link_info->module_type[2] &
 		    I40E_MODULE_TYPE_1000BASE_SX ||
 		    hw_link_info->module_type[2] &
 		    I40E_MODULE_TYPE_1000BASE_LX) {
-			ethtool_link_ksettings_add_link_mode(ks, supported,
-							     1000baseT_Full);
+			ethtool_ks_add_mode(ks, supported, 1000baseT_Full);
 			if (hw_link_info->requested_speeds &
 			    I40E_LINK_SPEED_1GB)
-				ethtool_link_ksettings_add_link_mode(
-				     ks, advertising, 1000baseT_Full);
+				ethtool_ks_add_mode(ks, advertising,
+						    1000baseT_Full);
 		}
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     10000baseT_Full);
+			ethtool_ks_add_mode(ks, advertising, 10000baseT_Full);
 		break;
 	case I40E_PHY_TYPE_10GBASE_T:
 	case I40E_PHY_TYPE_1000BASE_T:
 	case I40E_PHY_TYPE_100BASE_TX:
-		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     10000baseT_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     1000baseT_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     100baseT_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
+		ethtool_ks_add_mode(ks, supported, Autoneg);
+		ethtool_ks_add_mode(ks, supported, 10000baseT_Full);
+		ethtool_ks_add_mode(ks, supported, 1000baseT_Full);
+		ethtool_ks_add_mode(ks, supported, 100baseT_Full);
+		ethtool_ks_add_mode(ks, advertising, Autoneg);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     10000baseT_Full);
+			ethtool_ks_add_mode(ks, advertising, 10000baseT_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     1000baseT_Full);
+			ethtool_ks_add_mode(ks, advertising, 1000baseT_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_100MB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     100baseT_Full);
+			ethtool_ks_add_mode(ks, advertising, 100baseT_Full);
 		break;
 	case I40E_PHY_TYPE_1000BASE_T_OPTICAL:
-		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     1000baseT_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     1000baseT_Full);
+		ethtool_ks_add_mode(ks, supported, Autoneg);
+		ethtool_ks_add_mode(ks, supported, 1000baseT_Full);
+		ethtool_ks_add_mode(ks, advertising, Autoneg);
+		ethtool_ks_add_mode(ks, advertising, 1000baseT_Full);
 		break;
 	case I40E_PHY_TYPE_10GBASE_CR1_CU:
 	case I40E_PHY_TYPE_10GBASE_CR1:
-		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     10000baseT_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     10000baseT_Full);
+		ethtool_ks_add_mode(ks, supported, Autoneg);
+		ethtool_ks_add_mode(ks, supported, 10000baseT_Full);
+		ethtool_ks_add_mode(ks, advertising, Autoneg);
+		ethtool_ks_add_mode(ks, advertising, 10000baseT_Full);
 		break;
 	case I40E_PHY_TYPE_XAUI:
 	case I40E_PHY_TYPE_XFI:
 	case I40E_PHY_TYPE_SFI:
 	case I40E_PHY_TYPE_10GBASE_SFPP_CU:
 	case I40E_PHY_TYPE_10GBASE_AOC:
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     10000baseT_Full);
+		ethtool_ks_add_mode(ks, supported, 10000baseT_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     10000baseT_Full);
+			ethtool_ks_add_mode(ks, advertising, 10000baseT_Full);
 		break;
 	case I40E_PHY_TYPE_SGMII:
-		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     1000baseT_Full);
+		ethtool_ks_add_mode(ks, supported, Autoneg);
+		ethtool_ks_add_mode(ks, supported, 1000baseT_Full);
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
-			ethtool_link_ksettings_add_link_mode(ks, advertising,
-							     1000baseT_Full);
+			ethtool_ks_add_mode(ks, advertising, 1000baseT_Full);
 		if (pf->hw_features & I40E_HW_100M_SGMII_CAPABLE) {
-			ethtool_link_ksettings_add_link_mode(ks, supported,
-							     100baseT_Full);
+			ethtool_ks_add_mode(ks, supported, 100baseT_Full);
 			if (hw_link_info->requested_speeds &
 			    I40E_LINK_SPEED_100MB)
-				ethtool_link_ksettings_add_link_mode(
-				      ks, advertising, 100baseT_Full);
+				ethtool_ks_add_mode(ks, advertising,
+						    100baseT_Full);
 		}
 		break;
 	case I40E_PHY_TYPE_40GBASE_KR4:
@@ -593,54 +517,36 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 	case I40E_PHY_TYPE_10GBASE_KR:
 	case I40E_PHY_TYPE_10GBASE_KX4:
 	case I40E_PHY_TYPE_1000BASE_KX:
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     40000baseKR4_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     25000baseKR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     20000baseKR2_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     10000baseKR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     10000baseKX4_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     1000baseKX_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     40000baseKR4_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     25000baseKR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     20000baseKR2_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     10000baseKR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     10000baseKX4_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     1000baseKX_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
+		ethtool_ks_add_mode(ks, supported, 40000baseKR4_Full);
+		ethtool_ks_add_mode(ks, supported, 25000baseKR_Full);
+		ethtool_ks_add_mode(ks, supported, 20000baseKR2_Full);
+		ethtool_ks_add_mode(ks, supported, 10000baseKR_Full);
+		ethtool_ks_add_mode(ks, supported, 10000baseKX4_Full);
+		ethtool_ks_add_mode(ks, supported, 1000baseKX_Full);
+		ethtool_ks_add_mode(ks, supported, Autoneg);
+		ethtool_ks_add_mode(ks, advertising, 40000baseKR4_Full);
+		ethtool_ks_add_mode(ks, advertising, 25000baseKR_Full);
+		ethtool_ks_add_mode(ks, advertising, 20000baseKR2_Full);
+		ethtool_ks_add_mode(ks, advertising, 10000baseKR_Full);
+		ethtool_ks_add_mode(ks, advertising, 10000baseKX4_Full);
+		ethtool_ks_add_mode(ks, advertising, 1000baseKX_Full);
+		ethtool_ks_add_mode(ks, advertising, Autoneg);
 		break;
 	case I40E_PHY_TYPE_25GBASE_CR:
-		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     25000baseCR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     25000baseCR_Full);
+		ethtool_ks_add_mode(ks, supported, Autoneg);
+		ethtool_ks_add_mode(ks, advertising, Autoneg);
+		ethtool_ks_add_mode(ks, supported, 25000baseCR_Full);
+		ethtool_ks_add_mode(ks, advertising, 25000baseCR_Full);
 		break;
 	case I40E_PHY_TYPE_25GBASE_AOC:
 	case I40E_PHY_TYPE_25GBASE_ACC:
-		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     25000baseCR_Full);
-
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     25000baseCR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     10000baseCR_Full);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     10000baseCR_Full);
+		ethtool_ks_add_mode(ks, supported, Autoneg);
+		ethtool_ks_add_mode(ks, advertising, Autoneg);
+		ethtool_ks_add_mode(ks, supported, 25000baseCR_Full);
+
+		ethtool_ks_add_mode(ks, advertising, 25000baseCR_Full);
+		ethtool_ks_add_mode(ks, supported, 10000baseCR_Full);
+		ethtool_ks_add_mode(ks, advertising, 10000baseCR_Full);
 		break;
 	default:
 		/* if we got here and link is up something bad is afoot */
@@ -721,8 +627,8 @@ static int i40e_get_link_ksettings(struct net_device *netdev,
 	struct i40e_link_status *hw_link_info = &hw->phy.link_info;
 	bool link_up = hw_link_info->link_info & I40E_AQ_LINK_UP;
 
-	ethtool_link_ksettings_zero_link_mode(ks, supported);
-	ethtool_link_ksettings_zero_link_mode(ks, advertising);
+	ethtool_ks_clear(ks, supported);
+	ethtool_ks_clear(ks, advertising);
 
 	if (link_up)
 		i40e_get_settings_link_up(hw, ks, netdev, pf);
@@ -737,26 +643,25 @@ static int i40e_get_link_ksettings(struct net_device *netdev,
 	/* Set media type settings */
 	switch (hw->phy.media_type) {
 	case I40E_MEDIA_TYPE_BACKPLANE:
-		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, supported, Backplane);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     Backplane);
+		ethtool_ks_add_mode(ks, supported, Autoneg);
+		ethtool_ks_add_mode(ks, supported, Backplane);
+		ethtool_ks_add_mode(ks, advertising, Autoneg);
+		ethtool_ks_add_mode(ks, advertising, Backplane);
 		ks->base.port = PORT_NONE;
 		break;
 	case I40E_MEDIA_TYPE_BASET:
-		ethtool_link_ksettings_add_link_mode(ks, supported, TP);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, TP);
+		ethtool_ks_add_mode(ks, supported, TP);
+		ethtool_ks_add_mode(ks, advertising, TP);
 		ks->base.port = PORT_TP;
 		break;
 	case I40E_MEDIA_TYPE_DA:
 	case I40E_MEDIA_TYPE_CX4:
-		ethtool_link_ksettings_add_link_mode(ks, supported, FIBRE);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, FIBRE);
+		ethtool_ks_add_mode(ks, supported, FIBRE);
+		ethtool_ks_add_mode(ks, advertising, FIBRE);
 		ks->base.port = PORT_DA;
 		break;
 	case I40E_MEDIA_TYPE_FIBER:
-		ethtool_link_ksettings_add_link_mode(ks, supported, FIBRE);
+		ethtool_ks_add_mode(ks, supported, FIBRE);
 		ks->base.port = PORT_FIBRE;
 		break;
 	case I40E_MEDIA_TYPE_UNKNOWN:
@@ -766,25 +671,22 @@ static int i40e_get_link_ksettings(struct net_device *netdev,
 	}
 
 	/* Set flow control settings */
-	ethtool_link_ksettings_add_link_mode(ks, supported, Pause);
+	ethtool_ks_add_mode(ks, supported, Pause);
 
 	switch (hw->fc.requested_mode) {
 	case I40E_FC_FULL:
-		ethtool_link_ksettings_add_link_mode(ks, advertising, Pause);
+		ethtool_ks_add_mode(ks, advertising, Pause);
 		break;
 	case I40E_FC_TX_PAUSE:
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     Asym_Pause);
+		ethtool_ks_add_mode(ks, advertising, Asym_Pause);
 		break;
 	case I40E_FC_RX_PAUSE:
-		ethtool_link_ksettings_add_link_mode(ks, advertising, Pause);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     Asym_Pause);
+		ethtool_ks_add_mode(ks, advertising, Pause);
+		ethtool_ks_add_mode(ks, advertising, Asym_Pause);
 		break;
 	default:
-		ethtool_link_ksettings_del_link_mode(ks, advertising, Pause);
-		ethtool_link_ksettings_del_link_mode(ks, advertising,
-						     Asym_Pause);
+		ethtool_ks_del_mode(ks, advertising, Pause);
+		ethtool_ks_del_mode(ks, advertising, Asym_Pause);
 		break;
 	}
 
@@ -897,9 +799,7 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 		/* If autoneg was not already enabled */
 		if (!(hw->phy.link_info.an_info & I40E_AQ_AN_COMPLETED)) {
 			/* If autoneg is not supported, return error */
-			if (!ethtool_link_ksettings_test_link_mode(&safe_ks,
-								   supported,
-								   Autoneg)) {
+			if (!ethtool_ks_test(&safe_ks, supported, Autoneg)) {
 				netdev_info(netdev, "Autoneg not supported on this phy\n");
 				err = -EINVAL;
 				goto done;
@@ -915,9 +815,7 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 			/* If autoneg is supported 10GBASE_T is the only PHY
 			 * that can disable it, so otherwise return error
 			 */
-			if (ethtool_link_ksettings_test_link_mode(&safe_ks,
-								  supported,
-								  Autoneg) &&
+			if (ethtool_ks_test(&safe_ks, supported, Autoneg) &&
 			    hw->phy.link_info.phy_type !=
 			    I40E_PHY_TYPE_10GBASE_T) {
 				netdev_info(netdev, "Autoneg cannot be disabled on this phy\n");
@@ -931,47 +829,29 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 		}
 	}
 
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  100baseT_Full))
+	if (ethtool_ks_test(ks, advertising, 100baseT_Full))
 		config.link_speed |= I40E_LINK_SPEED_100MB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  1000baseT_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  1000baseX_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  1000baseKX_Full))
+	if (ethtool_ks_test(ks, advertising, 1000baseT_Full) ||
+	    ethtool_ks_test(ks, advertising, 1000baseX_Full) ||
+	    ethtool_ks_test(ks, advertising, 1000baseKX_Full))
 		config.link_speed |= I40E_LINK_SPEED_1GB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  10000baseT_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  10000baseKX4_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  10000baseKR_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  10000baseCR_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  10000baseSR_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  10000baseLR_Full))
+	if (ethtool_ks_test(ks, advertising, 10000baseT_Full) ||
+	    ethtool_ks_test(ks, advertising, 10000baseKX4_Full) ||
+	    ethtool_ks_test(ks, advertising, 10000baseKR_Full) ||
+	    ethtool_ks_test(ks, advertising, 10000baseCR_Full) ||
+	    ethtool_ks_test(ks, advertising, 10000baseSR_Full) ||
+	    ethtool_ks_test(ks, advertising, 10000baseLR_Full))
 		config.link_speed |= I40E_LINK_SPEED_10GB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  20000baseKR2_Full))
+	if (ethtool_ks_test(ks, advertising, 20000baseKR2_Full))
 		config.link_speed |= I40E_LINK_SPEED_20GB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  25000baseCR_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  25000baseKR_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  25000baseSR_Full))
+	if (ethtool_ks_test(ks, advertising, 25000baseCR_Full) ||
+	    ethtool_ks_test(ks, advertising, 25000baseKR_Full) ||
+	    ethtool_ks_test(ks, advertising, 25000baseSR_Full))
 		config.link_speed |= I40E_LINK_SPEED_25GB;
-	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  40000baseKR4_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  40000baseCR4_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  40000baseSR4_Full) ||
-	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  40000baseLR4_Full))
+	if (ethtool_ks_test(ks, advertising, 40000baseKR4_Full) ||
+	    ethtool_ks_test(ks, advertising, 40000baseCR4_Full) ||
+	    ethtool_ks_test(ks, advertising, 40000baseSR4_Full) ||
+	    ethtool_ks_test(ks, advertising, 40000baseLR4_Full))
 		config.link_speed |= I40E_LINK_SPEED_40GB;
 
 	/* If speed didn't get set, set it to what it currently is.
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
index 69efe0aec76a..ba94d9a0a29e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
@@ -76,7 +76,7 @@ static int i40evf_get_link_ksettings(struct net_device *netdev,
 {
 	struct i40evf_adapter *adapter = netdev_priv(netdev);
 
-	ethtool_link_ksettings_zero_link_mode(cmd, supported);
+	ethtool_ks_clear(cmd, supported);
 	cmd->base.autoneg = AUTONEG_DISABLE;
 	cmd->base.port = PORT_NONE;
 	/* Set speed and duplex */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 1db304c01d10..c85b2c5b9369 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -318,10 +318,8 @@ ice_get_link_ksettings(struct net_device *netdev,
 	hw_link_info = &vsi->port_info->phy.link_info;
 	link_up = hw_link_info->link_info & ICE_AQ_LINK_UP;
 
-	ethtool_link_ksettings_add_link_mode(ks, supported,
-					     10000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(ks, advertising,
-					     10000baseT_Full);
+	ethtool_ks_add_mode(ks, supported, 10000baseT_Full);
+	ethtool_ks_add_mode(ks, advertising, 10000baseT_Full);
 
 	/* set speed and duplex */
 	if (link_up) {
@@ -362,25 +360,24 @@ ice_get_link_ksettings(struct net_device *netdev,
 	/* set media type settings */
 	switch (vsi->port_info->phy.media_type) {
 	case ICE_MEDIA_FIBER:
-		ethtool_link_ksettings_add_link_mode(ks, supported, FIBRE);
+		ethtool_ks_add_mode(ks, supported, FIBRE);
 		ks->base.port = PORT_FIBRE;
 		break;
 	case ICE_MEDIA_BASET:
-		ethtool_link_ksettings_add_link_mode(ks, supported, TP);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, TP);
+		ethtool_ks_add_mode(ks, supported, TP);
+		ethtool_ks_add_mode(ks, advertising, TP);
 		ks->base.port = PORT_TP;
 		break;
 	case ICE_MEDIA_BACKPLANE:
-		ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, supported, Backplane);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     Backplane);
+		ethtool_ks_add_mode(ks, supported, Autoneg);
+		ethtool_ks_add_mode(ks, supported, Backplane);
+		ethtool_ks_add_mode(ks, advertising, Autoneg);
+		ethtool_ks_add_mode(ks, advertising, Backplane);
 		ks->base.port = PORT_NONE;
 		break;
 	case ICE_MEDIA_DA:
-		ethtool_link_ksettings_add_link_mode(ks, supported, FIBRE);
-		ethtool_link_ksettings_add_link_mode(ks, advertising, FIBRE);
+		ethtool_ks_add_mode(ks, supported, FIBRE);
+		ethtool_ks_add_mode(ks, advertising, FIBRE);
 		ks->base.port = PORT_DA;
 		break;
 	default:
@@ -389,26 +386,23 @@ ice_get_link_ksettings(struct net_device *netdev,
 	}
 
 	/* flow control is symmetric and always supported */
-	ethtool_link_ksettings_add_link_mode(ks, supported, Pause);
+	ethtool_ks_add_mode(ks, supported, Pause);
 
 	switch (vsi->port_info->fc.req_mode) {
 	case ICE_FC_FULL:
-		ethtool_link_ksettings_add_link_mode(ks, advertising, Pause);
+		ethtool_ks_add_mode(ks, advertising, Pause);
 		break;
 	case ICE_FC_TX_PAUSE:
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     Asym_Pause);
+		ethtool_ks_add_mode(ks, advertising, Asym_Pause);
 		break;
 	case ICE_FC_RX_PAUSE:
-		ethtool_link_ksettings_add_link_mode(ks, advertising, Pause);
-		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     Asym_Pause);
+		ethtool_ks_add_mode(ks, advertising, Pause);
+		ethtool_ks_add_mode(ks, advertising, Asym_Pause);
 		break;
 	case ICE_FC_PFC:
 	default:
-		ethtool_link_ksettings_del_link_mode(ks, advertising, Pause);
-		ethtool_link_ksettings_del_link_mode(ks, advertising,
-						     Asym_Pause);
+		ethtool_ks_add_mode(ks, advertising, Pause);
+		ethtool_ks_add_mode(ks, advertising, Asym_Pause);
 		break;
 	}
 
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 2d798499d35e..79248669fa4b 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -248,10 +248,8 @@ static int igb_get_link_ksettings(struct net_device *netdev,
 	else
 		cmd->base.eth_tp_mdix_ctrl = hw->phy.mdix;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -290,8 +288,7 @@ static int igb_set_link_ksettings(struct net_device *netdev,
 	while (test_and_set_bit(__IGB_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
 		hw->mac.autoneg = 1;
diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/ethernet/intel/igbvf/ethtool.c
index 3ae358b35227..91bd31f80bf7 100644
--- a/drivers/net/ethernet/intel/igbvf/ethtool.c
+++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
@@ -55,10 +55,10 @@ static int igbvf_get_link_ksettings(struct net_device *netdev,
 	struct e1000_hw *hw = &adapter->hw;
 	u32 status;
 
-	ethtool_link_ksettings_zero_link_mode(cmd, supported);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, 1000baseT_Full);
-	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, 1000baseT_Full);
+	ethtool_ks_clear(cmd, supported);
+	ethtool_ks_add_mode(cmd, supported, 1000baseT_Full);
+	ethtool_ks_clear(cmd, advertising);
+	ethtool_ks_add_mode(cmd, advertising, 1000baseT_Full);
 
 	cmd->base.port = -1;
 
diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_ethtool.c b/drivers/net/ethernet/intel/ixgb/ixgb_ethtool.c
index 43744bf0fc1c..c1e0e286c462 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_ethtool.c
@@ -74,13 +74,13 @@ ixgb_get_link_ksettings(struct net_device *netdev,
 {
 	struct ixgb_adapter *adapter = netdev_priv(netdev);
 
-	ethtool_link_ksettings_zero_link_mode(cmd, supported);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, 10000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
+	ethtool_ks_clear(cmd, supported);
+	ethtool_ks_add_mode(cmd, supported, 10000baseT_Full);
+	ethtool_ks_add_mode(cmd, supported, FIBRE);
 
-	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, 10000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
+	ethtool_ks_clear(cmd, advertising);
+	ethtool_ks_add_mode(cmd, advertising, 10000baseT_Full);
+	ethtool_ks_add_mode(cmd, advertising, FIBRE);
 
 	cmd->base.port = PORT_FIBRE;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index bdd179c29ea4..9e1b28c343da 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -178,8 +178,7 @@ static int ixgbe_get_link_ksettings(struct net_device *netdev,
 	bool autoneg = false;
 	u32 supported, advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&supported,
-						cmd->link_modes.supported);
+	ethtool_ks_to_u32(&supported, cmd->link_modes.supported);
 
 	hw->mac.ops.get_link_capabilities(hw, &supported_link, &autoneg);
 
@@ -356,10 +355,8 @@ static int ixgbe_get_link_ksettings(struct net_device *netdev,
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
@@ -373,10 +370,8 @@ static int ixgbe_set_link_ksettings(struct net_device *netdev,
 	s32 err = 0;
 	u32 supported, advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&supported,
-						cmd->link_modes.supported);
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&supported, cmd->link_modes.supported);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	if ((hw->phy.media_type == ixgbe_media_type_copper) ||
 	    (hw->phy.multispeed_fiber)) {
diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index e7813d76527c..face33dc2ca9 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -87,8 +87,8 @@ static int ixgbevf_get_link_ksettings(struct net_device *netdev,
 	u32 link_speed = 0;
 	bool link_up;
 
-	ethtool_link_ksettings_zero_link_mode(cmd, supported);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, 10000baseT_Full);
+	ethtool_ks_clear(cmd, supported);
+	ethtool_ks_add_mode(cmd, supported, 10000baseT_Full);
 	cmd->base.autoneg = AUTONEG_DISABLE;
 	cmd->base.port = -1;
 
diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 62f204f32316..d8bffe6ac1d7 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -1506,16 +1506,12 @@ mv643xx_eth_get_link_ksettings_phy(struct mv643xx_eth_private *mp,
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
 
 	return 0;
 }
@@ -1551,10 +1547,8 @@ mv643xx_eth_get_link_ksettings_phyless(struct mv643xx_eth_private *mp,
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
@@ -1611,11 +1605,9 @@ mv643xx_eth_set_link_ksettings(struct net_device *dev,
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
index 3a9730612a70..b72fda65107e 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -988,8 +988,7 @@ static int pxa168_init_phy(struct net_device *dev)
 	cmd.base.phy_address = pep->phy_addr;
 	cmd.base.speed = pep->phy_speed;
 	cmd.base.duplex = pep->phy_duplex;
-	ethtool_convert_legacy_u32_to_link_mode(cmd.link_modes.advertising,
-						PHY_BASIC_FEATURES);
+	ethtool_u32_to_ks(cmd.link_modes.advertising, PHY_BASIC_FEATURES);
 	cmd.base.autoneg = AUTONEG_ENABLE;
 
 	if (cmd.base.speed != 0)
diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index 9c08c3650c02..ff4a598c9e7c 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -320,10 +320,8 @@ static int skge_get_link_ksettings(struct net_device *dev,
 	cmd->base.speed = skge->speed;
 	cmd->base.duplex = skge->duplex;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -337,8 +335,7 @@ static int skge_set_link_ksettings(struct net_device *dev,
 	int err = 0;
 	u32 advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
 		advertising = supported;
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 697d9b374f5e..b1f5149892ed 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -3613,10 +3613,8 @@ static int sky2_get_link_ksettings(struct net_device *dev,
 		? AUTONEG_ENABLE : AUTONEG_DISABLE;
 	cmd->base.duplex = sky2->duplex;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -3629,8 +3627,7 @@ static int sky2_set_link_ksettings(struct net_device *dev,
 	u32 supported = sky2_supported_modes(hw);
 	u32 new_advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&new_advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&new_advertising, cmd->link_modes.advertising);
 
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
 		if (new_advertising & ~supported)
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index f11b45001cad..ccae4d26d97e 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -770,8 +770,8 @@ ethtool_get_ptys_link_ksettings(struct net_device *dev,
 	       be32_to_cpu(ptys_reg.eth_proto_lp_adv));
 
 	/* reset supported/advertising masks */
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, supported);
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, advertising);
+	ethtool_ks_clear(link_ksettings, supported);
+	ethtool_ks_clear(link_ksettings, advertising);
 
 	ptys2ethtool_update_supported_port(link_ksettings->link_modes.supported,
 					   &ptys_reg);
@@ -784,25 +784,19 @@ ethtool_get_ptys_link_ksettings(struct net_device *dev,
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
@@ -811,13 +805,12 @@ ethtool_get_ptys_link_ksettings(struct net_device *dev,
 
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
@@ -836,27 +829,21 @@ ethtool_get_default_link_ksettings(
 
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
index 2b786c4d3dab..a9cdb10e087d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -550,12 +550,8 @@ static void ptys2ethtool_supported_advertised_port(struct ethtool_link_ksettings
 				   | MLX5E_PROT_MASK(MLX5E_40GBASE_SR4)
 				   | MLX5E_PROT_MASK(MLX5E_100GBASE_SR4)
 				   | MLX5E_PROT_MASK(MLX5E_1000BASE_CX_SGMII))) {
-			ethtool_link_ksettings_add_link_mode(link_ksettings,
-							     supported,
-							     FIBRE);
-			ethtool_link_ksettings_add_link_mode(link_ksettings,
-							     advertising,
-							     FIBRE);
+			ethtool_ks_add_mode(link_ksettings, supported, FIBRE);
+			ethtool_ks_add_mode(link_ksettings, advertising, FIBRE);
 		}
 
 		if (eth_proto_cap & (MLX5E_PROT_MASK(MLX5E_100GBASE_KR4)
@@ -563,52 +559,38 @@ static void ptys2ethtool_supported_advertised_port(struct ethtool_link_ksettings
 				   | MLX5E_PROT_MASK(MLX5E_10GBASE_KR)
 				   | MLX5E_PROT_MASK(MLX5E_10GBASE_KX4)
 				   | MLX5E_PROT_MASK(MLX5E_1000BASE_KX))) {
-			ethtool_link_ksettings_add_link_mode(link_ksettings,
-							     supported,
-							     Backplane);
-			ethtool_link_ksettings_add_link_mode(link_ksettings,
-							     advertising,
-							     Backplane);
+			ethtool_ks_add_mode(link_ksettings, supported,
+					    Backplane);
+			ethtool_ks_add_mode(link_ksettings, advertising,
+					    Backplane);
 		}
 		return;
 	}
 
 	switch (connector_type) {
 	case MLX5E_PORT_TP:
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, TP);
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising, TP);
+		ethtool_ks_add_mode(link_ksettings, supported, TP);
+		ethtool_ks_add_mode(link_ksettings, advertising, TP);
 		break;
 	case MLX5E_PORT_AUI:
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, AUI);
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising, AUI);
+		ethtool_ks_add_mode(link_ksettings, supported, AUI);
+		ethtool_ks_add_mode(link_ksettings, advertising, AUI);
 		break;
 	case MLX5E_PORT_BNC:
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, BNC);
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising, BNC);
+		ethtool_ks_add_mode(link_ksettings, supported, BNC);
+		ethtool_ks_add_mode(link_ksettings, advertising, BNC);
 		break;
 	case MLX5E_PORT_MII:
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, MII);
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising, MII);
+		ethtool_ks_add_mode(link_ksettings, supported, MII);
+		ethtool_ks_add_mode(link_ksettings, advertising, MII);
 		break;
 	case MLX5E_PORT_FIBRE:
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, FIBRE);
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising, FIBRE);
+		ethtool_ks_add_mode(link_ksettings, supported, FIBRE);
+		ethtool_ks_add_mode(link_ksettings, advertising, FIBRE);
 		break;
 	case MLX5E_PORT_DA:
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, Backplane);
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     advertising, Backplane);
+		ethtool_ks_add_mode(link_ksettings, supported, Backplane);
+		ethtool_ks_add_mode(link_ksettings, advertising, Backplane);
 		break;
 	case MLX5E_PORT_NONE:
 	case MLX5E_PORT_OTHER:
@@ -665,7 +647,7 @@ static void get_supported(u32 eth_proto_cap,
 	unsigned long *supported = link_ksettings->link_modes.supported;
 
 	ptys2ethtool_supported_link(supported, eth_proto_cap);
-	ethtool_link_ksettings_add_link_mode(link_ksettings, supported, Pause);
+	ethtool_ks_add_mode(link_ksettings, supported, Pause);
 }
 
 static void get_advertising(u32 eth_proto_cap, u8 tx_pause,
@@ -676,9 +658,9 @@ static void get_advertising(u32 eth_proto_cap, u8 tx_pause,
 
 	ptys2ethtool_adver_link(advertising, eth_proto_cap);
 	if (rx_pause)
-		ethtool_link_ksettings_add_link_mode(link_ksettings, advertising, Pause);
+		ethtool_ks_add_mode(link_ksettings, advertising, Pause);
 	if (tx_pause ^ rx_pause)
-		ethtool_link_ksettings_add_link_mode(link_ksettings, advertising, Asym_Pause);
+		ethtool_ks_add_mode(link_ksettings, advertising, Asym_Pause);
 }
 
 static int ptys2connector_type[MLX5E_CONNECTOR_TYPE_NUMBER] = {
@@ -766,8 +748,8 @@ static int mlx5e_get_link_ksettings(struct net_device *netdev,
 
 	mlx5_query_port_pause(mdev, &rx_pause, &tx_pause);
 
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, supported);
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, advertising);
+	ethtool_ks_clear(link_ksettings, supported);
+	ethtool_ks_clear(link_ksettings, advertising);
 
 	get_supported(eth_proto_cap, link_ksettings);
 	get_advertising(eth_proto_admin, tx_pause, rx_pause, link_ksettings);
@@ -782,16 +764,13 @@ static int mlx5e_get_link_ksettings(struct net_device *netdev,
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
index 90cb50fe17fd..60c095585b5b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
@@ -217,8 +217,8 @@ static int mlx5i_get_link_ksettings(struct net_device *netdev,
 	if (ret)
 		return ret;
 
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, supported);
-	ethtool_link_ksettings_zero_link_mode(link_ksettings, advertising);
+	ethtool_ks_clear(link_ksettings, supported);
+	ethtool_ks_clear(link_ksettings, advertising);
 
 	speed = mlx5i_get_speed_settings(ib_link_width_oper, ib_proto_oper);
 	if (speed < 0)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 94132f6cec61..bd227e8d90a0 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2243,14 +2243,14 @@ mlxsw_sp_from_ptys_supported_port(u32 ptys_eth_proto,
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
@@ -2349,9 +2349,9 @@ static u32 mlxsw_sp_to_ptys_upper_speed(u32 upper_speed)
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
@@ -2363,7 +2363,7 @@ static void mlxsw_sp_port_get_link_advertise(u32 eth_proto_admin, bool autoneg,
 	if (!autoneg)
 		return;
 
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, Autoneg);
+	ethtool_ks_add_mode(cmd, advertising, Autoneg);
 	mlxsw_sp_from_ptys_link(eth_proto_admin, cmd->link_modes.advertising);
 }
 
@@ -2374,7 +2374,7 @@ mlxsw_sp_port_get_link_lp_advertise(u32 eth_proto_lp, u8 autoneg_status,
 	if (autoneg_status != MLXSW_REG_PTYS_AN_STATUS_OK || !eth_proto_lp)
 		return;
 
-	ethtool_link_ksettings_add_link_mode(cmd, lp_advertising, Autoneg);
+	ethtool_ks_add_mode(cmd, lp_advertising, Autoneg);
 	mlxsw_sp_from_ptys_link(eth_proto_lp, cmd->link_modes.lp_advertising);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/switchx2.c b/drivers/net/ethernet/mellanox/mlxsw/switchx2.c
index a655c5850aa6..bb11aadfd8c6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/switchx2.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/switchx2.c
@@ -809,12 +809,9 @@ mlxsw_sx_port_get_link_ksettings(struct net_device *dev,
 	cmd->base.port = mlxsw_sx_port_connector_port(eth_proto_oper);
 	lp_advertising = mlxsw_sx_from_ptys_advert_link(eth_proto_oper);
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.lp_advertising,
-						lp_advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
+	ethtool_u32_to_ks(cmd->link_modes.lp_advertising, lp_advertising);
 
 	return 0;
 }
@@ -872,8 +869,7 @@ mlxsw_sx_port_set_link_ksettings(struct net_device *dev,
 
 	speed = cmd->base.speed;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	eth_proto_new = cmd->base.autoneg == AUTONEG_ENABLE ?
 		mlxsw_sx_to_ptys_advert_link(advertising) :
diff --git a/drivers/net/ethernet/micrel/ks8695net.c b/drivers/net/ethernet/micrel/ks8695net.c
index bd51e057e915..a0de2002eb36 100644
--- a/drivers/net/ethernet/micrel/ks8695net.c
+++ b/drivers/net/ethernet/micrel/ks8695net.c
@@ -905,10 +905,8 @@ ks8695_wan_get_link_ksettings(struct net_device *ndev,
 			DUPLEX_FULL : DUPLEX_HALF;
 	}
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -926,8 +924,7 @@ ks8695_wan_set_link_ksettings(struct net_device *ndev,
 	u32 ctrl;
 	u32 advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	if ((cmd->base.speed != SPEED_10) && (cmd->base.speed != SPEED_100))
 		return -EINVAL;
diff --git a/drivers/net/ethernet/micrel/ksz884x.c b/drivers/net/ethernet/micrel/ksz884x.c
index 52207508744c..b9f1bdaf0956 100644
--- a/drivers/net/ethernet/micrel/ksz884x.c
+++ b/drivers/net/ethernet/micrel/ksz884x.c
@@ -5959,12 +5959,11 @@ static int netdev_get_link_ksettings(struct net_device *dev,
 
 	mutex_lock(&hw_priv->lock);
 	mii_ethtool_get_link_ksettings(&priv->mii_if, cmd);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
+	ethtool_ks_add_mode(cmd, advertising, TP);
 	mutex_unlock(&hw_priv->lock);
 
 	/* Save advertised settings for workaround in next function. */
-	ethtool_convert_link_mode_to_legacy_u32(&priv->advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&priv->advertising, cmd->link_modes.advertising);
 
 	return 0;
 }
@@ -5989,8 +5988,7 @@ static int netdev_set_link_ksettings(struct net_device *dev,
 	u32 advertising;
 	int rc;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	/*
 	 * ethtool utility does not change advertised setting if auto
@@ -6032,8 +6030,7 @@ static int netdev_set_link_ksettings(struct net_device *dev,
 	}
 
 	memcpy(&copy_cmd, cmd, sizeof(copy_cmd));
-	ethtool_convert_legacy_u32_to_link_mode(copy_cmd.link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(copy_cmd.link_modes.advertising, advertising);
 	rc = mii_ethtool_set_link_ksettings(
 		&priv->mii_if,
 		(const struct ethtool_link_ksettings *)&copy_cmd);
diff --git a/drivers/net/ethernet/microchip/enc28j60.c b/drivers/net/ethernet/microchip/enc28j60.c
index f6ecfa778660..3ab7779a594e 100644
--- a/drivers/net/ethernet/microchip/enc28j60.c
+++ b/drivers/net/ethernet/microchip/enc28j60.c
@@ -1492,10 +1492,10 @@ enc28j60_get_link_ksettings(struct net_device *dev,
 {
 	struct enc28j60_net *priv = netdev_priv(dev);
 
-	ethtool_link_ksettings_zero_link_mode(cmd, supported);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, 10baseT_Half);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, 10baseT_Full);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
+	ethtool_ks_clear(cmd, supported);
+	ethtool_ks_add_mode(cmd, supported, 10baseT_Half);
+	ethtool_ks_add_mode(cmd, supported, 10baseT_Full);
+	ethtool_ks_add_mode(cmd, supported, TP);
 
 	cmd->base.speed = SPEED_10;
 	cmd->base.duplex = priv->full_duplex ? DUPLEX_FULL : DUPLEX_HALF;
diff --git a/drivers/net/ethernet/microchip/encx24j600.c b/drivers/net/ethernet/microchip/encx24j600.c
index f831238d9793..fe32166bff0d 100644
--- a/drivers/net/ethernet/microchip/encx24j600.c
+++ b/drivers/net/ethernet/microchip/encx24j600.c
@@ -950,8 +950,7 @@ static int encx24j600_get_link_ksettings(struct net_device *dev,
 			 SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full |
 			 SUPPORTED_Autoneg | SUPPORTED_TP;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
 
 	cmd->base.speed = priv->speed;
 	cmd->base.duplex = priv->full_duplex ? DUPLEX_FULL : DUPLEX_HALF;
diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index b2d2ec8c11e2..6319e0e389f8 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -1645,8 +1645,8 @@ myri10ge_get_link_ksettings(struct net_device *netdev,
 	if (*ptr == 'R' || *ptr == 'Q' || *ptr == 'S') {
 		/* We've found either an XFP, quad ribbon fiber, or SFP+ */
 		cmd->base.port = PORT_FIBRE;
-		ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
+		ethtool_ks_add_mode(cmd, supported, FIBRE);
+		ethtool_ks_add_mode(cmd, advertising, FIBRE);
 	} else {
 		cmd->base.port = PORT_OTHER;
 	}
diff --git a/drivers/net/ethernet/natsemi/natsemi.c b/drivers/net/ethernet/natsemi/natsemi.c
index b9a1a9f999ea..406e6b1d14c6 100644
--- a/drivers/net/ethernet/natsemi/natsemi.c
+++ b/drivers/net/ethernet/natsemi/natsemi.c
@@ -2905,10 +2905,8 @@ static int netdev_get_ecmd(struct net_device *dev,
 
 	/* ignore maxtxpkt, maxrxpkt for now */
 
-	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(ecmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(ecmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -2919,8 +2917,7 @@ static int netdev_set_ecmd(struct net_device *dev,
 	struct netdev_private *np = netdev_priv(dev);
 	u32 advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						ecmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, ecmd->link_modes.advertising);
 
 	if (ecmd->base.port != PORT_TP &&
 	    ecmd->base.port != PORT_MII &&
diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
index 958fced4dacf..b8dda53b5446 100644
--- a/drivers/net/ethernet/natsemi/ns83820.c
+++ b/drivers/net/ethernet/natsemi/ns83820.c
@@ -1263,8 +1263,7 @@ static int ns83820_get_link_ksettings(struct net_device *ndev,
 		cmd->base.port = PORT_MII;
 	}
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
 
 	cmd->base.duplex = fullduplex ? DUPLEX_FULL : DUPLEX_HALF;
 	switch (cfg / CFG_SPDSTS0 & 3) {
diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index b8983e73265a..0c83278e380a 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -5300,13 +5300,13 @@ s2io_ethtool_get_link_ksettings(struct net_device *dev,
 {
 	struct s2io_nic *sp = netdev_priv(dev);
 
-	ethtool_link_ksettings_zero_link_mode(cmd, supported);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, 10000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
+	ethtool_ks_clear(cmd, supported);
+	ethtool_ks_add_mode(cmd, supported, 10000baseT_Full);
+	ethtool_ks_add_mode(cmd, supported, FIBRE);
 
-	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, 10000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
+	ethtool_ks_clear(cmd, advertising);
+	ethtool_ks_add_mode(cmd, advertising, 10000baseT_Full);
+	ethtool_ks_add_mode(cmd, advertising, FIBRE);
 
 	cmd->base.port = PORT_FIBRE;
 
diff --git a/drivers/net/ethernet/neterion/vxge/vxge-ethtool.c b/drivers/net/ethernet/neterion/vxge/vxge-ethtool.c
index 0452848d1316..0f1522812373 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-ethtool.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-ethtool.c
@@ -74,13 +74,13 @@ vxge_ethtool_set_link_ksettings(struct net_device *dev,
 static int vxge_ethtool_get_link_ksettings(struct net_device *dev,
 					   struct ethtool_link_ksettings *cmd)
 {
-	ethtool_link_ksettings_zero_link_mode(cmd, supported);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, 10000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
+	ethtool_ks_clear(cmd, supported);
+	ethtool_ks_add_mode(cmd, supported, 10000baseT_Full);
+	ethtool_ks_add_mode(cmd, supported, FIBRE);
 
-	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, 10000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
+	ethtool_ks_clear(cmd, advertising);
+	ethtool_ks_add_mode(cmd, advertising, 10000baseT_Full);
+	ethtool_ks_add_mode(cmd, advertising, FIBRE);
 
 	cmd->base.port = PORT_FIBRE;
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
index c9016419bfa0..bd2466c45a72 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
@@ -248,21 +248,21 @@ nfp_net_set_fec_link_mode(struct nfp_eth_table_port *eth_port,
 {
 	unsigned int modes;
 
-	ethtool_link_ksettings_add_link_mode(c, supported, FEC_NONE);
+	ethtool_ks_add_mode(c, supported, FEC_NONE);
 	if (!nfp_eth_can_support_fec(eth_port)) {
-		ethtool_link_ksettings_add_link_mode(c, advertising, FEC_NONE);
+		ethtool_ks_add_mode(c, advertising, FEC_NONE);
 		return;
 	}
 
 	modes = nfp_eth_supported_fec_modes(eth_port);
 	if (modes & NFP_FEC_BASER) {
-		ethtool_link_ksettings_add_link_mode(c, supported, FEC_BASER);
-		ethtool_link_ksettings_add_link_mode(c, advertising, FEC_BASER);
+		ethtool_ks_add_mode(c, supported, FEC_BASER);
+		ethtool_ks_add_mode(c, advertising, FEC_BASER);
 	}
 
 	if (modes & NFP_FEC_REED_SOLOMON) {
-		ethtool_link_ksettings_add_link_mode(c, supported, FEC_RS);
-		ethtool_link_ksettings_add_link_mode(c, advertising, FEC_RS);
+		ethtool_ks_add_mode(c, supported, FEC_RS);
+		ethtool_ks_add_mode(c, advertising, FEC_RS);
 	}
 }
 
@@ -293,7 +293,7 @@ nfp_net_get_link_ksettings(struct net_device *netdev,
 	u32 sts, ls;
 
 	/* Init to unknowns */
-	ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
+	ethtool_ks_add_mode(cmd, supported, FIBRE);
 	cmd->base.port = PORT_OTHER;
 	cmd->base.speed = SPEED_UNKNOWN;
 	cmd->base.duplex = DUPLEX_UNKNOWN;
diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index 66c665d0b926..ad38071fd41a 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -4333,10 +4333,8 @@ static int nv_get_link_ksettings(struct net_device *dev,
 
 	cmd->base.phy_address = np->phyaddr;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	/* ignore maxtxpkt, maxrxpkt for now */
 	spin_unlock_irq(&np->lock);
@@ -4350,8 +4348,7 @@ static int nv_set_link_ksettings(struct net_device *dev,
 	u32 speed = cmd->base.speed;
 	u32 advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	if (cmd->base.port != PORT_MII)
 		return -EINVAL;
diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c
index 731ce1e419e4..980c42f0d37c 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c
@@ -88,18 +88,14 @@ static int pch_gbe_get_link_ksettings(struct net_device *netdev,
 
 	mii_ethtool_get_link_ksettings(&adapter->mii, ecmd);
 
-	ethtool_convert_link_mode_to_legacy_u32(&supported,
-						ecmd->link_modes.supported);
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						ecmd->link_modes.advertising);
+	ethtool_ks_to_u32(&supported, ecmd->link_modes.supported);
+	ethtool_ks_to_u32(&advertising, ecmd->link_modes.advertising);
 
 	supported &= ~(SUPPORTED_TP | SUPPORTED_1000baseT_Half);
 	advertising &= ~(ADVERTISED_TP | ADVERTISED_1000baseT_Half);
 
-	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(ecmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(ecmd->link_modes.advertising, advertising);
 
 	if (!netif_carrier_ok(adapter->netdev))
 		ecmd->base.speed = SPEED_UNKNOWN;
@@ -143,8 +139,7 @@ static int pch_gbe_set_link_ksettings(struct net_device *netdev,
 	}
 	hw->mac.link_speed = speed;
 	hw->mac.link_duplex = copy_ecmd.base.duplex;
-	ethtool_convert_link_mode_to_legacy_u32(
-		&advertising, copy_ecmd.link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, copy_ecmd.link_modes.advertising);
 	hw->phy.autoneg_advertised = advertising;
 	hw->mac.autoneg = copy_ecmd.base.autoneg;
 
diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ethtool.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_ethtool.c
index 3157f97dd782..1c0a7669532b 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ethtool.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_ethtool.c
@@ -250,10 +250,8 @@ netxen_nic_get_link_ksettings(struct net_device *dev,
 		cmd->base.speed = SPEED_UNKNOWN;
 	}
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index ecbf1ded7a39..7f90c78f8b57 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -448,13 +448,13 @@ static int qede_get_link_ksettings(struct net_device *dev,
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
diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index b48f76182049..e91566a5438b 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -1726,10 +1726,8 @@ static int ql_get_link_ksettings(struct net_device *ndev,
 	cmd->base.speed = ql_get_speed(qdev);
 	cmd->base.duplex = ql_get_full_dup(qdev);
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
index 97c146e7698a..27d883d83533 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
@@ -3323,8 +3323,7 @@ int qlcnic_83xx_get_link_ksettings(struct qlcnic_adapter *adapter,
 			   SUPPORTED_10000baseT_Full |
 			   SUPPORTED_Autoneg);
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						ecmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, ecmd->link_modes.advertising);
 
 	if (ecmd->base.autoneg == AUTONEG_ENABLE) {
 		if (ahw->port_config & QLC_83XX_10_CAPABLE)
@@ -3381,10 +3380,8 @@ int qlcnic_83xx_get_link_ksettings(struct qlcnic_adapter *adapter,
 	}
 	ecmd->base.phy_address = ahw->physical_port;
 
-	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(ecmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(ecmd->link_modes.advertising, advertising);
 
 	return status;
 }
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
index 7f7deeaf1cf0..7e582c817259 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
@@ -424,10 +424,8 @@ static int qlcnic_82xx_get_link_ksettings(struct qlcnic_adapter *adapter,
 		}
 	}
 
-	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(ecmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(ecmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/qlogic/qlge/qlge_ethtool.c b/drivers/net/ethernet/qlogic/qlge/qlge_ethtool.c
index 5edbd532127d..a10767ecead6 100644
--- a/drivers/net/ethernet/qlogic/qlge/qlge_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qlge/qlge_ethtool.c
@@ -400,10 +400,8 @@ static int ql_get_link_ksettings(struct net_device *ndev,
 	ecmd->base.speed = SPEED_10000;
 	ecmd->base.duplex = DUPLEX_FULL;
 
-	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(ecmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(ecmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ethernet/qualcomm/qca_debug.c
index 51d89c86e60f..dd769b719c51 100644
--- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -191,8 +191,8 @@ static int
 qcaspi_get_link_ksettings(struct net_device *dev,
 			  struct ethtool_link_ksettings *cmd)
 {
-	ethtool_link_ksettings_zero_link_mode(cmd, supported);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, 10baseT_Half);
+	ethtool_ks_clear(cmd, supported);
+	ethtool_ks_add_mode(cmd, supported, 10baseT_Half);
 
 	cmd->base.speed = SPEED_10;
 	cmd->base.duplex = DUPLEX_HALF;
diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 2c2f0c5b3f94..8d0ebd2c85c1 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -1958,10 +1958,8 @@ static int rtl8169_get_link_ksettings_tbi(struct net_device *dev,
 	cmd->base.speed = SPEED_1000;
 	cmd->base.duplex = DUPLEX_FULL; /* Always set */
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -1996,8 +1994,7 @@ static int rtl8169_set_link_ksettings(struct net_device *dev,
 	int rc;
 	u32 advertising;
 
-	if (!ethtool_convert_link_mode_to_legacy_u32(&advertising,
-	    cmd->link_modes.advertising))
+	if (!ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising))
 		return -EINVAL;
 
 	del_timer_sync(&tp->timer);
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index e73e4febeedb..fc8be30aecd0 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1139,8 +1139,8 @@ rocker_cmd_get_port_settings_ethtool_proc(const struct rocker_port *rocker_port,
 	duplex = rocker_tlv_get_u8(info_attrs[ROCKER_TLV_CMD_PORT_SETTINGS_DUPLEX]);
 	autoneg = rocker_tlv_get_u8(info_attrs[ROCKER_TLV_CMD_PORT_SETTINGS_AUTONEG]);
 
-	ethtool_link_ksettings_zero_link_mode(ecmd, supported);
-	ethtool_link_ksettings_add_link_mode(ecmd, supported, TP);
+	ethtool_ks_clear(ecmd, supported);
+	ethtool_ks_add_mode(ecmd, supported, TP);
 
 	ecmd->base.phy_address = 0xff;
 	ecmd->base.port = PORT_TP;
diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index 3143588ffd77..89f06c170134 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -138,13 +138,11 @@ efx_ethtool_get_link_ksettings(struct net_device *net_dev,
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
diff --git a/drivers/net/ethernet/sfc/falcon/ethtool.c b/drivers/net/ethernet/sfc/falcon/ethtool.c
index 56049157a5af..230cccfb656b 100644
--- a/drivers/net/ethernet/sfc/falcon/ethtool.c
+++ b/drivers/net/ethernet/sfc/falcon/ethtool.c
@@ -127,8 +127,8 @@ ef4_ethtool_get_link_ksettings(struct net_device *net_dev,
 	mutex_unlock(&efx->mac_lock);
 
 	/* Both MACs support pause frames (bidirectional and respond-only) */
-	ethtool_link_ksettings_add_link_mode(cmd, supported, Pause);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, Asym_Pause);
+	ethtool_ks_add_mode(cmd, supported, Pause);
+	ethtool_ks_add_mode(cmd, supported, Asym_Pause);
 
 	if (LOOPBACK_INTERNAL(efx)) {
 		cmd->base.speed = link_state->speed;
diff --git a/drivers/net/ethernet/sfc/falcon/mdio_10g.c b/drivers/net/ethernet/sfc/falcon/mdio_10g.c
index ee0713f03d01..58f350c4113d 100644
--- a/drivers/net/ethernet/sfc/falcon/mdio_10g.c
+++ b/drivers/net/ethernet/sfc/falcon/mdio_10g.c
@@ -241,12 +241,9 @@ int ef4_mdio_set_link_ksettings(struct ef4_nic *efx,
 
 	efx->phy_op->get_link_ksettings(efx, &prev);
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
-	ethtool_convert_link_mode_to_legacy_u32(&prev_advertising,
-						prev.link_modes.advertising);
-	ethtool_convert_link_mode_to_legacy_u32(&prev_supported,
-						prev.link_modes.supported);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&prev_advertising, prev.link_modes.advertising);
+	ethtool_ks_to_u32(&prev_supported, prev.link_modes.supported);
 
 	if (advertising == prev_advertising &&
 	    cmd->base.speed == prev.base.speed &&
diff --git a/drivers/net/ethernet/silan/sc92031.c b/drivers/net/ethernet/silan/sc92031.c
index c07fd594fe71..c1b843987397 100644
--- a/drivers/net/ethernet/silan/sc92031.c
+++ b/drivers/net/ethernet/silan/sc92031.c
@@ -1178,10 +1178,8 @@ sc92031_ethtool_get_link_ksettings(struct net_device *dev,
 	cmd->base.autoneg = (phy_ctrl & PhyCtrlAne) ?
 		AUTONEG_ENABLE : AUTONEG_DISABLE;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -1197,8 +1195,7 @@ sc92031_ethtool_set_link_ksettings(struct net_device *dev,
 	u32 old_phy_ctrl;
 	u32 advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	if (!(speed == SPEED_10 || speed == SPEED_100))
 		return -EINVAL;
diff --git a/drivers/net/ethernet/smsc/smc911x.c b/drivers/net/ethernet/smsc/smc911x.c
index 05157442a980..6113e3644b7f 100644
--- a/drivers/net/ethernet/smsc/smc911x.c
+++ b/drivers/net/ethernet/smsc/smc911x.c
@@ -1477,8 +1477,7 @@ smc911x_ethtool_get_link_ksettings(struct net_device *dev,
 			(status & (PHY_SPECIAL_SPD_10FULL_ | PHY_SPECIAL_SPD_100FULL_)) ?
 				DUPLEX_FULL : DUPLEX_HALF;
 
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.supported, supported);
+		ethtool_u32_to_ks(cmd->link_modes.supported, supported);
 
 	}
 
diff --git a/drivers/net/ethernet/smsc/smc91c92_cs.c b/drivers/net/ethernet/smsc/smc91c92_cs.c
index a55f430f6a7b..49e5d9e1b6e3 100644
--- a/drivers/net/ethernet/smsc/smc91c92_cs.c
+++ b/drivers/net/ethernet/smsc/smc91c92_cs.c
@@ -1863,8 +1863,7 @@ static void smc_netdev_get_ecmd(struct net_device *dev,
 	tmp = inw(ioaddr + TCR);
 	ecmd->base.duplex = (tmp & TCR_FDUPLX) ? DUPLEX_FULL : DUPLEX_HALF;
 
-	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.supported,
-						supported);
+	ethtool_u32_to_ks(ecmd->link_modes.supported, supported);
 }
 
 static int smc_netdev_set_ecmd(struct net_device *dev,
diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 080428762858..f253b3926733 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -1559,8 +1559,7 @@ smc_ethtool_get_link_ksettings(struct net_device *dev,
 		cmd->base.duplex = lp->tcr_cur_mode & TCR_SWFDUP ?
 			DUPLEX_FULL : DUPLEX_HALF;
 
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.supported, supported);
+		ethtool_u32_to_ks(cmd->link_modes.supported, supported);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 6d82b3ef5c3b..0e24f3404235 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -296,12 +296,10 @@ static int stmmac_ethtool_get_link_ksettings(struct net_device *dev,
 
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
@@ -343,12 +341,10 @@ static int stmmac_ethtool_get_link_ksettings(struct net_device *dev,
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
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index 9020b084b953..9c2e0653b51b 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -4633,10 +4633,8 @@ static int cas_get_link_ksettings(struct net_device *dev,
 		}
 	}
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 88c12474a0c3..d416f10ea92c 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -6819,10 +6819,8 @@ static int niu_get_link_ksettings(struct net_device *dev,
 
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->base.phy_address = np->phy_addr;
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						lp->supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						lp->active_advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, lp->supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, lp->active_advertising);
 	cmd->base.autoneg = lp->active_autoneg;
 	cmd->base.speed = lp->active_speed;
 	cmd->base.duplex = lp->active_duplex;
@@ -6837,8 +6835,7 @@ static int niu_set_link_ksettings(struct net_device *dev,
 	struct niu *np = netdev_priv(dev);
 	struct niu_link_config *lp = &np->link_config;
 
-	ethtool_convert_link_mode_to_legacy_u32(&lp->advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&lp->advertising, cmd->link_modes.advertising);
 	lp->speed = cmd->base.speed;
 	lp->duplex = cmd->base.duplex;
 	lp->autoneg = cmd->base.autoneg;
diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 7a16d40a72d1..1186d42e0944 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -1261,8 +1261,7 @@ static void gem_begin_auto_negotiation(struct gem *gp,
 	u32 advertising;
 
 	if (ep)
-		ethtool_convert_link_mode_to_legacy_u32(
-			&advertising, ep->link_modes.advertising);
+		ethtool_ks_to_u32(&advertising, ep->link_modes.advertising);
 
 	if (gp->phy_type != phy_mii_mdio0 &&
      	    gp->phy_type != phy_mii_mdio1)
@@ -2579,10 +2578,8 @@ static int gem_get_link_ksettings(struct net_device *dev,
 		}
 	}
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
@@ -2594,8 +2591,7 @@ static int gem_set_link_ksettings(struct net_device *dev,
 	u32 speed = cmd->base.speed;
 	u32 advertising;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	/* Verify the settings we care about. */
 	if (cmd->base.autoneg != AUTONEG_ENABLE &&
diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/sunhme.c
index 06da2f59fcbf..8011ee4e0b17 100644
--- a/drivers/net/ethernet/sun/sunhme.c
+++ b/drivers/net/ethernet/sun/sunhme.c
@@ -2476,8 +2476,7 @@ static int hme_get_link_ksettings(struct net_device *dev,
 			DUPLEX_FULL : DUPLEX_HALF;
 	}
 	cmd->base.speed = speed;
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/tehuti/tehuti.c b/drivers/net/ethernet/tehuti/tehuti.c
index 163d8d16bc24..ba90104c4326 100644
--- a/drivers/net/ethernet/tehuti/tehuti.c
+++ b/drivers/net/ethernet/tehuti/tehuti.c
@@ -2133,14 +2133,12 @@ static const char
 static int bdx_get_link_ksettings(struct net_device *netdev,
 				  struct ethtool_link_ksettings *ecmd)
 {
-	ethtool_link_ksettings_zero_link_mode(ecmd, supported);
-	ethtool_link_ksettings_add_link_mode(ecmd, supported,
-					     10000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(ecmd, supported, FIBRE);
-	ethtool_link_ksettings_zero_link_mode(ecmd, advertising);
-	ethtool_link_ksettings_add_link_mode(ecmd, advertising,
-					     10000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(ecmd, advertising, FIBRE);
+	ethtool_ks_clear(ecmd, supported);
+	ethtool_ks_add_mode(ecmd, supported, 10000baseT_Full);
+	ethtool_ks_add_mode(ecmd, supported, FIBRE);
+	ethtool_ks_clear(ecmd, advertising);
+	ethtool_ks_add_mode(ecmd, advertising, 10000baseT_Full);
+	ethtool_ks_add_mode(ecmd, advertising, FIBRE);
 
 	ecmd->base.speed = SPEED_10000;
 	ecmd->base.duplex = DUPLEX_FULL;
diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 6a728d35e776..e10b3527e9f0 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -1969,10 +1969,8 @@ static int keystone_set_link_ksettings(struct net_device *ndev,
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
diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index 88d74aef218a..6c4c07ddd97f 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -1248,10 +1248,8 @@ static int gelic_ether_get_link_ksettings(struct net_device *netdev,
 	}
 	cmd->base.port = PORT_TP;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/toshiba/spider_net_ethtool.c b/drivers/net/ethernet/toshiba/spider_net_ethtool.c
index 16bd036d0682..9865e0055f66 100644
--- a/drivers/net/ethernet/toshiba/spider_net_ethtool.c
+++ b/drivers/net/ethernet/toshiba/spider_net_ethtool.c
@@ -53,13 +53,13 @@ spider_net_ethtool_get_link_ksettings(struct net_device *netdev,
 	struct spider_net_card *card;
 	card = netdev_priv(netdev);
 
-	ethtool_link_ksettings_zero_link_mode(cmd, supported);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, 1000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
+	ethtool_ks_clear(cmd, supported);
+	ethtool_ks_add_mode(cmd, supported, 1000baseT_Full);
+	ethtool_ks_add_mode(cmd, supported, FIBRE);
 
-	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, 1000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
+	ethtool_ks_clear(cmd, advertising);
+	ethtool_ks_add_mode(cmd, advertising, 1000baseT_Full);
+	ethtool_ks_add_mode(cmd, advertising, FIBRE);
 
 	cmd->base.port = PORT_FIBRE;
 	cmd->base.speed = card->phy.speed;
diff --git a/drivers/net/ethernet/via/via-velocity.c b/drivers/net/ethernet/via/via-velocity.c
index ef9538ee53d0..38da243dcf09 100644
--- a/drivers/net/ethernet/via/via-velocity.c
+++ b/drivers/net/ethernet/via/via-velocity.c
@@ -3358,10 +3358,8 @@ static int velocity_get_link_ksettings(struct net_device *dev,
 	else
 		cmd->base.duplex = DUPLEX_HALF;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
 
 	return 0;
 }
diff --git a/drivers/net/fjes/fjes_ethtool.c b/drivers/net/fjes/fjes_ethtool.c
index 7d101714c2ef..37c9b868960d 100644
--- a/drivers/net/fjes/fjes_ethtool.c
+++ b/drivers/net/fjes/fjes_ethtool.c
@@ -178,8 +178,8 @@ static void fjes_get_drvinfo(struct net_device *netdev,
 static int fjes_get_link_ksettings(struct net_device *netdev,
 				   struct ethtool_link_ksettings *ecmd)
 {
-	ethtool_link_ksettings_zero_link_mode(ecmd, supported);
-	ethtool_link_ksettings_zero_link_mode(ecmd, advertising);
+	ethtool_ks_clear(ecmd, supported);
+	ethtool_ks_clear(ecmd, advertising);
 	ecmd->base.duplex = DUPLEX_FULL;
 	ecmd->base.autoneg = AUTONEG_DISABLE;
 	ecmd->base.port = PORT_NONE;
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index da07ccdf84bf..cf2ef960df4f 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -975,7 +975,7 @@ netvsc_validate_ethtool_ss_cmd(const struct ethtool_link_ksettings *cmd)
 	diff1.base.speed = 0;
 	diff1.base.duplex = 0;
 	/* advertising and cmd are usually set */
-	ethtool_link_ksettings_zero_link_mode(&diff1, advertising);
+	ethtool_ks_clear(&diff1, advertising);
 	diff1.base.cmd = 0;
 	/* We set port to PORT_OTHER */
 	diff2.base.port = PORT_OTHER;
diff --git a/drivers/net/mdio.c b/drivers/net/mdio.c
index 077364cbf439..6eb0a793743a 100644
--- a/drivers/net/mdio.c
+++ b/drivers/net/mdio.c
@@ -493,12 +493,9 @@ void mdio45_ethtool_ksettings_get_npage(const struct mdio_if_info *mdio,
 
 	cmd->base.speed = speed;
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.lp_advertising,
-						lp_advertising);
+	ethtool_u32_to_ks(cmd->link_modes.supported, supported);
+	ethtool_u32_to_ks(cmd->link_modes.advertising, advertising);
+	ethtool_u32_to_ks(cmd->link_modes.lp_advertising, lp_advertising);
 
 	/* 10GBASE-T MDI/MDI-X */
 	if (cmd->base.port == PORT_TP && (cmd->base.speed == SPEED_10000)) {
diff --git a/drivers/net/mii.c b/drivers/net/mii.c
index 44612122338b..76d7f7284083 100644
--- a/drivers/net/mii.c
+++ b/drivers/net/mii.c
@@ -217,12 +217,9 @@ void mii_ethtool_get_link_ksettings(struct mii_if_info *mii,
 
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
 }
@@ -355,8 +352,7 @@ int mii_ethtool_set_link_ksettings(struct mii_if_info *mii,
 		u32 advert2 = 0, tmp2 = 0;
 		u32 advertising;
 
-		ethtool_convert_link_mode_to_legacy_u32(
-			&advertising, cmd->link_modes.advertising);
+		ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 		if ((advertising & (ADVERTISED_10baseT_Half |
 				    ADVERTISED_10baseT_Full |
diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 9f6f7ccd44f7..8d7bf9fb9691 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -375,10 +375,10 @@ static void ntb_get_drvinfo(struct net_device *ndev,
 static int ntb_get_link_ksettings(struct net_device *dev,
 				  struct ethtool_link_ksettings *cmd)
 {
-	ethtool_link_ksettings_zero_link_mode(cmd, supported);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, Backplane);
-	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, Backplane);
+	ethtool_ks_clear(cmd, supported);
+	ethtool_ks_add_mode(cmd, supported, Backplane);
+	ethtool_ks_clear(cmd, advertising);
+	ethtool_ks_add_mode(cmd, advertising, Backplane);
 
 	cmd->base.speed = SPEED_UNKNOWN;
 	cmd->base.duplex = DUPLEX_FULL;
diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index f77a2d9e7f9d..09d792693b8d 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -336,7 +336,7 @@ static int mv3310_config_init(struct phy_device *phydev)
 		}
 	}
 
-	if (!ethtool_convert_link_mode_to_legacy_u32(&mask, supported))
+	if (!ethtool_ks_to_u32(&mask, supported))
 		dev_warn(&phydev->mdio.dev,
 			 "PHY supports (%*pb) more modes than phylib supports, some modes not supported.\n",
 			 __ETHTOOL_LINK_MODE_MASK_NBITS, supported);
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 05c1e8ef15e6..58212c032aa1 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -312,8 +312,7 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 	if (cmd->base.phy_address != phydev->mdio.addr)
 		return -EINVAL;
 
-	ethtool_convert_link_mode_to_legacy_u32(&advertising,
-						cmd->link_modes.advertising);
+	ethtool_ks_to_u32(&advertising, cmd->link_modes.advertising);
 
 	/* We make sure that we don't pass unsupported values in to the PHY */
 	advertising &= phydev->supported;
@@ -358,14 +357,12 @@ EXPORT_SYMBOL(phy_ethtool_ksettings_set);
 void phy_ethtool_ksettings_get(struct phy_device *phydev,
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
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 581ce93ecaf9..a6ddaef51f67 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -665,9 +665,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy)
 	int ret;
 
 	memset(&config, 0, sizeof(config));
-	ethtool_convert_legacy_u32_to_link_mode(supported, phy->supported);
-	ethtool_convert_legacy_u32_to_link_mode(config.advertising,
-						phy->advertising);
+	ethtool_u32_to_ks(supported, phy->supported);
+	ethtool_u32_to_ks(config.advertising, phy->advertising);
 	config.interface = pl->link_config.interface;
 
 	/*
@@ -700,7 +699,7 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy)
 	linkmode_copy(pl->link_config.advertising, config.advertising);
 
 	/* Restrict the phy advertisement according to the MAC support. */
-	ethtool_convert_link_mode_to_legacy_u32(&advertising, config.advertising);
+	ethtool_ks_to_u32(&advertising, config.advertising);
 	phy->advertising = advertising;
 	mutex_unlock(&pl->state_mutex);
 	mutex_unlock(&phy->lock);
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 44d4f3d25350..7a03ef50d9db 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3307,8 +3307,8 @@ static struct miscdevice tun_miscdev = {
 static int tun_get_link_ksettings(struct net_device *dev,
 				  struct ethtool_link_ksettings *cmd)
 {
-	ethtool_link_ksettings_zero_link_mode(cmd, supported);
-	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
+	ethtool_ks_clear(cmd, supported);
+	ethtool_ks_clear(cmd, advertising);
 	cmd->base.speed		= SPEED_10;
 	cmd->base.duplex	= DUPLEX_FULL;
 	cmd->base.port		= PORT_TP;
diff --git a/drivers/net/usb/catc.c b/drivers/net/usb/catc.c
index 18d36dff97ea..0a7079195bf2 100644
--- a/drivers/net/usb/catc.c
+++ b/drivers/net/usb/catc.c
@@ -695,13 +695,13 @@ static int catc_get_link_ksettings(struct net_device *dev,
 	if (!catc->is_f5u011)
 		return -EOPNOTSUPP;
 
-	ethtool_link_ksettings_zero_link_mode(cmd, supported);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, 10baseT_Half);
-	ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
+	ethtool_ks_clear(cmd, supported);
+	ethtool_ks_add_mode(cmd, supported, 10baseT_Half);
+	ethtool_ks_add_mode(cmd, supported, TP);
 
-	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, 10baseT_Half);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
+	ethtool_ks_clear(cmd, advertising);
+	ethtool_ks_add_mode(cmd, advertising, 10baseT_Half);
+	ethtool_ks_add_mode(cmd, advertising, TP);
 
 	cmd->base.speed = SPEED_10;
 	cmd->base.duplex = DUPLEX_HALF;
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 91761436709a..eb5bb8e2a868 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1609,15 +1609,13 @@ static int lan78xx_set_pause(struct net_device *net,
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
diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 5f565bd574da..8bbe4be8a27d 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -827,8 +827,7 @@ static int rtl8150_get_link_ksettings(struct net_device *netdev,
 		    DUPLEX_FULL : DUPLEX_HALF;
 	}
 
-	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.supported,
-						supported);
+	ethtool_u32_to_ks(ecmd->link_modes.supported, supported);
 
 	return 0;
 }
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f34794a76c4d..afbd03ab43d0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2021,7 +2021,7 @@ virtnet_validate_ethtool_cmd(const struct ethtool_link_ksettings *cmd)
 	 */
 	diff1.base.speed = 0;
 	diff2.base.port = PORT_OTHER;
-	ethtool_link_ksettings_zero_link_mode(&diff1, advertising);
+	ethtool_ks_clear(&diff1, advertising);
 	diff1.base.duplex = 0;
 	diff1.base.cmd = 0;
 	diff1.base.link_mode_masks_nwords = 0;
diff --git a/drivers/net/vmxnet3/vmxnet3_ethtool.c b/drivers/net/vmxnet3/vmxnet3_ethtool.c
index 2ff27314e047..3c1353eb98c1 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethtool.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethtool.c
@@ -476,12 +476,12 @@ vmxnet3_get_link_ksettings(struct net_device *netdev,
 {
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 
-	ethtool_link_ksettings_zero_link_mode(ecmd, supported);
-	ethtool_link_ksettings_add_link_mode(ecmd, supported, 10000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(ecmd, supported, 1000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(ecmd, supported, TP);
-	ethtool_link_ksettings_zero_link_mode(ecmd, advertising);
-	ethtool_link_ksettings_add_link_mode(ecmd, advertising, TP);
+	ethtool_ks_clear(ecmd, supported);
+	ethtool_ks_add_mode(ecmd, supported, 10000baseT_Full);
+	ethtool_ks_add_mode(ecmd, supported, 1000baseT_Full);
+	ethtool_ks_add_mode(ecmd, supported, TP);
+	ethtool_ks_clear(ecmd, advertising);
+	ethtool_ks_add_mode(ecmd, advertising, TP);
 	ecmd->base.port = PORT_TP;
 
 	if (adapter->link_speed) {
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 06415b6a8f68..9b8b23e49036 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6113,72 +6113,72 @@ EXPORT_SYMBOL_GPL(qeth_core_get_drvinfo);
 static void qeth_set_cmd_adv_sup(struct ethtool_link_ksettings *cmd,
 				int maxspeed, int porttype)
 {
-	ethtool_link_ksettings_zero_link_mode(cmd, supported);
-	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
-	ethtool_link_ksettings_zero_link_mode(cmd, lp_advertising);
+	ethtool_ks_clear(cmd, supported);
+	ethtool_ks_clear(cmd, advertising);
+	ethtool_ks_clear(cmd, lp_advertising);
 
-	ethtool_link_ksettings_add_link_mode(cmd, supported, Autoneg);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, Autoneg);
+	ethtool_ks_add_mode(cmd, supported, Autoneg);
+	ethtool_ks_add_mode(cmd, advertising, Autoneg);
 
 	switch (porttype) {
 	case PORT_TP:
-		ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
+		ethtool_ks_add_mode(cmd, supported, TP);
+		ethtool_ks_add_mode(cmd, advertising, TP);
 		break;
 	case PORT_FIBRE:
-		ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
+		ethtool_ks_add_mode(cmd, supported, FIBRE);
+		ethtool_ks_add_mode(cmd, advertising, FIBRE);
 		break;
 	default:
-		ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
+		ethtool_ks_add_mode(cmd, supported, TP);
+		ethtool_ks_add_mode(cmd, advertising, TP);
 		WARN_ON_ONCE(1);
 	}
 
 	/* fallthrough from high to low, to select all legal speeds: */
 	switch (maxspeed) {
 	case SPEED_10000:
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
+		ethtool_ks_add_mode(cmd, supported,
 						     10000baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+		ethtool_ks_add_mode(cmd, advertising,
 						     10000baseT_Full);
 	case SPEED_1000:
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
+		ethtool_ks_add_mode(cmd, supported,
 						     1000baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+		ethtool_ks_add_mode(cmd, advertising,
 						     1000baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
+		ethtool_ks_add_mode(cmd, supported,
 						     1000baseT_Half);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+		ethtool_ks_add_mode(cmd, advertising,
 						     1000baseT_Half);
 	case SPEED_100:
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
+		ethtool_ks_add_mode(cmd, supported,
 						     100baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+		ethtool_ks_add_mode(cmd, advertising,
 						     100baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
+		ethtool_ks_add_mode(cmd, supported,
 						     100baseT_Half);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+		ethtool_ks_add_mode(cmd, advertising,
 						     100baseT_Half);
 	case SPEED_10:
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
+		ethtool_ks_add_mode(cmd, supported,
 						     10baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+		ethtool_ks_add_mode(cmd, advertising,
 						     10baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
+		ethtool_ks_add_mode(cmd, supported,
 						     10baseT_Half);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+		ethtool_ks_add_mode(cmd, advertising,
 						     10baseT_Half);
 		/* end fallthrough */
 		break;
 	default:
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
+		ethtool_ks_add_mode(cmd, supported,
 						     10baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+		ethtool_ks_add_mode(cmd, advertising,
 						     10baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
+		ethtool_ks_add_mode(cmd, supported,
 						     10baseT_Half);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+		ethtool_ks_add_mode(cmd, advertising,
 						     10baseT_Half);
 		WARN_ON_ONCE(1);
 	}
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f8a2245b70ac..c87ace66092f 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -119,37 +119,35 @@ struct ethtool_link_ksettings {
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
- * link mode mask
+ * ethtool_ks_add_mode - set bit in link_ksettings link mode mask
  *   @ptr : pointer to struct ethtool_link_ksettings
  *   @name : one of supported/advertising/lp_advertising
  *   @mode : one of the ETHTOOL_LINK_MODE_*_BIT
  * (not atomic, no bound checking)
  */
-#define ethtool_link_ksettings_add_link_mode(ptr, name, mode)		\
+#define ethtool_ks_add_mode(ptr, name, mode)		\
 	__set_bit(ETHTOOL_LINK_MODE_ ## mode ## _BIT, (ptr)->link_modes.name)
 
 /**
- * ethtool_link_ksettings_del_link_mode - clear bit in link_ksettings
- * link mode mask
+ * ethtool_ks_del_mode - clear bit in link_ksettings link mode mask
  *   @ptr : pointer to struct ethtool_link_ksettings
  *   @name : one of supported/advertising/lp_advertising
  *   @mode : one of the ETHTOOL_LINK_MODE_*_BIT
  * (not atomic, no bound checking)
  */
-#define ethtool_link_ksettings_del_link_mode(ptr, name, mode)		\
+#define ethtool_ks_del_mode(ptr, name, mode)		\
 	__clear_bit(ETHTOOL_LINK_MODE_ ## mode ## _BIT, (ptr)->link_modes.name)
 
 /**
- * ethtool_link_ksettings_test_link_mode - test bit in ksettings link mode mask
+ * ethtool_ks_test - test bit in ksettings link mode mask
  *   @ptr : pointer to struct ethtool_link_ksettings
  *   @name : one of supported/advertising/lp_advertising
  *   @mode : one of the ETHTOOL_LINK_MODE_*_BIT
@@ -157,7 +155,7 @@ struct ethtool_link_ksettings {
  *
  * Returns true/false.
  */
-#define ethtool_link_ksettings_test_link_mode(ptr, name, mode)		\
+#define ethtool_ks_test(ptr, name, mode)		\
 	test_bit(ETHTOOL_LINK_MODE_ ## mode ## _BIT, (ptr)->link_modes.name)
 
 extern int
@@ -174,12 +172,10 @@ __ethtool_get_link_ksettings(struct net_device *dev,
 void ethtool_intersect_link_masks(struct ethtool_link_ksettings *dst,
 				  struct ethtool_link_ksettings *src);
 
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
index c15075dc7572..43d4e68b6b9a 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -398,17 +398,15 @@ void ethtool_intersect_link_masks(struct ethtool_link_ksettings *dst,
 }
 EXPORT_SYMBOL(ethtool_intersect_link_masks);
 
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
 
@@ -428,7 +426,7 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
 	*legacy_u32 = src[0];
 	return retval;
 }
-EXPORT_SYMBOL(ethtool_convert_link_mode_to_legacy_u32);
+EXPORT_SYMBOL(ethtool_ks_to_u32);
 
 /* return false if legacy contained non-0 deprecated fields
  * maxtxpkt/maxrxpkt. rest of ksettings always updated
@@ -450,15 +448,12 @@ convert_legacy_settings_to_link_ksettings(
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
@@ -495,15 +490,12 @@ convert_link_ksettings_to_legacy_settings(
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
2.17.0


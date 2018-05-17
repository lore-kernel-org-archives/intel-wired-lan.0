From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 17 May 2018 23:05:33 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/2] ethtool: stop the line
 wrapping madness
In-Reply-To: <20180515180155.19164-1-jeffrey.t.kirsher@intel.com>
References: <20180515180155.19164-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B964D0C99@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, May 15, 2018 11:02 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 1/2] ethtool: stop the line wrapping
> madness
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Folks, we have a hard limit of 80 characters per line in the kernel,
> mostly due to Linus' insistence on printing out each release on greenbar
> with his Decwriter. So why do we have function and macro names that are
> over 30 characters long? Add a tab or two and a few parameters and boom!
> you're wrapping lines.
> 
> This patch is a search-n-replace of the newly-added ethtool link
> settings API with shorter names. In general, I replaced 'ksettings' with
> 'ks' and elided some unnecessary verbiage. In nearly every instance I
> unwrapped lines and made the code easier to read, especially on a VT102.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
> v2: fix patch description to remove the reference to fixing the Amazon
>     Ethernet driver, since this fix is actually in patch 2 of the series
> 
>  drivers/infiniband/hw/nes/nes_nic.c           |  12 +-
>  drivers/net/ethernet/3com/3c509.c             |   3 +-
>  drivers/net/ethernet/3com/typhoon.c           |   6 +-
>  drivers/net/ethernet/alteon/acenic.c          |   3 +-
>  drivers/net/ethernet/amazon/ena/ena_ethtool.c |   6 +-
>  drivers/net/ethernet/amd/pcnet32.c            |   5 +-
>  drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c   |   6 +-
>  drivers/net/ethernet/amd/xgbe/xgbe.h          |  24 +-
>  .../ethernet/apm/xgene/xgene_enet_ethtool.c   |  16 +-
>  .../net/ethernet/aquantia/atlantic/aq_nic.c   |  53 +--
>  drivers/net/ethernet/atheros/alx/ethtool.c    |   9 +-
>  .../ethernet/atheros/atl1c/atl1c_ethtool.c    |   6 +-
>  .../ethernet/atheros/atl1e/atl1e_ethtool.c    |   9 +-
>  drivers/net/ethernet/atheros/atlx/atl1.c      |   6 +-
>  drivers/net/ethernet/atheros/atlx/atl2.c      |   9 +-
>  drivers/net/ethernet/broadcom/b44.c           |   9 +-
>  drivers/net/ethernet/broadcom/bcm63xx_enet.c  |   6 +-
>  drivers/net/ethernet/broadcom/bnx2.c          |   9 +-
>  .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   |  24 +-
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  84 ++--
>  drivers/net/ethernet/broadcom/tg3.c           |  14 +-
>  .../net/ethernet/brocade/bna/bnad_ethtool.c   |   6 +-
>  drivers/net/ethernet/calxeda/xgmac.c          |   4 +-
>  .../ethernet/cavium/liquidio/lio_ethtool.c    | 149 +++---
>  .../ethernet/cavium/thunder/nicvf_ethtool.c   |   6 +-
>  drivers/net/ethernet/chelsio/cxgb/cxgb2.c     |   9 +-
>  .../net/ethernet/chelsio/cxgb3/cxgb3_main.c   |  13 +-
>  .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    |  25 +-
>  .../ethernet/chelsio/cxgb4vf/cxgb4vf_main.c   |  25 +-
>  .../net/ethernet/cisco/enic/enic_ethtool.c    |  10 +-
>  drivers/net/ethernet/dec/tulip/de2104x.c      |   9 +-
>  drivers/net/ethernet/dec/tulip/uli526x.c      |   6 +-
>  drivers/net/ethernet/dlink/dl2k.c             |   6 +-
>  .../net/ethernet/emulex/benet/be_ethtool.c    |   6 +-
>  .../net/ethernet/hisilicon/hns/hns_ethtool.c  |  12 +-
>  .../ethernet/hisilicon/hns3/hns3_ethtool.c    |   6 +-
>  .../net/ethernet/huawei/hinic/hinic_main.c    |   8 +-
>  drivers/net/ethernet/ibm/ehea/ehea_ethtool.c  |   6 +-
>  drivers/net/ethernet/ibm/emac/core.c          |   9 +-
>  drivers/net/ethernet/ibm/ibmveth.c            |   6 +-
>  drivers/net/ethernet/ibm/ibmvnic.c            |   6 +-
>  .../net/ethernet/intel/e1000/e1000_ethtool.c  |   9 +-
>  drivers/net/ethernet/intel/e1000e/ethtool.c   |   9 +-
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 432 +++++++-----------
>  .../ethernet/intel/i40evf/i40evf_ethtool.c    |   2 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  42 +-
>  drivers/net/ethernet/intel/igb/igb_ethtool.c  |   9 +-
>  drivers/net/ethernet/intel/igbvf/ethtool.c    |   8 +-
>  .../net/ethernet/intel/ixgb/ixgb_ethtool.c    |  12 +-
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  15 +-
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c  |   4 +-
>  drivers/net/ethernet/marvell/mv643xx_eth.c    |  24 +-
>  drivers/net/ethernet/marvell/pxa168_eth.c     |   3 +-
>  drivers/net/ethernet/marvell/skge.c           |   9 +-
>  drivers/net/ethernet/marvell/sky2.c           |   9 +-
>  .../net/ethernet/mellanox/mlx4/en_ethtool.c   |  49 +-
>  .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  73 ++-
>  .../mellanox/mlx5/core/ipoib/ethtool.c        |   4 +-
>  .../net/ethernet/mellanox/mlxsw/spectrum.c    |  14 +-
>  .../net/ethernet/mellanox/mlxsw/switchx2.c    |  12 +-
>  drivers/net/ethernet/micrel/ks8695net.c       |   9 +-
>  drivers/net/ethernet/micrel/ksz884x.c         |  11 +-
>  drivers/net/ethernet/microchip/enc28j60.c     |   8 +-
>  drivers/net/ethernet/microchip/encx24j600.c   |   3 +-
>  .../net/ethernet/myricom/myri10ge/myri10ge.c  |   4 +-
>  drivers/net/ethernet/natsemi/natsemi.c        |   9 +-
>  drivers/net/ethernet/natsemi/ns83820.c        |   3 +-
>  drivers/net/ethernet/neterion/s2io.c          |  12 +-
>  .../net/ethernet/neterion/vxge/vxge-ethtool.c |  12 +-
>  .../ethernet/netronome/nfp/nfp_net_ethtool.c  |  14 +-
>  drivers/net/ethernet/nvidia/forcedeth.c       |   9 +-
>  .../oki-semi/pch_gbe/pch_gbe_ethtool.c        |  15 +-
>  .../qlogic/netxen/netxen_nic_ethtool.c        |   6 +-
>  .../net/ethernet/qlogic/qede/qede_ethtool.c   |   6 +-
>  drivers/net/ethernet/qlogic/qla3xxx.c         |   6 +-
>  .../ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c   |   9 +-
>  .../ethernet/qlogic/qlcnic/qlcnic_ethtool.c   |   6 +-
>  .../net/ethernet/qlogic/qlge/qlge_ethtool.c   |   6 +-
>  drivers/net/ethernet/qualcomm/qca_debug.c     |   4 +-
>  drivers/net/ethernet/realtek/r8169.c          |   9 +-
>  drivers/net/ethernet/rocker/rocker_main.c     |   4 +-
>  drivers/net/ethernet/sfc/ethtool.c            |   6 +-
>  drivers/net/ethernet/sfc/falcon/ethtool.c     |   4 +-
>  drivers/net/ethernet/sfc/falcon/mdio_10g.c    |   9 +-
>  drivers/net/ethernet/silan/sc92031.c          |   9 +-
>  drivers/net/ethernet/smsc/smc911x.c           |   3 +-
>  drivers/net/ethernet/smsc/smc91c92_cs.c       |   3 +-
>  drivers/net/ethernet/smsc/smc91x.c            |   3 +-
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  20 +-
>  drivers/net/ethernet/sun/cassini.c            |   6 +-
>  drivers/net/ethernet/sun/niu.c                |   9 +-
>  drivers/net/ethernet/sun/sungem.c             |  12 +-
>  drivers/net/ethernet/sun/sunhme.c             |   3 +-
>  drivers/net/ethernet/tehuti/tehuti.c          |  14 +-
>  drivers/net/ethernet/ti/netcp_ethss.c         |   6 +-
>  drivers/net/ethernet/toshiba/ps3_gelic_net.c  |   6 +-
>  .../net/ethernet/toshiba/spider_net_ethtool.c |  12 +-
>  drivers/net/ethernet/via/via-velocity.c       |   6 +-
>  drivers/net/fjes/fjes_ethtool.c               |   4 +-
>  drivers/net/hyperv/netvsc_drv.c               |   2 +-
>  drivers/net/mdio.c                            |   9 +-
>  drivers/net/mii.c                             |  12 +-
>  drivers/net/ntb_netdev.c                      |   8 +-
>  drivers/net/phy/marvell10g.c                  |   2 +-
>  drivers/net/phy/phy.c                         |  13 +-
>  drivers/net/phy/phylink.c                     |   7 +-
>  drivers/net/tun.c                             |   4 +-
>  drivers/net/usb/catc.c                        |  12 +-
>  drivers/net/usb/lan78xx.c                     |   6 +-
>  drivers/net/usb/rtl8150.c                     |   3 +-
>  drivers/net/virtio_net.c                      |   2 +-
>  drivers/net/vmxnet3/vmxnet3_ethtool.c         |  12 +-
>  drivers/s390/net/qeth_core_main.c             |  58 +--
>  include/linux/ethtool.h                       |  24 +-
>  net/core/ethtool.c                            |  40 +-
>  115 files changed, 723 insertions(+), 1176 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Well, compile tested for all and a bit of regression testing on the Intel drivers.

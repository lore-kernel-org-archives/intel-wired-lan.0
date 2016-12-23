From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 23 Dec 2016 00:40:35 +0000
Subject: [Intel-wired-lan] [PATCH v3] ethtool: stop the line wrapping
 madness
In-Reply-To: <20161221003528.4483-1-mitch.a.williams@intel.com>
References: <20161221003528.4483-1-mitch.a.williams@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81FFCE3A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mitch Williams
> Sent: Tuesday, December 20, 2016 4:35 PM
> To: intel-wired-lan at lists.osuosl.org; netanel at annapurnalabs.com;
> saeed at annapurnalabs.com; zorik at annapurnalabs.com;
> decot at googlers.com
> Subject: [Intel-wired-lan] [PATCH v3] ethtool: stop the line wrapping
> madness
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
> In the case of the Amazon Ethernet driver, I found a bug where they were
> setting bits in the the 'settings' field twice. Almost certainly this
> was supposed to set bits in the 'advertising' field instead. So I fixed
> it.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> v3: catch a few more drivers
> v2: catch a few more drivers
> ---
>  drivers/infiniband/hw/nes/nes_nic.c                |  12 +--
>  drivers/net/ethernet/3com/3c509.c                  |   3 +-
>  drivers/net/ethernet/3com/typhoon.c                |   6 +-
>  drivers/net/ethernet/alteon/acenic.c               |   3 +-
>  drivers/net/ethernet/amazon/ena/ena_ethtool.c      |   6 +-
>  drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |  13 +--
>  .../net/ethernet/apm/xgene/xgene_enet_ethtool.c    |  16 +---
>  drivers/net/ethernet/atheros/alx/ethtool.c         |   9 +-
>  drivers/net/ethernet/atheros/atl1c/atl1c_ethtool.c |   6 +-
>  drivers/net/ethernet/atheros/atl1e/atl1e_ethtool.c |   9 +-
>  drivers/net/ethernet/atheros/atlx/atl1.c           |   6 +-
>  drivers/net/ethernet/atheros/atlx/atl2.c           |   9 +-
>  drivers/net/ethernet/broadcom/b44.c                |   9 +-
>  drivers/net/ethernet/broadcom/bcm63xx_enet.c       |   6 +-
>  drivers/net/ethernet/broadcom/bnx2.c               |   9 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  | 102 ++++++++------
> -------
>  drivers/net/ethernet/broadcom/tg3.c                |  14 +--
>  drivers/net/ethernet/brocade/bna/bnad_ethtool.c    |   6 +-
>  drivers/net/ethernet/calxeda/xgmac.c               |   4 +-
>  drivers/net/ethernet/cavium/liquidio/lio_ethtool.c |   6 +-
>  .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |   6 +-
>  drivers/net/ethernet/chelsio/cxgb/cxgb2.c          |   9 +-
>  drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |  13 +--
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c |  12 +--
>  .../net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c    |  12 +--
>  drivers/net/ethernet/cisco/enic/enic_ethtool.c     |  10 +-
>  drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |  12 +--
>  drivers/net/ethernet/marvell/mv643xx_eth.c         |  24 ++---
>  drivers/net/ethernet/marvell/pxa168_eth.c          |   3 +-
>  drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |  49 ++++------
>  .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  25 +++--
>  drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |  14 +--
>  drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |   6 +-
>  drivers/net/ethernet/sfc/ethtool.c                 |   6 +-
>  drivers/net/ethernet/sfc/mcdi_port.c               |  12 +--
>  .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  20 ++--
>  drivers/net/ethernet/ti/netcp_ethss.c              |   6 +-
>  drivers/net/mii.c                                  |  12 +--
>  drivers/net/phy/phy.c                              |  13 +--
>  drivers/net/usb/lan78xx.c                          |   6 +-
>  include/linux/ethtool.h                            |  21 ++---
>  net/core/ethtool.c                                 |  40 ++++----
>  42 files changed, 217 insertions(+), 368 deletions(-)

I don't have the hardware (or inclination) to check the vast majority of parts affected, but this compiles fine and behaves the same on my (Intel based) set of regression systems.  Patchwork throws a few "checks", but they are all for pre-existing things and not brought about by the changes. So, from a sanity check point of view...

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

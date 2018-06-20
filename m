From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jun 2018 17:21:03 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 6/7] net: allow
 ndo_select_queue to pass netdev
In-Reply-To: <20180612151857.86792.68635.stgit@ahduyck-green-test.jf.intel.com>
References: <20180612151322.86792.97587.stgit@ahduyck-green-test.jf.intel.com>
 <20180612151857.86792.68635.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C8119@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, June 12, 2018 8:19 AM
> To: intel-wired-lan at osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 6/7] net: allow
> ndo_select_queue to pass netdev
> 
> This patch makes it so that instead of passing a void pointer as the accel_priv
> we instead pass a net_device pointer as sb_dev. Making this change allows
> us to pass the subordinate device through to the fallback function eventually
> so that we can keep the actual code in the ndo_select_queue call as focused
> on possible on the exception cases.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/vnic_main.c            |    2 +-
>  drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c |    4 ++--
>  drivers/net/bonding/bond_main.c                   |    3 ++-
>  drivers/net/ethernet/amazon/ena/ena_netdev.c      |    3 ++-
>  drivers/net/ethernet/broadcom/bcmsysport.c        |    2 +-
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   |    3 ++-
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |    3 ++-
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c   |    3 ++-
>  drivers/net/ethernet/hisilicon/hns/hns_enet.c     |    3 ++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |    7 ++++---
>  drivers/net/ethernet/mellanox/mlx4/en_tx.c        |    3 ++-
>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h      |    3 ++-
>  drivers/net/ethernet/mellanox/mlx5/core/en.h      |    3 ++-
>  drivers/net/ethernet/mellanox/mlx5/core/en_tx.c   |    3 ++-
>  drivers/net/ethernet/renesas/ravb_main.c          |    3 ++-
>  drivers/net/ethernet/sun/ldmvsw.c                 |    3 ++-
>  drivers/net/ethernet/sun/sunvnet.c                |    3 ++-
>  drivers/net/hyperv/netvsc_drv.c                   |    4 ++--
>  drivers/net/net_failover.c                        |    5 +++--
>  drivers/net/team/team.c                           |    3 ++-
>  drivers/net/tun.c                                 |    3 ++-
>  drivers/net/wireless/marvell/mwifiex/main.c       |    3 ++-
>  drivers/net/xen-netback/interface.c               |    2 +-
>  drivers/net/xen-netfront.c                        |    3 ++-
>  drivers/staging/rtl8188eu/os_dep/os_intfs.c       |    3 ++-
>  drivers/staging/rtl8723bs/os_dep/os_intfs.c       |    7 +++----
>  include/linux/netdevice.h                         |   11 +++++++----
>  net/core/dev.c                                    |    6 ++++--
>  net/mac80211/iface.c                              |    4 ++--
>  29 files changed, 66 insertions(+), 42 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



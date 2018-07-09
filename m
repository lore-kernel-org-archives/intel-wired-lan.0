From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Jul 2018 21:18:23 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 7/7] net: allow
 fallback function to pass netdev
In-Reply-To: <20180709162004.8383.91041.stgit@ahduyck-green-test.jf.intel.com>
References: <20180709161743.8383.97754.stgit@ahduyck-green-test.jf.intel.com>
 <20180709162004.8383.91041.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2D46EB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, July 9, 2018 9:20 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 7/7] net: allow
> fallback function to pass netdev
> 
> For most of these calls we can just pass NULL through to the fallback function
> as the sb_dev. The only cases where we cannot are the cases where we
> might be dealing with either an upper device or a driver that would have
> configured things to support an sb_dev itself.
> 
> The only driver that has any signficant change in this patchset should be ixgbe
> as we can drop the redundant functionality that existed in both the
> ndo_select_queue function and the fallback function that was passed
> through to us.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c    |    2 +-
>  drivers/net/ethernet/broadcom/bcmsysport.c      |    4 ++--
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c |    3 ++-
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c |    2 +-
>  drivers/net/ethernet/hisilicon/hns/hns_enet.c   |    2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |    4 ++--
>  drivers/net/ethernet/mellanox/mlx4/en_tx.c      |    4 ++--
>  drivers/net/ethernet/mellanox/mlx5/core/en_tx.c |    2 +-
>  drivers/net/hyperv/netvsc_drv.c                 |    2 +-
>  drivers/net/net_failover.c                      |    2 +-
>  drivers/net/xen-netback/interface.c             |    2 +-
>  include/linux/netdevice.h                       |    3 ++-
>  net/core/dev.c                                  |   12 +++---------
>  net/packet/af_packet.c                          |    7 ++++---
>  14 files changed, 24 insertions(+), 27 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



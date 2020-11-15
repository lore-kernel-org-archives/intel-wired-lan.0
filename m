From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 15 Nov 2020 06:48:31 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 6/9] xsk: propagate napi_id
 to XDP socket Rx path
In-Reply-To: <20201112114041.131998-7-bjorn.topel@gmail.com>
References: <20201112114041.131998-1-bjorn.topel@gmail.com>
 <20201112114041.131998-7-bjorn.topel@gmail.com>
Message-ID: <20201115044831.GA1304196@apalos.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Nov 12, 2020 at 12:40:38PM +0100, Bj?rn T?pel wrote:
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> Add napi_id to the xdp_rxq_info structure, and make sure the XDP
> socket pick up the napi_id in the Rx path. The napi_id is used to find
> the corresponding NAPI structure for socket busy polling.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c  |  2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
>  .../ethernet/cavium/thunder/nicvf_queues.c    |  2 +-
>  .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  2 +-
>  drivers/net/ethernet/intel/ice/ice_base.c     |  4 ++--
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c     |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  2 +-
>  drivers/net/ethernet/marvell/mvneta.c         |  2 +-
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  4 ++--
>  drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  2 +-
>  .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
>  .../ethernet/netronome/nfp/nfp_net_common.c   |  2 +-
>  drivers/net/ethernet/qlogic/qede/qede_main.c  |  2 +-
>  drivers/net/ethernet/sfc/rx_common.c          |  2 +-
>  drivers/net/ethernet/socionext/netsec.c       |  2 +-
>  drivers/net/ethernet/ti/cpsw_priv.c           |  2 +-
>  drivers/net/hyperv/netvsc.c                   |  2 +-
>  drivers/net/tun.c                             |  2 +-
>  drivers/net/veth.c                            |  2 +-
>  drivers/net/virtio_net.c                      |  2 +-
>  drivers/net/xen-netfront.c                    |  2 +-
>  include/net/busy_poll.h                       | 19 +++++++++++++++----
>  include/net/xdp.h                             |  3 ++-
>  net/core/dev.c                                |  2 +-
>  net/core/xdp.c                                |  3 ++-
>  net/xdp/xsk.c                                 |  1 +
>  29 files changed, 47 insertions(+), 33 deletions(-)
> 
 
For the socionext driver

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

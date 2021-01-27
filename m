From: Alexander Lobakin <alobakin@pm.me>
Date: Wed, 27 Jan 2021 20:23:48 +0000
Subject: [Intel-wired-lan] [PATCH net-next 0/3] net: constify
 page_is_pfmemalloc() and its users
In-Reply-To: <20210125164612.243838-1-alobakin@pm.me>
References: <20210125164612.243838-1-alobakin@pm.me>
Message-ID: <20210127202322.99523-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Lobakin <alobakin@pm.me>
Date: Mon, 25 Jan 2021 16:46:48 +0000

> page_is_pfmemalloc() is used mostly by networking drivers. It doesn't
> write anything to the struct page itself, so constify its argument and
> a bunch of callers and wrappers around this function in drivers.
> In Page Pool core code, it can be simply inlined instead.
> 
> Alexander Lobakin (3):
>   mm: constify page_is_pfmemalloc() argument
>   net: constify page_is_pfmemalloc() argument at call sites
>   net: page_pool: simplify page recycling condition tests

Superseded with v2 [0].

>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c   |  2 +-
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c     |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c       |  2 +-
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c       |  2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.c         |  2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c         |  2 +-
>  drivers/net/ethernet/intel/igc/igc_main.c         |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  2 +-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   |  2 +-
>  include/linux/mm.h                                |  2 +-
>  include/linux/skbuff.h                            |  4 ++--
>  net/core/page_pool.c                              | 14 ++++----------
>  13 files changed, 17 insertions(+), 23 deletions(-)
> 
> -- 
> 2.30.0

[0] https://lore.kernel.org/netdev/20210127201031.98544-1-alobakin at pm.me

Thanks,
Al


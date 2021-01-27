From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 27 Jan 2021 13:47:26 -0800
Subject: [Intel-wired-lan] [PATCH v2 net-next 3/4] net: introduce common
 dev_page_is_reserved()
In-Reply-To: <20210127201031.98544-4-alobakin@pm.me>
References: <20210127201031.98544-1-alobakin@pm.me>
 <20210127201031.98544-4-alobakin@pm.me>
Message-ID: <20210127134726.00003605@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Lobakin wrote:

> A bunch of drivers test the page before reusing/recycling for two
> common conditions:
>  - if a page was allocated under memory pressure (pfmemalloc page);
>  - if a page was allocated at a distant memory node (to exclude
>    slowdowns).
> 
> Introduce and use a new common function for doing this and eliminate
> all functions-duplicates from drivers.
> 
> Suggested-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c   | 10 ++--------
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c     |  9 ++-------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 15 +--------------
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c       | 15 +--------------
>  drivers/net/ethernet/intel/ice/ice_txrx.c         | 11 +----------
>  drivers/net/ethernet/intel/igb/igb_main.c         |  7 +------
>  drivers/net/ethernet/intel/igc/igc_main.c         |  7 +------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  7 +------
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  7 +------
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   |  7 +------
>  include/linux/skbuff.h                            | 15 +++++++++++++++
>  11 files changed, 27 insertions(+), 83 deletions(-)

For the patch, and esp. for the Intel drivers:
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Wed, 24 Feb 2021 15:13:52 +0100
Subject: [Intel-wired-lan] [PATCH net-next v1 0/3] intel: packet type
 table simplification
In-Reply-To: <20210223234707.1170711-1-jesse.brandeburg@intel.com>
References: <20210223234707.1170711-1-jesse.brandeburg@intel.com>
Message-ID: <20210224141352.GA20163@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Feb 23, 2021 at 03:47:04PM -0800, Jesse Brandeburg wrote:
> Update three of the Intel Ethernet drivers with similar (but not the
> same) improvements to simplify the packet type table init, while removing
> an unused structure entry. For the ice driver, the table is extended
> to 10 bits, which is the hardware limit, and for now is initialized
> to zero.
> 
> The end result is slightly reduced memory usage, removal of a bunch
> of code, and more specific initialization.

Thanks, that is much better!

For the series:
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

FWIW, I see that in the subject of patches only the ice one has a v2, but
that's no big deal.

> 
> Jesse Brandeburg (3):
>   ice: report hash type such as L2/L3/L4
>   i40e: clean up packet type lookup table
>   iavf: clean up packet type lookup table
> 
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 124 +--------------
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |   1 -
>  drivers/net/ethernet/intel/iavf/iavf_common.c | 124 +--------------
>  drivers/net/ethernet/intel/iavf/iavf_type.h   |   1 -
>  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 147 ++++--------------
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  23 ++-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   2 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
>  9 files changed, 62 insertions(+), 364 deletions(-)
> 
> -- 
> 2.29.2
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

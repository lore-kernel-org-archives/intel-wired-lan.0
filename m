From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Fri, 17 Dec 2021 15:23:42 +0000
Subject: [Intel-wired-lan] [PATCH v2 intel-net 6/6] ice: xsk: fix
 cleaned_count setting
In-Reply-To: <20211213153111.110877-7-maciej.fijalkowski@intel.com>
References: <20211213153111.110877-1-maciej.fijalkowski@intel.com>
 <20211213153111.110877-7-maciej.fijalkowski@intel.com>
Message-ID: <DM6PR11MB32924BE7BB15755573E2BE80F1789@DM6PR11MB3292.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Monday, December 13, 2021 9:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Mathew, Elza <elza.mathew@intel.com>; netdev at vger.kernel.org;
> kuba at kernel.org; bpf at vger.kernel.org; davem at davemloft.net; Karlsson,
> Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 intel-net 6/6] ice: xsk: fix cleaned_count
> setting
> 
> Currently cleaned_count is initialized to ICE_DESC_UNUSED(rx_ring) and later
> on during the Rx processing it is incremented per each frame that driver
> consumed. This can result in excessive buffers requested from xsk pool
> based on that value.
> 
> To address this, just drop cleaned_count and pass
> ICE_DESC_UNUSED(rx_ring) directly as a function argument to
> ice_alloc_rx_bufs_zc(). Idea is to ask for buffers as many as consumed.
> 
> Let us also call ice_alloc_rx_bufs_zc unconditionally at the end of
> ice_clean_rx_irq_zc. This has been changed in that way for corresponding
> ice_clean_rx_irq, but not here.
> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.h | 1 -
> drivers/net/ethernet/intel/ice/ice_xsk.c  | 6 +-----
>  2 files changed, 1 insertion(+), 6 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel

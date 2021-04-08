From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 8 Apr 2021 13:10:32 +0300
Subject: [Intel-wired-lan] [PATCH v5 4/9] igc: Refactor XDP rxq info
 registration
In-Reply-To: <20210226002308.2348-5-jithu.joseph@intel.com>
References: <20210226002308.2348-1-jithu.joseph@intel.com>
 <20210226002308.2348-5-jithu.joseph@intel.com>
Message-ID: <1a150870-d333-f025-2b60-9b24eebe75ca@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 26/02/2021 02:23, Jithu Joseph wrote:
> From: Andre Guedes <andre.guedes@intel.com>
> 
> Refactor XDP rxq info registration code, preparing the driver for AF_XDP
> zero-copy support which is added by upcoming patches.
> 
> Currently, xdp_rxq and memory model are both registered during RX
> resource setup time by igc_xdp_register_rxq_info() helper. With AF_XDP,
> we want to register the memory model later on while configuring the ring
> because we will know which memory model type to register
> (MEM_TYPE_PAGE_SHARED or MEM_TYPE_XSK_BUFF_POOL).
> 
> The helpers igc_xdp_register_rxq_info() and igc_xdp_unregister_rxq_
> info() are not useful anymore so they are removed.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 16 ++++++++++----
>   drivers/net/ethernet/intel/igc/igc_xdp.c  | 27 -----------------------
>   drivers/net/ethernet/intel/igc/igc_xdp.h  |  3 ---
>   3 files changed, 12 insertions(+), 34 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>

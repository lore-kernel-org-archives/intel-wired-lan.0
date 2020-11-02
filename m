From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 2 Nov 2020 19:31:29 +0100
Subject: [Intel-wired-lan] [PATCH v3 0/9] igc: Add XDP support
In-Reply-To: <20201030210351.46482-1-andre.guedes@intel.com>
References: <20201030210351.46482-1-andre.guedes@intel.com>
Message-ID: <20201102183129.GM6427@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Oct 30, 2020 at 02:03:42PM -0700, Andre Guedes wrote:
> Hi all,
> 
> This is the third version of this series which adds XDP support to igc driver.
> 
> The main changes from v2 are:
> 
>     - Moved functions that belong to the driver's hot path to igc_main.c to
>       allow the compiler to inline them if convenient.
>     - Squashed ndo_xdp_xmit patch into XDP_REDIRECT patch.
> 
> v2 is here:
> 
>     https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20201028201943.93147-1-andre.guedes at intel.com/
> 
> v1 is here:
> 
>     https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20201009025349.4037-1-andre.guedes at intel.com/
> 
> Cheers,
> Andre

I had only minor comments/questions for this version, so you can take my:

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

for series.

> 
> 
> Andre Guedes (9):
>   igc: Fix igc_ptp_rx_pktstamp()
>   igc: Remove unused argument from igc_tx_cmd_type()
>   igc: Introduce igc_rx_buffer_flip() helper
>   igc: Introduce igc_get_rx_frame_truesize() helper
>   igc: Refactor rx timestamp handling
>   igc: Add set/clear large buffer helpers
>   igc: Add initial XDP support
>   igc: Add support for XDP_TX action
>   igc: Add support for XDP_REDIRECT action
> 
>  drivers/net/ethernet/intel/igc/Makefile   |   2 +-
>  drivers/net/ethernet/intel/igc/igc.h      |  18 +-
>  drivers/net/ethernet/intel/igc/igc_main.c | 431 +++++++++++++++++++---
>  drivers/net/ethernet/intel/igc/igc_ptp.c  |  89 +++--
>  drivers/net/ethernet/intel/igc/igc_xdp.c  |  60 +++
>  drivers/net/ethernet/intel/igc/igc_xdp.h  |  13 +
>  6 files changed, 512 insertions(+), 101 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_xdp.c
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_xdp.h
> 
> -- 
> 2.28.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

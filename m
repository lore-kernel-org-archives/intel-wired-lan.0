From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 23 Mar 2018 22:39:12 +0000
Subject: [Intel-wired-lan] [v4,
 06/15] ice: Initialize PF and setup miscellaneous interrupt
In-Reply-To: <20180320145819.19133-7-anirudh.venkataramanan@intel.com>
References: <20180320145819.19133-7-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261789F11C@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Anirudh Venkataramanan
> [mailto:anirudh.venkataramanan at intel.com]
> Sent: Tuesday, March 20, 2018 7:58 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [v4,06/15] ice: Initialize PF and setup miscellaneous interrupt
> 
> This patch continues the initialization flow as follows:
> 
> 1) Allocate and initialize necessary fields (like vsi, num_alloc_vsi,
>    irq_tracker, etc) in the ice_pf instance.
> 
> 2) Setup the miscellaneous interrupt handler. This also known as the
>    "other interrupt causes" (OIC) handler and is used to handle non
>    hotpath interrupts (like control queue events, link events,
>    exceptions, etc.
> 
> 3) Implement a background task to process admin queue receive (ARQ)
>    events received by the driver.
> 
> CC: Shannon Nelson <shannon.nelson@oracle.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Acked-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h            |  84 +++
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |   2 +
>  drivers/net/ethernet/intel/ice/ice_common.c     |   6 +
>  drivers/net/ethernet/intel/ice/ice_common.h     |   3 +
>  drivers/net/ethernet/intel/ice/ice_controlq.c   | 101 ++++
>  drivers/net/ethernet/intel/ice/ice_controlq.h   |   8 +
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  63 +++
>  drivers/net/ethernet/intel/ice/ice_main.c       | 719
> +++++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_txrx.h       |  43 ++
>  drivers/net/ethernet/intel/ice/ice_type.h       |  11 +
>  10 files changed, 1039 insertions(+), 1 deletion(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_txrx.h


Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>



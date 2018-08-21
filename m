From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:40:46 +0000
Subject: [Intel-wired-lan] [PATCH v3 10/15] ice: Add support for Tx hang,
 Tx timeout and malicious driver detection
In-Reply-To: <20180809132958.23036-11-anirudh.venkataramanan@intel.com>
References: <20180809132958.23036-1-anirudh.venkataramanan@intel.com>
 <20180809132958.23036-11-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD2619545AF1@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 10/15] ice: Add support for Tx hang, Tx
> timeout and malicious driver detection
> 
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 
> When a malicious operation is detected, the firmware triggers an interrupt,
> which is then picked up by the service task (specifically by
> ice_handle_mdd_event). A reset is scheduled if required.
> 
> Tx hang detection works in a similar way, except the logic here monitors the
> VSI's Tx queues and tries to revive them if stalled. If the hang is not resolved,
> the kernel eventually calls ndo_tx_timeout, which is handled by
> ice_tx_timeout.
> 
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   4 +
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |  39 +++
>  drivers/net/ethernet/intel/ice/ice_main.c     | 286 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |   1 +
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |   1 +
>  5 files changed, 331 insertions(+)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>



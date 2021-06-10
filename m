From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 10 Jun 2021 21:19:54 +0000
Subject: [Intel-wired-lan] [PATCH v2 5/8] ice: register 1588 PTP clock
 device object for E810 devices
In-Reply-To: <20210609163953.52440-6-anthony.l.nguyen@intel.com>
References: <20210609163953.52440-1-anthony.l.nguyen@intel.com>
 <20210609163953.52440-6-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB510540E50D6A21C9119C8217FA359@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, June 9, 2021 9:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 5/8] ice: register 1588 PTP clock device
> object for E810 devices
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Add a new ice_ptp.c file for holding the basic PTP clock interface functions. If
> the device supports PTP, call the new ice_ptp_init and ice_ptp_release
> functions where appropriate.
> 
> If the function owns the hardware resource associated with the PTP
> hardware clock, register with the PTP_1588_CLOCK infrastructure to allocate
> a new clock object that represents the device hardware clock.
> 
> Implement basic functionality for reading and setting the clock time,
> performing clock adjustments, and adjusting the clock frequency.
> 
> Future changes will introduce functionality for handling related features
> including Tx and Rx timestamps.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/Kconfig          |   1 +
>  drivers/net/ethernet/intel/ice/Makefile     |   1 +
>  drivers/net/ethernet/intel/ice/ice.h        |   4 +
>  drivers/net/ethernet/intel/ice/ice_common.c |  11 +
>  drivers/net/ethernet/intel/ice/ice_common.h |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c   |  21 +
>  drivers/net/ethernet/intel/ice/ice_ptp.c    | 439 ++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_ptp.h    |  36 ++
>  8 files changed, 514 insertions(+)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_ptp.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_ptp.h

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)



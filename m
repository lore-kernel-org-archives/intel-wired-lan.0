From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 27 May 2021 17:25:13 +0000
Subject: [Intel-wired-lan] [PATCH 5/8] ice: register 1588 PTP clock
 device object for E810 devices
In-Reply-To: <20210520164850.1884656-6-jacob.e.keller@intel.com>
References: <20210520164850.1884656-1-jacob.e.keller@intel.com>
 <20210520164850.1884656-6-jacob.e.keller@intel.com>
Message-ID: <CO1PR11MB5105A293E9B143CC9E557A10FA239@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Thursday, May 20, 2021 9:49 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Lion, Sean <sean.lion@intel.com>
> Subject: [Intel-wired-lan] [PATCH 5/8] ice: register 1588 PTP clock device
> object for E810 devices
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
>  drivers/net/ethernet/intel/ice/ice_ptp.c    | 453 ++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_ptp.h    |  36 ++
>  8 files changed, 528 insertions(+)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_ptp.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_ptp.h

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)



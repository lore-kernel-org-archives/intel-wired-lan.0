From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 27 May 2021 17:22:52 +0000
Subject: [Intel-wired-lan] [PATCH 2/8] ice: process 1588 PTP
 capabilities during initialization
In-Reply-To: <20210520164850.1884656-3-jacob.e.keller@intel.com>
References: <20210520164850.1884656-1-jacob.e.keller@intel.com>
 <20210520164850.1884656-3-jacob.e.keller@intel.com>
Message-ID: <CO1PR11MB5105D6C5AA3B313C90B4FA57FA239@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH 2/8] ice: process 1588 PTP capabilities
> during initialization
> 
> The device firmware reports PTP clock capabilities to each PF during
> initialization. This includes various information for both the overall device and
> the individual function, including
> 
> For functions:
> * whether this function has timesync enabled
> * whether this function owns one of the 2 possible clock timers, and
>   which one
> * which timer the function is associated with
> * the clock frequency, if the device supports multiple clock frequencies
> * The GPIO pin association for the timer owned by this PF, if any
> 
> For the device:
> * Which PF owns timer 0, if any
> * Which PF owns timer 1, if any
> * whether timer 0 is enabled
> * whether timer 1 is enabled
> 
> Extract the bits from the capabilities information reported by firmware and
> store them in the device and function capability structures.o
> 
> This information will be used in a future change to have the function driver
> enable PTP hardware clock support.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
>  drivers/net/ethernet/intel/ice/ice_common.c   | 99
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_type.h     | 51 ++++++++++
>  3 files changed, 151 insertions(+)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)



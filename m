From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 10 Jun 2021 21:19:17 +0000
Subject: [Intel-wired-lan] [PATCH v2 4/8] ice: add low level PTP clock
 access functions
In-Reply-To: <20210609163953.52440-5-anthony.l.nguyen@intel.com>
References: <20210609163953.52440-1-anthony.l.nguyen@intel.com>
 <20210609163953.52440-5-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51050E49A6501ACB66CFAC84FA359@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 4/8] ice: add low level PTP clock access
> functions
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Add the ice_ptp_hw.c file and some associated definitions to the ice driver
> folder. This file contains basic low level definitions for functions that interact
> with the device hardware.
> 
> For now, only E810-based devices are supported. The ice hardware supports
> 2 major variants which have different PHYs with different procedures
> necessary for interacting with the device clock.
> 
> Because the device captures timestamps in the PHY, each PHY has its own
> internal timer. The timers are synchronized in hardware by first preparing the
> source timer and the PHY timer shadow registers, and then issuing a
> synchronization command. This ensures that both the source timer and PHY
> timers are programmed simultaneously. The timers themselves are all driven
> from the same oscillator source.
> 
> The functions in ice_ptp_hw.c abstract over the differences between how
> the PHYs in E810 are programmed vs how the PHYs in E822 devices are
> programmed. This series only implements E810 support, but E822 support will
> be added in a future change.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |  17 +
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 655 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  79 +++
>  drivers/net/ethernet/intel/ice/ice_type.h     |   9 +
>  include/linux/kernel.h                        |  12 +
>  5 files changed, 772 insertions(+)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_ptp_hw.h

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)



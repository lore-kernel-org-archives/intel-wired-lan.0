From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 12 May 2021 16:09:39 +0000
Subject: [Intel-wired-lan] [PATCH S59 04/13] ice: wait for reset before
 reporting devlink info
In-Reply-To: <20210506154008.12880-4-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
 <20210506154008.12880-4-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51056B3366F7514947B3A78BFA529@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, May 6, 2021 8:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S59 04/13] ice: wait for reset before
> reporting devlink info
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Requesting device firmware information while the device is busy cleaning up
> after a reset can result in an unexpected failure:
> 
> This occurs because the command is attempting to access the device AdminQ
> while it is down. Resolve this by having the command wait for a while until
> the reset is complete. To do this, introduce a reset_wait_queue and
> associated helper function "ice_wait_for_reset".
> 
> This helper will use the wait queue to sleep until the driver is done
> rebuilding. Use of a wait queue is preferred because the potential sleep
> duration can be several seconds.
> 
> To ensure that the thread wakes up properly, a new wake_up call is added
> during all code paths which clear the reset state bits associated with the
> driver rebuild flow.
> 
> Using this ensures that tools can request device information without
> worrying about whether the driver is cleaning up from a reset.
> Specifically, it is expected that a flash update could result in a device reset,
> and it is better to delay the response for information until the reset is
> complete rather than exit with an immediate failure.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  2 ++
>  drivers/net/ethernet/intel/ice/ice_devlink.c |  6 +++++
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 28 ++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.h     |  1 +
>  drivers/net/ethernet/intel/ice/ice_main.c    |  5 ++++
>  5 files changed, 42 insertions(+)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)



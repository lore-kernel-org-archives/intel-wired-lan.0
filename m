From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Jul 2020 21:31:19 +0000
Subject: [Intel-wired-lan] [PATCH v3] i40e: add support for PTP external
 synchronization clock
In-Reply-To: <20200728134748.26703-1-piotr.kwapulinski@intel.com>
References: <20200728134748.26703-1-piotr.kwapulinski@intel.com>
Message-ID: <BN6PR1101MB2145F88FBECBE0EDBBE065878C4E0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Piotr Kwapulinski
> Sent: Tuesday, July 28, 2020 6:48 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
> Subject: [Intel-wired-lan] [PATCH v3] i40e: add support for PTP external
> synchronization clock
> 
> Add support for external synchronization clock via GPIOs.
> 1PPS signals are handled via the dedicated 3 GPIOs: SDP3_2,
> SDP3_3 and GPIO_4.
> Previously it was not possible to use the external PTP synchronization clock.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  76 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  18 +-
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c    | 747 +++++++++++++++++-
>  .../net/ethernet/intel/i40e/i40e_register.h   |  31 +-
>  4 files changed, 845 insertions(+), 27 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



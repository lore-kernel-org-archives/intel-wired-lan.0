From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jul 2020 23:56:42 +0000
Subject: [Intel-wired-lan] [PATCH S48 v6 14/16] ice: Add GTPU FDIR
 filter for AVF
In-Reply-To: <20200716133938.46921-15-qi.z.zhang@intel.com>
References: <20200716133938.46921-1-qi.z.zhang@intel.com>
 <20200716133938.46921-15-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB21455A9F704336C9CFC85E2E8C770@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Qi
> Zhang
> Sent: Thursday, July 16, 2020 6:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Qi Z <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [PATCH S48 v6 14/16] ice: Add GTPU FDIR filter for
> AVF
> 
> Add new FDIR filter type to forward GTPU packets by matching TEID or QFI.
> The filter is only enabled when COMMS DDP package is downloaded.
> 
> Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_fdir.c          | 135
> +++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_fdir.h          |  25 +++-
>  drivers/net/ethernet/intel/ice/ice_type.h          |   4 +
>  drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c |  74 +++++++++++
>  4 files changed, 237 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



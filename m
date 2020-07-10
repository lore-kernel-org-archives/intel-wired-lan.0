From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 10 Jul 2020 21:28:40 +0000
Subject: [Intel-wired-lan] [PATCH S48 v5 14/16] ice: Add GTPU FDIR
 filter for AVF
In-Reply-To: <20200710010644.33817-15-qi.z.zhang@intel.com>
References: <20200710010644.33817-1-qi.z.zhang@intel.com>
 <20200710010644.33817-15-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB2145BAC53B1497F559ACB24C8C650@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Qi
> Zhang
> Sent: Thursday, July 9, 2020 6:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Qi Z <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [PATCH S48 v5 14/16] ice: Add GTPU FDIR filter for
> AVF
> 
> Add new FDIR filter type to forward GTPU packets by matching TEID or QFI.
> The filter is only enabled when COMMS DDP package is downloaded.
> 
> Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_fdir.h          | 21 ++++++
>  drivers/net/ethernet/intel/ice/ice_type.h          |  4 ++
>  drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 74
> ++++++++++++++++++++++
>  3 files changed, 99 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


